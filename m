Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSHOMfq>; Thu, 15 Aug 2002 08:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSHOMfp>; Thu, 15 Aug 2002 08:35:45 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:11662 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S316860AbSHOMfm>; Thu, 15 Aug 2002 08:35:42 -0400
Date: Thu, 15 Aug 2002 21:39:29 +0900 (JST)
Message-Id: <20020815.213929.846960657.nomura@hpc.bs1.fc.nec.co.jp>
To: linux-kernel@vger.kernel.org
Cc: j-nomura@ce.jp.nec.com
Subject: 2.4.18(19) swapcache oops
From: j-nomura@ce.jp.nec.com
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using 2.4.18 kernel and suspect there are swapcache race. 
I looked into 2.4.19 patch but could not find the fix to it.

The race condition is described below.
Do you have any idea?


In the situation such as:
  - two processes (process A and B) sharing memory space
  - one of the pages in the space has been swapped out and
    not remained in swapcache
  - process A runs on cpu0, process B runs on cpu1

when process A reads the address corresponding to the page,
page fault occurs and the cpu0 reads swapped-out page into memory,
calls add_to_page_cache_unique() to add it to swapcache and then
calls lru_cache_add() to add it to lru list.

If process B reads the same address at that time, cpu1 calls
do_swap_page() and lookup_swap_cache() may succeed before cpu0
calls lru_cache_add() and cpu1 will set the page active by
following mark_page_accessed().

lru_cache_add() checks if the page is active and if it is active,
it calls BUG().

   process A                          process B
   cpu0                               cpu1
   -----------------------------------------------------------
   do_swap_page()
    spinunlock(mm->page_table_lock)
                                     spinlock(mm->page_table_lock)
    lookup_swap_cache()
    read_swap_cache_async()
     alloc_page()
     add_to_swap_cache_unique()
       __add_to_page_cache()
                                      do_swap_page()
                                        lookup_swap_cache()
                                        mark_page_accessed()
       lru_cache_add()


Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
HPC Operating System Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.
