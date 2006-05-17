Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWEQSMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWEQSMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWEQSMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:12:35 -0400
Received: from [198.99.130.12] ([198.99.130.12]:12492 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750837AbWEQSMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:12:34 -0400
Date: Wed, 17 May 2006 14:12:52 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Alberto Bertogli <albertito@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64ync-mailbox><next-undeleted><enter-command>set editor=vim
Message-ID: <20060517181252.GA5896@ccure.user-mode-linux.org>
References: <20060514182541.GA4980@gmail.com> <20060515033919.GD21383@ccure.user-mode-linux.org> <20060515152958.GA4553@gmail.com> <20060516191244.GB6337@ccure.user-mode-linux.org> <20060517023942.GI9066@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517023942.GI9066@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 11:39:42PM -0300, Alberto Bertogli wrote:
> [42949374.050000] Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x4000f349

Err, there was a rather serious bug in that last patch.  Can you
replace it with the version below and boot UML again?

				Jeff

Index: linux-2.6.16/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/skas/process.c
+++ linux-2.6.16/arch/um/os-Linux/skas/process.c
@@ -45,6 +45,22 @@ int is_skas_winch(int pid, int fd, void 
 	return(1);
 }
 
+static int ptrace_dump_regs(int pid)
+{
+        unsigned long regs[HOST_FRAME_SIZE];
+        int i;
+
+        if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+                return -errno;
+        else {
+                printk("Stub registers -\n");
+                for(i = 0; i < HOST_FRAME_SIZE; i++)
+                        printk("\t%d - %lx\n", i, regs[i]);
+        }
+
+        return 0;
+}
+
 void wait_stub_done(int pid, int sig, char * fname)
 {
 	int n, status, err;
@@ -68,18 +84,10 @@ void wait_stub_done(int pid, int sig, ch
 
 	if((n < 0) || !WIFSTOPPED(status) ||
 	   (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
-		unsigned long regs[HOST_FRAME_SIZE];
-
-		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
-			printk("Failed to get registers from stub, "
-			       "errno = %d\n", errno);
-		else {
-			int i;
-
-			printk("Stub registers -\n");
-			for(i = 0; i < HOST_FRAME_SIZE; i++)
-				printk("\t%d - %lx\n", i, regs[i]);
-		}
+                err = ptrace_dump_regs(pid);
+                if(err)
+                        printk("Failed to get registers from stub, "
+                               "errno = %d\n", -err);
 		panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
 		      "pid = %d, n = %d, errno = %d, status = 0x%x\n",
 		      fname, pid, n, errno, status);
@@ -146,9 +154,14 @@ static void handle_trap(int pid, union u
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if((err < 0) || !WIFSTOPPED(status) ||
-		   (WSTOPSIG(status) != SIGTRAP + 0x80))
+		   (WSTOPSIG(status) != SIGTRAP + 0x80)){
+                        err = ptrace_dump_regs(pid);
+                        if(err)
+                                printk("Failed to get registers from process, "
+                                       "errno = %d\n", -err);
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
+                }
 	}
 
 	handle_syscall(regs);
Index: linux-2.6.16/arch/um/sys-x86_64/user-offsets.c
===================================================================
--- linux-2.6.16.orig/arch/um/sys-x86_64/user-offsets.c
+++ linux-2.6.16/arch/um/sys-x86_64/user-offsets.c
@@ -57,7 +57,7 @@ void foo(void)
 	OFFSET(HOST_SC_SS, sigcontext, ss);
 #endif
 
-	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE_LONGS(HOST_FRAME_SIZE, sizeof(struct user_regs_struct));
 	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
 	DEFINE(HOST_XFP_SIZE, 0);
 	DEFINE_LONGS(HOST_RBX, RBX);
