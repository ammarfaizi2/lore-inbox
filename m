Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVLVPj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVLVPj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLVPjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:39:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48325 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751162AbVLVPi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:38:57 -0500
Date: Thu, 22 Dec 2005 16:38:10 +0100
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
Subject: [patch 07/10] mutex subsystem, switch ARM to use the xchg based implementation
Message-ID: <20051222153810.GH6090@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
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

 arch/arm/Kconfig         |    4 ++++
 include/asm-arm/atomic.h |    7 +------
 2 files changed, 5 insertions(+), 6 deletions(-)

Index: linux/arch/arm/Kconfig
===================================================================
--- linux.orig/arch/arm/Kconfig
+++ linux/arch/arm/Kconfig
@@ -50,6 +50,10 @@ config UID16
 	bool
 	default y
 
+config MUTEX_XCHG_ALGORITHM
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: linux/include/asm-arm/atomic.h
===================================================================
--- linux.orig/include/asm-arm/atomic.h
+++ linux/include/asm-arm/atomic.h
@@ -179,12 +179,7 @@ static inline void atomic_clear_mask(uns
 
 /*
  * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
+ * atomic_inc_call_if_nonpositive():
  */
 #include <asm-generic/atomic-call-if.h>
 
