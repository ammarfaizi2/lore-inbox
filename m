Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUHaITw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUHaITw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHaITw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:19:52 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:45810 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267405AbUHaIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:19:27 -0400
Message-ID: <01b401c48f33$3fb05000$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>
References: <2wJxj-7g2-23@gated-at.bofh.it> <2x2JC-3Uu-11@gated-at.bofh.it> <m3k6vjco9e.fsf@averell.firstfloor.org>
Subject: Re: [PATCH]atomic_inc_return() for i386/x86_64 (Re: RCU issue with SELinux)
Date: Tue, 31 Aug 2004 17:19:34 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01B1_01C48F7E.AF888EB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01B1_01C48F7E.AF888EB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Andi, thanks for your comment.
Sorry, I have not noticed your mail in the flood of Linux-Kernel ML.

> > atomic_inc_return() is not defined for arm,arm26,i386,x86_64 and um archtectures.
> > This attached patch adds atomic_inc_return() and atomic_dec_return() to arm,i386 and x86_64.
> >
> > It is implemented by 'xaddl' operation with LOCK prefix for i386 and x86_64.
> > But this operation is permitted after i486 processor only.
> > Another implementation may be necessary for i386SX/DX processor.
> > But 'xaddl' operation is used in 'include/asm-i386/rwsem.h' unconditionally.
> > I think it has agreed on using 'xaddl' operation in past days.
> 
> We don't support SMP on 386 boxes. What you can do for 386 is to use 
> alternative() and just use an non SMP safe version for 386 and xadd 
> for 486+ 

We can avoid the problem by the simple solution, since SMP
on 386 boxes isn't supported. It is to disable interrupt
while updating atomic_t variable.

The attached patch modifies the include/asm-i386/atomic.h.
If the target processor is 386, then atomic_add_return() use
non-atomic operations between local_irq_disable() and local_irq_enable().
Otherwise, atomic_add_return() use 'xadd' operation with LOCK prefix.

By the way, do you know why 'xadd' operation is used
unconditionally in 'include/asm-i386/rwsem.h'?

Thanks.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
Signed-off-by: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>

------=_NextPart_000_01B1_01C48F7E.AF888EB0
Content-Type: application/octet-stream;
	name="atomic_inc_return-2.6.8.1.M386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="atomic_inc_return-2.6.8.1.M386.patch"

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
--- linux-2.6.8.1/include/asm-i386/atomic.h	2004-08-14 =
19:55:09.000000000 +0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-i386/atomic.h	2004-08-31 =
13:10:48.000000000 +0900=0A=
@@ -1,8 +1,9 @@=0A=
 #ifndef __ARCH_I386_ATOMIC__=0A=
 #define __ARCH_I386_ATOMIC__=0A=
 =0A=
 #include <linux/config.h>=0A=
+#include <asm/system.h>=0A=
 =0A=
 /*=0A=
  * Atomic operations that C can't guarantee us.  Useful for=0A=
  * resource counting etc..=0A=
@@ -175,8 +176,41 @@=0A=
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
+	local_irq_disable();=0A=
+	__i =3D atomic_read(v);=0A=
+	atomic_set(v, i + __i);=0A=
+	local_irq_enable();=0A=
+#else=0A=
+	__i =3D i;=0A=
+	__asm__ __volatile__(=0A=
+		LOCK "xaddl %0, %1;"=0A=
+		:"=3Dr"(i)=0A=
+		:"m"(v->counter), "0"(i));=0A=
+#endif=0A=
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

------=_NextPart_000_01B1_01C48F7E.AF888EB0--

