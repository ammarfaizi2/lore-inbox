Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTITB2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 21:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTITB2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 21:28:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261195AbTITB2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 21:28:45 -0400
Date: Sat, 20 Sep 2003 02:28:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
Message-ID: <20030920012844.GD7665@parcelfarce.linux.theplanet.co.uk>
References: <20030919231046.4626.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919231046.4626.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 05:10:46PM -0600, Jonathan Corbet wrote:
> I assume that the (empty, currently) entries in /sys/cdev are there for
> some purpose...  for purposes of my own, I've been thinking that it would
> be nice to be able to find which device numbers got assigned when using the
> new char dev registration functions.  Thus, the following patch, which adds
> default "dev" and "count" attributes to /sys/cdev entries.
> 
> I have no idea whether this follows the original plan for /sys/cdev.
> There *is* a plan for it, no...?

They are more of a side effect.  The thing is, expected setup for character
devices is the following:
	* driver has embedded struct cdev in its data structures
	* it has the thing registered in global search structure - as tty
does, for example.
	* open() on a character device finds the kobject of that cdev (same
as block device open() finds kobject of gendisk) and uses it for the rest of
work.  Namely, file_operations() are picked from it and inode->i_cdev /
inode->i_cindex are set.  Then we call ->open().
	* ->open() can use ->i_cdev to get whatever data structure driver
had intended and avoid any lookups of its own (of course it's still perfectly
free to look at the minor, mess with its own arrya/lists/whatnot - it's not
mandatory anymore, but it certainly won't break).

To avoid breaking the old drivers we do the following: register_chrdev()
allocates a cdev itself, inserts it in search tree, etc., so open() on
character device registered that way will work with the new scheme.  We'll
find the cdev allocated by register_chrdev(), take the file_operations from
it (register_chrdev() had stored the pointer when it had created cdev), set
->i_cindex (potentially useful for ->open()) and ->i_cdev (useless for ->open(),
since it has no relationship to any driver objects).  And call ->open().

FWIW, I would be just fine with not seeing these guys in sysfs - they don't
have any intrinsic sense from the driver POV and they exist only for those
who use old scheme, so putting them to any universal use is hopeless.

Real driver-registered cdevs are different story - they should bear whatever
attributes driver wants them to bear.  Note that even for tty conversion is
not complete - we still have sucky refcounting there and it has to be fixed
first.  Once it's done, get_tty_driver() goes to hell and tty_driver embedded
cdev will get sane attributes.

BTW, I suspect that we need a way to say "this kobject and its children
will *never* have any attributes and will never be seen in sysfs".  There
are quite a few uses when we keep kobject as a refcounting vehicle, etc.,
but have nothing meaningful to show in sysfs tree.  Keep in mind that
sysfs nodes (including attributes) are not free - it's struct inode +
struct dentry at the very least.  Both pinned down and permanently mapped...
