Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVCGHAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVCGHAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVCGHAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:00:45 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:43201 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261655AbVCGHAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:00:19 -0500
Date: Mon, 7 Mar 2005 18:00:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate the last compat sigvals
Message-Id: <20050307180016.7cba76c8.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Linus,

This patch just consolidates the last of the (what should have been)
compat_sigval_ts.  It also fixes S390 that had a sigval_t in its struct
compat_siginfo.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

This patch needs to be applied on top of my "add and use
COMPAT_SIGEV_PAD_SIZE" patch posted a few minutes ago.

P.S. this patch has not even been compiled as I don't have acces to any of
the platforms involved, but has been acked by Dave Miller.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-SIGEV/arch/ia64/ia32/ia32priv.h linus-sigval/arch/ia64/ia32/ia32priv.h
--- linus-SIGEV/arch/ia64/ia32/ia32priv.h	2005-02-21 12:02:07.000000000 +1100
+++ linus-sigval/arch/ia64/ia32/ia32priv.h	2005-03-07 17:52:28.000000000 +1100
@@ -225,11 +225,6 @@ struct stat64 {
 	unsigned int	st_ino_hi;
 };
 
-typedef union sigval32 {
-	int sival_int;
-	unsigned int sival_ptr;
-} sigval_t32;
-
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_errno;
@@ -249,7 +244,7 @@ typedef struct compat_siginfo {
 			timer_t _tid;		/* timer id */
 			int _overrun;		/* overrun count */
 			char _pad[sizeof(unsigned int) - sizeof(int)];
-			sigval_t32 _sigval;	/* same as below */
+			compat_sigval_t _sigval;	/* same as below */
 			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
@@ -257,7 +252,7 @@ typedef struct compat_siginfo {
 		struct {
 			unsigned int _pid;	/* sender's pid */
 			unsigned int _uid;	/* sender's uid */
-			sigval_t32 _sigval;
+			compat_sigval_t _sigval;
 		} _rt;
 
 		/* SIGCHLD */
@@ -283,7 +278,7 @@ typedef struct compat_siginfo {
 } compat_siginfo_t;
 
 typedef struct sigevent32 {
-	sigval_t32 sigev_value;
+	compat_sigval_t sigev_value;
 	int sigev_signo;
 	int sigev_notify;
 	union {
diff -ruNp linus-SIGEV/arch/mips/kernel/signal32.c linus-sigval/arch/mips/kernel/signal32.c
--- linus-SIGEV/arch/mips/kernel/signal32.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-sigval/arch/mips/kernel/signal32.c	2005-03-02 14:25:33.000000000 +1100
@@ -32,11 +32,6 @@
 
 #define SI_PAD_SIZE32   ((SI_MAX_SIZE/sizeof(int)) - 3)
 
-typedef union sigval32 {
-	int sival_int;
-	s32 sival_ptr;
-} sigval_t32;
-
 typedef struct compat_siginfo {
 	int si_signo;
 	int si_code;
@@ -89,7 +84,7 @@ typedef struct compat_siginfo {
 		struct {
 			compat_pid_t _pid;	/* sender's pid */
 			compat_uid_t _uid;	/* sender's uid */
-			sigval_t32 _sigval;
+			compat_sigval_t _sigval;
 		} _rt;
 
 	} _sifields;
diff -ruNp linus-SIGEV/arch/s390/kernel/compat_linux.h linus-sigval/arch/s390/kernel/compat_linux.h
--- linus-SIGEV/arch/s390/kernel/compat_linux.h	2005-02-21 12:02:07.000000000 +1100
+++ linus-sigval/arch/s390/kernel/compat_linux.h	2005-03-07 17:49:16.000000000 +1100
@@ -29,11 +29,6 @@ struct old_sigaction32 {
        __u32			sa_restorer;	/* Another 32 bit pointer */
 };
  
-typedef union sigval32 {
-        int     sival_int;
-        __u32   sival_ptr;
-} sigval_t32;
-                 
 typedef struct compat_siginfo {
 	int	si_signo;
 	int	si_errno;
@@ -52,7 +47,7 @@ typedef struct compat_siginfo {
 		struct {
 			timer_t _tid;		/* timer id */
 			int _overrun;		/* overrun count */
-			sigval_t _sigval;	/* same as below */
+			compat_sigval_t _sigval;	/* same as below */
 			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
@@ -60,7 +55,7 @@ typedef struct compat_siginfo {
 		struct {
 			pid_t			_pid;	/* sender's pid */
 			uid_t			_uid;	/* sender's uid */
-			sigval_t32		_sigval;
+			compat_sigval_t		_sigval;
 		} _rt;
 
 		/* SIGCHLD */
diff -ruNp linus-SIGEV/arch/sparc64/kernel/signal32.c linus-sigval/arch/sparc64/kernel/signal32.c
--- linus-SIGEV/arch/sparc64/kernel/signal32.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-sigval/arch/sparc64/kernel/signal32.c	2005-03-02 14:25:33.000000000 +1100
@@ -104,7 +104,7 @@ typedef struct compat_siginfo{
 		struct {
 			timer_t _tid;			/* timer id */
 			int _overrun;			/* overrun count */
-			sigval_t32 _sigval;		/* same as below */
+			compat_sigval_t _sigval;		/* same as below */
 			int _sys_private;		/* not to be passed to user */
 		} _timer;
 
@@ -112,7 +112,7 @@ typedef struct compat_siginfo{
 		struct {
 			compat_pid_t _pid;		/* sender's pid */
 			unsigned int _uid;		/* sender's uid */
-			sigval_t32 _sigval;
+			compat_sigval_t _sigval;
 		} _rt;
 
 		/* SIGCHLD */
diff -ruNp linus-SIGEV/include/asm-sparc64/siginfo.h linus-sigval/include/asm-sparc64/siginfo.h
--- linus-SIGEV/include/asm-sparc64/siginfo.h	2005-02-21 12:02:07.000000000 +1100
+++ linus-sigval/include/asm-sparc64/siginfo.h	2005-03-07 17:49:55.000000000 +1100
@@ -18,11 +18,6 @@
 
 #ifdef CONFIG_COMPAT
 
-typedef union sigval32 {
-	int sival_int;
-	u32 sival_ptr;
-} sigval_t32;
-
 struct compat_siginfo;
 
 #endif /* CONFIG_COMPAT */
@@ -42,7 +37,7 @@ struct compat_siginfo;
 #ifdef CONFIG_COMPAT
 
 typedef struct sigevent32 {
-	sigval_t32 sigev_value;
+	compat_sigval_t sigev_value;
 	int sigev_signo;
 	int sigev_notify;
 	union {
