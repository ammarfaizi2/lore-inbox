Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTIVVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTIVVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:00:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263325AbTIVVAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:00:23 -0400
Date: Mon, 22 Sep 2003 22:00:21 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
Message-ID: <20030922210021.GH7665@parcelfarce.linux.theplanet.co.uk>
References: <20030920012844.GD7665@parcelfarce.linux.theplanet.co.uk> <20030922164609.5929.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922164609.5929.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 10:46:09AM -0600, Jonathan Corbet wrote:
> > > I have no idea whether this follows the original plan for /sys/cdev.
> > 
> > They are more of a side effect.
> 
> So...to be sure I have things straight.../sys/cdev isn't really meant to be
> there, and char devices wanting to do things in sysfs should be working
> under /sys/devices or /sys/class or /sys/somethingelse?

<nod>

For block devices we really have non-trivial properties associated with them -
struct gendisk and request queue, for one thing.  And these are uniform across
the entire set.

Character devices per se have *no* meaningful properties common to the entire
class.  To put it another way, while block devices do form a natural class,
character ones do not.
 
> > 	* driver has embedded struct cdev in its data structures
> 
> > 	* ->open() can use ->i_cdev to get whatever data structure driver
> > had intended and avoid any lookups of its own
> 
> I noticed there's no "private" member in the cdev structure.  So drivers
> should embed the structure and use container_of to get their real structure
> of interest?

Yes, if they bother with cdev of their own in the first place.

> [Forgive my ignorance here...] If I embed a struct cdev within my own
> device structure, how do I know when I can safely free said device
> structure?  Will there be a release method that gets exposed at the driver
> level, or am I missing something obvious again?

Umm...  Any kobject has ->release() method, obviously.  NOTE: as always,
embedding kobject into one of your objects requires serious thinking about
lifetime rules for your objects.  Until they are cleaned up you'd better
*not* mess with that.  OTOH, in a lot of cases cleanup is needed anyway -
e.g. if you declare per-object sysctls/procfs entries/whatnot, you have
the same sort of problems already (plus you need to deal with the same
sort of races in your code that finds object by major:minor; many drivers
are FUBAR in that area).
