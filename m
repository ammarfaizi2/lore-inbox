Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSEaAyD>; Thu, 30 May 2002 20:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSEaAyC>; Thu, 30 May 2002 20:54:02 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:54155 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313190AbSEaAyA>;
	Thu, 30 May 2002 20:54:00 -0400
Date: Fri, 31 May 2002 10:53:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] missing bit from signal patches - take 2 (or 3)
Message-Id: <20020531105343.055ad372.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following should allow the affected architectures to build in
2.5.19 as currently there will be two definitions of
copy_siginfo_to_user and if an architecture defines its own
siginfo_t it MUST define copy_siginfo().

Please apply.  This one should have a better chance of working :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.19/include/asm-alpha/siginfo.h 2.5.19-si.4/include/asm-alpha/siginfo.h
--- 2.5.19/include/asm-alpha/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-alpha/siginfo.h	Thu May 30 23:11:50 2002
@@ -6,6 +6,7 @@
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
 
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-cris/siginfo.h 2.5.19-si.4/include/asm-cris/siginfo.h
--- 2.5.19/include/asm-cris/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-cris/siginfo.h	Thu May 30 23:11:50 2002
@@ -1,6 +1,8 @@
 #ifndef _CRIS_SIGINFO_H
 #define _CRIS_SIGINFO_H
 
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
+
 #include <asm-generic/siginfo.h>
 
 #endif
diff -ruN 2.5.19/include/asm-ia64/siginfo.h 2.5.19-si.4/include/asm-ia64/siginfo.h
--- 2.5.19/include/asm-ia64/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-ia64/siginfo.h	Fri May 31 10:27:41 2002
@@ -11,8 +11,8 @@
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
 
 #define HAVE_ARCH_SIGINFO_T
-
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-m68k/siginfo.h 2.5.19-si.4/include/asm-m68k/siginfo.h
--- 2.5.19/include/asm-m68k/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-m68k/siginfo.h	Fri May 31 10:28:37 2002
@@ -2,6 +2,7 @@
 #define _M68K_SIGINFO_H
 
 #define HAVE_ARCH_SIGINFO_T
+#define HAVE_ARCH_COPY_SIGINFO
 
 #include <asm-generic/siginfo.h>
 
@@ -68,6 +69,21 @@
 #define si_uid16	_sifields._kill._uid
 #else
 #define si_uid		_sifields._kill._uid
+#endif
+
+#ifdef __KERNEL__
+
+#include <linux/string.h>
+
+static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
+}
+
 #endif /* __KERNEL__ */
 
 #endif
diff -ruN 2.5.19/include/asm-mips/siginfo.h 2.5.19-si.4/include/asm-mips/siginfo.h
--- 2.5.19/include/asm-mips/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-mips/siginfo.h	Thu May 30 23:18:46 2002
@@ -12,8 +12,8 @@
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
 
 #define HAVE_ARCH_SIGINFO_T
-
 #define HAVE_ARCH_SIGEVENT_T
+#define HAVE_ARCH_COPY_SIGINFO
 
 #include <asm-generic/siginfo.h>
 
@@ -121,5 +121,20 @@
 		} _sigev_thread;
 	} _sigev_un;
 } sigevent_t;
+
+#ifdef __KERNEL__
+
+#include <linux/string.h>
+
+static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
+}
+
+#endif
 
 #endif /* _ASM_SIGINFO_H */
diff -ruN 2.5.19/include/asm-mips64/siginfo.h 2.5.19-si.4/include/asm-mips64/siginfo.h
--- 2.5.19/include/asm-mips64/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-mips64/siginfo.h	Thu May 30 23:19:33 2002
@@ -13,6 +13,8 @@
 
 #define HAVE_ARCH_SIGINFO_T
 #define HAVE_ARCH_SIGEVENT_T
+#define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
@@ -120,5 +122,20 @@
 		} _sigev_thread;
 	} _sigev_un;
 } sigevent_t;
+
+#ifdef __KERNEL__
+
+#include <linux/string.h>
+
+static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
+}
+
+#endif
 
 #endif /* _ASM_SIGINFO_H */
diff -ruN 2.5.19/include/asm-parisc/siginfo.h 2.5.19-si.4/include/asm-parisc/siginfo.h
--- 2.5.19/include/asm-parisc/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.4/include/asm-parisc/siginfo.h	Thu May 30 23:11:50 2002
@@ -1,6 +1,8 @@
 #ifndef _PARISC_SIGINFO_H
 #define _PARISC_SIGINFO_H
 
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
+
 #include <asm-generic/siginfo.h>
 
 /*
diff -ruN 2.5.19/include/asm-sparc/siginfo.h 2.5.19-si.4/include/asm-sparc/siginfo.h
--- 2.5.19/include/asm-sparc/siginfo.h	Thu May 30 09:44:39 2002
+++ 2.5.19-si.4/include/asm-sparc/siginfo.h	Thu May 30 23:11:50 2002
@@ -7,6 +7,7 @@
 
 #define HAVE_ARCH_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-sparc64/siginfo.h 2.5.19-si.4/include/asm-sparc64/siginfo.h
--- 2.5.19/include/asm-sparc64/siginfo.h	Thu May 30 09:44:39 2002
+++ 2.5.19-si.4/include/asm-sparc64/siginfo.h	Fri May 31 10:30:00 2002
@@ -8,8 +8,8 @@
 #define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 
 #define HAVE_ARCH_SIGINFO_T
-
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
