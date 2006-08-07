Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWHGMDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWHGMDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWHGMDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:03:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:654 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750865AbWHGMDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:03:23 -0400
Date: Mon, 7 Aug 2006 17:34:47 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 3/3] Kprobes: Update Documentation/kprobes.txt
Message-ID: <20060807120447.GE15253@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060807115537.GA15253@in.ibm.com> <20060807120024.GD15253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807120024.GD15253@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Update Documentation/kprobes.txt to reflect addition of KPROBE_ADDR,
KPROBE_RETVAL and the in-kernel symbol resolution.

While at it:
- Document usage of JPROBE_RETURN
- Update the references list
- Update module examples to use module_init/module_exit interfaces

---
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Jim Keniston <jkenisto@us.ibm.com>


---
 Documentation/kprobes.txt |   77 ++++++++++++++++++++++++++++------------------
 1 files changed, 47 insertions(+), 30 deletions(-)

Index: linux-2.6.18-rc3/Documentation/kprobes.txt
===================================================================
--- linux-2.6.18-rc3.orig/Documentation/kprobes.txt
+++ linux-2.6.18-rc3/Documentation/kprobes.txt
@@ -179,6 +179,21 @@ occurs during execution of kp->pre_handl
 or during single-stepping of the probed instruction, Kprobes calls
 kp->fault_handler.  Any or all handlers can be NULL.
 
+NOTE:
+1. The KPROBE_ADDR macro is provided as an aid to make kprobe modules
+portable. Some architectures (notably powerpc) uses function descriptors
+due to which a kallsyms_lookup_name("probepoint") will give a data address,
+which, incidentally, is a placeholder for the actual text address. It is
+therefore advised to use:
+
+	kp.addr = KPROBE_ADDR("probepoint");
+
+2. With the introduction of the "symbol_name" field to struct kprobe,
+the probepoint address resolution will now be taken care of by the kernel.
+The following will also work:
+
+	kp.symbol_name = "symbol_name";
+
 register_kprobe() returns 0 on success, or a negative errno otherwise.
 
 User's pre-handler (kp->pre_handler):
@@ -225,6 +240,12 @@ control to Kprobes.)  If the probed func
 fastcall, or anything else that affects how args are passed, the
 handler's declaration must match.
 
+NOTE: Similar to KPROBE_ADDR, a macro JPROBE_ENTRY is provided to handle
+architecture-specific aliasing of jp->entry. In the interest of
+portability, it is advised to use:
+
+	jp->entry = JPROBE_ENTRY(handler);
+
 register_jprobe() returns 0 on success, or a negative errno otherwise.
 
 4.3 register_kretprobe
@@ -251,6 +272,11 @@ of interest:
 - ret_addr: the return address
 - rp: points to the corresponding kretprobe object
 - task: points to the corresponding task struct
+
+The KPROBE_RETVAL(regs) macro provides a simple abstraction to extract
+the return value from the appropriate register as defined by the
+architecture's ABI.
+
 The handler's return value is currently ignored.
 
 4.4 unregister_*probe
@@ -369,7 +395,6 @@ stack trace and selected i386 registers 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
-#include <linux/kallsyms.h>
 #include <linux/sched.h>
 
 /*For each probe you need to allocate a kprobe structure*/
@@ -403,18 +428,14 @@ int handler_fault(struct kprobe *p, stru
 	return 0;
 }
 
-int init_module(void)
+static int __init kprobe_init(void)
 {
 	int ret;
 	kp.pre_handler = handler_pre;
 	kp.post_handler = handler_post;
 	kp.fault_handler = handler_fault;
-	kp.addr = (kprobe_opcode_t*) kallsyms_lookup_name("do_fork");
-	/* register the kprobe now */
-	if (!kp.addr) {
-		printk("Couldn't find %s to plant kprobe\n", "do_fork");
-		return -1;
-	}
+	kp.symbol_name = "do_fork";
+
 	if ((ret = register_kprobe(&kp) < 0)) {
 		printk("register_kprobe failed, returned %d\n", ret);
 		return -1;
@@ -423,12 +444,14 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit kprobe_exit(void)
 {
 	unregister_kprobe(&kp);
 	printk("kprobe unregistered\n");
 }
 
+module_init(kprobe_init)
+module_exit(kprobe_exit)
 MODULE_LICENSE("GPL");
 ----- cut here -----
 
@@ -463,7 +486,6 @@ the arguments of do_fork().
 #include <linux/fs.h>
 #include <linux/uio.h>
 #include <linux/kprobes.h>
-#include <linux/kallsyms.h>
 
 /*
  * Jumper probe for do_fork.
@@ -485,17 +507,13 @@ long jdo_fork(unsigned long clone_flags,
 }
 
 static struct jprobe my_jprobe = {
-	.entry = (kprobe_opcode_t *) jdo_fork
+	.entry = JPROBE_ENTRY(jdo_fork)
 };
 
-int init_module(void)
+static int __init jprobe_init(void)
 {
 	int ret;
-	my_jprobe.kp.addr = (kprobe_opcode_t *) kallsyms_lookup_name("do_fork");
-	if (!my_jprobe.kp.addr) {
-		printk("Couldn't find %s to plant jprobe\n", "do_fork");
-		return -1;
-	}
+	my_jprobe.kp.symbol_name = "do_fork";
 
 	if ((ret = register_jprobe(&my_jprobe)) <0) {
 		printk("register_jprobe failed, returned %d\n", ret);
@@ -506,12 +524,14 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit jprobe_exit(void)
 {
 	unregister_jprobe(&my_jprobe);
 	printk("jprobe unregistered\n");
 }
 
+module_init(jprobe_init)
+module_exit(jprobe_exit)
 MODULE_LICENSE("GPL");
 ----- cut here -----
 
@@ -530,16 +550,13 @@ report failed calls to sys_open().
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
-#include <linux/kallsyms.h>
 
 static const char *probed_func = "sys_open";
 
 /* Return-probe handler: If the probed function fails, log the return value. */
 static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
-	// Substitute the appropriate register name for your architecture --
-	// e.g., regs->rax for x86_64, regs->gpr[3] for ppc64.
-	int retval = (int) regs->eax;
+	int retval = KPROBE_RETVAL(regs);
 	if (retval < 0) {
 		printk("%s returns %d\n", probed_func, retval);
 	}
@@ -552,15 +569,11 @@ static struct kretprobe my_kretprobe = {
 	.maxactive = 20
 };
 
-int init_module(void)
+static int __init kretprobe_init(void)
 {
 	int ret;
-	my_kretprobe.kp.addr =
-		(kprobe_opcode_t *) kallsyms_lookup_name(probed_func);
-	if (!my_kretprobe.kp.addr) {
-		printk("Couldn't find %s to plant return probe\n", probed_func);
-		return -1;
-	}
+	my_kretprobe.kp.symbol_name = (char *)probed_func;
+
 	if ((ret = register_kretprobe(&my_kretprobe)) < 0) {
 		printk("register_kretprobe failed, returned %d\n", ret);
 		return -1;
@@ -569,7 +582,7 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit kretprobe_exit(void)
 {
 	unregister_kretprobe(&my_kretprobe);
 	printk("kretprobe unregistered\n");
@@ -578,6 +591,8 @@ void cleanup_module(void)
 		my_kretprobe.nmissed, probed_func);
 }
 
+module_init(kretprobe_init)
+module_exit(kretprobe_exit)
 MODULE_LICENSE("GPL");
 ----- cut here -----
 
@@ -590,3 +605,5 @@ messages.)
 For additional information on Kprobes, refer to the following URLs:
 http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
 http://www.redhat.com/magazine/005mar05/features/kprobes/
+http://www-users.cs.umn.edu/~boutcher/kprobes/
+http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)
