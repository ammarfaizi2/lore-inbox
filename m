Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVGLRVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVGLRVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVGLRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:21:50 -0400
Received: from [151.97.230.9] ([151.97.230.9]:52431 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261756AbVGLRVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:21:45 -0400
Subject: [patch 1/1] uml: fix TT mode by reverting "use fork instead of clone"
To: stable@kernel.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 12 Jul 2005 19:28:37 +0200
Message-Id: <20050712172838.271E8D9A84@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Revert the following patch, because of miscompilation problems in different
environments leading to UML not working *at all* in TT mode; it was merged
lately in 2.6 development cycle, a little after being written, and has caused
problems to lots of people; I know it's a bit too long, but it shouldn't have
been merged in first place, so I still apply for inclusion in the -stable
tree. Anyone using this feature currently is either using some older kernel
(some reports even used 2.6.12-rc4-mm2) or using this patch, as included in my
-bs patchset.

For now there's not yet a fix for this patch, so for now the best thing is to
drop it (which was widely reported to give a working kernel).

"Convert the boot-time host ptrace testing from clone to fork.  They were
essentially doing fork anyway.  This cleans up the code a bit, and makes
valgrind a bit happier about grinding it."

URL:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=98fdffccea6cc3fe9dba32c0fcc310bcb5d71529

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.12-paolo/arch/um/kernel/process.c |   48 ++++++++++++--------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff -puN arch/um/kernel/process.c~uml-revert-fork-instead-of-clone arch/um/kernel/process.c
--- vanilla-linux-2.6.12/arch/um/kernel/process.c~uml-revert-fork-instead-of-clone	2005-07-12 18:22:03.000000000 +0200
+++ vanilla-linux-2.6.12-paolo/arch/um/kernel/process.c	2005-07-12 18:22:03.000000000 +0200
@@ -130,7 +130,7 @@ int start_fork_tramp(void *thread_arg, u
 	return(arg.pid);
 }
 
-static int ptrace_child(void)
+static int ptrace_child(void *arg)
 {
 	int ret;
 	int pid = os_getpid(), ppid = getppid();
@@ -159,16 +159,20 @@ static int ptrace_child(void)
 	_exit(ret);
 }
 
-static int start_ptraced_child(void)
+static int start_ptraced_child(void **stack_out)
 {
+	void *stack;
+	unsigned long sp;
 	int pid, n, status;
 	
-	pid = fork();
-	if(pid == 0)
-		ptrace_child();
-
+	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if(stack == MAP_FAILED)
+		panic("check_ptrace : mmap failed, errno = %d", errno);
+	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
+	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
 	if(pid < 0)
-		panic("check_ptrace : fork failed, errno = %d", errno);
+		panic("check_ptrace : clone failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0)
 		panic("check_ptrace : wait failed, errno = %d", errno);
@@ -176,6 +180,7 @@ static int start_ptraced_child(void)
 		panic("check_ptrace : expected SIGSTOP, got status = %d",
 		      status);
 
+	*stack_out = stack;
 	return(pid);
 }
 
@@ -183,12 +188,12 @@ static int start_ptraced_child(void)
  * just avoid using sysemu, not panic, but only if SYSEMU features are broken.
  * So only for SYSEMU features we test mustpanic, while normal host features
  * must work anyway!*/
-static int stop_ptraced_child(int pid, int exitcode, int mustexit)
+static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustpanic)
 {
 	int status, n, ret = 0;
 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		panic("stop_ptraced_child : ptrace failed, errno = %d", errno);
+		panic("check_ptrace : ptrace failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
@@ -199,13 +204,15 @@ static int stop_ptraced_child(int pid, i
 		printk("check_ptrace : child exited with exitcode %d, while "
 		      "expecting %d; status 0x%x", exit_with,
 		      exitcode, status);
-		if (mustexit)
+		if (mustpanic)
 			panic("\n");
 		else
 			printk("\n");
 		ret = -1;
 	}
 
+	if(munmap(stack, PAGE_SIZE) < 0)
+		panic("check_ptrace : munmap failed, errno = %d", errno);
 	return ret;
 }
 
@@ -227,11 +234,12 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 
 static void __init check_sysemu(void)
 {
+	void *stack;
 	int pid, syscall, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
 		goto fail;
@@ -249,7 +257,7 @@ static void __init check_sysemu(void)
 		panic("check_sysemu : failed to modify system "
 		      "call return, errno = %d", errno);
 
-	if (stop_ptraced_child(pid, 0, 0) < 0)
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
@@ -257,7 +265,7 @@ static void __init check_sysemu(void)
 	set_using_sysemu(!force_sysemu_disabled);
 
 	printk("Checking advanced syscall emulation patch for ptrace...");
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 	while(1){
 		count++;
 		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
@@ -282,7 +290,7 @@ static void __init check_sysemu(void)
 			break;
 		}
 	}
-	if (stop_ptraced_child(pid, 0, 0) < 0)
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
@@ -293,17 +301,18 @@ static void __init check_sysemu(void)
 	return;
 
 fail:
-	stop_ptraced_child(pid, 1, 0);
+	stop_ptraced_child(pid, stack, 1, 0);
 fail_stopped:
 	printk("missing\n");
 }
 
 void __init check_ptrace(void)
 {
+	void *stack;
 	int pid, syscall, n, status;
 
 	printk("Checking that ptrace can change system call numbers...");
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
@@ -330,7 +339,7 @@ void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, 0, 1);
+	stop_ptraced_child(pid, stack, 0, 1);
 	printk("OK\n");
 	check_sysemu();
 }
@@ -362,10 +371,11 @@ void forward_pending_sigio(int target)
 static inline int check_skas3_ptrace_support(void)
 {
 	struct ptrace_faultinfo fi;
+	void *stack;
 	int pid, n, ret = 1;
 
 	printf("Checking for the skas3 patch in the host...");
-	pid = start_ptraced_child();
+	pid = start_ptraced_child(&stack);
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
@@ -380,7 +390,7 @@ static inline int check_skas3_ptrace_sup
 	}
 
 	init_registers(pid);
-	stop_ptraced_child(pid, 1, 1);
+	stop_ptraced_child(pid, stack, 1, 1);
 
 	return(ret);
 }
_
