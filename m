Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQJ1KXe>; Sat, 28 Oct 2000 06:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbQJ1KXZ>; Sat, 28 Oct 2000 06:23:25 -0400
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:6154 "EHLO mail3.kc.rr.com")
	by vger.kernel.org with ESMTP id <S129595AbQJ1KXM>;
	Sat, 28 Oct 2000 06:23:12 -0400
To: torvalds@transmeta.com
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ambiguous PTRACE_SYSCALL tracing
From: Mike Coleman <mcoleman2@kc.rr.com>
Date: 28 Oct 2000 05:22:47 -0500
In-Reply-To: Mike Coleman's message of "13 Mar 2000 17:34:06 -0600"
Message-ID: <87k8atuux4.fsf@kc.net>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch allows a (ptrace) parent to unambiguously distinguish between a
child ptrace stop following a PTRACE_SYSCALL due to a system call and a ptrace
stop due to delivery of a SIGTRAP.

Currently, when PTRACE_SYSCALL is being used, it's not possible to tell for
certain why a particular ptrace stop happens.  The workaround is to check the
"wait channel" of the stopped process, but this is ugly and slow.

This patch is of benefit to all users of PTRACE_SYSCALL (strace, SUBTERFUGUE,
etc).

The new functionality is enabled on a per-child basis by the ptrace'ing
parent, and is disabled by default, thus preserving full backward
compatibility with existing versions of strace.

--Mike

P.S.  Even if you disallow the patch, you may want to look at the first
chunk.  I believe this change was missed when the ptrace flag field was added
recently.



diff -aur linux/arch/i386/kernel/ptrace.c linux-2.4.0-test9/arch/i386/kernel/ptrace.c
--- linux/arch/i386/kernel/ptrace.c	Fri Sep 22 14:25:19 2000
+++ linux-2.4.0-test9/arch/i386/kernel/ptrace.c	Thu Oct 19 23:20:58 2000
@@ -351,7 +351,7 @@
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		child->ptrace &= ~(PT_PTRACED|PT_TRACESYS);
+		child->ptrace = 0;
 		child->exit_code = data;
 		write_lock_irq(&tasklist_lock);
 		REMOVE_LINKS(child);
@@ -451,6 +451,15 @@
 		break;
 	}
 
+	case PTRACE_SETOPTIONS: {
+		if (data & PTRACE_O_TRACESYSGOOD)
+			child->ptrace |= PT_TRACESYSGOOD;
+		else
+			child->ptrace &= ~PT_TRACESYSGOOD;
+		ret = 0;
+		break;
+	}
+
 	default:
 		ret = -EIO;
 		break;
@@ -467,7 +476,10 @@
 	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS)) !=
 			(PT_PTRACED|PT_TRACESYS))
 		return;
-	current->exit_code = SIGTRAP;
+	/* the 0x80 provides a way for the tracing parent to distinguish
+	   between a syscall stop and SIGTRAP delivery */
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -aur linux/include/asm-i386/ptrace.h linux-2.4.0-test9/include/asm-i386/ptrace.h
--- linux/include/asm-i386/ptrace.h	Wed Jun 21 22:59:38 2000
+++ linux-2.4.0-test9/include/asm-i386/ptrace.h	Thu Oct 19 23:12:35 2000
@@ -49,6 +49,11 @@
 #define PTRACE_GETFPXREGS         18
 #define PTRACE_SETFPXREGS         19
 
+#define PTRACE_SETOPTIONS         21
+
+/* options set using PTRACE_SETOPTIONS */
+#define PTRACE_O_TRACESYSGOOD     0x00000001
+
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
