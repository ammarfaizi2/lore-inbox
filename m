Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268798AbUIAGYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268798AbUIAGYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268988AbUIAGYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:24:18 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:55948 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S268798AbUIAGYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:24:06 -0400
Message-ID: <01f201c48fec$15608f40$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>
References: <2wJxj-7g2-23@gated-at.bofh.it> <2x2JC-3Uu-11@gated-at.bofh.it> <m3k6vjco9e.fsf@averell.firstfloor.org> <01b401c48f33$3fb05000$f97d220a@linux.bs1.fc.nec.co.jp> <20040831084953.GA11113@muc.de>
Subject: Re: [PATCH]atomic_inc_return() for i386/x86_64 (Re: RCU issue with SELinux)
Date: Wed, 1 Sep 2004 15:22:40 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01EF_01C49037.8535E7C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01EF_01C49037.8535E7C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Andi, thanks for your comment.

> > We can avoid the problem by the simple solution, since SMP
> > on 386 boxes isn't supported. It is to disable interrupt
> > while updating atomic_t variable.
> 
> The patch is wrong.  A CONFIG_M386 kernel can run on non
> 386 SMP boxes. Your patch would be racy then. The only thing 
> that's not supported is a real 386 with multiple CPUs.
> 
> You either have to check boot_cpu_data.x86 == 3 at runtime or 
> use alternative() like I earlier suggested.

Indeed, the attached patch is implemented according to the suggestion.
The code for legacy-386 is used only when boot_cpu_data.x86 == 3.
This run-time check is done only when CONFIG_M386 is set.
Otherwise, we use 'XADD' operation for atomic_add_return()
as the previous patch.

I don't adopt the alternative(), because the macro doesn't fit for the situation
when arguments for __asm__ are necessary.

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>

------=_NextPart_000_01EF_01C49037.8535E7C0
Content-Type: application/octet-stream;
	name="atomic_inc_return-2.6.8.1.M386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="atomic_inc_return-2.6.8.1.M386.patch"

--- linux-2.6.8.1/include/asm-i386/atomic.h	2004-08-14 =
19:55:09.000000000 +0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-i386/atomic.h	2004-09-01 =
14:40:40.000000000 +0900=0A=
@@ -1,8 +1,10 @@=0A=
 #ifndef __ARCH_I386_ATOMIC__=0A=
 #define __ARCH_I386_ATOMIC__=0A=
 =0A=
 #include <linux/config.h>=0A=
+#include <linux/compiler.h>=0A=
+#include <asm/processor.h>=0A=
 =0A=
 /*=0A=
  * Atomic operations that C can't guarantee us.  Useful for=0A=
  * resource counting etc..=0A=
@@ -175,8 +177,48 @@=0A=
 		:"ir" (i), "m" (v->counter) : "memory");=0A=
 	return c;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * atomic_add_return - add and return=0A=
+ * @v: pointer of type atomic_t=0A=
+ * @i: integer value to add=0A=
+ *=0A=
+ * Atomically adds @i to @v and returns @i + @v=0A=
+ */=0A=
+static __inline__ int atomic_add_return(int i, atomic_t *v)=0A=
+{=0A=
+	int __i;=0A=
+#ifdef CONFIG_M386=0A=
+	if(unlikely(boot_cpu_data.x86=3D=3D3))=0A=
+		goto no_xadd;=0A=
+#endif=0A=
+	/* Modern 486+ processor */=0A=
+	__i =3D i;=0A=
+	__asm__ __volatile__(=0A=
+		LOCK "xaddl %0, %1;"=0A=
+		:"=3Dr"(i)=0A=
+		:"m"(v->counter), "0"(i));=0A=
+	return i + __i;=0A=
+=0A=
+#ifdef CONFIG_M386=0A=
+no_xadd: /* Legacy 386 processor */=0A=
+	local_irq_disable();=0A=
+	__i =3D atomic_read(v);=0A=
+	atomic_set(v, i + __i);=0A=
+	local_irq_enable();=0A=
+	return i + __i;=0A=
+#endif=0A=
+}=0A=
+=0A=
+static __inline__ int atomic_sub_return(int i, atomic_t *v)=0A=
+{=0A=
+	return atomic_add_return(-i,v);=0A=
+}=0A=
+=0A=
+#define atomic_inc_return(v)  (atomic_add_return(1,v))=0A=
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))=0A=
+=0A=
 /* These are x86-specific, used by some header files */=0A=
 #define atomic_clear_mask(mask, addr) \=0A=
 __asm__ __volatile__(LOCK "andl %0,%1" \=0A=
 : : "r" (~(mask)),"m" (*addr) : "memory")=0A=
--- linux-2.6.8.1/include/asm-x86_64/atomic.h	2004-08-14 =
19:56:23.000000000 +0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-x86_64/atomic.h	2004-08-25 =
11:57:36.000000000 +0900=0A=
@@ -177,8 +177,33 @@=0A=
 		:"ir" (i), "m" (v->counter) : "memory");=0A=
 	return c;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * atomic_add_return - add and return=0A=
+ * @v: pointer of type atomic_t=0A=
+ * @i: integer value to add=0A=
+ *=0A=
+ * Atomically adds @i to @v and returns @i + @v=0A=
+ */=0A=
+static __inline__ int atomic_add_return(int i, atomic_t *v)=0A=
+{=0A=
+	int __i =3D i;=0A=
+	__asm__ __volatile__(=0A=
+		LOCK "xaddl %0, %1;"=0A=
+		:"=3Dr"(i)=0A=
+		:"m"(v->counter), "0"(i));=0A=
+	return i + __i;=0A=
+}=0A=
+=0A=
+static __inline__ int atomic_sub_return(int i, atomic_t *v)=0A=
+{=0A=
+	return atomic_add_return(-i,v);=0A=
+}=0A=
+=0A=
+#define atomic_inc_return(v)  (atomic_add_return(1,v))=0A=
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))=0A=
+=0A=
 /* These are x86-specific, used by some header files */=0A=
 #define atomic_clear_mask(mask, addr) \=0A=
 __asm__ __volatile__(LOCK "andl %0,%1" \=0A=
 : : "r" (~(mask)),"m" (*addr) : "memory")=0A=
--- linux-2.6.8.1/include/asm-arm/atomic.h	2004-08-14 19:54:50.000000000 =
+0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-arm/atomic.h	2004-08-24 =
19:31:56.000000000 +0900=0A=
@@ -194,8 +194,10 @@=0A=
 #define atomic_dec(v)		atomic_sub(1, v)=0A=
 =0A=
 #define atomic_inc_and_test(v)	(atomic_add_return(1, v) =3D=3D 0)=0A=
 #define atomic_dec_and_test(v)	(atomic_sub_return(1, v) =3D=3D 0)=0A=
+#define atomic_inc_return(v)    (atomic_add_return(1, v))=0A=
+#define atomic_dec_return(v)    (atomic_sub_return(1, v))=0A=
 =0A=
 #define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)=0A=
 =0A=
 /* Atomic operations are already serializing on ARM */=0A=

------=_NextPart_000_01EF_01C49037.8535E7C0--

