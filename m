Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWFHG11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWFHG11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWFHG11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:27:27 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:18090 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932524AbWFHG10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:27:26 -0400
Date: Thu, 8 Jun 2006 02:23:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: fix compat mode ptrace() bug
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Albert Cahalan <acahalan@gmail.com>, Andi Kleen <ak@suse.de>
Message-ID: <200606080226_MC3-1-C1E2-4DA4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace(PTRACE_[GS]ETSIGINFO) is broken in ia32 mode on 64-bit kernel,
as reported by Albert Cahalan.

Below patch fixes it; should the new code be moved to kernel/compat.c?
I only added it to x86_64 for now; it was copied from kernel/ptrace.c
with minor changes.

Test program:

/* ptrace() test program: does tracer get the correct pid and uid?
 * Run this test in 32-bit compat environment on 64-bit kernel.
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <linux/ptrace.h>
#include <sys/wait.h>

static void handler(int nr, siginfo_t *si, void *vuc)
{
	printf("child %u in signal handler: signal %d from pid %d, uid %d\n",
		getpid(), si->si_signo, si->si_pid, si->si_uid);
}

static void do_child()
{
	struct sigaction sa = {
		.sa_sigaction = handler,
		.sa_flags     = SA_SIGINFO,
	};
	sigaction(SIGUSR1, &sa, NULL);
	ptrace(PTRACE_TRACEME, 0, 0, 0);
	kill(getpid(), SIGUSR1);
}

static void do_parent()
{
	int children = 1, child, status;
	siginfo_t si;
 again:
	child = wait(&status);
	if (WIFSTOPPED(status)) {
		unsigned int signo = WSTOPSIG(status) & 0x7f;
		ptrace(PTRACE_GETSIGINFO, child, 0, &si);
		fprintf(stderr, "child %u stopped in parent: signal %u from pid %d, uid %d\n",
				child, signo, si.si_pid, si.si_uid);
		ptrace(PTRACE_CONT, child, NULL, (void *)signo);
	}
	if (!WIFEXITED(status) && !(WIFSIGNALED(status)))
		goto again;
	fprintf(stderr, "child %u gone\n", child);
	if (--children > 0)
		goto again;
	fprintf(stderr, "exiting: no children left\n");
}


int main(int argc, char * const argv[])
{
	if (fork())
		do_parent();
	else
		do_child();

	return 0;
}


 arch/x86_64/ia32/ptrace32.c |   60 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 58 insertions(+), 2 deletions(-)

--- 2.6.17-rc6-64.orig/arch/x86_64/ia32/ptrace32.c
+++ 2.6.17-rc6-64/arch/x86_64/ia32/ptrace32.c
@@ -18,6 +18,7 @@
 #include <linux/unistd.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
+#include <linux/compat.h>
 #include <asm/ptrace.h>
 #include <asm/compat.h>
 #include <asm/uaccess.h>
@@ -199,6 +200,51 @@ static int getreg32(struct task_struct *
 
 #undef R32
 
+static int compat_ptrace_getsiginfo(struct task_struct *child,
+				    struct compat_siginfo __user *data)
+{
+	siginfo_t lastinfo;
+	int error = -ESRCH;
+
+	read_lock(&tasklist_lock);
+	if (likely(child->sighand != NULL)) {
+		error = -EINVAL;
+		spin_lock_irq(&child->sighand->siglock);
+		if (likely(child->last_siginfo != NULL)) {
+			lastinfo = *child->last_siginfo;
+			error = 0;
+		}
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
+	if (!error)
+		return copy_siginfo_to_user32(data, &lastinfo);
+	return error;
+}
+
+static int compat_ptrace_setsiginfo(struct task_struct *child,
+				    struct compat_siginfo __user *data)
+{
+	siginfo_t newinfo;
+	int error = -ESRCH;
+
+	if (copy_siginfo_from_user32(&newinfo, data))
+		return -EFAULT;
+
+	read_lock(&tasklist_lock);
+	if (likely(child->sighand != NULL)) {
+		error = -EINVAL;
+		spin_lock_irq(&child->sighand->siglock);
+		if (likely(child->last_siginfo != NULL)) {
+			*child->last_siginfo = newinfo;
+			error = 0;
+		}
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
+	return error;
+}
+
 asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
 {
 	struct task_struct *child;
@@ -207,7 +253,7 @@ asmlinkage long sys32_ptrace(long reques
 	int ret;
 	__u32 val;
 
-	switch (request) { 
+	switch (request) {
 	default:
 		return sys_ptrace(request, pid, addr, data); 
 
@@ -223,6 +269,8 @@ asmlinkage long sys32_ptrace(long reques
 	case PTRACE_GETFPREGS:
 	case PTRACE_SETFPXREGS:
 	case PTRACE_GETFPXREGS:
+	case PTRACE_GETSIGINFO:
+	case PTRACE_SETSIGINFO:
 	case PTRACE_GETEVENTMSG:
 		break;
 	} 
@@ -344,8 +392,16 @@ asmlinkage long sys32_ptrace(long reques
 		break;
 	}
 
+	case PTRACE_GETSIGINFO:
+		ret = compat_ptrace_getsiginfo(child, datap);
+		break;
+
+	case PTRACE_SETSIGINFO:
+		ret = compat_ptrace_setsiginfo(child, datap);
+		break;
+
 	case PTRACE_GETEVENTMSG:
-		ret = put_user(child->ptrace_message,(unsigned int __user *)compat_ptr(data));
+		ret = put_user(child->ptrace_message, (unsigned int __user *)datap);
 		break;
 
 	default:
-- 
Chuck
