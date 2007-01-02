Return-Path: <linux-kernel-owner+w=401wt.eu-S964984AbXABVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbXABVIa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbXABVI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:08:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38989 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964984AbXABVI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:08:28 -0500
Date: Tue, 2 Jan 2007 19:09:30 -0200
From: Glauber de Oliveira Costa <gcosta@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Remove fastcall references in x86_64 code. 
Message-ID: <20070102210930.GA15354@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Unlike x86, x86_64 already passes arguments in registers. The use of
regparm attribute makes no difference in produced code, and the use of
fastcall just bloats the code.


-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fastcall.patch"

diff -rup linux-2.6.19.1-devel/arch/x86_64/kernel/acpi/sleep.c linux-2.6.19.1/arch/x86_64/kernel/acpi/sleep.c
--- linux-2.6.19.1-devel/arch/x86_64/kernel/acpi/sleep.c	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19.1/arch/x86_64/kernel/acpi/sleep.c	2007-01-02 12:50:58.000000000 -0200
@@ -58,7 +58,7 @@ unsigned long acpi_wakeup_address = 0;
 unsigned long acpi_video_flags;
 extern char wakeup_start, wakeup_end;
 
-extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
+extern unsigned long acpi_copy_wakeup_routine(unsigned long);
 
 static pgd_t low_ptr;
 
diff -rup linux-2.6.19.1-devel/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.19.1/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.19.1-devel/arch/x86_64/kernel/x8664_ksyms.c	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19.1/arch/x86_64/kernel/x8664_ksyms.c	2007-01-02 12:50:36.000000000 -0200
@@ -34,8 +34,8 @@ EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
 
 #ifdef CONFIG_SMP
-extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
-extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
+extern void  __write_lock_failed(rwlock_t *rw);
+extern void  __read_lock_failed(rwlock_t *rw);
 EXPORT_SYMBOL(__write_lock_failed);
 EXPORT_SYMBOL(__read_lock_failed);
 #endif
diff -rup linux-2.6.19.1-devel/include/asm-x86_64/hw_irq.h linux-2.6.19.1/include/asm-x86_64/hw_irq.h
--- linux-2.6.19.1-devel/include/asm-x86_64/hw_irq.h	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19.1/include/asm-x86_64/hw_irq.h	2007-01-02 12:51:30.000000000 -0200
@@ -91,7 +91,7 @@ extern void enable_8259A_irq(unsigned in
 extern int i8259A_irq_pending(unsigned int irq);
 extern void make_8259A_irq(unsigned int irq);
 extern void init_8259A(int aeoi);
-extern void FASTCALL(send_IPI_self(int vector));
+extern void send_IPI_self(int vector);
 extern void init_VISWS_APIC_irqs(void);
 extern void setup_IO_APIC(void);
 extern void disable_IO_APIC(void);
diff -rup linux-2.6.19.1-devel/include/asm-x86_64/mutex.h linux-2.6.19.1/include/asm-x86_64/mutex.h
--- linux-2.6.19.1-devel/include/asm-x86_64/mutex.h	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19.1/include/asm-x86_64/mutex.h	2007-01-02 12:49:42.000000000 -0200
@@ -21,7 +21,7 @@ do {									\
 	unsigned long dummy;						\
 									\
 	typecheck(atomic_t *, v);					\
-	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
+	typecheck_fn(void (*)(atomic_t *), fail_fn);			\
 									\
 	__asm__ __volatile__(						\
 		LOCK_PREFIX "   decl (%%rdi)	\n"			\
@@ -47,7 +47,7 @@ do {									\
  */
 static inline int
 __mutex_fastpath_lock_retval(atomic_t *count,
-			     int fastcall (*fail_fn)(atomic_t *))
+			     int (*fail_fn)(atomic_t *))
 {
 	if (unlikely(atomic_dec_return(count) < 0))
 		return fail_fn(count);
@@ -67,7 +67,7 @@ do {									\
 	unsigned long dummy;						\
 									\
 	typecheck(atomic_t *, v);					\
-	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
+	typecheck_fn(void (*)(atomic_t *), fail_fn);			\
 									\
 	__asm__ __volatile__(						\
 		LOCK_PREFIX "   incl (%%rdi)	\n"			\

--ikeVEW9yuYc//A+q--
