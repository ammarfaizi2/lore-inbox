Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVDHX7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDHX7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVDHX7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:59:12 -0400
Received: from mail.dif.dk ([193.138.115.101]:910 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261204AbVDHX7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:59:05 -0400
Date: Sat, 9 Apr 2005 02:01:37 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Ingo Molnar <mingo@redhat.com>,
       Robert Love <rml@tech9.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] silence spinlock/rwlock uninitialized break_lock member
 warnings
Message-ID: <Pine.LNX.4.62.0504090150520.2455@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Any chance this patch could be added to -mm (and possibly mainline)?

It removes a bunch of warnings when building with gcc -W, like these:
include/linux/wait.h:82: warning: missing initializer
include/linux/wait.h:82: warning: (near initialization for `(anonymous).break_lock')
include/asm/rwsem.h:88: warning: missing initializer
include/asm/rwsem.h:88: warning: (near initialization for `(anonymous).break_lock')
so there's less to sift through when looking for real problems with this 
patch applied. 
I've been using it for a while with no ill effects.

This patch has surfaced previously, please see the lkml thread 
"[RFC] spinlock_t & rwlock_t break_lock member initialization (patch seeking comments included)" 


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

---

 spinlock.h |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)


--- linux-2.6.12-rc2-mm2-orig/include/asm-i386/spinlock.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc2-mm2/include/asm-i386/spinlock.h	2005-04-09 01:49:48.000000000 +0200
@@ -32,7 +32,13 @@ typedef struct {
 #define SPINLOCK_MAGIC_INIT	/* */
 #endif
 
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
+#ifdef CONFIG_PREEMPT
+#define SPINLOCK_BREAK_INIT	, 0
+#else
+#define SPINLOCK_BREAK_INIT	/* */
+#endif
+
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT SPINLOCK_BREAK_INIT }
 
 #define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 
@@ -182,7 +188,13 @@ typedef struct {
 #define RWLOCK_MAGIC_INIT	/* */
 #endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
+#ifdef CONFIG_PREEMPT
+#define RWLOCK_BREAK_INIT	, 0
+#else
+#define RWLOCK_BREAK_INIT	/* */
+#endif
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT RWLOCK_BREAK_INIT }
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 



