Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWEPTM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWEPTM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEPTM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:12:28 -0400
Received: from [198.99.130.12] ([198.99.130.12]:61119 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750823AbWEPTM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:12:28 -0400
Date: Tue, 16 May 2006 15:12:44 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Alberto Bertogli <albertito@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060516191244.GB6337@ccure.user-mode-linux.org>
References: <20060514182541.GA4980@gmail.com> <20060515033919.GD21383@ccure.user-mode-linux.org> <20060515152958.GA4553@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515152958.GA4553@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:29:58PM -0300, Alberto Bertogli wrote:
> Sure, here it is:
> (gdb) disas stub_segv_handler

Sorry, I misread the error message and asked for the wrong thing.
Your UML is seeing a process segfault during a system call, before the
SIGTRAP expected at the end of the system call.  I don't know what's
happening there.

Can you apply the following patch, which will just give you a register
dump of the process, and send me the output?

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
