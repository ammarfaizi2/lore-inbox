Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264269AbSIQPgj>; Tue, 17 Sep 2002 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264297AbSIQPgj>; Tue, 17 Sep 2002 11:36:39 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:34265 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264269AbSIQPgi>; Tue, 17 Sep 2002 11:36:38 -0400
Message-ID: <3D874DA1.20803@drugphish.ch>
Date: Tue, 17 Sep 2002 17:43:29 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TLB flush counters gone in 2.5.35-bk?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was just browsing over the latest bk tree when I saw the following change:

--- a/include/asm-generic/tlb.h Thu Aug 29 13:27:24 2002
+++ b/include/asm-generic/tlb.h Mon Sep  9 14:58:18 2002
@@ -21,7 +21,7 @@
   * and page free order so much..
   */
  #ifdef CONFIG_SMP
-  #define FREE_PTE_NR  507
+  #define FREE_PTE_NR  506
    #define tlb_fast_mode(tlb) ((tlb)->nr == ~0U)
  #else
    #define FREE_PTE_NR  1
@@ -40,8 +40,6 @@
         unsigned int            fullmm; /* non-zero means full mm flush */
         unsigned long           freed;
         struct page *           pages[FREE_PTE_NR];
-       unsigned long           flushes;/* stats: count avoided flushes */
-       unsigned long           avoided_flushes;
  } mmu_gather_t;

  /* Users of the generic TLB shootdown code must declare this storage 
space. */
@@ -67,17 +65,10 @@

  static inline void tlb_flush_mmu(mmu_gather_t *tlb, unsigned long 
start, unsigned long en
d)
  {
-       unsigned long nr;
-
-       if (!tlb->need_flush) {
-               tlb->avoided_flushes++;
+       if (!tlb->need_flush)
                 return;
-       }
         tlb->need_flush = 0;
-       tlb->flushes++;
-
         tlb_flush(tlb);
-       nr = tlb->nr;
         if (!tlb_fast_mode(tlb)) {
                 free_pages_and_swap_cache(tlb->pages, tlb->nr);
                 tlb->nr = 0;

Why was that done? I'm actually about to conduct some tests where I 
think that I need this information to check the L1 <-> L2 caching size 
influence on kernel data structures. What is the problem with the 
existing counters, did I miss some discussion on LKML?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

