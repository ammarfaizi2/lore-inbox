Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266478AbUFUVXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbUFUVXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266480AbUFUVXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:23:10 -0400
Received: from aun.it.uu.se ([130.238.12.36]:28070 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266478AbUFUVXE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:23:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16599.20905.527283.517210@alkaid.it.uu.se>
Date: Mon, 21 Jun 2004 23:22:49 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
Cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile linux-2.4.27-rc1 ... ipt_REJECT.c
In-Reply-To: <Pine.OSF.4.51.0406211848480.202417@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0406211343160.157782@tao.natur.cuni.cz>
	<16598.56442.254480.281844@alkaid.it.uu.se>
	<Pine.OSF.4.51.0406211848480.202417@tao.natur.cuni.cz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ© writes:
 > gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASENAME=vt  -c -o vt.o vt.c
 > vt.c: In function `do_kdsk_ioctl':
 > vt.c:166: warning: comparison is always false due to limited range of data type
 > vt.c: In function `do_kdgkb_ioctl':
 > vt.c:283: warning: comparison is always false due to limited range of data type

This happens with many gcc-3.x versions, not just gcc-3.4.
In any case, it doesn't prevent a successful kernel build.

 > gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASENAME=highmem  -c -o highmem.o highmem.c
 > highmem.c:133: error: conflicting types for 'kmap_high'
 > /usr/src/linux-2.4.27-rc1/include/asm/highmem.h:59: error: previous declaration of 'kmap_high' was here
 > highmem.c:133: error: conflicting types for 'kmap_high'
 > /usr/src/linux-2.4.27-rc1/include/asm/highmem.h:59: error: previous declaration of 'kmap_high' was here
 > highmem.c:158: error: conflicting types for 'kunmap_high'
 > /usr/src/linux-2.4.27-rc1/include/asm/highmem.h:60: error: previous declaration of 'kunmap_high' was here
 > highmem.c:158: error: conflicting types for 'kunmap_high'
 > /usr/src/linux-2.4.27-rc1/include/asm/highmem.h:60: error: previous declaration of 'kunmap_high' was here

This is HIGHMEM which I never tested before. The problem is yet
another FASTCALL/fastcall discrepancy where a function's definition
doesn't have the exact same attributes as its prototype.

My updated gcc340 patch fixes this problem. Get
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v2-2.4.27-rc1>
or simply apply the patch below on top of the previous version.

/Mikael

--- linux-2.4.27-rc1/mm/highmem.c.~1~	2003-06-14 13:30:29.000000000 +0200
+++ linux-2.4.27-rc1/mm/highmem.c	2004-06-21 22:42:58.000000000 +0200
@@ -129,7 +129,7 @@
 	return vaddr;
 }
 
-void *kmap_high(struct page *page, int nonblocking)
+void fastcall *kmap_high(struct page *page, int nonblocking)
 {
 	unsigned long vaddr;
 
@@ -154,7 +154,7 @@
 	return (void*) vaddr;
 }
 
-void kunmap_high(struct page *page)
+void fastcall kunmap_high(struct page *page)
 {
 	unsigned long vaddr;
 	unsigned long nr;
