Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWGFIVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWGFIVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWGFIVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:21:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:908 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964990AbWGFIVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:21:16 -0400
Date: Thu, 6 Jul 2006 10:16:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: [patch] spinlocks: remove 'volatile'
Message-ID: <20060706081639.GA24179@elte.hu>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I wonder if we should remove the "volatile". There really isn't 
> anything _good_ that gcc can do with it, but we've seen gcc code 
> generation do stupid things before just because "volatile" seems to 
> just disable even proper normal working.

yeah. I tried this and it indeed slashed 42K off text size (0.2%):

 text            data    bss     dec             filename
 20779489        6073834 3075176 29928499        vmlinux.volatile
 20736884        6073834 3075176 29885894        vmlinux.non-volatile

i booted the resulting allyesconfig bzImage and everything seems to be 
working fine. Find patch below.

	Ingo

------------------>
Subject: spinlocks: remove 'volatile'
From: Ingo Molnar <mingo@elte.hu>

remove 'volatile' from the spinlock types, it causes gcc to
generate really bad code. (and it's pointless anyway)

this reduces the non-debug SMP kernel's size by 0.2% (!).

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-i386/spinlock_types.h   |    4 ++--
 include/asm-x86_64/spinlock_types.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/include/asm-i386/spinlock_types.h
===================================================================
--- linux.orig/include/asm-i386/spinlock_types.h
+++ linux/include/asm-i386/spinlock_types.h
@@ -6,13 +6,13 @@
 #endif
 
 typedef struct {
-	volatile unsigned int slock;
+	unsigned int slock;
 } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
 
 typedef struct {
-	volatile unsigned int lock;
+	unsigned int lock;
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
Index: linux/include/asm-x86_64/spinlock_types.h
===================================================================
--- linux.orig/include/asm-x86_64/spinlock_types.h
+++ linux/include/asm-x86_64/spinlock_types.h
@@ -6,13 +6,13 @@
 #endif
 
 typedef struct {
-	volatile unsigned int slock;
+	unsigned int slock;
 } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
 
 typedef struct {
-	volatile unsigned int lock;
+	unsigned int lock;
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
