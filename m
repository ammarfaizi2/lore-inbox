Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRJIKaV>; Tue, 9 Oct 2001 06:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273985AbRJIKaM>; Tue, 9 Oct 2001 06:30:12 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45061 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S273976AbRJIK35>; Tue, 9 Oct 2001 06:29:57 -0400
Date: Tue, 9 Oct 2001 14:30:13 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.11-pre5] atomic_dec_and_lock() for alpha
Message-ID: <20011009143013.A2884@jurassic.park.msu.ru>
In-Reply-To: <20011008194257.A705@jurassic.park.msu.ru> <20011008102412.A24348@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011008102412.A24348@twiddle.net>; from rth@twiddle.net on Mon, Oct 08, 2001 at 10:24:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 10:24:12AM -0700, Richard Henderson wrote:
> I am extremely uncomfortable with you returning out of the middle of
> an asm statement.  What if the compiler decides to allocate a stack
> frame for some reason?  You'll return without deallocating it.

Indeed.

> Please write the whole thing in assembly or avoid the early return.

OK. I prefer the latter - rewriting in assembly won't allow DEBUG_SPINLOCK
stuff in this function. OTOH, moving the return outside an asm statement
adds only one instruction - conditional branch that falls through in the
fast path.

Ivan.

--- 2.4.11p5/arch/alpha/lib/dec_and_lock.c	Thu Jan  1 00:00:00 1970
+++ linux/arch/alpha/lib/dec_and_lock.c	Tue Oct  9 14:15:01 2001
@@ -0,0 +1,37 @@
+/*
+ * arch/alpha/lib/dec_and_lock.c
+ *
+ * ll/sc version of atomic_dec_and_lock()
+ */
+
+#include <linux/compiler.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+
+int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+	long cnt;
+	__asm__ __volatile__(
+	"1:	ldl_l	%0,%1\n"
+	"	subl	%0,1,%0\n"
+	"	beq	%0,2f\n"
+	"	stl_c	%0,%1\n"
+	"	beq	%0,3f\n"
+	"	mb\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br	1b\n"
+	".previous"
+	:"=&r" (cnt), "=m" (atomic->counter)
+	:"m" (atomic->counter) : "memory");
+
+	if (likely(cnt))
+		return 0;
+
+	/* Slow path */
+	spin_lock(lock);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	spin_unlock(lock);
+	return 0;
+}
--- 2.4.11p5/arch/alpha/lib/Makefile	Wed Jun 20 22:10:27 2001
+++ linux/arch/alpha/lib/Makefile	Fri Oct  5 17:37:20 2001
@@ -49,6 +49,10 @@ OBJS =	__divqu.o __remqu.o __divlu.o __r
 	fpreg.o \
 	callback_srm.o srm_puts.o srm_printk.o
 
+ifeq ($(CONFIG_SMP),y)
+  OBJS += dec_and_lock.o
+endif
+
 lib.a: $(OBJS)
 	$(AR) rcs lib.a $(OBJS)
 
--- 2.4.11p5/arch/alpha/kernel/alpha_ksyms.c	Fri Sep 14 02:21:32 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Fri Oct  5 19:56:39 2001
@@ -215,6 +215,7 @@ EXPORT_SYMBOL(__global_cli);
 EXPORT_SYMBOL(__global_sti);
 EXPORT_SYMBOL(__global_save_flags);
 EXPORT_SYMBOL(__global_restore_flags);
+EXPORT_SYMBOL(atomic_dec_and_lock);
 #if DEBUG_SPINLOCK
 EXPORT_SYMBOL(spin_unlock);
 EXPORT_SYMBOL(debug_spin_lock);
--- 2.4.11p5/arch/alpha/config.in	Fri Oct  5 17:27:50 2001
+++ linux/arch/alpha/config.in	Fri Oct  5 17:37:20 2001
@@ -217,6 +217,10 @@ then
 	bool 'Symmetric multi-processing support' CONFIG_SMP
 fi
 
+if [ "$CONFIG_SMP" = "y" ]; then
+   define_bool CONFIG_HAVE_DEC_LOCK y
+fi
+
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    bool 'Discontiguous Memory Support' CONFIG_DISCONTIGMEM
    if [ "$CONFIG_DISCONTIGMEM" = "y" ]; then
