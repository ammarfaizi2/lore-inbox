Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHJbu>; Thu, 8 Feb 2001 04:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHJbl>; Thu, 8 Feb 2001 04:31:41 -0500
Received: from www.wen-online.de ([212.223.88.39]:44804 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129031AbRBHJbi>;
	Thu, 8 Feb 2001 04:31:38 -0500
Date: Thu, 8 Feb 2001 10:31:20 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Christoph Rohland <cr@sap.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: tmpfs swapoff oddity
Message-ID: <Pine.Linu.4.10.10102080953430.1381-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

While testing Jens' loop-4 patch (and not being able to find
any way to lock it up), I stumbled onto a strange behavior.

I set up an interleaved swap with one swap partition, and one
swapfile in a loopback mounted reiserfs - populated tmpfs with
a kernel tree and did hefty make -j kernel builds to generate
much I/O.  Afterward (bored), I figured I'd bounce the data in
tmpfs back and forth between swap containers with swapoff.  It
took much longer than I expected.

This is likely only something a bored tester would do, but it
seems odd enough to report.. repeated without loop.

[root]:# pwd
/var/tmp/linux-2.4.2-pre1
[root]:# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda6              4157873   3734124    213701  95% /
shm                     499092         0    499092   0% /dev/shm
/dev/hda7               256592    155715     87625  64% /var
tmpfs                   622228    123136    499092  20% /var/tmp
/dev/hda8             10445318   6450096   3669907  64% /usr/local
/dev/hda1              4088532   2286968   1801564  56% /dos_c
[root]:# mount
/dev/hda6 on / type ext2 (rw)
proc on /proc type proc (rw)
shm on /dev/shm type shm (rw)
/dev/hda7 on /var type ext2 (rw)
tmpfs on /var/tmp type tmpfs (rw)
/dev/hda8 on /usr/local type ext2 (rw)
/dev/hda1 on /dos_c type vfat (rw,noexec)
devpts on /dev/pts type devpts (rw,gid=5,mode=0620)
[root]:# swapon -s
Filename			Type		Size	Used	Priority
/dev/hda2                       partition	265064	127356	2
/dev/hda5                       partition	265032	0	2
[root]:# time swapoff /dev/hda2

real	7m17.555s
user	0m0.010s
sys	7m3.040s
[root]:#

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
