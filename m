Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVBGL33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVBGL33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVBGL33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:29:29 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:12807 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261397AbVBGL3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:29:22 -0500
Date: Mon, 7 Feb 2005 12:29:14 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Pozsar Balazs <pozsy@uhulinux.hu>,
       Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207112914.GB2686@pclin040.win.tue.nl>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <4207104C.1000604@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207104C.1000604@tequila.co.jp>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 03:53:00PM +0900, Clemens Schwaighofer wrote:

> >>Yeah, but the link order could be changed... Patch inlined.
> > 
> > And just what does the link order (or changes thereof) have to do with that?
> 
> because some distributions (eg gentoo) make a symlink to /proc/filesystems
> 
> jupiter root # ls -l /etc/filesystems
> lrwxrwxrwx  1 root root 19 Oct 25 11:18 /etc/filesystems ->
> ../proc/filesystems
> 
> and then its impossible to change the order. (unless you make a "hand
> made" file of course).

Ah, I had not met this particular form of brokenness before.

If one does not specify a filesystem type to mount,
mount will try its own collection of heuristics, looking for
known magic numbers. This stuff comes in two versions, depending
on whether mount was linked against the blkid library or not.

When no magic is recognized, mount will try all filesystems
listed in /proc/filesystems that were not rejected already
because of wrong magic. The list in /proc/filesystems can
be overridden by the file /etc/filesystems. That is useful
for two reasons: (i) sometimes the kernel crashes when one
tries to mount something with the wrong type, so
/etc/filesystems can skip the types that must never be tried,
and (ii) sometimes several types would succeed (e.g. msdos/vfat)
and the user can override the kernel order.

Making a symlink /etc/filesystems -> /proc/filesystems is
meaningless.

By the way, it is best to consider the kernel order as undefined.
It plays a role when mounting the rootfs. If you get undesirable
results at boot time, specify the rootfstype= boot option.
It plays a role when generating /proc/filesystems.
If you get undesirable results, adapt /etc/filesystems.

It is not true that vfat is universally better than msdos.
Some need one, some need the other.

Instead of having a global order, one can have a per-mountpoint
list in /etc/fstab. For example,

/dev/foo	/mnt	ext2,msdos	noauto	0 0

Finally, guessing is always bad. It is convenient in the short run
but may lead to crashes and data loss in the long run.

Andries
