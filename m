Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSEEUuo>; Sun, 5 May 2002 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313512AbSEEUun>; Sun, 5 May 2002 16:50:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313508AbSEEUun>;
	Sun, 5 May 2002 16:50:43 -0400
Message-ID: <3CD59BAD.37BD6A51@zip.com.au>
Date: Sun, 05 May 2002 13:53:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/10] suppress allocation warnings for radix-tree allocations
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The recently-added page allocation failure warning generates a lot of
noise due to radix-tree node allocation failures.  Those messages are
not interesting.

But I think the warning is otherwise useful - "I got an allocation
failure and then it crashed" is better than "it crashed".

The patch suppresses the message for ratnode allocation failures.



=====================================

--- 2.5.13/mm/vmscan.c~radix-tree-warning	Sun May  5 13:31:59 2002
+++ 2.5.13-akpm/mm/vmscan.c	Sun May  5 13:31:59 2002
@@ -58,6 +58,7 @@ swap_out_add_to_swap_cache(struct page *
 	int ret;
 
 	current->flags &= ~PF_MEMALLOC;
+	current->flags |= PF_RADIX_TREE;
 	ret = add_to_swap_cache(page, entry);
 	current->flags = flags;
 	return ret;
--- 2.5.13/mm/page_alloc.c~radix-tree-warning	Sun May  5 13:31:59 2002
+++ 2.5.13-akpm/mm/page_alloc.c	Sun May  5 13:32:36 2002
@@ -396,8 +396,11 @@ rebalance:
 				return page;
 		}
 nopage:
-		printk("%s: page allocation failure. order:%d, mode:0x%x\n",
-			current->comm, order, gfp_mask);
+		if (!(current->flags & PF_RADIX_TREE)) {
+			printk("%s: page allocation failure."
+				" order:%d, mode:0x%x\n",
+				current->comm, order, gfp_mask);
+		}
 		return NULL;
 	}
 
--- 2.5.13/include/linux/sched.h~radix-tree-warning	Sun May  5 13:31:59 2002
+++ 2.5.13-akpm/include/linux/sched.h	Sun May  5 13:32:15 2002
@@ -371,6 +371,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_FLUSHER	0x00004000	/* responsible for disk writeback */
+#define PF_RADIX_TREE	0x00008000	/* debug: performing radix tree alloc */
 
 /*
  * Ptrace flags

-
