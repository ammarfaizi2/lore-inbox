Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTEMBLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEMBLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:11:09 -0400
Received: from holomorphy.com ([66.224.33.161]:37557 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262108AbTEMBLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:11:08 -0400
Date: Mon, 12 May 2003 18:23:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: 2.5.69-mjb1
Message-ID: <20030513012346.GQ19053@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <3EBFB82B.8040509@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBFB82B.8040509@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 08:05:15AM -0700, Dave Hansen wrote:
> Wow, that's intuitive :)
> They're trying to access the variables that have been pushed onto the
> top of the stack.  The thread_info field points to the bottom of the
> kernel's stack (no matter how big it is).  I don't know where the -5 and
> -2 come from.  It needs a big, fat stinking comment.

I'm not 100% convinced it DTRT on modern kernels. I vaguely wonder if
the following would be more appropriate. Shame the typedef isn't there
yet; the _struct suffix is an eyesore.


-- wli


diff -prauN linux-2.5.69/include/asm-i386/processor.h kstk-2.5.69-1/include/asm-i386/processor.h
--- linux-2.5.69/include/asm-i386/processor.h	2003-05-04 16:53:00.000000000 -0700
+++ kstk-2.5.69-1/include/asm-i386/processor.h	2003-05-12 14:02:13.000000000 -0700
@@ -96,9 +96,9 @@ extern struct cpuinfo_x86 cpu_data[];
 
 extern char ignore_fpu_irq;
 
-extern void identify_cpu(struct cpuinfo_x86 *);
-extern void print_cpu_info(struct cpuinfo_x86 *);
-extern void dodgy_tsc(void);
+void identify_cpu(struct cpuinfo_x86 *);
+void print_cpu_info(struct cpuinfo_x86 *);
+void dodgy_tsc(void);
 
 /*
  * EFLAGS bits
@@ -457,21 +457,21 @@ struct task_struct;
 struct mm_struct;
 
 /* Free all resources held by a thread. */
-extern void release_thread(struct task_struct *);
+void release_thread(struct task_struct *);
 
 /* Prepare to copy thread state - unlazy all lazy status */
-extern void prepare_to_copy(struct task_struct *tsk);
+void prepare_to_copy(struct task_struct *);
 
 /*
  * create a kernel thread without removing it from tasklists
  */
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
+int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
+unsigned long thread_saved_pc(struct task_struct *);
 
-unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
+unsigned long get_wchan(struct task_struct *);
+#define KSTK_EIP(task)	((task)->thread.eip)
+#define KSTK_ESP(task)	((task)->thread.esp)
 
 struct microcode {
 	unsigned int hdrver;
