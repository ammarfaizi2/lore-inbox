Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTAPHlY>; Thu, 16 Jan 2003 02:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTAPHlY>; Thu, 16 Jan 2003 02:41:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:26507 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265051AbTAPHlX>; Thu, 16 Jan 2003 02:41:23 -0500
Date: Wed, 15 Jan 2003 23:47:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm mailing list <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make vm_enough_memory more efficient
Message-ID: <66360000.1042703224@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vm_enough_memory seems to call si_meminfo just to get the total 
RAM, which seems far too expensive. This replaces the comment
saying "this is crap" with some code that's less crap.

Not heavily tested (compiles and boots), but seems pretty obvious.

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/mm/mmap.c vm_enough_memory/mm/mmap.c
--- virgin/mm/mmap.c	Mon Jan 13 21:09:28 2003
+++ vm_enough_memory/mm/mmap.c	Wed Jan 15 23:41:39 2003
@@ -72,7 +72,6 @@ inline void vm_unacct_memory(long pages)
 int vm_enough_memory(long pages)
 {
 	unsigned long free, allowed;
-	struct sysinfo i;
 
 	atomic_add(pages, &vm_committed_space);
 
@@ -113,12 +112,7 @@ int vm_enough_memory(long pages)
 		return 0;
 	}
 
-	/*
-	 * FIXME: need to add arch hooks to get the bits we need
-	 * without this higher overhead crap
-	 */
-	si_meminfo(&i);
-	allowed = i.totalram * sysctl_overcommit_ratio / 100;
+	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
 	if (atomic_read(&vm_committed_space) < allowed)

