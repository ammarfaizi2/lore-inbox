Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWJPNLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWJPNLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWJPNLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:11:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750798AbWJPNLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:11:12 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Use the correct preemption primitives in kmap_atomic() and co [try #2]
Date: Mon, 16 Oct 2006 14:10:49 +0100
To: torvalds@osdl.org, akpm@osdl.org, a.p.zijlstra@chello.nl
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061016131049.28249.16488.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Use inc/dec_preempt_count() rather than preempt_enable/disable() and manually
add in the compiler barriers that were provided by the latter.  This makes FRV
consistent with other archs.

Furthermore, the compiler barrier effects are now there unconditionally - at
least as far as preemption is concerned - because we don't want the compiler
moving memory accesses out of the section of code in which the mapping is in
force - in effect the kmap_atomic() must imply a LOCK-class barrier and the
kunmap_atomic() must imply an UNLOCK-class barrier to the compiler.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/highmem.h |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/asm-frv/highmem.h b/include/asm-frv/highmem.h
index e2247c2..0f390f4 100644
--- a/include/asm-frv/highmem.h
+++ b/include/asm-frv/highmem.h
@@ -82,11 +82,11 @@ ({												\
 	dampr = paddr | xAMPRx_L | xAMPRx_M | xAMPRx_S | xAMPRx_SS_16Kb | xAMPRx_V;		\
 												\
 	if (type != __KM_CACHE)									\
-		asm volatile("movgs %0,dampr"#ampr :: "r"(dampr));				\
+		asm volatile("movgs %0,dampr"#ampr :: "r"(dampr) : "memory");			\
 	else											\
 		asm volatile("movgs %0,iampr"#ampr"\n"						\
 			     "movgs %0,dampr"#ampr"\n"						\
-			     :: "r"(dampr)							\
+			     :: "r"(dampr) : "memory"						\
 			     );									\
 												\
 	asm("movsg damlr"#ampr",%0" : "=r"(damlr));						\
@@ -104,7 +104,7 @@ ({												  \
 	asm volatile("movgs %0,tplr \n"								  \
 		     "movgs %1,tppr \n"								  \
 		     "tlbpr %0,gr0,#2,#1"							  \
-		     : : "r"(damlr), "r"(dampr));						  \
+		     : : "r"(damlr), "r"(dampr) : "memory");					  \
 												  \
 	/*printk("TLB: SECN sl=%d L=%08lx P=%08lx\n", slot, damlr, dampr);*/			  \
 												  \
@@ -115,7 +115,7 @@ static inline void *kmap_atomic(struct p
 {
 	unsigned long paddr;
 
-	preempt_disable();
+	inc_preempt_count();
 	paddr = page_to_phys(page);
 
 	switch (type) {
@@ -138,16 +138,16 @@ static inline void *kmap_atomic(struct p
 	}
 }
 
-#define __kunmap_atomic_primary(type, ampr)			\
-do {								\
-	asm volatile("movgs gr0,dampr"#ampr"\n");		\
-	if (type == __KM_CACHE)					\
-		asm volatile("movgs gr0,iampr"#ampr"\n");	\
+#define __kunmap_atomic_primary(type, ampr)				\
+do {									\
+	asm volatile("movgs gr0,dampr"#ampr"\n" ::: "memory");		\
+	if (type == __KM_CACHE)						\
+		asm volatile("movgs gr0,iampr"#ampr"\n" ::: "memory");	\
 } while(0)
 
-#define __kunmap_atomic_secondary(slot, vaddr)			\
-do {								\
-	asm volatile("tlbpr %0,gr0,#4,#1" : : "r"(vaddr));	\
+#define __kunmap_atomic_secondary(slot, vaddr)				\
+do {									\
+	asm volatile("tlbpr %0,gr0,#4,#1" : : "r"(vaddr) : "memory");	\
 } while(0)
 
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
@@ -170,7 +170,8 @@ static inline void kunmap_atomic(void *k
 	default:
 		BUG();
 	}
-	preempt_enable();
+	dec_preempt_count();
+	preempt_check_resched();
 }
 
 #endif /* !__ASSEMBLY__ */
