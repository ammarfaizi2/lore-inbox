Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288770AbSADVSe>; Fri, 4 Jan 2002 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288769AbSADVSY>; Fri, 4 Jan 2002 16:18:24 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:38040 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288767AbSADVSK>; Fri, 4 Jan 2002 16:18:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Date: Fri, 4 Jan 2002 16:17:45 -0500
X-Mailer: KMail [version 1.3.2]
Cc: William Lee Irwin III <wli@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020104211746.CF5C6D722@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The following fixes a compile problem with agpgart:

-------------
--- linux/drivers/char/agp/agpgart_be.c.orig	Fri Jan  4 15:01:50 2002
+++ linux/drivers/char/agp/agpgart_be.c	Fri Jan  4 15:22:46 2002
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -830,7 +831,7 @@
 	page = virt_to_page(pt);
 	atomic_dec(&page->count);
 	clear_bit(PG_locked, &page->flags);
-	wake_up(&page->wait);
+	wake_up(page_waitqueue(page));
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
---------------

As a quick test of a new kernel I copy dbench to a tmpfs fs and run "time dbench 32".
This typically takes over 512M swap (with rmap 10c and mainline).  With hashed
waitqueues it does not reach 512M.  The machine has 512M of memory.   I observe
about the same runtimes and datarate with all three kernels.

Ed Tomlinson
