Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRABJWc>; Tue, 2 Jan 2001 04:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRABJWW>; Tue, 2 Jan 2001 04:22:22 -0500
Received: from smtp.mountain.net ([198.77.1.35]:16904 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129805AbRABJWE>;
	Tue, 2 Jan 2001 04:22:04 -0500
Message-ID: <3A51968C.618D272B@mountain.net>
Date: Tue, 02 Jan 2001 03:51:24 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-prerelease i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Matt Wright <matt@teletubbies.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.4.0-testX fails to compile on my Athlon
In-Reply-To: <Pine.LNX.4.21.0012311635530.1649-100000@po.teletubbies.dhs.org>
Content-Type: multipart/mixed;
 boundary="------------CEC452EB654ADACA05AB9A99"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CEC452EB654ADACA05AB9A99
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Matt Wright wrote:
> 
> I've looked for answers to this question before, but all I could find was
> someone asking a similar question and no replies...
> 
> I'm having great trouble getting 2.4.0-testX to compile on my system when
> I select Athlon/K7 as the Processor Family....
> 
> I've attached below the error's I'm getting.... the kernel DOES compile if
> I select anything else... but I don't have anything else :)
> 

Hello,

The problem with SMP+K7 builds is that include/asm-i386/string.h has no
business using in_interrupt(). That introduces circular dependencies which
nobody has been able to rearrange away.

Here is a patch I've posted here several times. It moves the mmx functions
from string.h to arch/i386/lib/mmx.c (lib.a).It does not __inline__ the call
for memcpy() of large or unknown length. Athlon supposedly does branch
prediction for function pointers, so that shouldn't hurt too much. The point
is to get it to build: optimize later.

The actual usefulness of this may be limited to development on UP machines.
I don't know whether the AMD-760 SMP boards will be compatable with Linux
SMP. Hearsay is that they will have significant architectural differences
with Intel flavored SMP boards.

Cheers,
Tom

Patch as attachment to avoid mailer brain damage. It has not been tested
lately, but still applies cleanish.
--------------CEC452EB654ADACA05AB9A99
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

--------------CEC452EB654ADACA05AB9A99--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
