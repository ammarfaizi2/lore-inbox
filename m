Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263632AbSIQFZa>; Tue, 17 Sep 2002 01:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263633AbSIQFZa>; Tue, 17 Sep 2002 01:25:30 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:11440 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S263632AbSIQFZ3>;
	Tue, 17 Sep 2002 01:25:29 -0400
Date: Tue, 17 Sep 2002 15:30:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH][TRIVIAL] sigmask() was mutilply defined
Message-Id: <20020917153004.45a531e6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Every definition if sigmask() was the same.  In one case it was
mutilply defined for the arm architecture.  This patch removes all the
architecture defines of sigmask and moves the generic define from
the protection of __HAVE_ARCH_SIG_BITOPS.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35/include/asm-arm/signal.h 2.5.35-si.1/include/asm-arm/signal.h
--- 2.5.35/include/asm-arm/signal.h	2002-05-30 05:12:29.000000000 +1000
+++ 2.5.35-si.1/include/asm-arm/signal.h	2002-09-17 14:49:55.000000000 +1000
@@ -185,8 +185,6 @@
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
-
 #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
 #endif
diff -ruN 2.5.35/include/asm-i386/signal.h 2.5.35-si.1/include/asm-i386/signal.h
--- 2.5.35/include/asm-i386/signal.h	2002-01-31 07:12:46.000000000 +1100
+++ 2.5.35-si.1/include/asm-i386/signal.h	2002-09-17 14:50:38.000000000 +1000
@@ -209,8 +209,6 @@
 	 __const_sigismember((set),(sig)) :	\
 	 __gen_sigismember((set),(sig)))
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
-
 static __inline__ int sigfindinword(unsigned long word)
 {
 	__asm__("bsfl %1,%0" : "=r"(word) : "rm"(word) : "cc");
diff -ruN 2.5.35/include/asm-m68k/signal.h 2.5.35-si.1/include/asm-m68k/signal.h
--- 2.5.35/include/asm-m68k/signal.h	2002-05-30 05:12:29.000000000 +1000
+++ 2.5.35-si.1/include/asm-m68k/signal.h	2002-09-17 14:51:19.000000000 +1000
@@ -207,8 +207,6 @@
 	 __const_sigismember(set,sig) :		\
 	 __gen_sigismember(set,sig))
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
-
 extern __inline__ int sigfindinword(unsigned long word)
 {
 	__asm__("bfffo %1{#0,#0},%0" : "=d"(word) : "d"(word & -word) : "cc");
diff -ruN 2.5.35/include/asm-sh/signal.h 2.5.35-si.1/include/asm-sh/signal.h
--- 2.5.35/include/asm-sh/signal.h	1999-11-19 14:37:03.000000000 +1100
+++ 2.5.35-si.1/include/asm-sh/signal.h	2002-09-17 14:52:24.000000000 +1000
@@ -165,8 +165,6 @@
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_SIGNAL_H */
diff -ruN 2.5.35/include/asm-x86_64/signal.h 2.5.35-si.1/include/asm-x86_64/signal.h
--- 2.5.35/include/asm-x86_64/signal.h	2002-06-17 13:12:30.000000000 +1000
+++ 2.5.35-si.1/include/asm-x86_64/signal.h	2002-09-17 14:53:50.000000000 +1000
@@ -195,8 +195,6 @@
 	 __const_sigismember((set),(sig)) :	\
 	 __gen_sigismember((set),(sig)))
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
-
 extern __inline__ int sigfindinword(unsigned long word)
 {
 	__asm__("bsfq %1,%0" : "=r"(word) : "rm"(word) : "cc");
diff -ruN 2.5.35/include/linux/signal.h 2.5.35-si.1/include/linux/signal.h
--- 2.5.35/include/linux/signal.h	2002-08-02 11:11:42.000000000 +1000
+++ 2.5.35-si.1/include/linux/signal.h	2002-09-17 14:53:23.000000000 +1000
@@ -60,10 +60,10 @@
 	return ffz(~word);
 }
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
-
 #endif /* __HAVE_ARCH_SIG_BITOPS */
 
+#define sigmask(sig)	(1UL << ((sig) - 1))
+
 #ifndef __HAVE_ARCH_SIG_SETOPS
 #include <linux/string.h>
 
