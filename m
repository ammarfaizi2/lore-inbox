Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293125AbSBWMLQ>; Sat, 23 Feb 2002 07:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293126AbSBWMLH>; Sat, 23 Feb 2002 07:11:07 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:18444 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S293125AbSBWMKv>;
	Sat, 23 Feb 2002 07:10:51 -0500
Message-ID: <3C7786FE.6828F4BF@yahoo.com>
Date: Sat, 23 Feb 2002 07:11:42 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf as module
Content-Type: text/plain; charset=us-ascii; name="ksyms"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="ksyms"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone reported binfmt_elf.o wouldn't load because of unresolved symbols,
but didn't report the symbols that were missing (I seem to have deleted 
the original mail.)

Turns out it is empty_zero_page and get_user_pages that are missing.
Probably been broken for ages, as binfmt_elf is compiled in for 99.9% 
of folks of course.

Patch for i386 against 2.4.17 follows.  Other arch may also still be broken,
depending on their definition of ZERO_PAGE and whether or not it uses 
empty_zero_page.

Paul.

--- mm/Makefile~	Tue Nov  6 19:14:49 2001
+++ mm/Makefile	Sat Feb 23 06:30:04 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := mm.o
 
-export-objs := shmem.o filemap.o
+export-objs := shmem.o filemap.o memory.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
--- arch/i386/kernel/i386_ksyms.c~	Sat Feb  2 06:43:30 2002
+++ arch/i386/kernel/i386_ksyms.c	Sat Feb 23 06:23:33 2002
@@ -71,6 +71,7 @@
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(gdt);
+EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
--- mm/memory.c~	Sat Feb  2 06:51:18 2002
+++ mm/memory.c	Sat Feb 23 06:28:36 2002
@@ -44,6 +44,7 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/module.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -499,6 +500,8 @@
 	} while(len);
 	return i;
 }
+
+EXPORT_SYMBOL(get_user_pages);
 
 /*
  * Force in an entire range of pages from the current process's user VA,



