Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267855AbUHPSRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267855AbUHPSRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUHPSRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:17:13 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:54402 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S267855AbUHPSRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:17:06 -0400
Date: Mon, 16 Aug 2004 20:17:04 +0200
From: Martin Buck <mb-tmp-xreary.bet@gromit.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Ramdisk corruption in 2.4.25
Message-ID: <20040816181704.GA16063@gromit.at.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with corruption of ramdisk contents on a small embedded
MIPS board. I'm using kernel 2.4.25 from linux-mips.org, but its rd.c is
identical to the one in plain 2.4.25. Symptoms are that a short time after
starting /sbin/init, some ramdisk contents get corrupted (the contents are
OK when /sbin/init starts). What usually happens is that some part of one
file (several 100 bytes, but usually *not* a power of 2) shows up somewhere
in another file or at a different position in the same file.

The filesystem on the ramdisk is ext2, the ramdisk is loaded via initrd
from a gzipped image and is used as root filesystem. It's usually mounted
rw, but to make sure it's not me or ext2 corrupting the files, I also tried
mounting it ro. User space is busybox/uClibc based. About the smallest test
case I could come up with is by replacing /sbin/init with the following
shell script. Note that at this time, no hardware-specific drivers are
loaded:

#!/bin/sh

md5sum /dev/ram0
md5sum /dev/ram0
md5sum /dev/ram0
md5sum /dev/ram0
md5sum /dev/ram0


Corruption currently happens between the 2nd and 3rd md5sum, but I've had
different setups (with a real /sbin/init) which ran much more commands
before corruption showed up. This is the output I get:

[...]
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1272k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k freed
Algorithmics/MIPS FPU Emulator v1.5
dfd6710a4a6d0b0d5492d5d683c1ad5e  /dev/ram0
dfd6710a4a6d0b0d5492d5d683c1ad5e  /dev/ram0
a62a7629e2c3bbfe0880aa2bce66e5cc  /dev/ram0
a62a7629e2c3bbfe0880aa2bce66e5cc  /dev/ram0
a62a7629e2c3bbfeKernel panic: Attempted to kill init!
0880aa2bce66e5cc   /dev/ram0


The first 2 md5sums are the ones that match my actual initrd image.


Since this seems to be some kind of Heisenbug, I doubt that anybody will be
able to reproduce this easily. So what I'd appreciate instead are some
hints how to debug this myself, or any other suggestions.

Thanks a lot,
Martin
