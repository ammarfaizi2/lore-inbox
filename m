Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVBOErJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVBOErJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 23:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVBOErJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 23:47:09 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:48263 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261624AbVBOEqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 23:46:55 -0500
Date: Tue, 15 Feb 2005 15:46:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       schwidefsky@de.ibm.com
Subject: [PATCH] Consolidate the last compat sigvals
Message-Id: <20050215154648.74e54fff.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch just consolidates the last of the (what should have been)
compat_sigval_ts.  It worries me that S390 has a sigval_t in its struct
compat_siginfo, but I have left that for now.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

P.S. this patch has not even been compiled as I don't have acces to any of
the platforms involved, but should be straight forward to fix if it breaks
anything.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-waitid.1/arch/ia64/ia32/ia32priv.h linus-waitid.2/arch/ia64/ia32/ia32priv.h
--- linus-waitid.1/arch/ia64/ia32/ia32priv.h	2005-01-05 17:06:07.000000000 +1100
+++ linus-waitid.2/arch/ia64/ia32/ia32priv.h	2005-02-15 15:26:42.000000000 +1100
@@ -225,11 +225,6 @@ struct stat64 {
 	unsigned int	st_ino_hi;
 };
 
-typedef union sigval32 {
-	int sival_int;
-	unsigned int sival_ptr;
-} sigval_t32;
-
 #define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 
 typedef struct compat_siginfo {
@@ -251,7 +246,7 @@ typedef struct compat_siginfo {
 			timer_t _tid;		/* timer id */
 			int _overrun;		/* overrun count */
 			char _pad[sizeof(unsigned int) - sizeof(int)];
-			sigval_t32 _sigval;	/* same as below */
+			compat_sigval_t _sigval;	/* same as below */
 			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
@@ -259,7 +254,7 @@ typedef struct compat_siginfo {
 		struct {
 			unsigned int _pid;	/* sender's pid */
 			unsigned int _uid;	/* sender's uid */
-			sigval_t32 _sigval;
+			compat_sigval_t _sigval;
 		} _rt;
 
 		/* SIGCHLD */
@@ -285,7 +280,7 @@ typedef struct compat_siginfo {
 } compat_siginfo_t;
 
 typedef struct sigevent32 {
-	sigval_t32 sigev_value;
+	compat_sigval_t sigev_value;
 	int sigev_signo;
 	int sigev_notify;
 	union {
diff -ruNp linus-waitid.1/arch/mips/kernel/signal32.c linus-waitid.2/arch/mips/kernel/signal32.c
--- linus-waitid.1/arch/mips/kernel/signal32.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-waitid.2/arch/mips/kernel/signal32.c	2005-02-15 15:27:37.000000000 +1100
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
diff -ruNp linus-waitid.1/arch/s390/kernel/compat_linux.h linus-waitid.2/arch/s390/kernel/compat_linux.h
--- linus-waitid.1/arch/s390/kernel/compat_linux.h	2005-02-04 13:05:31.000000000 +1100
+++ linus-waitid.2/arch/s390/kernel/compat_linux.h	2005-02-15 15:28:48.000000000 +1100
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
@@ -60,7 +55,7 @@ typedef struct compat_siginfo {
 		struct {
 			pid_t			_pid;	/* sender's pid */
 			uid_t			_uid;	/* sender's uid */
-			sigval_t32		_sigval;
+			compat_sigval_t		_sigval;
 		} _rt;
 
 		/* SIGCHLD */
diff -ruNp linus-waitid.1/arch/sparc64/kernel/signal32.c linus-waitid.2/arch/sparc64/kernel/signal32.c
--- linus-waitid.1/arch/sparc64/kernel/signal32.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-waitid.2/arch/sparc64/kernel/signal32.c	2005-02-15 15:38:14.000000000 +1100
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
diff -ruNp linus-waitid.1/include/asm-sparc64/siginfo.h linus-waitid.2/include/asm-sparc64/siginfo.h
--- linus-waitid.1/include/asm-sparc64/siginfo.h	2005-01-05 17:06:08.000000000 +1100
+++ linus-waitid.2/include/asm-sparc64/siginfo.h	2005-02-15 15:30:04.000000000 +1100
@@ -19,11 +19,6 @@
 
 #ifdef CONFIG_COMPAT
 
-typedef union sigval32 {
-	int sival_int;
-	u32 sival_ptr;
-} sigval_t32;
-
 struct compat_siginfo;
 
 #endif /* CONFIG_COMPAT */
@@ -43,7 +38,7 @@ struct compat_siginfo;
 #ifdef CONFIG_COMPAT
 
 typedef struct sigevent32 {
-	sigval_t32 sigev_value;
+	compat_sigval_t sigev_value;
 	int sigev_signo;
 	int sigev_notify;
 	union {

