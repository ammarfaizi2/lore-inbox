Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVDFQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVDFQNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVDFQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:13:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41101 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262250AbVDFQMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:12:00 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Christophe Saout <christophe@saout.de>
Subject: Re: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 6 Apr 2005 19:11:47 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Jan Hubicka <hubicka@ucw.cz>,
       Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu> <200504021526.53990.vda@ilport.com.ua> <1112718844.22591.15.camel@leto.cs.pocnet.net>
In-Reply-To: <1112718844.22591.15.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DpAVCoiqoH9UqTz"
Message-Id: <200504061911.47732.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_DpAVCoiqoH9UqTz
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 05 April 2005 19:34, Christophe Saout wrote:
> the new i386 memcpy macro is a ticking timebomb.
> 
> I've been debugging a new mISDN crash, just to find out that a memcpy
> was not inlined correctly.
> 
> Andrew, you should drop the fix-i386-memcpy.patch (or have it fixed).

Updated patch against 2.6.11 follows. This one, like the original
patch, is run tested too.

This time I took no chances, esi/edi contents are
explicitly propagated from one asm() block to another.
I didn't do it before, not expecting that gcc can be
soooo incredibly clever. Sorry.

Christophe does this one look/compile ok?
--
vda

--Boundary-00=_DpAVCoiqoH9UqTz
Content-Type: text/x-diff;
  charset="koi8-r";
  name="string2.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="string2.h.diff"

--- linux-2.6.11.src/include/asm-i386/string.h.orig	Thu Mar  3 09:31:08 2005
+++ linux-2.6.11.src/include/asm-i386/string.h	Wed Apr  6 19:08:39 2005
@@ -198,47 +198,80 @@ static inline void * __memcpy(void * to,
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
+#if 1	/* want to pay 2 byte penalty for a chance to skip microcoded rep? */
+	"jz 1f\n\t"
+#endif
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
+	long esi, edi;
+	if (!n) return to;
+#if 1	/* want to do small copies with non-string ops? */
+	switch (n) {
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
+#endif
+	esi = (long) from;
+	edi = (long) to;
+	if (n >= 5*4) {
+		/* large block: use rep prefix */
+		int ecx;
+		__asm__ __volatile__(
+			"rep ; movsl"
+			: "=&c" (ecx), "=&D" (edi), "=&S" (esi)
+			: "0" (n/4), "1" (edi),"2" (esi)
+			: "memory"
+		);
+	} else {
+		/* small block: don't clobber ecx + smaller code */
+		if (n >= 4*4) __asm__ __volatile__("movsl"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+		if (n >= 3*4) __asm__ __volatile__("movsl"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+		if (n >= 2*4) __asm__ __volatile__("movsl"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+		if (n >= 1*4) __asm__ __volatile__("movsl"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+	}
 	switch (n % 4) {
-		case 0: COMMON(""); return to;
-		case 1: COMMON("\n\tmovsb"); return to;
-		case 2: COMMON("\n\tmovsw"); return to;
-		default: COMMON("\n\tmovsw\n\tmovsb"); return to;
+		/* tail */
+		case 0: return to;
+		case 1: __asm__ __volatile__("movsb"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+			return to;
+		case 2: __asm__ __volatile__("movsw"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+			return to;
+		default: __asm__ __volatile__("movsw\n\tmovsb"
+			:"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
+			return to;
 	}
 }
-  
-#undef COMMON
-}
 
 #define __HAVE_ARCH_MEMCPY
 

--Boundary-00=_DpAVCoiqoH9UqTz--

