Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269403AbUJFQwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269403AbUJFQwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUJFQtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:49:32 -0400
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:52137 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S269367AbUJFQjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:39:10 -0400
Subject: Re: [PATCH] RFC. User space backtrace on segv
From: Alex Bennee <kernel-hacker@bennee.com>
To: "LinuxSH (sf)" <linuxsh-dev@lists.sourceforge.net>
Cc: "Linux-SH (m17n)" <linux-sh@m17n.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097080652.5420.34.camel@cambridge>
References: <1097080652.5420.34.camel@cambridge>
Content-Type: multipart/mixed; boundary="=-f4FLBfpVidfRAR/iSBKm"
Organization: Hackers Inc
Message-Id: <1097080781.5420.36.camel@cambridge>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Oct 2004 17:39:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f4FLBfpVidfRAR/iSBKm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-10-06 at 17:37, Alex Bennee wrote:
> Hi,
> 
> I hacked up this little patch to dump the stack and attempt to generate
> a back-trace for errant user-space tasks.
>  <snip>

It would of been helpful if I'd actually attached the patch. Doh!

-- 
Alex, Kernel Hacker: http://www.bennee.com/~alex/

Test input for validity and plausibility.
- The Elements of Programming Style (Kernighan & Plaugher)

--=-f4FLBfpVidfRAR/iSBKm
Content-Disposition: attachment; filename=lk.dump_user_task.patch
Content-Type: text/x-patch; name=lk.dump_user_task.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Index: arch/sh/kernel/traps.c
===================================================================
RCS file: /cvsroot/linuxsh/linux/arch/sh/kernel/traps.c,v
retrieving revision 1.1.1.1.2.5
diff -u -b -r1.1.1.1.2.5 traps.c
--- arch/sh/kernel/traps.c	23 Oct 2003 22:08:56 -0000	1.1.1.1.2.5
+++ arch/sh/kernel/traps.c	6 Oct 2004 16:27:06 -0000
@@ -1,4 +1,4 @@
-/* $Id: traps.c,v 1.1.1.1.2.4 2002/05/10 17:58:54 jzs Exp $
+/* $Id: traps.c,v 1.1.1.1.2.5 2003/10/23 22:08:56 yoshii Exp $
  *
  *  linux/arch/sh/traps.c
  *
@@ -32,6 +32,8 @@
 #include <asm/atomic.h>
 #include <asm/processor.h>
 
+void dump_user_task (struct task_struct *tsk, struct pt_regs *regs);
+
 #ifdef CONFIG_SH_KGDB
 #include <asm/kgdb.h>
 #define CHK_REMOTE_DEBUG(regs)                                               \
@@ -114,6 +116,7 @@
 			regs->pc = fixup;
 			return 0;
 		}
+		printk(KERN_ALERT "no fixup: pid=%d pc=0x%lx\n",current->pid,current->thread.pc);
 		die(str, regs, err);
 	}
 	return -EFAULT;
@@ -515,6 +518,7 @@
 
 	uspace_segv:
 		printk(KERN_NOTICE "Killing process \"%s\" due to unaligned access\n", current->comm);
+		dump_user_task(current, regs);
 		force_sig(SIGSEGV, current);
 	} else {
 		if (regs->pc & 1)
@@ -605,6 +609,11 @@
 		     : "memory");
 }
 
+/*
+** This attempts to do a backtrace through the
+** kernel-space stack (therfor shows the kernel backtrace)
+*/
+
 void show_task(unsigned long *sp)
 {
 	unsigned long *stack, addr;
@@ -653,3 +662,104 @@
 {
 	show_task((unsigned long *)tsk->thread.sp);
 }
+
+
+/*
+** Generate Userspace Backtrace
+**
+** In theory this shouldn't be needed as when a userspace task
+** dies you can generate a core dump. However for embedded systems it
+** may just be easier to dump the registers and the user-stack
+*/
+
+void dump_user_frame(int frame, unsigned long *start_addr, unsigned long *end_addr)
+{
+    unsigned long addr;
+
+#if 0
+    printk(KERN_ALERT "Frame %d (%p->%p)\n",
+	    frame, start_addr, end_addr);
+#endif
+    
+    printk(KERN_ALERT "Frame %2d: ", frame);
+
+    do {
+	get_user(addr, start_addr);
+	printk("0x%08lx ", addr);
+	start_addr++;
+    } while (start_addr<end_addr);
+	
+    get_user(addr, end_addr);
+    printk(": <0x%08lx>\n",addr);
+}
+
+void dump_user_task (struct task_struct *tsk, struct pt_regs *regs)
+{
+    unsigned long start_code, end_code, *sp;
+    unsigned long *start_frame, *end_frame;
+    int frame=0;
+    
+    if (!user_mode(regs)) {
+	printk(KERN_ALERT "dump_user_task: not in userspace");
+	return;
+    }
+
+    printk(KERN_ALERT "dump_user_task (%p): %s, pid %d, pc 0x%lx\n",
+	    tsk, tsk->comm, tsk->pid, regs->pc);
+     
+    show_regs(regs);
+
+    /*
+     * Find the start and end code addresses from the
+     * process descriptor. We shall need this to work
+     * out if values on the stack are return addresses
+     */
+    start_code = tsk->mm->start_code;
+    end_code = tsk->mm->end_code;
+    sp = (unsigned long *)  regs->regs[14];
+    
+    printk(KERN_ALERT "start_code=0x%lx, end_code=0x%lx, sp=%p/0x%lx\n",
+	    start_code,
+	    end_code,
+	    sp, tsk->mm->start_stack);
+   
+    /*
+     * R14 points at the bottom of the stack frame (it grows down)
+     * which include the local variables and return addresses.
+     *
+     * We simply follow the stack back up, a long word at a time
+     * printing anything that falls in a vma with execute privalages
+     */
+
+    start_frame = sp;
+    
+    do {
+	unsigned long addr;
+	struct vm_area_struct * vma;
+
+	get_user(addr, sp);
+
+	if(addr==0)
+	    vma = NULL;
+	else
+	    vma = find_vma(tsk->mm, addr);
+	
+	if (vma) {
+	    if (vma->vm_flags&VM_EXECUTABLE)
+	    {
+#if 0
+		printk(KERN_ALERT "addr %p, vma 0x%lx (0x%lx->0x%lx), flags 0x%x\n",
+			addr, vma, vma->vm_start, vma->vm_end, vma->vm_flags);
+#endif
+		end_frame = sp;
+		dump_user_frame(frame, start_frame, end_frame);
+		frame++;
+		start_frame = end_frame;
+		start_frame++;
+	    }
+	}
+	sp++;
+    } while ((unsigned long)sp<tsk->mm->start_stack && frame<4 );
+    
+}
+

--=-f4FLBfpVidfRAR/iSBKm--

