Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVLMJCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVLMJCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVLMJCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:02:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932582AbVLMJB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:01:59 -0500
Date: Tue, 13 Dec 2005 01:01:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213010126.0832356d.akpm@osdl.org>
In-Reply-To: <20051213084926.GN23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213075835.GZ15804@wotan.suse.de>
	<20051213004257.0f87d814.akpm@osdl.org>
	<20051213084926.GN23384@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Can you please apply the following patch then? 
> 
>  Remove -Wdeclaration-after-statement

OK.

Thus far I have this:


From: Andrew Morton <akpm@osdl.org>

There's one scsi driver which doesn't compile due to weird __VA_ARGS__ tricks
and the rather useful scsi/sd.c is currently getting an ICE.  None of the new
SAS code compiles, due to extensive use of anonymous unions.  The V4L guys are
very good at exploiting the gcc-2.95.x macro expansion bug (_why_ does each
driver need to implement its own debug macros?) and various people keep on
sneaking in anonymous unions.

Plus anonymous unions are rather useful.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 dev/null                 |   29 -----------------------------
 include/linux/compiler.h |    2 --
 init/main.c              |    7 +------
 3 files changed, 1 insertion(+), 37 deletions(-)

diff -puN init/main.c~abandon-gcc-295x init/main.c
--- devel/init/main.c~abandon-gcc-295x	2005-12-13 00:48:17.000000000 -0800
+++ devel-akpm/init/main.c	2005-12-13 00:48:17.000000000 -0800
@@ -58,11 +58,6 @@
  * This is one of the first .c files built. Error out early
  * if we have compiler trouble..
  */
-#if __GNUC__ == 2 && __GNUC_MINOR__ == 96
-#ifdef CONFIG_FRAME_POINTER
-#error This compiler cannot compile correctly with frame pointers enabled
-#endif
-#endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/smp.h>
@@ -74,7 +69,7 @@
  * To avoid associated bogus bug reports, we flatly refuse to compile
  * with a gcc that is known to be too old from the very beginning.
  */
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
+#if __GNUC__ < 3
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
diff -L include/linux/compiler-gcc2.h -puN include/linux/compiler-gcc2.h~abandon-gcc-295x /dev/null
--- devel/include/linux/compiler-gcc2.h
+++ /dev/null	2003-09-15 06:40:47.000000000 -0700
@@ -1,29 +0,0 @@
-/* Never include this file directly.  Include <linux/compiler.h> instead.  */
-
-/* These definitions are for GCC v2.x.  */
-
-/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
-   a mechanism by which the user can annotate likely branch directions and
-   expect the blocks to be reordered appropriately.  Define __builtin_expect
-   to nothing for earlier compilers.  */
-#include <linux/compiler-gcc.h>
-
-#if __GNUC_MINOR__ < 96
-# define __builtin_expect(x, expected_value) (x)
-#endif
-
-#define __attribute_used__	__attribute__((__unused__))
-
-/*
- * The attribute `pure' is not implemented in GCC versions earlier
- * than 2.96.
- */
-#if __GNUC_MINOR__ >= 96
-# define __attribute_pure__	__attribute__((pure))
-# define __attribute_const__	__attribute__((__const__))
-#endif
-
-/* GCC 2.95.x/2.96 recognize __va_copy, but not va_copy. Actually later GCC's
- * define both va_copy and __va_copy, but the latter may go away, so limit this
- * to this header */
-#define va_copy			__va_copy
diff -puN include/linux/compiler.h~abandon-gcc-295x include/linux/compiler.h
--- devel/include/linux/compiler.h~abandon-gcc-295x	2005-12-13 00:48:17.000000000 -0800
+++ devel-akpm/include/linux/compiler.h	2005-12-13 00:48:17.000000000 -0800
@@ -42,8 +42,6 @@ extern void __chk_io_ptr(void __iomem *)
 # include <linux/compiler-gcc4.h>
 #elif __GNUC__ == 3
 # include <linux/compiler-gcc3.h>
-#elif __GNUC__ == 2
-# include <linux/compiler-gcc2.h>
 #else
 # error Sorry, your compiler is too old/not recognized.
 #endif
_

