Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUCOAlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 19:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUCOAlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 19:41:09 -0500
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:46747 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S262112AbUCOAlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 19:41:02 -0500
Message-ID: <4054FBE3.6010905@quark.didntduck.org>
Date: Sun, 14 Mar 2004 19:42:11 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 execve from kernel
Content-Type: multipart/mixed;
 boundary="------------010109020905030708050109"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109020905030708050109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove the jump through int $0x80 for execve from a kernel thread.

--
				Brian Gerst

--------------010109020905030708050109
Content-Type: text/plain;
 name="execve-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="execve-1"

diff -urN linux-bk/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-bk/arch/i386/kernel/process.c	2004-03-14 18:25:39.000000000 -0500
+++ linux/arch/i386/kernel/process.c	2004-03-14 19:39:47.333293016 -0500
@@ -630,6 +630,33 @@
 }
 
 /*
+ * execs a userspace program from a kernel thread
+ */
+int execve(char *filename, char **argv, char **envp)
+{
+	struct pt_regs regs;
+	int error;
+	unsigned long flags;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.eflags = X86_EFLAGS_IF;
+
+	error = do_execve(filename,
+			(char __user * __user *) argv,
+			(char __user * __user *) envp,
+			&regs);
+	if (error == 0) {
+		current->ptrace &= ~PT_DTRACE;
+		__asm__ __volatile__(
+		       "movl %0,%%esp\n\t"
+		       "movl %1,%%ebp\n\t"
+		       "jmp resume_userspace\n\t"
+		       : : "r" (&regs), "r" (current_thread_info()));
+	}
+	return error;
+}
+
+/*
  * These bracket the sleeping functions..
  */
 extern void scheduling_functions_start_here(void);
diff -urN linux-bk/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-bk/include/asm-i386/unistd.h	2004-03-14 18:25:46.000000000 -0500
+++ linux/include/asm-i386/unistd.h	2004-03-14 19:12:38.000000000 -0500
@@ -395,7 +395,7 @@
 static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
 static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
 static inline _syscall1(int,dup,int,fd)
-static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
+extern int execve(char *, char **, char **);
 static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
 static inline _syscall1(int,close,int,fd)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)

--------------010109020905030708050109--
