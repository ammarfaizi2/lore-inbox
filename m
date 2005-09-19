Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVISQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVISQYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 12:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVISQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 12:24:37 -0400
Received: from motgate4.mot.com ([144.189.100.102]:60098 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id S932493AbVISQYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 12:24:36 -0400
Message-ID: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
From: Smarduch Mario-CMS063 <CMS063@motorola.com>
To: linux-kernel@vger.kernel.org
Subject: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
Date: Mon, 19 Sep 2005 11:24:24 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MMU/Kernel experts,
    
    recently I've been involved in debugging MT forks on IA-64 the issues
found were related to the way IA64 does its TLB invalidation. But there
is still one  issue that appears to be Linux in general related, and it
has to do with MT forks. 
 
For example a process has 3 threads T1, T2, T3.
 
1 - T1 issues a fork()
    - under page_table_lock write bit is reset in src and dest pte's
2 - T2 may have a TLB mis, the new write protected pte is inserted
    (hw walker or sw tlb hdlr)
3 - T2 winds up in do_wp_page() the page is copied to a new one
4 - In the mean time T3 may be working off the same page, the
    TLB invalidation (flush_tlb_mm()) has no occurred yet.
5 - Eventually TLB is globally flushed so threads will see the new pte.
6 - As a result the MT task may experience inconsisitent state.
    - During 3 & 4. For example locks may be acquired by both
      threads depending on the timing of the copy.

The TLB refill (hw/sw) work independently of the page_table_lock,
it seems all threads should be forced to see the new pte
before the new page is copied over by forcing the pte to 0 
and allowing page_table_lock to synchronize the threads.

I come from an SVR4 background and relatively new to
Linux, any insights or corrections would be greatly appreciated.
Please copy my email id as its to miss email on this list.

	- mario.
  
