Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWAJVHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWAJVHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWAJVHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:07:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:3240 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932653AbWAJVHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:07:40 -0500
Date: Tue, 10 Jan 2006 22:07:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] fix i386 mutex fastpath on FRAME_POINTER && !DEBUG_MUTEXES
Message-ID: <20060110210744.GA8850@elte.hu>
References: <Pine.LNX.4.61.0601101718570.2942@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601101718570.2942@goblin.wat.veritas.com>
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


* Hugh Dickins <hugh@veritas.com> wrote:

> I find the 2.6.15-git6 i386 CONFIG_FRAME_POINTER=y doesn't work unless 
> CONFIG_DEBUG_MUTEXES=y, because of the __mutex_fastpath jumps to 
> fail_fn (giving two pushes of %ebp to one pop).  Whereas x86_64 
> __mutex_fastpaths use calls and work with FRAME_POINTER=y.  Whether 
> i386 deserves asm mods rather than Kconfigery to force one from other, 
> I've no strong instinct.

ah, good eyes! This explains some of the crashes i saw today. The patch 
below solves it. Build and boot tested on x86. Linus, please apply.

	Ingo

--
call the mutex slowpath more conservatively - e.g. FRAME_POINTERS can
change the calling convention, in which case a direct branch to the
slowpath becomes illegal. Bug found by Hugh Dickins.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-i386/mutex.h |   16 ++++++++++++++--
 kernel/mutex.c           |    9 ---------
 2 files changed, 14 insertions(+), 11 deletions(-)

Index: linux/include/asm-i386/mutex.h
===================================================================
--- linux.orig/include/asm-i386/mutex.h
+++ linux/include/asm-i386/mutex.h
@@ -28,7 +28,13 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 		LOCK	"   decl (%%eax)	\n"			\
-			"   js "#fail_fn"	\n"			\
+			"   js 2f		\n"			\
+			"1:			\n"			\
+									\
+		LOCK_SECTION_START("")					\
+			"2: call "#fail_fn"	\n"			\
+			"   jmp 1b		\n"			\
+		LOCK_SECTION_END					\
 									\
 		:"=a" (dummy)						\
 		: "a" (count)						\
@@ -78,7 +84,13 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 		LOCK	"   incl (%%eax)	\n"			\
-			"   jle "#fail_fn"	\n"			\
+			"   jle 2f		\n"			\
+			"1:			\n"			\
+									\
+		LOCK_SECTION_START("")					\
+			"2: call "#fail_fn"	\n"			\
+			"   jmp 1b		\n"			\
+		LOCK_SECTION_END					\
 									\
 		:"=a" (dummy)						\
 		: "a" (count)						\
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -84,12 +84,6 @@ void fastcall __sched mutex_lock(struct 
 	/*
 	 * The locking fastpath is the 1->0 transition from
 	 * 'unlocked' into 'locked' state.
-	 *
-	 * NOTE: if asm/mutex.h is included, then some architectures
-	 * rely on mutex_lock() having _no other code_ here but this
-	 * fastpath. That allows the assembly fastpath to do
-	 * tail-merging optimizations. (If you want to put testcode
-	 * here, do it under #ifndef CONFIG_MUTEX_DEBUG.)
 	 */
 	__mutex_fastpath_lock(&lock->count, __mutex_lock_slowpath);
 }
@@ -115,8 +109,6 @@ void fastcall __sched mutex_unlock(struc
 	/*
 	 * The unlocking fastpath is the 0->1 transition from 'locked'
 	 * into 'unlocked' state:
-	 *
-	 * NOTE: no other code must be here - see mutex_lock() .
 	 */
 	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_slowpath);
 }
@@ -261,7 +253,6 @@ __mutex_lock_interruptible_slowpath(atom
  */
 int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
 {
-	/* NOTE: no other code must be here - see mutex_lock() */
 	return __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_slowpath);
 }
