Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751731AbWD1ASl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWD1ASl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWD1ASk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:18:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:20949 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751756AbWD1ASe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:18:34 -0400
Date: Thu, 27 Apr 2006 17:16:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jason Baron <jbaron@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/24] make vm86 call audit_syscall_exit
Message-ID: <20060428001652.GD18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="make-vm86-call-audit_syscall_exit.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
hi,

The motivation behind the patch below was to address messages in
/var/log/messages such as:

Jan 31 10:54:15 mets kernel: audit(:0): major=252 name_count=0: freeing
multiple contexts (1)
Jan 31 10:54:15 mets kernel: audit(:0): major=113 name_count=0: freeing
multiple contexts (2)

I can reproduce by running 'get-edid' from:
http://john.fremlin.de/programs/linux/read-edid/.

These messages come about in the log b/c the vm86 calls do not exit via
the normal system call exit paths and thus do not call
'audit_syscall_exit'. The next system call will then free the context for
itself and for the vm86 context, thus generating the above messages. This
patch addresses the issue by simply adding a call to 'audit_syscall_exit'
from the vm86 code.

Besides fixing the above error messages the patch also now allows vm86
system calls to become auditable. This is useful since strace does not
appear to properly record the return values from sys_vm86.

I think this patch is also a step in the right direction in terms of
cleaning up some core auditing code. If we can correct any other paths
that do not properly call the audit exit and entries points, then we can
also eliminate the notion of context chaining.

I've tested this patch by verifying that the log messages no longer
appear, and that the audit records for sys_vm86 appear to be correct.
Also, 'read_edid' produces itentical output.

thanks,

-Jason

Signed-off-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
---
 arch/i386/kernel/vm86.c |   12 ++++++++++--
 kernel/auditsc.c        |    5 -----
 2 files changed, 10 insertions(+), 7 deletions(-)

--- linux-2.6.16.11.orig/arch/i386/kernel/vm86.c
+++ linux-2.6.16.11/arch/i386/kernel/vm86.c
@@ -43,6 +43,7 @@
 #include <linux/smp_lock.h>
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
+#include <linux/audit.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -252,6 +253,7 @@ out:
 static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_struct *tsk)
 {
 	struct tss_struct *tss;
+	long eax;
 /*
  * make sure the vm86() system call doesn't try to do anything silly
  */
@@ -305,13 +307,19 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
+	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
+	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
+
+	/*call audit_syscall_exit since we do not exit via the normal paths */
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, AUDITSC_RESULT(eax), eax);
+
 	__asm__ __volatile__(
-		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
 		"movl %0,%%esp\n\t"
 		"movl %1,%%ebp\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (task_thread_info(tsk)) : "ax");
+		:"r" (&info->regs), "r" (task_thread_info(tsk)));
 	/* we never return here */
 }
 
--- linux-2.6.16.11.orig/kernel/auditsc.c
+++ linux-2.6.16.11/kernel/auditsc.c
@@ -966,11 +966,6 @@ void audit_syscall_entry(struct task_str
 	if (context->in_syscall) {
 		struct audit_context *newctx;
 
-#if defined(__NR_vm86) && defined(__NR_vm86old)
-		/* vm86 mode should only be entered once */
-		if (major == __NR_vm86 || major == __NR_vm86old)
-			return;
-#endif
 #if AUDIT_DEBUG
 		printk(KERN_ERR
 		       "audit(:%d) pid=%d in syscall=%d;"

--
