Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWELWiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWELWiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWELWiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:38:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31500 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751072AbWELWiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:38:05 -0400
Date: Fri, 12 May 2006 23:37:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512223755.GJ17120@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
	axboe@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <20060512203416.GA17120@flint.arm.linux.org.uk> <20060512214354.GP27946@ftp.linux.org.uk> <20060512215520.GH17120@flint.arm.linux.org.uk> <20060512220807.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 03:22:42PM -0700, Linus Torvalds wrote:
> On Fri, 12 May 2006, Al Viro wrote:
> > Secondary question: who had resurrected that crap?  I distinctly remember
> > killing it off...
> 
> If you did, I don't think it ever got into the kernel.
> 
> It was added by Kay Sievers on Nov 3, 2004, according to the old history 
> (back then it was in drivers/block/genhd.c, and the function was called 
> "block_hotplug()", but apart from renaming the function and moving the 
> file, it's recognizably the same.
> 
> Of course, you may have killed off an even earlier incarnation..

The changes in question are:

commit fa675765afed59bb89adba3369094ebd428b930b
tree 777a8c1bb48ef7de39073104f974209f4a462b6f
parent b00dc3ad74fdb676552d46ee573b88e927240d0c
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Feb 2006 09:39:02 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Feb 2006 09:39:02 -0800

    Revert mount/umount uevent removal

    This change reverts the 033b96fd30db52a710d97b06f87d16fc59fee0f1 commit
    from Kay Sievers that removed the mount/umount uevents from the kernel.
    Some older versions of HAL still depend on these events to detect when a
    new device has been mounted.  These events are not correctly emitted,
    and are broken by design, and so, should not be relied upon by any
    future program.  Instead, the /proc/mounts file should be polled to
    properly detect this kind of event.

    A feature-removal-schedule.txt entry has been added, noting when this
    interface will be removed from the kernel.

    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

commit 033b96fd30db52a710d97b06f87d16fc59fee0f1
tree 00fbccf2cf478307e213f298a221e330f3ba12ae
parent 0f76e5acf9dc788e664056dda1e461f0bec93948
author Kay Sievers <kay.sievers@suse.de> 1131685795 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> 1136420287 -0800

    [PATCH] remove mount/umount uevents from superblock handling

    The names of these events have been confusing from the beginning
    on, as they have been more like claim/release events. We needed these
    events for noticing HAL if storage devices have been mounted.

    Thanks to Al, we have the proper solution now and can poll()
    /proc/mounts instead to get notfied about mount tree changes.

    Signed-off-by: Kay Sievers <kay.sievers@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
