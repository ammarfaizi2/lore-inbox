Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136430AbRA1Bho>; Sat, 27 Jan 2001 20:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136431AbRA1Bhg>; Sat, 27 Jan 2001 20:37:36 -0500
Received: from smtp.mountain.net ([198.77.1.35]:27911 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S136430AbRA1BhQ>;
	Sat, 27 Jan 2001 20:37:16 -0500
Message-ID: <3A7377B5.B3F9FE91@mountain.net>
Date: Sat, 27 Jan 2001 20:36:53 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP Athlon...(a quiet question)
In-Reply-To: <Pine.LNX.4.10.10101271650170.25882-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------980011676530C611E412AAA1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------980011676530C611E412AAA1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre Hedrick wrote:
> 
> ER, they work but must compile as PII/Celeron :-(
> A bunch of memcpy header stuff fails to compile....
> current is one of the left overs in some cases.
> 
> I will dive deeper in monday, just wanting some feed back first.
> 
> Cheers,
> 
> Andre Hedrick
> Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Hello Andre,

I think that there is no good way to use in_interrupt() in asm/string.h.
Circular dependencies.

I've been using some form of this patch since last May, posted here several
times. It moves the mmx style memcpy into lib.a (mmx.c). I lose some
inlining, but since k7 does branch prediction for call addresses, inline
functions are somewhat less of a win. Certainly the big speedup from mmx is
more than enough to pay for it.

Cheers,
Tom
-- 
The Daemons lurk and are dumb. -- Emerson
--------------980011676530C611E412AAA1
Content-Type: text/plain; charset=us-ascii;
 name="k7-smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k7-smp.patch"

--- linux/arch/i386/lib/mmx.c.orig	Wed Oct 27 21:30:39 1999
+++ linux/arch/i386/lib/mmx.c	Tue Jun  6 04:20:01 2000
@@ -1,6 +1,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <asm/hardirq.h>
 
 /*
  *	MMX 3DNow! library helper functions
@@ -88,6 +89,21 @@
 	stts();
 	return p;
 }
+
+void * __constant_mmx_memcpy3d(void * to, const void * from, size_t len)
+{
+	if(in_interrupt())
+		return __constant_memcpy(to, from, len);
+	return _mmx_memcpy(to, from, len);
+}
+
+void *__mmx_memcpy3d(void *to, const void *from, size_t len)
+{
+	if(in_interrupt())
+		return __memcpy(to, from, len);
+	return _mmx_memcpy(to, from, len);
+}
+
 
 static void fast_clear_page(void *page)
 {
--- linux/include/asm-i386/mmx.h.orig	Tue Jun  6 03:05:02 2000
+++ linux/include/asm-i386/mmx.h	Tue Jun  6 04:25:27 2000
@@ -10,5 +10,7 @@
 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
 extern void mmx_clear_page(void *page);
 extern void mmx_copy_page(void *to, void *from);
+extern __inline__ void *__constant_mmx_memcpy3d(void * to, const void * from, size_t len);
+extern __inline__ void *__mmx_memcpy3d(void *to, const void *from, size_t len);
 
 #endif
--- linux/include/asm-i386/string.h.orig	Tue Jun  6 03:05:02 2000
+++ linux/include/asm-i386/string.h	Tue Jun  6 04:30:37 2000
@@ -287,13 +287,6 @@
 
 #ifdef CONFIG_X86_USE_3DNOW
 
-/* All this just for in_interrupt() ... */
-
-#include <asm/system.h>
-#include <asm/ptrace.h>
-#include <linux/smp.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
 #include <asm/mmx.h>
 
 /*
@@ -302,16 +295,16 @@
 
 static inline void * __constant_memcpy3d(void * to, const void * from, size_t len)
 {
-	if(len<512 || in_interrupt())
+	if(len<512)
 		return __constant_memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
+	return __constant_mmx_memcpy3d(to, from, len);
 }
 
 extern __inline__ void *__memcpy3d(void *to, const void *from, size_t len)
 {
-	if(len<512 || in_interrupt())
+	if(len<512)
 		return __memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
+	return __mmx_memcpy3d(to, from, len);
 }
 
 #define memcpy(t, f, n) \

--------------980011676530C611E412AAA1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
