Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVBMUM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVBMUM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBMUM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 15:12:56 -0500
Received: from [206.169.145.186] ([206.169.145.186]:60754 "EHLO
	flood.nbttech.com") by vger.kernel.org with ESMTP id S261300AbVBMUMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 15:12:50 -0500
Date: Sun, 13 Feb 2005 12:10:46 -0800 (PST)
From: John Cho <jcho@riverbed.com>
X-X-Sender: jcho@embarcadero.nbttech.com
To: linux-kernel@vger.kernel.org
cc: Riley@Williams.Name, davej@codemonkey.org.uk, hpa@zytor.com
Subject: [PATCH] i386 ramdisk_max fix for < 1GB kernel space
Message-ID: <Pine.LNX.4.61.0502131103370.8097@embarcadero.nbttech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-OriginalArrivalTime: 13 Feb 2005 20:10:48.0326 (UTC) FILETIME=[1BAC9260:01C51208]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a vmalloc tuning patch made back in September 2004 that reserved 
a larger amount of memory for vmalloc. Unfortunately, the patch does not 
work properly for modified kernels where the kernel's virtual address 
space has been reduced to 512MB or less.

More specifically, if __PAGE_OFFSET is set to 0xE0000000 (reducing the 
kernel's virtual address space to 512MB), then the code:

     ramdisk_max:   .long (-__PAGE_OFFSET-(512 << 20)-1) & 0x7fffffff

results in a ramdisk_max of 0x7fffffff which is out of bounds. The patch 
is to change the above code to:

     ramdisk_max:   .long (((-__PAGE_OFFSET) / 2) - 1) & 0x7fffffff

This keeps the spirit of the original patch and reserves 512MB of space 
for vmalloc when __PAGE_OFFSET is not modified (0xc0000000). If 
__PAGE_OFFSET is lowered (increasing the kernel's virtual address space), 
more vmalloc space is proportionally reserved. If __PAGE_OFFSET is 
increased (my case), less vmalloc space is reserved.



Signed-off-by: John Cho <jcho@riverbed.com>

--- linux-2.6.10.orig/arch/i386/boot/setup.S	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10/arch/i386/boot/setup.S	2005-02-13 10:34:27.413862125 -0800
@@ -156,7 +156,7 @@
  					# can be located anywhere in
  					# low memory 0x10000 or higher.

-ramdisk_max:	.long (-__PAGE_OFFSET-(512 << 20)-1) & 0x7fffffff
+ramdisk_max:	.long (((-__PAGE_OFFSET) / 2) - 1) & 0x7fffffff
  					# (Header version 0x0203 or later)
  					# The highest safe address for
  					# the contents of an initrd
