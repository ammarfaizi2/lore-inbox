Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbTHLJ5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbTHLJ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:57:23 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45733
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S267317AbTHLJ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:57:17 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jeff Garzik <jgarzik@pobox.com>, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] file extents for EXT3
Date: Tue, 12 Aug 2003 05:33:58 -0400
User-Agent: KMail/1.5
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <m3ptjcabey.fsf@bzzz.home.net> <20030811095518.T7752@schatzie.adilger.int> <3F37C2EB.5050503@pobox.com>
In-Reply-To: <3F37C2EB.5050503@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120533.58020.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 August 2003 12:23, Jeff Garzik wrote:

> Of course, the other alternative is to rename ext3 to "linuxfs", add a
> "no journal at all" mode, and remove ext2.  But I prefer my "ext4"
> solution :)

Well, embedded developers probably like the smaller driver.  Of course they 
can always use minixfs. :)

Something I've wondered about for a while:

With the ability to place a journal on another block device, you could 
theoretically throw the journal on a 1 megabyte ramdisk, and more or less 
degrade ext3 to ext2 that way (as long as you made sure to fsck the heck out 
of it on the way back up each time).

Beyond that, why is the minimum journal size 1 megabyte?  (Having to waste a 
megabyte of ram on a 4 megabyte filesystem is kind of annoying.  And yes, 
buildroot on uclibc with busybox can give you quite a lot of functionality in 
4 megabytes)  In theory, if the journal could be crushed down small enough, 
then the ramdisk solution isn't so bad, although needing to compile in the 
ramdisk and set it up is a bit clumsy, better still if the journal code could 
just bounce the blocks off of a small internal ram buffer.  (Personally, I'll 
live with the redundant in-memory copies; still faster than the disk by a 
long shot.)

Beyond THAT, ext2 could be considered ext3 with a "no journal" flag 
(automatically supplied when the mount is read only, for example).  Last time 
I did an embedded device, I had to stick both ext3 in (for the runtime data 
partition) and ext2 in (for the initrd that loopback mounted the firmware 
image, which was a zisofs containing the root partition).  Initramfs 
addresses this particular annoyance, but still leaves a problem creating a 
bootable CD that's going to install to ext3...

Having to compile two filesystems into the kernel with basically the same 
on-disk layout is kind of annoying, but ext3 simply isn't a good fit for a 
small ramdisk or for read-only media.

I realise that ext3 was kept separate from ext2 because ext2 should be 
uber-stable, but the argument there is that people who care about keeping 
their writeable data safe are intentionally not using journaling.  (Meanwhile 
we're completely redoing the block layer underneath them, and both the SCSI 
and IDE subsystems, and raid, but all those are obviously FAR less likely to 
do strange things to their data behind their back than the filesystem is... 
:)

Oh well.  Too late to worry about it for 2.6 anyway... :)

Rob


