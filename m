Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVCTVpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVCTVpI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVCTVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:45:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:30172 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261285AbVCTVoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:44:55 -0500
Date: Sun, 20 Mar 2005 22:46:38 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, Ingo Molnar <mingo@redhat.com>,
       Robert Love <rml@tech9.net>
Subject: [RFC] spinlock_t & rwlock_t break_lock member initialization (patch
 seeking comments included)
Message-ID: <Pine.LNX.4.62.0503202205480.2508@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm often building the tree with gcc -W to look for potential trouble 
spots, and of course I see a lot of warning messages. I'm well aware that 
most of these don't indicate actual problems and should just be ignored, 
but the less warnings there are the easier it is to zoom in on the ones 
that might actually matter, so I try to also locate those that can be 
silenced safely even when they don't indicate a real problem - just to cut 
down on the number of warnings I have to sift through.
One class of warnings that belong in the "not really a problem but I 
believe I can silence it without doing any harm" category are these : 

include/linux/wait.h:82: warning: missing initializer
include/linux/wait.h:82: warning: (near initialization for `(anonymous).break_lock')

include/asm/rwsem.h:88: warning: missing initializer
include/asm/rwsem.h:88: warning: (near initialization for `(anonymous).break_lock')

These stem from the fact that when you enable CONFIG_PREEMPT spinlock_t 
and rwlock_t each gain an extra member "break_lock", but the lock 
initialization code neglects to initialize this extra member in that case.

If you enable CONFIG_PREEMPT and build with gcc -W you'll see a *lot* of 
those, since spinlocks and rwlocks are used all over the place.

I've come up with a patch to that silence those warnings by making sure 
the "break_lock" member will be initialized when CONFIG_PREEMPT is 
enabled.

I would like to know if a patch like this is welcome or just considered 
clutter for no real gain. I would also like to know if I've overlooked 
some implications of doing this - it seems to me that this should be 
completely safe to do and without significant overhead, but I'm also well 
aware that my knowledge of this code is quite shallow, so I need comments 
(especially since lock performance is quite performance critical, so I 
don't want to screw up here).

Here's the patch I came up with - comments are very welcome.


(no Signed-off-by since this is not intended to be merged just yet)

--- linux-2.6.11-mm4-orig/include/asm-i386/spinlock.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11-mm4/include/asm-i386/spinlock.h	2005-03-20 22:40:46.000000000 +0100
@@ -32,7 +32,13 @@
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
 
@@ -182,7 +188,13 @@
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
 

