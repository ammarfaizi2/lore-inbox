Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWBSCYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWBSCYo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 21:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWBSCYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 21:24:44 -0500
Received: from cabal.ca ([134.117.69.58]:20459 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750737AbWBSCYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 21:24:43 -0500
Date: Sat, 18 Feb 2006 21:23:36 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Decrapify asm-generic/local.h
Message-ID: <20060219022336.GZ13492@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The asm-generic/local.h BITS_PER_LONG == 64 case can best be described
as, uh, creative use of in_irq() and in_interrupt()... Now that Christoph
Lameter's atomic_long_t support is merged in mainline, might as well
convert asm-generic/local.h to use it, so the same code can be used
for both sizes of 32 and 64-bit unsigned longs.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

[NOTE, this patch was previously sent on February 9th]

Is there any particular reason why these routines weren't simply
implemented with local_save/restore_flags, if they are only meant to
guarantee atomicity to the local cpu? I'm sure on most platforms
this would be more efficient than using an atomic...

 local.h |   80 +++++++---------------------------------------------------------
 1 file changed, 9 insertions(+), 71 deletions(-)

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index 16fc003..de46148 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -4,28 +4,28 @@
 #include <linux/config.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <asm/atomic.h>
 #include <asm/types.h>
 
 /* An unsigned long type for operations which are atomic for a single
  * CPU.  Usually used in combination with per-cpu variables. */
 
-#if BITS_PER_LONG == 32
 /* Implement in terms of atomics. */
 
 /* Don't use typedef: don't want them to be mixed with atomic_t's. */
 typedef struct
 {
-	atomic_t a;
+	atomic_long_t a;
 } local_t;
 
-#define LOCAL_INIT(i)	{ ATOMIC_INIT(i) }
+#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
 
-#define local_read(l)	((unsigned long)atomic_read(&(l)->a))
-#define local_set(l,i)	atomic_set((&(l)->a),(i))
-#define local_inc(l)	atomic_inc(&(l)->a)
-#define local_dec(l)	atomic_dec(&(l)->a)
-#define local_add(i,l)	atomic_add((i),(&(l)->a))
-#define local_sub(i,l)	atomic_sub((i),(&(l)->a))
+#define local_read(l)	((unsigned long)atomic_long_read(&(l)->a))
+#define local_set(l,i)	atomic_long_set((&(l)->a),(i))
+#define local_inc(l)	atomic_long_inc(&(l)->a)
+#define local_dec(l)	atomic_long_dec(&(l)->a)
+#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
+#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
 
 /* Non-atomic variants, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well. */
@@ -34,68 +34,6 @@ typedef struct
 #define __local_add(i,l)	local_set((l), local_read(l) + (i))
 #define __local_sub(i,l)	local_set((l), local_read(l) - (i))
 
-#else /* ... can't use atomics. */
-/* Implement in terms of three variables.
-   Another option would be to use local_irq_save/restore. */
-
-typedef struct
-{
-	/* 0 = in hardirq, 1 = in softirq, 2 = usermode. */
-	unsigned long v[3];
-} local_t;
-
-#define _LOCAL_VAR(l)	((l)->v[!in_interrupt() + !in_irq()])
-
-#define LOCAL_INIT(i)	{ { (i), 0, 0 } }
-
-static inline unsigned long local_read(local_t *l)
-{
-	return l->v[0] + l->v[1] + l->v[2];
-}
-
-static inline void local_set(local_t *l, unsigned long v)
-{
-	l->v[0] = v;
-	l->v[1] = l->v[2] = 0;
-}
-
-static inline void local_inc(local_t *l)
-{
-	preempt_disable();
-	_LOCAL_VAR(l)++;
-	preempt_enable();
-}
-
-static inline void local_dec(local_t *l)
-{
-	preempt_disable();
-	_LOCAL_VAR(l)--;
-	preempt_enable();
-}
-
-static inline void local_add(unsigned long v, local_t *l)
-{
-	preempt_disable();
-	_LOCAL_VAR(l) += v;
-	preempt_enable();
-}
-
-static inline void local_sub(unsigned long v, local_t *l)
-{
-	preempt_disable();
-	_LOCAL_VAR(l) -= v;
-	preempt_enable();
-}
-
-/* Non-atomic variants, ie. preemption disabled and won't be touched
- * in interrupt, etc.  Some archs can optimize this case well. */
-#define __local_inc(l)		((l)->v[0]++)
-#define __local_dec(l)		((l)->v[0]--)
-#define __local_add(i,l)	((l)->v[0] += (i))
-#define __local_sub(i,l)	((l)->v[0] -= (i))
-
-#endif /* Non-atomic implementation */
-
 /* Use these for per-cpu local_t variables: on some archs they are
  * much more efficient than these naive implementations.  Note they take
  * a variable (eg. mystruct.foo), not an address.
