Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWAHTik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWAHTik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWAHTik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:38:40 -0500
Received: from cabal.ca ([134.117.69.58]:62134 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161135AbWAHTiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:38:08 -0500
Date: Sun, 8 Jan 2006 14:38:07 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, carlos@parisc-linux.org,
       willy@parisc-linux.org
Subject: [PATCH 4/5] Convert x86_64 to use generic compat_siginfo_t
Message-ID: <20060108193807.GK3782@tachyon.int.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle McMartin <kyle@parisc-linux.org>

Convert arch/x86_64 to use generic compat_siginfo_t.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

Andi,

I've done testing of this using my x86-64 machine, and it seems to survive
the GCC testsuite, which seemed to be a rather signal heavy workload. If you
would prefer me to run something else to test, let me know, I'd be more
than happy to.

 arch/x86_64/ia32/ia32_signal.c |    1 +
 include/asm-x86_64/compat.h    |    3 ++
 include/asm-x86_64/ia32.h      |   53 +---------------------------------------
 3 files changed, 5 insertions(+), 52 deletions(-)

82a78ba45a265996a8a8d5ffdcea568f3fe07c1f
diff --git a/arch/x86_64/ia32/ia32_signal.c b/arch/x86_64/ia32/ia32_signal.c
index 0903cc1..b02cfe4 100644
--- a/arch/x86_64/ia32/ia32_signal.c
+++ b/arch/x86_64/ia32/ia32_signal.c
@@ -23,6 +23,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compat.h>
+#include <linux/compat_siginfo.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
diff --git a/include/asm-x86_64/compat.h b/include/asm-x86_64/compat.h
index f0155c3..7e0a7fb 100644
--- a/include/asm-x86_64/compat.h
+++ b/include/asm-x86_64/compat.h
@@ -16,6 +16,9 @@ typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
+/* Define for use in compat_siginfo_t */
+#undef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T __compat_uid32_t
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
diff --git a/include/asm-x86_64/ia32.h b/include/asm-x86_64/ia32.h
index c7bc9c0..d9a32d5 100644
--- a/include/asm-x86_64/ia32.h
+++ b/include/asm-x86_64/ia32.h
@@ -6,6 +6,7 @@
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
+#include <linux/compat_siginfo.h>
 
 /*
  * 32 bit structures for IA32 support.
@@ -78,58 +79,6 @@ struct stat64 {
 	unsigned long long	st_ino;
 } __attribute__((packed));
 
-typedef struct compat_siginfo{
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
-			compat_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-			int _overrun_incr;	/* amount to add to overrun */
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
 struct sigframe32
 {
         u32 pretcode;
-- 
1.0.7

