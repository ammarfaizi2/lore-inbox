Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277644AbRJLMgS>; Fri, 12 Oct 2001 08:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277656AbRJLMf6>; Fri, 12 Oct 2001 08:35:58 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:36112 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S277644AbRJLMft>; Fri, 12 Oct 2001 08:35:49 -0400
Date: Fri, 12 Oct 2001 16:35:59 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.11-pre5] atomic_dec_and_lock() for alpha
Message-ID: <20011012163559.A17120@jurassic.park.msu.ru>
In-Reply-To: <20011008194257.A705@jurassic.park.msu.ru> <20011008102412.A24348@twiddle.net> <20011009143013.A2884@jurassic.park.msu.ru> <20011011112810.A1069@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011011112810.A1069@twiddle.net>; from rth@twiddle.net on Thu, Oct 11, 2001 at 11:28:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 11:28:10AM -0700, Richard Henderson wrote:
> Hmm.  What about a mixture:

...

> 2:	lda	$27, atomic_dec_and_lock_1");
> 
> 	/* FALLTHRU */
> 	
> static int
> atomic_dec_and_lock_1(atomic_t *atomic, spinlock_t *lock)

Oh cool.
I've made a patch of the above (with some minor changes), but
are you certain that these two will be linked in proper order
under any circumstances? Or "br atomic_dec_and_lock_1" is
needed?

Ivan.

--- 2.4.13p1/arch/alpha/lib/dec_and_lock.c	Thu Jan  1 00:00:00 1970
+++ linux/arch/alpha/lib/dec_and_lock.c	Fri Oct 12 14:48:57 2001
@@ -0,0 +1,41 @@
+/*
+ * arch/alpha/lib/dec_and_lock.c
+ *
+ * ll/sc version of atomic_dec_and_lock() and nice example
+ * of mixing C and assembly.
+ * 
+ */
+
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+
+  asm (".text					\n\
+	.global atomic_dec_and_lock		\n\
+	.ent atomic_dec_and_lock		\n\
+	.align	4				\n\
+atomic_dec_and_lock:				\n\
+	.prologue 0				\n\
+1:	ldl_l	$1, 0($16)			\n\
+	subl	$1, 1, $1			\n\
+	beq	$1, 2f				\n\
+	stl_c	$1, 0($16)			\n\
+	beq	$1, 3f				\n\
+	mb					\n\
+	clr	$0				\n\
+	ret					\n\
+3:	br	1b				\n\
+2:	lda	$27, atomic_dec_and_lock_1	\n\
+	.end atomic_dec_and_lock");
+
+	/* FALLTHRU */
+
+static int __attribute__((unused))
+atomic_dec_and_lock_1(atomic_t *atomic, spinlock_t *lock)
+{
+	/* Slow path */
+	spin_lock(lock);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	spin_unlock(lock);
+	return 0;
+}
--- 2.4.13p1/arch/alpha/lib/Makefile	Wed Jun 20 22:10:27 2001
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
 
--- 2.4.13p1/arch/alpha/kernel/alpha_ksyms.c	Fri Sep 14 02:21:32 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Fri Oct  5 19:56:39 2001
@@ -215,6 +215,7 @@ EXPORT_SYMBOL(__global_cli);
 EXPORT_SYMBOL(__global_sti);
 EXPORT_SYMBOL(__global_save_flags);
 EXPORT_SYMBOL(__global_restore_flags);
+EXPORT_SYMBOL(atomic_dec_and_lock);
 #if DEBUG_SPINLOCK
 EXPORT_SYMBOL(spin_unlock);
 EXPORT_SYMBOL(debug_spin_lock);
--- 2.4.13p1/arch/alpha/config.in	Fri Oct  5 17:27:50 2001
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
