Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWD1RCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWD1RCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWD1RA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:56 -0400
Received: from [198.99.130.12] ([198.99.130.12]:33496 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751635AbWD1RAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:33 -0400
Message-Id: <200604281601.k3SG1AIw007542@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: [PATCH 6/6] UML - Error handling fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blairsorblade noticed some confusion between our use of a system
call's return value and errno.  This patch fixes a number of related
bugs -
	using errno instead of a return value
	using a return value instead of errno
	forgetting to negate a error return to get a positive error code

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/file.c	2006-04-27 20:53:08.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/file.c	2006-04-27 20:57:20.000000000 -0400
@@ -171,7 +171,7 @@ int os_sigio_async(int master, int slave
 
 	flags = fcntl(master, F_GETFL);
 	if(flags < 0)
-		return errno;
+		return -errno;
 
 	if((fcntl(master, F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) ||
 	   (fcntl(master, F_SETOWN, os_getpid()) < 0))
Index: linux-2.6.16/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/skas/process.c	2006-04-27 20:53:08.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/skas/process.c	2006-04-27 20:57:20.000000000 -0400
@@ -344,12 +344,12 @@ int copy_context_skas0(unsigned long new
 	err = ptrace_setregs(pid, regs);
 	if(err < 0)
 		panic("copy_context_skas0 : PTRACE_SETREGS failed, "
-		      "pid = %d, errno = %d\n", pid, errno);
+		      "pid = %d, errno = %d\n", pid, -err);
 
 	err = ptrace_setfpregs(pid, fp_regs);
 	if(err < 0)
 		panic("copy_context_skas0 : PTRACE_SETFPREGS failed, "
-		      "pid = %d, errno = %d\n", pid, errno);
+		      "pid = %d, errno = %d\n", pid, -err);
 
 	/* set a well known return code for detection of child write failure */
 	child_data->err = 12345678;
@@ -362,7 +362,7 @@ int copy_context_skas0(unsigned long new
 	pid = data->err;
 	if(pid < 0)
 		panic("copy_context_skas0 - stub-parent reports error %d\n",
-		      pid);
+		      -pid);
 
 	/* Wait, until child has finished too: read child's result from
 	 * child's stack and check it.
Index: linux-2.6.16/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sys-i386/registers.c	2006-04-27 20:53:42.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/sys-i386/registers.c	2006-04-27 20:57:20.000000000 -0400
@@ -104,7 +104,7 @@ void init_registers(int pid)
 	err = ptrace(PTRACE_GETREGS, pid, 0, exec_regs);
 	if(err)
 		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d",
-		      err);
+		      errno);
 
 	errno = 0;
 	err = ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
@@ -119,7 +119,7 @@ void init_registers(int pid)
 	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
 	if(err)
 		panic("check_ptrace : PTRACE_GETFPREGS failed, errno = %d",
-		      err);
+		      errno);
 }
 
 void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
Index: linux-2.6.16/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-04-27 20:53:42.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/sys-x86_64/registers.c	2006-04-27 20:57:20.000000000 -0400
@@ -62,12 +62,12 @@ void init_registers(int pid)
 	err = ptrace(PTRACE_GETREGS, pid, 0, exec_regs);
 	if(err)
 		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d",
-		      err);
+		      errno);
 
 	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
 	if(err)
 		panic("check_ptrace : PTRACE_GETFPREGS failed, errno = %d",
-		      err);
+		      errno);
 }
 
 void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
Index: linux-2.6.16/arch/um/os-Linux/umid.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/umid.c	2006-04-27 20:53:08.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/umid.c	2006-04-27 20:57:20.000000000 -0400
@@ -178,14 +178,14 @@ static void __init create_pid_file(void)
 	fd = open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
 	if(fd < 0){
 		printk("Open of machine pid file \"%s\" failed: %s\n",
-		       file, strerror(-fd));
+		       file, strerror(errno));
 		return;
 	}
 
 	snprintf(pid, sizeof(pid), "%d\n", getpid());
 	n = write(fd, pid, strlen(pid));
 	if(n != strlen(pid))
-		printk("Write of pid file failed - err = %d\n", -n);
+		printk("Write of pid file failed - err = %d\n", errno);
 
 	close(fd);
 }

