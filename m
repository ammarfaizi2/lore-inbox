Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUBCVHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUBCVHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:07:40 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:21930 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266170AbUBCVHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:07:36 -0500
X-BrightmailFiltered: true
Date: Tue, 3 Feb 2004 22:07:38 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
Message-ID: <20040203210738.GB1337@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan> <20040202200344.GK6785@dreamland.darkstar.lan> <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Feb 02, 2004 at 10:08:48PM +0100, Geert Uytterhoeven ha scritto: 
> On Mon, 2 Feb 2004, Kronos wrote:
> > siimage.c:65: warning: control reaches end of non-void function
> >
> > The last statement before the end is BUG(), but I added a return to
> > silence the warning.
> >
> > diff -Nru -X dontdiff linux-2.4-vanilla/drivers/ide/pci/siimage.c linux-2.4/drivers/ide/pci/siimage.c
> > --- linux-2.4-vanilla/drivers/ide/pci/siimage.c	Tue Nov 11 17:51:38 2003
> > +++ linux-2.4/drivers/ide/pci/siimage.c	Sat Jan 31 19:07:56 2004
> > @@ -62,6 +62,9 @@
> >  			return 0;
> >  	}
> >  	BUG();
> > +
> > +	/* gcc will complain */
> > +	return 0;
> >  }
> 
> What about adding `attribute ((noreturn))' to the declaration of BUG() instead?

Ok, I cooked up this patch. BUG() is a function marked as noreturn that is
always inlined. Unfortunately, gcc prior to 3.x does not support
__always_inline__ attribute, so I had to revert to the old macro with older
compiler.

The patch fixes warnings with newer compiler, but not with older ones.
Note that the while(1) is needed, otherwise gcc will say that the
function marked as noreturn does actually return.

Comments?

diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/page.h linux-2.4/include/asm-i386/page.h
--- linux-2.4-vanilla/include/asm-i386/page.h	Tue Nov 11 18:05:52 2003
+++ linux-2.4/include/asm-i386/page.h	Tue Feb  3 07:26:04 2004
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -94,6 +95,26 @@
  * The offending file and line are encoded after the "officially
  * undefined" opcode for parsing in the trap handler.
  */
+#ifdef __bug
+#if 1	/* Set to zero for a slightly smaller kernel */
+__bug void __bugfn(void) {
+	while(1) {
+		 __asm__ __volatile__(	"ud2\n"
+					"\t.word %c0\n"
+					"\t.long %c1\n"
+					: : "i" (__LINE__), "i" (__FILE__));
+ 	}
+}
+#else
+__bug void __bugfn(void) {
+	while(1) {
+		__asm__ __volatile__("ud2\n");
+	}
+}
+#endif
+#define BUG() __bugfn()
+
+#else /* __bug */
 
 #if 1	/* Set to zero for a slightly smaller kernel */
 #define BUG()				\
@@ -104,6 +125,8 @@
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
+
+#endif /* __bug */
 
 #define PAGE_BUG(page) do { \
 	BUG(); \
diff -Nru -X dontdiff linux-2.4-vanilla/include/linux/compiler.h linux-2.4/include/linux/compiler.h
--- linux-2.4-vanilla/include/linux/compiler.h	Tue Sep 18 23:12:45 2001
+++ linux-2.4/include/linux/compiler.h	Tue Feb  3 07:25:57 2004
@@ -13,4 +13,11 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
+#if __GNUC__ >= 3
+/* __noreturn__ is implemented since gcc 2.5. 
+ * __always_inline__ is not present in 2.9x
+ */
+#define __bug __attribute__((__noreturn__, __always_inline__))
+#endif
+
 #endif /* __LINUX_COMPILER_H */


Luca
PS: I wrote the patch early this morning, on train. It may be a huge pile of
crap ;)
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
The trouble with computers is that they do what you tell them, 
not what you want.
D. Cohen
