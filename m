Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbTCKJgJ>; Tue, 11 Mar 2003 04:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbTCKJgJ>; Tue, 11 Mar 2003 04:36:09 -0500
Received: from hera.cwi.nl ([192.16.191.8]:18152 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262884AbTCKJgI>;
	Tue, 11 Mar 2003 04:36:08 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 11 Mar 2003 10:46:48 +0100 (MET)
Message-Id: <UTC200303110946.h2B9kmj20047.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, Thomas.Mieslinger@gls-germany.com,
       andre@linux-ide.org, davidsen@tmr.com, harald.schaefer@gls-germany.com
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Thomas.Mieslinger@gls-germany.com  Tue Mar 11 10:03:40 2003
    sorry for my late answer but I was not in my office yesterday.

    These are our problems:
    - We cannot read the mapping from the partition-table because in most
    cases there are no partitions before booting linux!
    - We also cannot supply a fixed mapping in the kernel append-line
    because this would require an extra bootdisk for each hd.

    Why not extend the append-parameter?
    current:
    give a fixed mapping to the kernel                      hda=1050,32,64

    this may be a possible solution:
    give a fixed mapping to the kernel                      hda=1050,32,64
    use bios-supplied mapping:                              hda=bios-lba
    read mapping from newer disk:                           hda=disk-lba
    force a mapping with 255 heads like current kernel:     hda=*,255,*

Here hda=disk-lba is meaningless. The standard tells every new disk
(namely any disk with more than 16514063 sectors, that is about 8.5 GB)
to report CHS = 16383/16/63. There is no information there.

So the disk has nothing to tell us, except its total capacity.
(And that is already complicated - there are several levels of lying
involved there.)

Also hda=*,255,* and similar options sound meaningless.
If you want to force 255 heads and 63 sectors then that must
be told to *fdisk, no need to involve the kernel.
(If some *fdisk should be adapted I'll be happy to do so.)

So the only interesting option to ask for is hda=bios-lba.
That is also what you need if you later use DOS on that machine.

Linux does not use the BIOS and talks directly to the disk.
But the disk does not know what the BIOS will use.
The kernel does not know either - it depends on the setup options
you chose in the BIOS setup.

But in very early kernel startup, before going to protected mode,
the kernel asks the BIOS a few questions. Among these questions
used to be that of the geometry of hd0 and hd1.

In general it is complicated (impossible) to decide which disks
are hd0 and hd1. If you boot from SCSI then hd0 will be a SCSI disk.
If you avoid mentioning a disk in the BIOS setup, it is not
included in the BIOS numbering, but is is in the kernel numbering,
so hd0, hd1 might be hda, hdd, for example.

At first sight a kernel patch does not seem to be what you need.
If you use a uniform BIOS setup, then fdisk parameters should suffice.
If you use random BIOS setup, then doing what you want probably
requires writing a pattern to the disk using the BIOS and then
later see which disk got this pattern.

Andries
