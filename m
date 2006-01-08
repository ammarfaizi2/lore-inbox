Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWAHTiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWAHTiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWAHTiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:38:08 -0500
Received: from cabal.ca ([134.117.69.58]:60086 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161135AbWAHTiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:38:02 -0500
Date: Sun, 8 Jan 2006 14:37:59 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, carlos@parisc-linux.org,
       willy@parisc-linux.org
Subject: [PATCH 2/5] Convert ia64 to use generic compat_siginfo_t
Message-ID: <20060108193759.GI3782@tachyon.int.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <willy@parisc-linux.org>

Convert arch/ia64 to use generic compat_siginfo_t.

Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

Tony,

This patch has been sitting in parisc-linux for quite some time. Matthew
has been running that tree on his ia64 machines for a while, but I'm not
sure how much testing the ia32 emulation received.

 arch/ia64/ia32/ia32_signal.c |    1 +
 arch/ia64/ia32/ia32priv.h    |   52 ------------------------------------------
 include/asm-ia64/compat.h    |    3 ++
 3 files changed, 4 insertions(+), 52 deletions(-)

55f9c468f33f732cc60793aaa4a425384254290c
diff --git a/arch/ia64/ia32/ia32_signal.c b/arch/ia64/ia32/ia32_signal.c
index aa891c9..cd76bbb 100644
--- a/arch/ia64/ia32/ia32_signal.c
+++ b/arch/ia64/ia32/ia32_signal.c
@@ -24,6 +24,7 @@
 #include <linux/unistd.h>
 #include <linux/wait.h>
 #include <linux/compat.h>
+#include <linux/compat_siginfo.h>
 
 #include <asm/intrinsics.h>
 #include <asm/uaccess.h>
diff --git a/arch/ia64/ia32/ia32priv.h b/arch/ia64/ia32/ia32priv.h
index 68ceb4e..2bc099c 100644
--- a/arch/ia64/ia32/ia32priv.h
+++ b/arch/ia64/ia32/ia32priv.h
@@ -225,58 +225,6 @@ struct stat64 {
 	unsigned int	st_ino_hi;
 };
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[((128/sizeof(int)) - 3)];
-
-		/* kill() */
-		struct {
-			unsigned int _pid;	/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;		/* overrun count */
-			char _pad[sizeof(unsigned int) - sizeof(int)];
-			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;       /* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			unsigned int _pid;	/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			unsigned int _pid;	/* which child */
-			unsigned int _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			unsigned int _addr;	/* faulting insn/memory ref. */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
-
 struct old_linux32_dirent {
 	u32	d_ino;
 	u32	d_offset;
diff --git a/include/asm-ia64/compat.h b/include/asm-ia64/compat.h
index aaf11f4..b96eafa 100644
--- a/include/asm-ia64/compat.h
+++ b/include/asm-ia64/compat.h
@@ -15,6 +15,9 @@ typedef s32		compat_key_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
+/* Define for use in compat_siginfo_t */
+#undef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T	__compat_uid32_t
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-- 
1.0.7

