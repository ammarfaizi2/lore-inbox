Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWERP7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWERP7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWERP7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:59:20 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:42938 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1751358AbWERP7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:59:19 -0400
Date: Thu, 18 May 2006 17:58:48 +0200
To: linux-kernel@vger.kernel.org
Cc: osd@cs.unibo.it
Subject: [PATCH] 2-ptrace_multi
Message-ID: <20060518155848.GC17498@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518155337.GA17498@cs.unibo.it>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ptmulti kernel patch inserts a new useful option for ptrace() call, 
adding a new request type to ptrace() syscall.

With PTRACE_MULTI option you can send multiple ptrace requests with a 
single system call: commonly a process that uses ptrace() needs
several PTRACE_PEEKDATA for getting some useful, even small pieces of data.
It is useful for these programs to run several ptrace
operations while limiting the number of context switches.

Ptrace-multi gets a "struct ptrace_multi" array (together with its 
number of elements). It is in this way similar to the management of buffers
for readv or writev.
Each "struct ptrace_multi" specifies a single request of normal type of
ptrace. So you have can join several requests into a requests array that will
be passed through the "void* addr" parameter (the third) of ptrace().
The last argument specify the numbers of request to be accomplished by ptrace.

While normal ptrace requests can get a word at a time, we have added some other
request for simplify the interface between kernel
and applications that use ptrace(); these requests can get from user space more
than one word at a time: 
- PTRACE_PEEKCHARDATA and PTRACE_POKECHARDATA is used for transferring general
  data, like structure, buffer, and so on...
- PTRACE_PEEKSTRINGDATA get strings from user space  (it relies on
  access_process_vm_user patch) and it check that data returned is a well formed
  string (null-terminated)

Debuggers and virtual machines (like User Mode Linux) and many other 
applications that are based on ptrace can get great 
performance improvements by PTRACE_MULTI: the number of system
calls (and context switches) decreases significantly.

This patch is architecture independent.

Signed-off-by: renzo davoli <renzo@cs.unibo.it>

diff -Naur linux-2.6.17-rc1/include/linux/ptrace.h linux-2.6.17-rc1-ptmulti/include/linux/ptrace.h
--- linux-2.6.17-rc1/include/linux/ptrace.h	2006-04-04 16:18:55.000000000 +0200
+++ linux-2.6.17-rc1-ptmulti/include/linux/ptrace.h	2006-04-04 16:17:30.000000000 +0200
@@ -27,6 +27,18 @@
 #define PTRACE_GETSIGINFO	0x4202
 #define PTRACE_SETSIGINFO	0x4203
 
+#define PTRACE_MULTI            0x4300
+#define PTRACE_PEEKCHARDATA     0x4301
+#define PTRACE_POKECHARDATA     0x4302
+#define PTRACE_PEEKSTRINGDATA   0x4303
+
+struct ptrace_multi {
+	long request;
+	long addr;
+	void *localaddr;
+	long length;
+};
+
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD	0x00000001
 #define PTRACE_O_TRACEFORK	0x00000002
diff -Naur linux-2.6.17-rc1/kernel/ptrace.c linux-2.6.17-rc1-ptmulti/kernel/ptrace.c
--- linux-2.6.17-rc1/kernel/ptrace.c	2006-04-04 16:18:55.000000000 +0200
+++ linux-2.6.17-rc1-ptmulti/kernel/ptrace.c	2006-04-04 16:17:30.000000000 +0200
@@ -2,6 +2,7 @@
  * linux/kernel/ptrace.c
  *
  * (C) Copyright 1999 Linus Torvalds
+ * PTRACE_MULTI support 2006 Renzo Davoli 
  *
  * Common interfaces for "ptrace()" which we do not want
  * to continually duplicate across every architecture.
@@ -503,6 +504,53 @@
 	return child;
 }
 
+static int multi_ptrace(struct task_struct *child, long request, long addr, long size)
+{
+	int i, ret;
+	long j;
+	ret=0;
+	if (!access_ok(VERIFY_READ, addr,size*sizeof(struct ptrace_multi))) {
+		ret = -EIO;
+		goto out_multi_ptrace;
+	}
+	for (i=0; i<size && ret==0; i++, addr+=sizeof(struct ptrace_multi)) {
+		unsigned long len;
+		struct ptrace_multi __user pm ;
+		__copy_from_user(&pm, (struct ptrace_multi __user *)addr, sizeof(struct ptrace_multi));
+		len = pm.length;
+		switch ( pm.request){
+			case PTRACE_PEEKTEXT:
+			case PTRACE_PEEKDATA:
+			case PTRACE_PEEKUSR:
+				if (len <= 0) len=1;
+				for (j=0; j<len && ret==0; j++)
+					ret=arch_ptrace(child, pm.request, (long) (pm.addr) + j*sizeof(long), (long) (pm.localaddr) + j*sizeof(long));
+				break;
+			case PTRACE_POKETEXT:
+			case PTRACE_POKEDATA:
+			case PTRACE_POKEUSR:
+				if (len <= 0) len=1;
+				for (j=0; j<len && ret==0; j++)
+					ret=arch_ptrace(child, pm.request, (long) (pm.addr) + j*sizeof(long), *(((long *) (pm.localaddr)) + j));
+				break;
+			case PTRACE_PEEKCHARDATA:
+				ret = ptrace_readdata(child, pm.addr, pm.localaddr, len);
+				break;
+			case PTRACE_POKECHARDATA:
+				ret = ptrace_writedata(child, pm.localaddr, pm.addr, len);
+				break;
+			case PTRACE_PEEKSTRINGDATA:
+				ret = ptrace_readstringdata(child, pm.addr, pm.localaddr, len);
+				break;
+			default:
+				ret=arch_ptrace(child, pm.request, (long) (pm.addr), (long) (pm.localaddr));
+				break;
+		}
+	}
+ out_multi_ptrace:
+	return ret;
+}
+
 #ifndef __ARCH_SYS_PTRACE
 asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
@@ -533,6 +581,9 @@
 	if (ret < 0)
 		goto out_put_task_struct;
 
+	if (request == PTRACE_MULTI) 
+		ret = multi_ptrace(child, request, addr, data);
+	else
 	ret = arch_ptrace(child, request, addr, data);
 	if (ret < 0)
 		goto out_put_task_struct;
