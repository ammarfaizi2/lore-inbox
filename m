Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVC2Uag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVC2Uag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVC2UaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:30:11 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2308 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261366AbVC2UXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:23:07 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Morton <akpm@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH] fix i386 memcpy
Date: Tue, 29 Mar 2005 23:22:57 +0300
User-Agent: KMail/1.5.4
References: <200503291737.06356.vda@ilport.com.ua>
In-Reply-To: <200503291737.06356.vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hkbSClQZxaKjszr"
Message-Id: <200503292322.57515.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hkbSClQZxaKjszr
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch shortens non-constant memcpy() by two bytes
and fixes spurious out-of-line constant memcpy().

Patch is run-tested (I run on patched kernel right now).

Benchmark and code generation test program will be mailed as reply.

# size vmlinux.org vmlinux
   text    data     bss     dec     hex filename
3954591 1553426  236544 5744561  57a7b1 vmlinux.org
3952615 1553426  236544 5742585  579ff9 vmlinux

Example of changes (part of dump_fpu() body):
old.............................................. new......................
8d 83 40 02 00 00 lea    0x240(%ebx),%eax         8d b3 40 02 00 00 lea    0x240(%ebx),%esi
74 31             je     c0108b27 <dump_fpu+0x9c> 74 2e             je     c0108b1d <dump_fpu+0x92>
6a 1c             push   $0x1c                    8b 7d 0c          mov    0xc(%ebp),%edi
50                push   %eax                     b9 07 00 00 00    mov    $0x7,%ecx
56                push   %esi                     f3 a5             repz movsl %ds:(%esi),%es:(%edi)
e8 49 21 10 00    call   c020ac48 <memcpy>        8b 55 0c          mov    0xc(%ebp),%edx
83 c4 0c          add    $0xc,%esp                83 c2 1c          add    $0x1c,%edx
83 c6 1c          add    $0x1c,%esi               8d 83 60 02 00 00 lea    0x260(%ebx),%eax
81 c3 60 02 00 00 add    $0x260,%ebx              b9 07 00 00 00    mov    $0x7,%ecx
bf 07 00 00 00    mov    $0x7,%edi                89 d7             mov    %edx,%edi
6a 0a             push   $0xa                     89 c6             mov    %eax,%esi
53                push   %ebx                     a5                movsl  %ds:(%esi),%es:(%edi)
56                push   %esi                     a5                movsl  %ds:(%esi),%es:(%edi)
e8 2f 21 10 00    call   c020ac48 <memcpy>        66 a5             movsw  %ds:(%esi),%es:(%edi)
83 c4 0c          add    $0xc,%esp                83 c2 0a          add    $0xa,%edx
83 c6 0a          add    $0xa,%esi                83 c0 10          add    $0x10,%eax
83 c3 10          add    $0x10,%ebx               49                dec    %ecx
4f                dec    %edi                     79 ef             jns    c0108b0a <dump_fpu+0x7f>
79 eb             jns    c0108b10 <dump_fpu+0x85> eb 0a             jmp    c0108b27 <dump_fpu+0x9c>
eb 0c             jmp    c0108b33 <dump_fpu+0xa8> 8b 7d 0c          mov    0xc(%ebp),%edi
6a 6c             push   $0x6c                    b9 1b 00 00 00    mov    $0x1b,%ecx
50                push   %eax                     f3 a5             repz movsl %ds:(%esi),%es:(%edi)
56                push   %esi                     8b 45 f0          mov    0xfffffff0(%ebp),%eax
e8 18 21 10 00    call   c020ac48 <memcpy>        5a                pop    %edx
83 c4 0c          add    $0xc,%esp                5b                pop    %ebx
8b 45 f0          mov    0xfffffff0(%ebp),%eax
8d 65 f4          lea    0xfffffff4(%ebp),%esp
5b                pop    %ebx
5e                pop    %esi

--
vda

--Boundary-00=_hkbSClQZxaKjszr
Content-Type: text/x-diff;
  charset="koi8-r";
  name="string.memcpy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="string.memcpy.diff"

--- linux-2.6.11.src/include/asm-i386/string.h.orig	Thu Mar  3 09:31:08 2005
+++ linux-2.6.11.src/include/asm-i386/string.h	Tue Mar 29 22:05:00 2005
@@ -198,46 +198,75 @@ static inline void * __memcpy(void * to,
 int d0, d1, d2;
 __asm__ __volatile__(
 	"rep ; movsl\n\t"
-	"testb $2,%b4\n\t"
-	"je 1f\n\t"
-	"movsw\n"
-	"1:\ttestb $1,%b4\n\t"
-	"je 2f\n\t"
-	"movsb\n"
-	"2:"
+	"movl %4,%%ecx\n\t"
+	"andl $3,%%ecx\n\t"
+	"jz 1f\n\t"	/* pay 2 byte penalty for a chance to skip microcoded rep */
+	"rep ; movsb\n\t"
+	"1:"
 	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
-	:"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
+	: "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
 	: "memory");
 return (to);
 }
 
 /*
- * This looks horribly ugly, but the compiler can optimize it totally,
+ * This looks ugly, but the compiler can optimize it totally,
  * as the count is constant.
  */
 static inline void * __constant_memcpy(void * to, const void * from, size_t n)
 {
-	if (n <= 128)
-		return __builtin_memcpy(to, from, n);
-
-#define COMMON(x) \
-__asm__ __volatile__( \
-	"rep ; movsl" \
-	x \
-	: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
-	: "0" (n/4),"1" ((long) to),"2" ((long) from) \
-	: "memory");
-{
-	int d0, d1, d2;
+#if 1	/* want to do small copies with non-string ops? */
+	switch (n) {
+		case 0: return to;
+		case 1: *(char*)to = *(char*)from; return to;
+		case 2: *(short*)to = *(short*)from; return to;
+		case 4: *(int*)to = *(int*)from; return to;
+#if 1	/* including those doable with two moves? */
+		case 3: *(short*)to = *(short*)from;
+			*((char*)to+2) = *((char*)from+2); return to;
+		case 5: *(int*)to = *(int*)from;
+			*((char*)to+4) = *((char*)from+4); return to;
+		case 6: *(int*)to = *(int*)from;
+			*((short*)to+2) = *((short*)from+2); return to;
+		case 8: *(int*)to = *(int*)from;
+			*((int*)to+1) = *((int*)from+1); return to;
+#endif
+	}
+#else
+	if (!n) return to;
+#endif
+	{
+		/* load esi/edi */
+		int esi, edi;
+		__asm__ __volatile__(
+			""
+			: "=&D" (edi), "=&S" (esi)
+			: "0" ((long) to),"1" ((long) from)
+			: "memory"
+		);
+	}
+	if (n >= 5*4) {
+		/* large block: use rep prefix */
+		int ecx;
+		__asm__ __volatile__(
+			"rep ; movsl"
+			: "=&c" (ecx)
+			: "0" (n/4)
+		);
+	} else {
+		/* small block: don't clobber ecx + smaller code */
+		if (n >= 4*4) __asm__ __volatile__("movsl");
+		if (n >= 3*4) __asm__ __volatile__("movsl");
+		if (n >= 2*4) __asm__ __volatile__("movsl");
+		if (n >= 1*4) __asm__ __volatile__("movsl");
+	}
 	switch (n % 4) {
-		case 0: COMMON(""); return to;
-		case 1: COMMON("\n\tmovsb"); return to;
-		case 2: COMMON("\n\tmovsw"); return to;
-		default: COMMON("\n\tmovsw\n\tmovsb"); return to;
+		/* tail */
+		case 0: return to;
+		case 1: __asm__ __volatile__("movsb"); return to;
+		case 2: __asm__ __volatile__("movsw"); return to;
+		default: __asm__ __volatile__("movsw\n\tmovsb"); return to;
 	}
-}
-  
-#undef COMMON
 }
 
 #define __HAVE_ARCH_MEMCPY

--Boundary-00=_hkbSClQZxaKjszr--

