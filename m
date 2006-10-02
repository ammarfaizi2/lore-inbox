Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWJBNMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWJBNMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWJBNMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:12:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932298AbWJBNMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:12:49 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/2] BLOCK: Revert patch to hack around undeclared sigset_t in linux/compat.h
Date: Mon, 02 Oct 2006 14:12:31 +0100
To: torvalds@osdl.org, akpm@osdl.org, axboe@suse.de
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Revert Andrew Morton's patch to temporarily hack around the lack of a
declaration of sigset_t in linux/compat.h to make the block-disablement patches
build on IA64.  This got accidentally pushed to Linus and should be fixed in a
different manner.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/mips/kernel/signal_n32.c |    4 ++--
 fs/compat.c                   |    2 --
 include/linux/compat.h        |    1 +
 kernel/compat.c               |    2 --
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 50c17ea..477c533 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -42,8 +42,6 @@ #include <asm/war.h>
 
 #include "signal-common.h"
 
-extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
-
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
@@ -83,6 +81,8 @@ #if ICACHE_REFILLS_WORKAROUND_WAR
 #endif
 };
 
+extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
+
 save_static_function(sysn32_rt_sigsuspend);
 __attribute_used__ noinline static int
 _sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
diff --git a/fs/compat.c b/fs/compat.c
index 13fb08d..d98c96f 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -56,8 +56,6 @@ #include "internal.h"
 
 int compat_log = 1;
 
-extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
-
 int compat_printk(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 9760753..967e748 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -227,6 +227,7 @@ static inline int compat_timespec_compar
 asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
 
 extern int compat_printk(const char *fmt, ...);
+extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index b4fbd83..75573e5 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -26,8 +26,6 @@ #include <linux/posix-timers.h>
 
 #include <asm/uaccess.h>
 
-extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
-
 int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
 {
 	return (!access_ok(VERIFY_READ, cts, sizeof(*cts)) ||
