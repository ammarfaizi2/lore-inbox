Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUHYJw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUHYJw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUHYJw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:52:57 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:27366 "EHLO
	tyo206.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265477AbUHYJv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:51:59 -0400
Message-ID: <025001c48a89$2bbd37b0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "James Morris" <jmorris@redhat.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0408240908530.19614-100000@thoron.boston.redhat.com>
Subject: [PATCH]atomic_inc_return() for i386/x86_64 (Re: RCU issue with SELinux)
Date: Wed, 25 Aug 2004 18:52:02 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_024D_01C48AD4.9B98AAB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_024D_01C48AD4.9B98AAB0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi James, thanks for your comment.

> > In IA-32 or x86_64, can anybady implement atomic_inc_return()?
> > If it can not, I'll try to make alternative macros or inline functions.
>
> If you can get this done, it will be very useful, as I could allso run
> some benchmarks on my test systems.

atomic_inc_return() is not defined for arm,arm26,i386,x86_64 and um archtectures.
This attached patch adds atomic_inc_return() and atomic_dec_return() to arm,i386 and x86_64.

It is implemented by 'xaddl' operation with LOCK prefix for i386 and x86_64.
But this operation is permitted after i486 processor only.
Another implementation may be necessary for i386SX/DX processor.
But 'xaddl' operation is used in 'include/asm-i386/rwsem.h' unconditionally.
I think it has agreed on using 'xaddl' operation in past days.

Is it acceptable? Any comment please.

(*) The implementation for ARM is simple wrapper to atomic_add_return().
--------
Kai Gai <kaigai@ak.jp.nec.com>

------=_NextPart_000_024D_01C48AD4.9B98AAB0
Content-Type: application/octet-stream;
	name="atomic_inc_return-2.6.8.1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="atomic_inc_return-2.6.8.1.patch"

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
+++ linux-2.6.8.1.rcu/include/asm-i386/atomic.h	2004-08-25 =
11:57:08.000000000 +0900=0A=
@@ -175,8 +175,34 @@=0A=
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
+	/* NOTICE: This function can be used on i486+ */=0A=
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

------=_NextPart_000_024D_01C48AD4.9B98AAB0--

