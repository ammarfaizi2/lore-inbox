Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbTBFWcG>; Thu, 6 Feb 2003 17:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTBFWcF>; Thu, 6 Feb 2003 17:32:05 -0500
Received: from crack.them.org ([65.125.64.184]:10986 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267668AbTBFWb4>;
	Thu, 6 Feb 2003 17:31:56 -0500
Date: Thu, 6 Feb 2003 17:41:32 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Ptrace updates: PTRACE_GETSIGINFO [2/5]
Message-ID: <20030206224132.GB22762@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030206223924.GA22688@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206223924.GA22688@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PTRACE_GETSIGINFO and PTRACE_SETSIGINFO, as suggested by
someone on linux-kernel (discussion between Andi Kleen and Roland McGrath, I
think).  You can use these to query the information about a signal or forge
it, which is useful if (for instance) a debugger needs to queue a signal
for later delivery.

This implements the feature for all architectures which use the generic
get_signal_to_deliver.  Doing it for the rest is straightforward.

# --------------------------------------------
# 03/01/18	drow@nevyn.them.org	1.958
# Add PTRACE_GETSIGINFO and PTRACE_SETSIGINFO
# 
# These new ptrace commands allow a debugger to control signals more precisely;
# for instance, store a signal and deliver it later, as if it had come from the
# original outside process or in response to the same faulting memory access.
# --------------------------------------------

diff -Nru a/include/linux/ptrace.h b/include/linux/ptrace.h
--- a/include/linux/ptrace.h	Thu Feb  6 16:57:36 2003
+++ b/include/linux/ptrace.h	Thu Feb  6 16:57:36 2003
@@ -26,6 +26,8 @@
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
 #define PTRACE_GETEVENTMSG	0x4201
+#define PTRACE_GETSIGINFO	0x4202
+#define PTRACE_SETSIGINFO	0x4203
 
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD	0x00000001
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Feb  6 16:57:36 2003
+++ b/include/linux/sched.h	Thu Feb  6 16:57:36 2003
@@ -400,6 +400,7 @@
 	struct backing_dev_info *backing_dev_info;
 
 	unsigned long ptrace_message;
+	siginfo_t *last_siginfo; /* For ptrace use.  */
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Thu Feb  6 16:57:36 2003
+++ b/kernel/ptrace.c	Thu Feb  6 16:57:36 2003
@@ -286,6 +286,23 @@
 	return 0;
 }
 
+static int ptrace_getsiginfo(struct task_struct *child, long data)
+{
+	if (child->last_siginfo == NULL)
+		return -EINVAL;
+	return copy_siginfo_to_user ((siginfo_t *) data, child->last_siginfo);
+}
+
+static int ptrace_setsiginfo(struct task_struct *child, long data)
+{
+	if (child->last_siginfo == NULL)
+		return -EINVAL;
+	if (copy_from_user (child->last_siginfo, (siginfo_t *) data,
+			    sizeof (siginfo_t)) != 0)
+		return -EFAULT;
+	return 0;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   long addr, long data)
 {
@@ -300,6 +317,12 @@
 		break;
 	case PTRACE_GETEVENTMSG:
 		ret = put_user(child->ptrace_message, (unsigned long *) data);
+		break;
+	case PTRACE_GETSIGINFO:
+		ret = ptrace_getsiginfo(child, data);
+		break;
+	case PTRACE_SETSIGINFO:
+		ret = ptrace_setsiginfo(child, data);
 		break;
 	default:
 		break;
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Thu Feb  6 16:57:36 2003
+++ b/kernel/signal.c	Thu Feb  6 16:57:36 2003
@@ -1244,10 +1244,13 @@
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			/* Let the debugger run.  */
 			current->exit_code = signr;
+			current->last_siginfo = info;
 			set_current_state(TASK_STOPPED);
 			notify_parent(current, SIGCHLD);
 			schedule();
 
+			current->last_siginfo = NULL;
+
 			/* We're back.  Did the debugger cancel the sig?  */
 			signr = current->exit_code;
 			if (signr == 0)
@@ -1258,7 +1261,10 @@
 			if (signr == SIGSTOP)
 				continue;
 
-			/* Update the siginfo structure.  Is this good?  */
+			/* Update the siginfo structure if the signal has
+			   changed.  If the debugger wanted something
+			   specific in the siginfo structure then it should
+			   have updated *info via PTRACE_SETSIGINFO.  */
 			if (signr != info->si_signo) {
 				info->si_signo = signr;
 				info->si_errno = 0;

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
