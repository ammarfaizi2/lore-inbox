Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVDVRhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVDVRhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVDVRhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:9425 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262077AbVDVRhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:37:09 -0400
Date: Fri, 22 Apr 2005 19:37:03 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Chris Wright <chrisw@osdl.org>, Andi Kleen <ak@suse.de>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Debugging patch was Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050422173703.GB7715@wotan.suse.de>
References: <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050415180703.GA26289@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415180703.GA26289@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can people who can reproduce the x86-64 2.6.11 pmd bad  problem please apply
the following patch and see (a) if it can be still reprocuded with it 
and send the output generated. Also a strace of the program that showed
it (pid and name of it should be dumped) would be useful if not too big.

After staring some time at the code I cant find the problem, but 
I somehow suspect it has to do with early page table frees. That is
why they were disabled. This should not cause any memory leaks,
the page tables will be always freed at process exit, so it is
safe to apply even for production machines.

Thanks,

-Andi


diff -u linux-2.6.11/mm/memory.c-o linux-2.6.11/mm/memory.c
--- linux-2.6.11/mm/memory.c-o	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11/mm/memory.c	2005-04-22 19:32:30.305402456 +0200
@@ -94,6 +94,7 @@
 	if (pmd_none(*pmd))
 		return;
 	if (unlikely(pmd_bad(*pmd))) {
+		printk("%s:%d: ", current->comm, current->pid);
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
diff -u linux-2.6.11/mm/mmap.c-o linux-2.6.11/mm/mmap.c
--- linux-2.6.11/mm/mmap.c-o	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.11/mm/mmap.c	2005-04-22 19:33:10.354580428 +0200
@@ -1645,11 +1645,13 @@
 		return;
 	if (first < FIRST_USER_PGD_NR * PGDIR_SIZE)
 		first = FIRST_USER_PGD_NR * PGDIR_SIZE;
+#if 0
 	/* No point trying to free anything if we're in the same pte page */
 	if ((first & PMD_MASK) < (last & PMD_MASK)) {
 		clear_page_range(tlb, first, last);
 		flush_tlb_pgtables(mm, first, last);
 	}
+#endif
 }
 
 /* Normal function to fix up a mapping

