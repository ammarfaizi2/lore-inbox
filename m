Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVASAPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVASAPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVASAPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:15:30 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:17134 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261498AbVASAPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:15:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16877.42598.336096.561224@wombat.chubb.wattle.id.au>
Date: Wed, 19 Jan 2005 11:14:30 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Tony Luck <tony.luck@intel.com>
Cc: Darren Williams <dsw@gelato.unsw.edu.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, Ia64 Linux <linux-ia64@vger.kernel.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
In-Reply-To: <20050118014752.GA14709@cse.unsw.EDU.AU>
References: <20050117055044.GA3514@taniwha.stupidest.org>
	<20050116230922.7274f9a2.akpm@osdl.org>
	<20050117143301.GA10341@elte.hu>
	<20050118014752.GA14709@cse.unsw.EDU.AU>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here's a patch that adds the missing read_is_locked() and
write_is_locked() macros for IA64.  When combined with Ingo's patch, I
can boot an SMP kernel with CONFIG_PREEMPT on.

However, I feel these macros are misnamed: read_is_locked() returns true if
the lock is held for writing; write_is_locked() returns true if the
lock is held for reading or writing.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

Index: linux-2.6-bklock/include/asm-ia64/spinlock.h
===================================================================
--- linux-2.6-bklock.orig/include/asm-ia64/spinlock.h	2005-01-18 13:46:08.138077857 +1100
+++ linux-2.6-bklock/include/asm-ia64/spinlock.h	2005-01-19 08:58:59.303821753 +1100
@@ -126,8 +126,20 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
 #define rwlock_is_locked(x)	(*(volatile int *) (x) != 0)
 
+/* read_is_locked --  - would read_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define read_is_locked(x)       (*(volatile int *) (x) < 0)
+
+/**
+ * write_is_locked - would write_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define write_is_locked(x)	(*(volatile int *) (x) != 0)
+
 #define _raw_read_lock(rw)								\
 do {											\
 	rwlock_t *__read_lock_ptr = (rw);						\

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
