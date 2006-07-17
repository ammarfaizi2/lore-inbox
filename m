Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWGRAEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWGRAEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWGRAEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:04:16 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:60563 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751249AbWGRAEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:04:15 -0400
Date: Mon, 17 Jul 2006 19:58:41 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix recursive faults during oops when current
  is invalid
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607172001_MC3-1-C544-DDA1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix recursive faults during oops caused by invalid value in current
by using __get_user()/__put_user() when dereferencing it.

Reported by Krzysztof Halasa <khc@pm.waw.pl>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 If this is OK I'll do x86_64 next.

 arch/i386/kernel/traps.c |   17 +++++++++++++----
 arch/i386/mm/fault.c     |    7 ++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

--- 2.6.18-rc1-32.orig/arch/i386/mm/fault.c
+++ 2.6.18-rc1-32/arch/i386/mm/fault.c
@@ -585,9 +585,10 @@ no_context:
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 #endif
-	tsk->thread.cr2 = address;
-	tsk->thread.trap_no = 14;
-	tsk->thread.error_code = error_code;
+	/* avoid possible fault here if tsk is garbage */
+	__put_user(address, &tsk->thread.cr2);
+	__put_user(14, &tsk->thread.trap_no);
+	__put_user(error_code, &tsk->thread.error_code);
 	die("Oops", regs, error_code);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
--- 2.6.18-rc1-32.orig/arch/i386/kernel/traps.c
+++ 2.6.18-rc1-32/arch/i386/kernel/traps.c
@@ -267,8 +267,16 @@ void show_registers(struct pt_regs *regs
 	int i;
 	int in_kernel = 1;
 	unsigned long esp;
+	char *comm = "<bad task>";
+	pid_t pid = 0;
+	void *thread_info = 0;
 	unsigned short ss;
 
+	__get_user(thread_info, &current->thread_info);
+	__get_user(pid, &current->pid);
+	if (!__get_user(comm, (char **)current->comm))
+		comm = current->comm;
+
 	esp = (unsigned long) (&regs->esp);
 	savesegment(ss, ss);
 	if (user_mode_vm(regs)) {
@@ -291,8 +299,8 @@ void show_registers(struct pt_regs *regs
 	printk(KERN_EMERG "ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk(KERN_EMERG "Process %.*s (pid: %d, ti=%p task=%p task.ti=%p)",
-		TASK_COMM_LEN, current->comm, current->pid,
-		current_thread_info(), current, current->thread_info);
+		TASK_COMM_LEN, comm, pid,
+		current_thread_info(), current, thread_info);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
@@ -371,6 +379,7 @@ void die(const char * str, struct pt_reg
 	};
 	static int die_counter;
 	unsigned long flags;
+	unsigned long trap_no = 0; /* default if task pointer is corrupt */
 
 	oops_enter();
 
@@ -409,8 +418,8 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
-		if (notify_die(DIE_OOPS, str, regs, err,
-					current->thread.trap_no, SIGSEGV) !=
+		__get_user(trap_no, &current->thread.trap_no);
+		if (notify_die(DIE_OOPS, str, regs, err, trap_no, SIGSEGV) !=
 				NOTIFY_STOP) {
 			show_registers(regs);
 			/* Executive summary in case the oops scrolled away */
-- 
Chuck
