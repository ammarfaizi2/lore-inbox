Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSFFTpO>; Thu, 6 Jun 2002 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317135AbSFFTpN>; Thu, 6 Jun 2002 15:45:13 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:27566
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317115AbSFFTpM>; Thu, 6 Jun 2002 15:45:12 -0400
Date: Thu, 6 Jun 2002 12:44:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove <linux/mm.h> from <linux/vmalloc.h>
Message-ID: <20020606194454.GE14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes <linux/mm.h> from <linux/vmalloc.h>.

This then goes and fixes all of the files (x86 and PPC) which relied on
implicit includes which don't happen anymore.  This also takes
<linux/kdev_t.h> out of fs/mpage.c and puts it into include/linux/bio.h
where it belongs since <linux/bio.h> references 'kdev_t' directly.

A quick summary of the of the added includes:
arch/i386/kernel/microcode.c: needs extern for num_physpages, in linux/mm.h
include/linux/spinlock.h: local_irq* is defined in <asm/system.h> but
this was never directly included.

This depends on the patch to move the vmalloc wrappers out of
<linux/vmalloc.h>

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/i386/kernel/microcode.c 1.10 vs edited =====
--- 1.10/arch/i386/kernel/microcode.c	Thu May 23 09:06:16 2002
+++ edited/arch/i386/kernel/microcode.c	Thu Jun  6 11:01:38 2002
@@ -67,6 +67,7 @@
 #include <linux/miscdevice.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
+#include <linux/mm.h>
 
 #include <asm/msr.h>
 #include <asm/uaccess.h>
===== fs/mpage.c 1.4 vs edited =====
--- 1.4/fs/mpage.c	Wed May 29 17:34:44 2002
+++ edited/fs/mpage.c	Thu Jun  6 10:45:42 2002
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/kdev_t.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
===== include/asm-i386/pci.h 1.13 vs edited =====
--- 1.13/include/asm-i386/pci.h	Thu Mar 14 03:11:25 2002
+++ edited/include/asm-i386/pci.h	Thu Jun  6 10:23:38 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 
 #ifdef __KERNEL__
+#include <linux/mm.h>		/* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
===== include/asm-i386/pgalloc.h 1.15 vs edited =====
--- 1.15/include/asm-i386/pgalloc.h	Wed May 15 23:17:13 2002
+++ edited/include/asm-i386/pgalloc.h	Thu Jun  6 10:19:21 2002
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
+#include <linux/mm.h>		/* for struct page */
 
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
===== include/linux/bio.h 1.13 vs edited =====
--- 1.13/include/linux/bio.h	Wed Apr 24 13:00:40 2002
+++ edited/include/linux/bio.h	Thu Jun  6 11:23:50 2002
@@ -20,6 +20,7 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
+#include <linux/kdev_t.h>
 /* Platforms may set this to teach the BIO layer about IOMMU hardware. */
 #include <asm/io.h>
 #ifndef BIO_VMERGE_BOUNDARY
===== include/linux/spinlock.h 1.9 vs edited =====
--- 1.9/include/linux/spinlock.h	Wed Apr  3 11:46:00 2002
+++ edited/include/linux/spinlock.h	Thu Jun  6 11:23:50 2002
@@ -7,6 +7,8 @@
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 
+#include <asm/system.h>
+
 /*
  * These are the generic versions of the spinlocks and read-write
  * locks..
===== include/linux/vmalloc.h 1.3 vs edited =====
--- 1.3/include/linux/vmalloc.h	Thu Jun  6 10:15:09 2002
+++ edited/include/linux/vmalloc.h	Thu Jun  6 10:19:16 2002
@@ -1,7 +1,6 @@
 #ifndef __LINUX_VMALLOC_H
 #define __LINUX_VMALLOC_H
 
-#include <linux/mm.h>
 #include <linux/spinlock.h>
 
 #include <asm/pgtable.h>
