Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTEZRQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTEZRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:16:14 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:10724 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S261872AbTEZRON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:14:13 -0400
Date: Mon, 26 May 2003 19:23:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/10): arch fixes.
Message-ID: <20030526172328.GB3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Base s390 bug fixes:
 - arch: Do create_proc_entry for debug feature outside spin locked code.
 - arch: Fix system call tracing for 64 bit kernels.
 - arch: Export empty_zero_page for use in binfmt_elf32 module.
 - arch: Fix call trace output and remove dead remote-debug code.
 - arch: Correct OUTPUT_ARCH for 64 bit compiles.
 - arch: Fix in_atomic.
 - arch: Fix broken _PAGE_INVALID_xxx definitions.
 - arch: Add __kernel_old_dev_t for 64 bit.
 - arch: adapt to new do_fork interface.
 - arch: set CR5 to get program checks for space switching instructions.
 - cio: Fix /proc output of blacklist ranges.
 - cio: Restructure chsc to avoid GFP_KERNEL allocation while holding a lock.
 - cio: Fix wait_cons_dev.
 - qdio: use GFP_ATOMIC for memory allocations in interrupt.

diffstat:
 arch/s390/defconfig            |   10 +++++
 arch/s390/kernel/debug.c       |   16 ++++++---
 arch/s390/kernel/entry64.S     |    4 +-
 arch/s390/kernel/head.S        |    2 -
 arch/s390/kernel/head64.S      |    2 -
 arch/s390/kernel/process.c     |   21 +++--------
 arch/s390/kernel/s390_ksyms.c  |    1 
 arch/s390/kernel/smp.c         |    3 +
 arch/s390/kernel/traps.c       |   31 +++++------------
 arch/s390/vmlinux.lds.S        |    2 -
 drivers/s390/cio/blacklist.c   |    4 +-
 drivers/s390/cio/chsc.c        |   72 ++++++++++++++++++-----------------------
 drivers/s390/cio/cio.c         |    7 +--
 drivers/s390/cio/qdio.c        |    7 ++-
 include/asm-s390/hardirq.h     |    2 -
 include/asm-s390/pgtable.h     |    6 +--
 include/asm-s390/posix_types.h |    1 
 17 files changed, 92 insertions(+), 99 deletions(-)

diff -urN linux-2.5/arch/s390/defconfig linux-2.5-s390/arch/s390/defconfig
--- linux-2.5/arch/s390/defconfig	Mon May  5 01:53:40 2003
+++ linux-2.5-s390/arch/s390/defconfig	Mon May 26 19:20:42 2003
@@ -19,6 +19,9 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_EMBEDDED is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
 
 #
 # Loadable module support
@@ -162,6 +165,7 @@
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
 # CONFIG_XFRM_USER is not set
 
 #
@@ -228,6 +232,10 @@
 #
 # Ethernet (1000 Mbit)
 #
+
+#
+# Ethernet (10000 Mbit)
+#
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 
@@ -262,6 +270,7 @@
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -292,6 +301,7 @@
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
 CONFIG_DEVPTS_FS=y
+# CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
 CONFIG_RAMFS=y
 
diff -urN linux-2.5/arch/s390/kernel/debug.c linux-2.5-s390/arch/s390/kernel/debug.c
--- linux-2.5/arch/s390/kernel/debug.c	Mon May 26 19:20:25 2003
+++ linux-2.5-s390/arch/s390/kernel/debug.c	Mon May 26 19:20:42 2003
@@ -851,9 +851,17 @@
 	int i;
 	unsigned long flags;
 	mode_t mode = S_IFREG;
+	struct proc_dir_entry *pde;
 
 	if (!id)
 		goto out;
+	pde = create_proc_entry(view->name, mode, id->proc_root_entry);
+	if (!pde){
+		printk(KERN_WARNING "debug: create_proc_entry() failed! Cannot register view %s/%s\n", id->name,view->name);
+		rc = -1;
+		goto out;
+	}
+
 	spin_lock_irqsave(&id->lock, flags);
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 		if (id->views[i] == NULL)
@@ -864,6 +872,7 @@
 			id->name,view->name);
 		printk(KERN_WARNING 
 			"debug: maximum number of views reached (%i)!\n", i);
+		remove_proc_entry(pde->name, id->proc_root_entry);
 		rc = -1;
 	}
 	else {
@@ -872,11 +881,8 @@
 			mode |= S_IRUSR;
 		if (view->input_proc)
 			mode |= S_IWUSR;
-		id->proc_entries[i] = create_proc_entry(view->name, mode,
-							id->proc_root_entry);
-		if (id->proc_entries[i] != NULL)
-			id->proc_entries[i]->proc_fops = &debug_file_ops;
-		rc = 0;
+		pde->proc_fops = &debug_file_ops;
+		id->proc_entries[i] = pde;
 	}
 	spin_unlock_irqrestore(&id->lock, flags);
       out:
diff -urN linux-2.5/arch/s390/kernel/entry64.S linux-2.5-s390/arch/s390/kernel/entry64.S
--- linux-2.5/arch/s390/kernel/entry64.S	Mon May  5 01:53:03 2003
+++ linux-2.5-s390/arch/s390/kernel/entry64.S	Mon May 26 19:20:42 2003
@@ -249,14 +249,14 @@
 # special linkage: %r12 contains the return address for trace_svc
 #
 sysc_tracesys:
-	srl	%r7,3
+	srl	%r7,2
 	stg     %r7,SP_R2(%r15)
         brasl   %r14,syscall_trace
 	larl	%r1,.Lnr_syscalls
 	clc	SP_R2(8,%r15),0(%r1)
 	jl	sysc_tracego
 	lg	%r7,SP_R2(%r15)   # strace might have changed the
-	sll     %r7,3             #  system call
+	sll     %r7,2             #  system call
 	lgf	%r8,0(%r7,%r10)
 sysc_tracego:
 	lmg     %r3,%r6,SP_R3(%r15)
diff -urN linux-2.5/arch/s390/kernel/head.S linux-2.5-s390/arch/s390/kernel/head.S
--- linux-2.5/arch/s390/kernel/head.S	Mon May  5 01:53:08 2003
+++ linux-2.5-s390/arch/s390/kernel/head.S	Mon May 26 19:20:42 2003
@@ -573,7 +573,7 @@
         .long  .Lduct                   # cr2: dispatchable unit control table
         .long  0                        # cr3: instruction authorization
         .long  0                        # cr4: instruction authorization
-        .long  0                        # cr5:  various things
+        .long  0xffffffff               # cr5: primary-aste origin
         .long  0                        # cr6:  I/O interrupts
         .long  0                        # cr7:  secondary space segment table
         .long  0                        # cr8:  access registers translation
diff -urN linux-2.5/arch/s390/kernel/head64.S linux-2.5-s390/arch/s390/kernel/head64.S
--- linux-2.5/arch/s390/kernel/head64.S	Mon May  5 01:53:09 2003
+++ linux-2.5-s390/arch/s390/kernel/head64.S	Mon May 26 19:20:42 2003
@@ -586,7 +586,7 @@
         .quad  .Lduct                   # cr2: dispatchable unit control table
         .quad  0                        # cr3: instruction authorization
         .quad  0                        # cr4: instruction authorization
-        .quad  0                        # cr5:  various things
+        .quad  0xffffffffffffffff       # cr5: primary-aste origin
         .quad  0                        # cr6:  I/O interrupts
         .quad  0                        # cr7:  secondary space segment table
         .quad  0                        # cr8:  access registers translation
diff -urN linux-2.5/arch/s390/kernel/process.c linux-2.5-s390/arch/s390/kernel/process.c
--- linux-2.5/arch/s390/kernel/process.c	Mon May  5 01:53:36 2003
+++ linux-2.5-s390/arch/s390/kernel/process.c	Mon May 26 19:20:42 2003
@@ -166,7 +166,6 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-	struct task_struct *p;
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(regs));
@@ -180,8 +179,8 @@
 	regs.orig_gpr2 = -1;
 
 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(flags | CLONE_VM | CLONE_UNTRACED,
+		       0, &regs, 0, NULL, NULL);
 }
 
 /*
@@ -272,16 +271,13 @@
 
 asmlinkage int sys_fork(struct pt_regs regs)
 {
-	struct task_struct *p;
-        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(SIGCHLD, regs.gprs[15], &regs, 0, NULL, NULL);
 }
 
 asmlinkage int sys_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
         unsigned long newsp;
-	struct task_struct *p;
 	int *parent_tidptr, *child_tidptr;
 
         clone_flags = regs.gprs[3];
@@ -290,9 +286,8 @@
 	child_tidptr = (int *) regs.gprs[5];
         if (!newsp)
                 newsp = regs.gprs[15];
-        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
-		    parent_tidptr, child_tidptr);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+        return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
+		       parent_tidptr, child_tidptr);
 }
 
 /*
@@ -307,10 +302,8 @@
  */
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
-	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
-		    regs.gprs[15], &regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+		       regs.gprs[15], &regs, 0, NULL, NULL);
 }
 
 /*
diff -urN linux-2.5/arch/s390/kernel/s390_ksyms.c linux-2.5-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.5/arch/s390/kernel/s390_ksyms.c	Mon May 26 19:20:25 2003
+++ linux-2.5-s390/arch/s390/kernel/s390_ksyms.c	Mon May 26 19:20:42 2003
@@ -59,6 +59,7 @@
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(overflowuid);
 EXPORT_SYMBOL(overflowgid);
+EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_S390_SUPPORT
 /*
diff -urN linux-2.5/arch/s390/kernel/smp.c linux-2.5-s390/arch/s390/kernel/smp.c
--- linux-2.5/arch/s390/kernel/smp.c	Mon May  5 01:52:48 2003
+++ linux-2.5-s390/arch/s390/kernel/smp.c	Mon May 26 19:20:42 2003
@@ -469,7 +469,7 @@
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+       return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }
 
 int __cpu_up(unsigned int cpu)
@@ -498,6 +498,7 @@
                 printk("failed fork for CPU %d", cpu);
 		return -EIO;
 	}
+	wake_up_forked_process(idle);
 
         /*
          * We remove it from the pidhash and the runqueue
diff -urN linux-2.5/arch/s390/kernel/traps.c linux-2.5-s390/arch/s390/kernel/traps.c
--- linux-2.5/arch/s390/kernel/traps.c	Mon May 26 19:20:25 2003
+++ linux-2.5-s390/arch/s390/kernel/traps.c	Mon May 26 19:20:42 2003
@@ -282,7 +282,7 @@
                 const struct exception_table_entry *fixup;
                 fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
                 if (fixup)
-                        regs->psw.addr = fixup->fixup | ~PSW_ADDR_INSN;
+                        regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
                 else
                         die(str, regs, interruption_code);
         }
@@ -293,27 +293,14 @@
 	return (void *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
 }
 
-int do_debugger_trap(struct pt_regs *regs,int signal)
+static int do_debugger_trap(struct pt_regs *regs)
 {
-	if(regs->psw.mask&PSW_MASK_PSTATE)
-	{
-		if(current->ptrace & PT_PTRACED)
-			force_sig(signal,current);
-		else
-			return 1;
-	}
-	else
-	{
-#ifdef CONFIG_REMOTE_DEBUG
-		if(gdb_stub_initialised)
-		{
-			gdb_stub_handle_exception(regs, signal);
-			return 0;
-		}
-#endif
-		return 1;
+	if ((regs->psw.mask & PSW_MASK_PSTATE) &&
+	    (current->ptrace & PT_PTRACED)) {
+		force_sig(SIGTRAP,current);
+		return 0;
 	}
-	return 0;
+	return 1;
 }
 
 #define DO_ERROR(signr, str, name) \
@@ -400,7 +387,7 @@
 		*((__u16 *)opcode)=*((__u16 *)location);
 	if (*((__u16 *)opcode)==S390_BREAKPOINT_U16)
         {
-		if(do_debugger_trap(regs,SIGTRAP))
+		if(do_debugger_trap(regs))
 			signal = SIGILL;
 	}
 #ifdef CONFIG_MATHEMU
@@ -659,7 +646,7 @@
 		per_info->lowcore.words.address=S390_lowcore.per_address;
 		per_info->lowcore.words.access_id=S390_lowcore.per_access_id;
 	}
-	if (do_debugger_trap(regs,SIGTRAP)) {
+	if (do_debugger_trap(regs)) {
 		/* I've seen this possibly a task structure being reused ? */
 		printk("Spurious per exception detected\n");
 		printk("switching off per tracing for this task.\n");
diff -urN linux-2.5/arch/s390/vmlinux.lds.S linux-2.5-s390/arch/s390/vmlinux.lds.S
--- linux-2.5/arch/s390/vmlinux.lds.S	Mon May  5 01:53:12 2003
+++ linux-2.5-s390/arch/s390/vmlinux.lds.S	Mon May 26 19:20:42 2003
@@ -12,7 +12,7 @@
 jiffies = jiffies_64 + 4;
 #else
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
-OUTPUT_ARCH(s390)
+OUTPUT_ARCH(s390:64-bit)
 ENTRY(_start)
 jiffies = jiffies_64;
 #endif
diff -urN linux-2.5/drivers/s390/cio/blacklist.c linux-2.5-s390/drivers/s390/cio/blacklist.c
--- linux-2.5/drivers/s390/cio/blacklist.c	Mon May  5 01:53:09 2003
+++ linux-2.5-s390/drivers/s390/cio/blacklist.c	Mon May 26 19:20:42 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.23 $
+ *   $Revision: 1.24 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -197,7 +197,7 @@
 			while (++devno < __MAX_SUBCHANNELS)
 				if (!test_bit(devno, bl_dev))
 					break;
-			len += sprintf(page + len, "-0x%04lx", devno);
+			len += sprintf(page + len, "-0x%04lx", --devno);
 		}
 		len += sprintf(page + len, "\n");
 	}
diff -urN linux-2.5/drivers/s390/cio/chsc.c linux-2.5-s390/drivers/s390/cio/chsc.c
--- linux-2.5/drivers/s390/cio/chsc.c	Mon May  5 01:53:31 2003
+++ linux-2.5-s390/drivers/s390/cio/chsc.c	Mon May 26 19:20:42 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.67 $
+ *   $Revision: 1.69 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -71,12 +71,11 @@
 }
 
 /* FIXME: this is _always_ called for every subchannel. shouldn't we
- *	  process more than one at a time?*/
+ *	  process more than one at a time? */
 static int
-chsc_get_sch_desc_irq(int irq)
+chsc_get_sch_desc_irq(int irq, void *page)
 {
 	int ccode, chpid, j;
-	int ret;
 
 	struct {
 		struct chsc_header request;
@@ -100,11 +99,7 @@
 		u16 fla[8];	  /* full link addresses 0-7 */
 	} *ssd_area;
 
-	ssd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!ssd_area) {
-		CIO_CRW_EVENT(0, "No memory for ssd area!\n");
-		return -ENOMEM;
-	}
+	ssd_area = page;
 
 	ssd_area->request = (struct chsc_header) {
 		.length = 0x0010,
@@ -117,34 +112,29 @@
 	ccode = chsc(ssd_area);
 	if (ccode > 0) {
 		pr_debug("chsc returned with ccode = %d\n", ccode);
-		ret = (ccode == 3) ? -ENODEV : -EBUSY;
-		goto out;
+		return (ccode == 3) ? -ENODEV : -EBUSY;
 	}
 
 	switch (ssd_area->response.code) {
 	case 0x0001: /* everything ok */
-		ret = 0;
 		break;
 	case 0x0002:
 		CIO_CRW_EVENT(2, "Invalid command!\n");
 	case 0x0003:
 		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
-		ret = -EINVAL;
+		return -EINVAL;
 		break;
 	case 0x0004:
 		CIO_CRW_EVENT(2, "Model does not provide ssd\n");
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 		break;
 	default:
 		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
 			      ssd_area->response.code);
-		ret = -EIO;
+		return -EIO;
 		break;
 	}
 
-	if (ret != 0)
-		goto out;
-
 	/*
 	 * ssd_area->st stores the type of the detected
 	 * subchannel, with the following definitions:
@@ -167,14 +157,14 @@
 		 * time since this code was written; since we don't know which
 		 * fields have meaning and what to do with it we just jump out
 		 */
-		goto out;
+		return 0;
 	} else {
 		const char *type[4] = {"I/O", "chsc", "message", "ADM"};
 		CIO_CRW_EVENT(6, "ssd: sch %x is %s subchannel\n",
 			      irq, type[ssd_area->st]);
 		if (ioinfo[irq] == NULL)
 			/* FIXME: we should do device rec. here... */
-			goto out;
+			return 0;
 
 		ioinfo[irq]->ssd_info.valid = 1;
 		ioinfo[irq]->ssd_info.type = ssd_area->st;
@@ -195,9 +185,8 @@
 			ioinfo[irq]->ssd_info.fla[j]   = ssd_area->fla[j];
 		}
 	}
-out:
-	free_page ((unsigned long) ssd_area);
-	return ret;
+
+	return 0;
 }
 
 static int
@@ -205,6 +194,7 @@
 {
 	int irq;
 	int err;
+	void *page;
 
 	CIO_TRACE_EVENT( 4, "gsdesc");
 
@@ -212,11 +202,15 @@
 	 * get information about chpids and link addresses
 	 * by executing the chsc command 'store subchannel description'
 	 */
+	page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!page)
+		return -ENOMEM;
+
 	for (irq = 0; irq <= highest_subchannel; irq++) {
 		/*
 		 * retrieve information for each sch
 		 */
-		err = chsc_get_sch_desc_irq(irq);
+		err = chsc_get_sch_desc_irq(irq, page);
 		if (err) {
 			static int cio_chsc_err_msg;
 
@@ -230,8 +224,10 @@
 			}
 			return err;
 		}
+		clear_page(page);
 	}
 	cio_chsc_desc_avail = 1;
+	free_page((unsigned long)page);
 	return 0;
 }
 
@@ -352,14 +348,14 @@
 
 static int
 s390_process_res_acc_sch(u8 chpid, __u16 fla, u32 fla_mask,
-			 struct subchannel *sch)
+			 struct subchannel *sch, void *page)
 {
 	int found;
 	int chp;
 	int ccode;
 	
 	/* Update our ssd_info */
-	if (chsc_get_sch_desc_irq(sch->irq))
+	if (chsc_get_sch_desc_irq(sch->irq, page))
 		return 0;
 	
 	found = 0;
@@ -396,6 +392,7 @@
 	int irq;
 	int ret;
 	char dbf_txt[15];
+	void *page;
 
 	sprintf(dbf_txt, "accpr%x", chpid);
 	CIO_TRACE_EVENT( 2, dbf_txt);
@@ -412,22 +409,13 @@
 	 * will we have to do.
 	 */
 
-	if (!cio_chsc_desc_avail)
-		chsc_get_sch_descriptions();
-
-	if (!cio_chsc_desc_avail) {
-		/*
-		 * Something went wrong...
-		 */
-		CIO_CRW_EVENT(0, "Error: Could not retrieve "
-			      "subchannel descriptions, will not process css"
-			      "machine check...\n");
-		return;
-	}
-
 	if (!test_bit(chpid, chpids_logical))
 		return; /* no need to do the rest */
 
+	page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!page)
+		return;
+
 	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		int chp_mask;
 
@@ -450,7 +438,10 @@
 	
 		spin_lock_irq(&sch->lock);
 
-		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask, sch);
+		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask,
+						    sch, page);
+		clear_page(page);
+
 		if (chp_mask == 0) {
 
 			spin_unlock_irq(&sch->lock);
@@ -475,6 +466,7 @@
 		if (fla_mask != 0)
 			break;
 	}
+	free_page((unsigned long)page);
 }
 
 static void
diff -urN linux-2.5/drivers/s390/cio/cio.c linux-2.5-s390/drivers/s390/cio/cio.c
--- linux-2.5/drivers/s390/cio/cio.c	Mon May  5 01:53:56 2003
+++ linux-2.5-s390/drivers/s390/cio/cio.c	Mon May 26 19:20:42 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.97 $
+ *   $Revision: 1.98 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -146,7 +146,7 @@
 		/* Not status pending or not operational. */
 		return 1;
 	sch = ioinfo[tpi_info->irq];
-	if (sch)
+	if (!sch)
 		return 1;
 	irq_enter ();
 	spin_lock(&sch->lock);
@@ -658,8 +658,7 @@
 	 * before entering the spinlock we may already have
 	 * processed the interrupt on a different CPU...
 	 */
-	if (!console_subchannel_in_use ||
-	    console_subchannel.schib.scsw.actl == 0)
+	if (!console_subchannel_in_use)
 		return;
 
 	/* disable all but isc 7 (console device) */
diff -urN linux-2.5/drivers/s390/cio/qdio.c linux-2.5-s390/drivers/s390/cio/qdio.c
--- linux-2.5/drivers/s390/cio/qdio.c	Mon May  5 01:53:32 2003
+++ linux-2.5-s390/drivers/s390/cio/qdio.c	Mon May 26 19:20:42 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.48 $"
+#define VERSION_QDIO_C "$Revision: 1.49 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -1668,6 +1668,7 @@
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
+		/* FIXME: defer this past interrupt time */
 		qdio_establish_handle_irq(cdev, cstat, dstat);
 		break;
 
@@ -1763,7 +1764,8 @@
 		u8  ocnt;
 	} *ssqd_area;
 
-	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	/* FIXME make this GFP_KERNEL */
+	ssqd_area = (void *)get_zeroed_page(GFP_ATOMIC | GFP_DMA);
 	if (!ssqd_area) {
 	        QDIO_PRINT_WARN("Could not get memory for chsc. Using all " \
 				"SIGAs for sch x%x.\n", sch);
@@ -2644,6 +2646,7 @@
 		return result;
 	}
 	
+	/* FIXME: don't wait forever if hardware is broken */
 	wait_event(cdev->private->wait_q,
 		   irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
 		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
diff -urN linux-2.5/include/asm-s390/hardirq.h linux-2.5-s390/include/asm-s390/hardirq.h
--- linux-2.5/include/asm-s390/hardirq.h	Mon May 26 19:20:29 2003
+++ linux-2.5-s390/include/asm-s390/hardirq.h	Mon May 26 19:20:42 2003
@@ -83,7 +83,7 @@
 #define invoke_softirq() do_call_softirq()
 
 #ifdef CONFIG_PREEMPT
-# define in_atomic()	(in_interrupt() || preempt_count() == PREEMPT_ACTIVE)
+# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
 # define in_atomic()	(preempt_count() != 0)
diff -urN linux-2.5/include/asm-s390/pgtable.h linux-2.5-s390/include/asm-s390/pgtable.h
--- linux-2.5/include/asm-s390/pgtable.h	Mon May  5 01:53:37 2003
+++ linux-2.5-s390/include/asm-s390/pgtable.h	Mon May 26 19:20:42 2003
@@ -218,9 +218,9 @@
 /* Mask and four different kinds of invalid pages. */
 #define _PAGE_INVALID_MASK	0x601
 #define _PAGE_INVALID_EMPTY	0x400
-#define _PAGE_INVALID_NONE	0x001
-#define _PAGE_INVALID_SWAP	0x200
-#define _PAGE_INVALID_FILE	0x201
+#define _PAGE_INVALID_NONE	0x401
+#define _PAGE_INVALID_SWAP	0x600
+#define _PAGE_INVALID_FILE	0x601
 
 #ifndef __s390x__
 
diff -urN linux-2.5/include/asm-s390/posix_types.h linux-2.5-s390/include/asm-s390/posix_types.h
--- linux-2.5/include/asm-s390/posix_types.h	Mon May  5 01:52:48 2003
+++ linux-2.5-s390/include/asm-s390/posix_types.h	Mon May 26 19:20:42 2003
@@ -65,6 +65,7 @@
 typedef __kernel_gid_t __kernel_old_gid_t;
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
+typedef unsigned short __kernel_old_dev_t;
 
 #endif /* __s390x__ */
 
