Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVCGGjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVCGGjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVCGGjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:39:37 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:54720 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261654AbVCGGjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:39:18 -0500
Date: Mon, 7 Mar 2005 17:39:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] add and use COMPAT_SIGEV_PAD_SIZE
Message-Id: <20050307173914.347c30e0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

All the 32 bit architectures (effectively) define SIGEV_PAD_SIZE to be
((SIGEV_MAX_SIZE/sizeof(int)) - 3).  So define COMPAT_SIGEV_PAD_SIZE to be
this and replace SIGEV_PAD_SIZE32 where it is used.  It also needs to be
used in the definition of struct compat_sigevent as most of the
architectures would have had it 4 bytes too small in the kernel (since we
were using SIGEV_PAD_SIZE).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/ia64/ia32/ia32priv.h linus-SIGEV/arch/ia64/ia32/ia32priv.h
--- linus/arch/ia64/ia32/ia32priv.h	2005-01-05 17:06:07.000000000 +1100
+++ linus-SIGEV/arch/ia64/ia32/ia32priv.h	2005-02-21 12:02:07.000000000 +1100
@@ -230,8 +230,6 @@ typedef union sigval32 {
 	unsigned int sival_ptr;
 } sigval_t32;
 
-#define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
-
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_errno;
@@ -289,7 +287,7 @@ typedef struct sigevent32 {
 	int sigev_signo;
 	int sigev_notify;
 	union {
-		int _pad[SIGEV_PAD_SIZE32];
+		int _pad[COMPAT_SIGEV_PAD_SIZE];
 		struct {
 			u32 _function;
 			u32 _attribute; /* really pthread_attr_t */
diff -ruNp linus/arch/s390/kernel/compat_linux.h linus-SIGEV/arch/s390/kernel/compat_linux.h
--- linus/arch/s390/kernel/compat_linux.h	2005-02-04 13:05:31.000000000 +1100
+++ linus-SIGEV/arch/s390/kernel/compat_linux.h	2005-02-21 12:02:07.000000000 +1100
@@ -199,7 +199,6 @@ struct ucontext32 {
 	compat_sigset_t		uc_sigmask;	/* mask last for extensibility */
 };
 
-#define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 struct sigevent32 {
 	union {
 		int sival_int;
@@ -208,7 +207,7 @@ struct sigevent32 {
 	int sigev_signo;
 	int sigev_notify;
 	union {
-		int _pad[SIGEV_PAD_SIZE32];
+		int _pad[COMPAT_SIGEV_PAD_SIZE];
 		int _tid;
 		struct {
 			u32 *_function;
diff -ruNp linus/include/asm-sparc64/siginfo.h linus-SIGEV/include/asm-sparc64/siginfo.h
--- linus/include/asm-sparc64/siginfo.h	2005-01-05 17:06:08.000000000 +1100
+++ linus-SIGEV/include/asm-sparc64/siginfo.h	2005-02-21 12:02:07.000000000 +1100
@@ -4,7 +4,6 @@
 #define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
 
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
-#define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #define __ARCH_SI_TRAPNO
@@ -47,7 +46,7 @@ typedef struct sigevent32 {
 	int sigev_signo;
 	int sigev_notify;
 	union {
-		int _pad[SIGEV_PAD_SIZE32];
+		int _pad[COMPAT_SIGEV_PAD_SIZE];
 
 		struct {
 			u32 _function;
diff -ruNp linus/include/linux/compat.h linus-SIGEV/include/linux/compat.h
--- linus/include/linux/compat.h	2005-03-07 13:06:24.000000000 +1100
+++ linus-SIGEV/include/linux/compat.h	2005-03-07 14:07:26.000000000 +1100
@@ -101,12 +101,14 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+#define COMPAT_SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 3)
+
 typedef struct compat_sigevent {
 	compat_sigval_t sigev_value;
 	compat_int_t sigev_signo;
 	compat_int_t sigev_notify;
 	union {
-		compat_int_t _pad[SIGEV_PAD_SIZE];
+		compat_int_t _pad[COMPAT_SIGEV_PAD_SIZE];
 		compat_int_t _tid;
 
 		struct {
