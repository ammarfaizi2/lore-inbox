Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTINWMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTINWMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:12:53 -0400
Received: from smtp14.us.dell.com ([143.166.85.137]:2630 "EHLO
	smtp14.us.dell.com") by vger.kernel.org with ESMTP id S262015AbTINWMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:12:51 -0400
Date: Sat, 13 Sep 2003 16:11:17 +1400
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030913021117.GA16296@tux.linuxdev.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <3F64A5AC.8020901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F64A5AC.8020901@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Further, some sites may prefer block-level GUIDs to fs-level ones.
>    Sites using raw partitions instead of filesystems, for one.

The EFI GUID Partition scheme (aka GPT aka CONFIG_EFI_PARTITION)
stores a GUID in the disk label to define the whole disk, plus another
per-partition GUID and per-partition label.  So even if the file
system doesn't have one, if you're using GPT, one *could* use those.
I haven't hacked up mount to search for those though.  If there's
enough interest, I'll do so.  Recall GPT is currently only used on
ia64, though the code works fine on other arches including x86, and
it's been decided (on l-k at least) that GPT will be the default disk
label format for systems running 2.6.x kernels with disks >2TB, as the
msdos label can't hold it.

> The boot disk, OTOH, is tough. Right now, we just assume the
> sysadmin knows what's he's doing, when he installs lilo or grub on a
> disk.  You care about the boot disk when installing lilo... maybe
> there are similar situations too which I do not recall.  As Alan
> said, besides EDD (only on newer boxes) there's really nothing.

EDD BIOSs are coming, slowly...  2 work today correctly, several more
are "close but no cigar", it's all the rest that worry me.

There's one more trick that's being used successfully, which I would
like to add to the EDD code.  That's "let BIOS help you out before
installing".  i.e. you boot into a FreeDOS environment, write a
system-unique disk signature to the boot disk (int13 device 80h)
"BOOT" or something - we've got 4 bytes available in the msdos label
for it, then reboot and let Linux go grab the signature,
store it, and like edd.o does, export it to userspace.  Now from
userspace one can see what Linux-named-disk has the signature you're
looking for, and voila, you now solved it w/o needing EDD BIOSs.  But
it requires a non-Linux boot step somewhere in the install process.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
