Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVLVLoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVLVLoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVLVLn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:43:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36994 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932257AbVLVLnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:43:19 -0500
Date: Thu, 22 Dec 2005 12:42:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 6/9] mutex subsystem, switch ARM to use the xchg based implementation
Message-ID: <20051222114240.GG18878@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as noted by Nicolas Pitre, atomic_[inc/dec]_call_if_[nonpositive/negative]()
atomic methods are slow on ARM, because they can only be implemented via
disabling interrupts. So tell the mutex code that we prefer atomic_xchg().

[ we still pull in asm-generic/atomic-call-if.h, so that they remain
  generally available primitives - even though unused on ARM at the
  moment. ]

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-arm/atomic.h |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

Index: linux/include/asm-arm/atomic.h
===================================================================
--- linux.orig/include/asm-arm/atomic.h
+++ linux/include/asm-arm/atomic.h
@@ -180,14 +180,16 @@ static inline void atomic_clear_mask(uns
 /*
  * Pull in the generic wrappers for atomic_dec_call_if_negative() and
  * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or use the __ARCH_WANT_XCHG_BASED_ATOMICS
- * mechanism to tell the generic mutex code to use the atomic_xchg()
- * based fastpath implementation.
  */
 #include <asm-generic/atomic-call-if.h>
 
+/*
+ * The atomic_[inc/dec]_call_if_[nonpositive/negative]() atomic methods
+ * are slow on ARM, because they can only be implemented via disabling
+ * interrupts. Tell the mutex code that we prefer atomic_xchg():
+ */
+#define __ARCH_WANT_XCHG_BASED_ATOMICS
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
