Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbULAXjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbULAXjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbULAXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:39:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53257 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261494AbULAXiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:38:55 -0500
Date: Thu, 2 Dec 2004 00:38:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] compile with -ffreestanding
Message-ID: <20041201233853.GB5148@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

for the kernel, it would be logical to use -ffreestanding. The kernel is 
not a hosted environment with a standard C library.

The gcc option -ffreestanding is supported by both gcc 2.95 and 3.4, 
which covers the whole range of currently supported compilers.

I'm currently running a 2.6.10-rc2-mm4 with this patch applied and 
compiled with gcc 2.95 and haven't yet observed any problems.

Regarding changes caused by this patch:

Andi Kleen reported:
  Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.

This is only true with unit-at-a-time (disabled on i386 but enabled
on x86_64). The Linux kernel doesn't offer a standard C library, and
such transparent replacements of kernel functions with builtins are
quite fragile.

Even with -ffreestanding, it's still possilble to explicitely use a gcc
builtin if desired.

Could you add the patch below to the next -mm to see whether there are 
any problems I didn't find?

TIA
Adrian



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full-ffreestanding/Makefile.old	2004-11-09 22:27:06.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full-ffreestanding/Makefile	2004-11-09 22:27:47.000000000 +0100
@@ -349,7 +349,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common \
+		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \



