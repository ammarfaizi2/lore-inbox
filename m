Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVLZT02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLZT02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLZT02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:26:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9189 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932126AbVLZT01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:26:27 -0500
Date: Mon, 26 Dec 2005 14:26:26 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 3/3] mutex subsystem: inline mutex_is_locked()
In-reply-to: <20051223161649.GA26830@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512261416370.1496@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is currently no advantage to not always inlining mutex_is_locked,
even on x86.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -22,19 +22,6 @@
 # include "mutex.h"
 #endif
 
-/***
- * mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-int fastcall mutex_is_locked(struct mutex *lock)
-{
-	return atomic_read(&lock->count) != 1;
-}
-
-EXPORT_SYMBOL(mutex_is_locked);
-
 /*
  * Block on a lock - add ourselves to the list of waiters.
  * Called with lock->wait_lock held.
Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -139,6 +139,9 @@ extern int FASTCALL(mutex_trylock(struct
 extern void FASTCALL(mutex_unlock(struct mutex *lock));
 #endif
 
-extern int FASTCALL(mutex_is_locked(struct mutex *lock));
+static inline int fastcall mutex_is_locked(struct mutex *lock)
+{
+	return atomic_read(&lock->count) != 1;
+}
 
 #endif
