Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318920AbSG1HaD>; Sun, 28 Jul 2002 03:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSG1HWa>; Sun, 28 Jul 2002 03:22:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318920AbSG1HVC>;
	Sun, 28 Jul 2002 03:21:02 -0400
Message-ID: <3D439E20.5AEB8FBE@zip.com.au>
Date: Sun, 28 Jul 2002 00:32:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/13] speed up pte_chain locking on uniprocessors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ifdef out some operations in pte_chain_lock() which are not necessary
on uniprocessor.


 page-flags.h |    4 ++++
 1 files changed, 4 insertions(+)

--- 2.5.29/include/linux/page-flags.h~SMP-pte_chain_lock	Sat Jul 27 23:39:04 2002
+++ 2.5.29-akpm/include/linux/page-flags.h	Sat Jul 27 23:39:04 2002
@@ -240,16 +240,20 @@ static inline void pte_chain_lock(struct
 	 * attempt to acquire the lock bit.
 	 */
 	preempt_disable();
+#ifdef CONFIG_SMP
 	while (test_and_set_bit(PG_chainlock, &page->flags)) {
 		while (test_bit(PG_chainlock, &page->flags))
 			cpu_relax();
 	}
+#endif
 }
 
 static inline void pte_chain_unlock(struct page *page)
 {
+#ifdef CONFIG_SMP
 	smp_mb__before_clear_bit();
 	clear_bit(PG_chainlock, &page->flags);
+#endif
 	preempt_enable();
 }
 

.
