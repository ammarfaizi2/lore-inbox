Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318408AbSGYK4x>; Thu, 25 Jul 2002 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318410AbSGYK4x>; Thu, 25 Jul 2002 06:56:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:17288 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318408AbSGYK4w>;
	Thu, 25 Jul 2002 06:56:52 -0400
Date: Thu, 25 Jul 2002 10:59:32 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com, akpm@zip.com.au, torvalds@transmeta.com,
       jsantos@austin.ibm.com
Subject: [PATCH] Missing memory barrier in pte_chain_unlock
Message-ID: <20020725005932.GA18140@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On a ppc64 machine running 2.5.28 we were hitting this BUG in
__free_pages_ok:

BUG_ON(page->pte.chain != NULL);

In pte_chain_lock we use test_and_set_bit which implies a memory
barrier. In pte_chain_unlock we use clear_bit which has no memory
barriers so we need to add one.

Anton

===== include/linux/page-flags.h 1.12 vs edited =====
--- 1.12/include/linux/page-flags.h	Wed Jul 17 07:46:30 2002
+++ edited/include/linux/page-flags.h	Thu Jul 25 19:24:52 2002
@@ -249,6 +248,7 @@
 
 static inline void pte_chain_unlock(struct page *page)
 {
+	smp_mb__before_clear_bit();
 	clear_bit(PG_chainlock, &page->flags);
 	preempt_enable();
 }
