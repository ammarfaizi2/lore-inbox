Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWAGEGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWAGEGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWAGEGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:06:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57466 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932662AbWAGEF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:05:59 -0500
Date: Fri, 06 Jan 2006 23:05:58 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 03/21] mutex subsystem,
 add asm-generic/mutex-[dec|xchg|null].h implementations
In-reply-to: <20060105153716.GD31013@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Message-id: <Pine.LNX.4.64.0601062247370.13870@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060105153716.GD31013@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Ingo Molnar wrote:

> 
> Add three (generic) mutex fastpath implementations.
> 
> The mutex-xchg.h implementation is atomic_xchg() based, and should
> work fine on every architecture.
> 
> The mutex-dec.h implementation is atomic_dec_return() based - this
> one too should work on every architecture, but might not perform the
> most optimally on architectures that have no atomic-dec/inc instructions.
> 
> The mutex-null.h implementation forces all calls into the slowpath. This
> is used for mutex debugging, but it can also be used on platforms that do
> not want (or need) a fastpath at all.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>

What about this patch that turns some macros into inline functions? It 
adds proper type checking as well as being more readable.

I was under the impression that, at least on ARM, the passing of a 
function pointer to an inline function would have caused indirect calls 
through that function pointer but that doesn't seem to be true.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/include/asm-generic/mutex-dec.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-dec.h
+++ linux-2.6/include/asm-generic/mutex-dec.h
@@ -17,11 +17,12 @@
  * it wasn't 1 originally. This function MUST leave the value lower than
  * 1 even when the "1" assertion wasn't true.
  */
-#define __mutex_fastpath_lock(count, fail_fn)				\
-do {									\
-	if (unlikely(atomic_dec_return(count) < 0))			\
-		fail_fn(count);						\
-} while (0)
+static inline void
+__mutex_fastpath_lock(atomic_t *count, fastcall void (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_dec_return(count) < 0))
+		fail_fn(count);
+}
 
 /**
  *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
@@ -34,7 +35,7 @@ do {									\
  * or anything the slow path function returns.
  */
 static inline int
-__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
+__mutex_fastpath_lock_retval(atomic_t *count, fastcall int (*fail_fn)(atomic_t *))
 {
 	if (unlikely(atomic_dec_return(count) < 0))
 		return fail_fn(count);
@@ -55,11 +56,12 @@ __mutex_fastpath_lock_retval(atomic_t *c
  * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
  * to return 0 otherwise.
  */
-#define __mutex_fastpath_unlock(count, fail_fn)				\
-do {									\
-	if (unlikely(atomic_inc_return(count) <= 0))			\
-		fail_fn(count);						\
-} while (0)
+static inline void
+__mutex_fastpath_unlock(atomic_t *count, fastcall void (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_inc_return(count) <= 0))
+		fail_fn(count);
+}
 
 #define __mutex_slowpath_needs_to_unlock()		1
 
Index: linux-2.6/include/asm-generic/mutex-xchg.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-xchg.h
+++ linux-2.6/include/asm-generic/mutex-xchg.h
@@ -22,12 +22,12 @@
  * wasn't 1 originally. This function MUST leave the value lower than 1
  * even when the "1" assertion wasn't true.
  */
-#define __mutex_fastpath_lock(count, fail_fn)				\
-do {									\
-	if (unlikely(atomic_xchg(count, 0) != 1))			\
-		fail_fn(count);						\
-} while (0)
-
+static inline void
+__mutex_fastpath_lock(atomic_t *count, fastcall void (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_xchg(count, 0) != 1))
+		fail_fn(count);
+}
 
 /**
  *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
@@ -40,7 +40,7 @@ do {									\
  * or anything the slow path function returns
  */
 static inline int
-__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
+__mutex_fastpath_lock_retval(atomic_t *count, fastcall int (*fail_fn)(atomic_t *))
 {
 	if (unlikely(atomic_xchg(count, 0) != 1))
 		return fail_fn(count);
@@ -60,11 +60,12 @@ __mutex_fastpath_lock_retval(atomic_t *c
  * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
  * to return 0 otherwise.
  */
-#define __mutex_fastpath_unlock(count, fail_fn)				\
-do {									\
-	if (unlikely(atomic_xchg(count, 1) != 0))			\
-		fail_fn(count);						\
-} while (0)
+static inline void
+__mutex_fastpath_unlock(atomic_t *count, fastcall void (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_xchg(count, 1) != 0))
+		fail_fn(count);
+}
 
 #define __mutex_slowpath_needs_to_unlock()		0
 
