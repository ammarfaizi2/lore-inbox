Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSJaQBl>; Thu, 31 Oct 2002 11:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJaQAk>; Thu, 31 Oct 2002 11:00:40 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:53002 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262805AbSJaQAa>; Thu, 31 Oct 2002 11:00:30 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21555.66344.176608@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:02:59 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [4/8] export pagevec_deactivate_inactive()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Windows: the cutting edge of obsolescence.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    Following patch exports pagevec_deactivate_inactive(): reiser4 uses
    its own ->writepages() method rather than mpage_writepages(). It
    needs access to pagevec_deactivate_inactive() to play fair with VM.

Please apply.
Nikita.
diff -urN linus-bk-2.5/mm/Makefile linux-2.5-reiser4/mm/Makefile
--- linus-bk-2.5/mm/Makefile	2002-10-12 13:35:03.000000000 +0200
+++ linux-2.5-reiser4/mm/Makefile	2002-10-30 17:15:10.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for the linux memory manager.
 #
 
-export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
+export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o swap.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
diff -urN linux-2.5.44-bk3-reiser4/mm/swap.c linux-2.5.44-bk3-reiser4.1/mm/swap.c
--- linux-2.5.44-bk3-reiser4/mm/swap.c	2002-10-16 10:53:13.000000000 +0200
+++ linux-2.5.44-bk3-reiser4.1/mm/swap.c	2002-10-30 17:14:23.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>
 #include <linux/prefetch.h>
+#include <linux/module.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -192,6 +193,7 @@
 		spin_unlock_irq(&zone->lru_lock);
 	__pagevec_release(pvec);
 }
+EXPORT_SYMBOL(pagevec_deactivate_inactive);
 
 /*
  * Add the passed pages to the LRU, then drop the caller's refcount

