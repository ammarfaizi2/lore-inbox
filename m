Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUBDUYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUBDUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:22:48 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:30117 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266499AbUBDUWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:22:07 -0500
X-BrightmailFiltered: true
Date: Wed, 4 Feb 2004 21:22:05 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
Message-ID: <20040204202205.GA1717@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan> <20040202200344.GK6785@dreamland.darkstar.lan> <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be> <20040203210738.GB1337@dreamland.darkstar.lan> <20040203231421.GC10009@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203231421.GC10009@zaniah>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Feb 03, 2004 at 11:14:21PM +0000, Philippe Elie ha scritto: 
> > diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/page.h linux-2.4/include/asm-i386/page.h
> > --- linux-2.4-vanilla/include/asm-i386/page.h	Tue Nov 11 18:05:52 2003
> > +++ linux-2.4/include/asm-i386/page.h	Tue Feb  3 07:26:04 2004
> > @@ -10,6 +10,7 @@
> >  #ifndef __ASSEMBLY__
> >  
> >  #include <linux/config.h>
> > +#include <linux/compiler.h>
> >  
> >  #ifdef CONFIG_X86_USE_3DNOW
> >  
> > @@ -94,6 +95,26 @@
> >   * The offending file and line are encoded after the "officially
> >   * undefined" opcode for parsing in the trap handler.
> >   */
> > +#ifdef __bug
> > +#if 1	/* Set to zero for a slightly smaller kernel */
> > +__bug void __bugfn(void) {
> > +	while(1) {
> > +		 __asm__ __volatile__(	"ud2\n"
> > +					"\t.word %c0\n"
> > +					"\t.long %c1\n"
> > +					: : "i" (__LINE__), "i" (__FILE__));
> > + 	}
> > +}
> 
> You must pass __LINE__ and __FILE__ as parameter to this function.

Good point. It's not that easy though ;)
BUG() places file name and line number after the invalid opcode (ud2) and
the kernel trap handler decodes these information when printing a BUG().
In order to do that you need immediate values to pass to assembler.

I think that the following patch will work. This is a BUG() from a dummy module
which calls BUG() in the init function:

kernel BUG at /tmp/mod3.c:22!
invalid operand: 0000 [#3]
CPU:    0
EIP:    0060:[<e09ed003>]    Tainted: PF
EFLAGS: 00010202
EIP is at modinit+0x3/0x20 [mod3]
eax: e09ed000   ebx: cdf9a000   ecx: c036de78   edx: 00000000
esi: e09ed180   edi: c036de78   ebp: cdf9bfa4   esp: cdf9bfa4
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 1960, threadinfo=cdf9a000 task=dd7546b0)
Stack: cdf9bfbc c01345d8 0804b018 080486dd 4009199b c036de5c cdf9a000 c0109067
       0804b018 0000055c 0804b008 080486dd 4009199b bffffb28 00000080 0000007b
       0000007b 00000080 400fb4ce 00000073 00000246 bffffae0 0000007b
Call Trace:
 [<c01345d8>] sys_init_module+0x118/0x240
 [<c0109067>] syscall_call+0x7/0xb

Code: 0f 0b 16 00 25 d0 9e e0 90 8d 74 26 00 eb fe 8d b4 26 00 00
 Segmentation fault
		 
It seems ok to me (kernel is tainted because I forgot MODULE_LICENSE...).
Comments on the patch?

diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/page.h linux-2.4/include/asm-i386/page.h
--- linux-2.4-vanilla/include/asm-i386/page.h	Tue Nov 11 18:05:52 2003
+++ linux-2.4/include/asm-i386/page.h	Wed Feb  4 14:43:00 2004
@@ -95,14 +95,28 @@
  * undefined" opcode for parsing in the trap handler.
  */
 
+#ifdef __bug
+static inline void __dummy_noreturn(void) __bug;
+static inline void __dummy_noreturn(void) {
+	while(1) {}
+}
+#else
+#define __dummy_noreturn() do {} while(0)
+#endif
+
 #if 1	/* Set to zero for a slightly smaller kernel */
-#define BUG()				\
- __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
-			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+#define BUG() do {						\
+		__asm__ __volatile__(	"ud2\n"			\
+			"\t.word %c0\n"				\
+			"\t.long %c1\n"				\
+			 : : "i" (__LINE__), "i" (__FILE__));	\
+		__dummy_noreturn();				\
+	} while(0)
 #else
-#define BUG() __asm__ __volatile__("ud2\n")
+#define BUG() do {						\
+		__asm__ __volatile__("ud2\n");			\
+		__dummy_noreturn();				\
+	} while(0)
 #endif
 
 #define PAGE_BUG(page) do { \
diff -Nru -X dontdiff linux-2.4-vanilla/include/linux/compiler.h linux-2.4/include/linux/compiler.h
--- linux-2.4-vanilla/include/linux/compiler.h	Tue Sep 18 23:12:45 2001
+++ linux-2.4/include/linux/compiler.h	Tue Feb  3 18:29:56 2004
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
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"L'ottimista pensa che questo sia il migliore dei mondi possibili. 
 Il pessimista sa che e` vero" -- J. Robert Oppenheimer
