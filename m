Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWIAGj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWIAGj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIAGj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:39:59 -0400
Received: from mx10.go2.pl ([193.17.41.74]:28595 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750750AbWIAGj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:39:58 -0400
Date: Fri, 1 Sep 2006 08:43:19 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] [ BUG: bad unlock balance detected! ] in 2.6.18-rc5
Message-ID: <20060901064319.GA2065@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some time ago I wrote about this bug in rc3.
I see it's still in 2.6.18-rc5 so here is what
I've found: with config like this:

CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set

spin_unlock_irqrestore() goes through lockdep
but spin_lock_irqrestore() doesn't.

I attach my proposal how to fix this.

Jarek P.

diff -Nru linux-2.6.18-rc5-/kernel/spinlock.c linux-2.6.18-rc5/kernel/spinlock.c
--- linux-2.6.18-rc5-/kernel/spinlock.c	2006-08-30 02:20:46.000000000 +0200
+++ linux-2.6.18-rc5/kernel/spinlock.c	2006-09-01 00:27:35.000000000 +0200
@@ -72,7 +72,7 @@
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
-	defined(CONFIG_PROVE_LOCKING)
+	defined(CONFIG_DEBUG_LOCK_ALLOC)
 
 void __lockfunc _read_lock(rwlock_t *lock)
 {
