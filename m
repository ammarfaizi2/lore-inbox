Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUF1UHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUF1UHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbUF1UHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:07:10 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:55436
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S265163AbUF1UGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:06:11 -0400
Date: Mon, 28 Jun 2004 16:06:04 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] move prototype for __get_vm_area() to a sane location
Message-ID: <Pine.LNX.4.44.0406281554590.1713-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are currently two files besides mm/vmalloc.c that make use of that 
function:

- arch/sh/kernel/cpu/sh4/sq.c
  which defined its own prototype locally risking not being in sync with 
  the real function, and

- arch/arm/kernel/module.c which has no prototype at all and cause
  build warnings.

This patch fixes those issues.

--- linux-2.6/include/linux/vmalloc.h	27 Jun 2004 17:54:00 -0000	1.11
+++ linux-2.6/include/linux/vmalloc.h	28 Jun 2004 19:48:16 -0000
@@ -36,6 +36,8 @@
  *	Lowlevel-APIs (not for driver use!)
  */
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
+extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
+					unsigned long start, unsigned long end);
 extern struct vm_struct *remove_vm_area(void *addr);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
 			struct page ***pages);
--- linux-2.6/arch/sh/kernel/cpu/sh4/sq.c	23 Mar 2004 15:25:10 -0000	1.3
+++ linux-2.6/arch/sh/kernel/cpu/sh4/sq.c	28 Jun 2004 19:43:18 -0000
@@ -34,8 +34,6 @@
 static LIST_HEAD(sq_mapping_list);
 static spinlock_t sq_mapping_lock = SPIN_LOCK_UNLOCKED;
 
-extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags, unsigned long start, unsigned long end);
-
 /**
  * sq_flush - Flush (prefetch) the store queue cache
  *

