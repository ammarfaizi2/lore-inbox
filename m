Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWAIWlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWAIWlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAIWlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:41:02 -0500
Received: from fmr21.intel.com ([143.183.121.13]:47252 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751284AbWAIWlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:41:01 -0500
Date: Mon, 9 Jan 2006 14:40:41 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       Systemtap <systemtap@sources.redhat.com>
Subject: [PATCH]Kprobes:Fix unloading of self probed module
Message-ID: <20060109144041.A29700@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix unloading of self probed module

When a kprobes modules is written in such a way that
probes are inserted on itself, then unload of that
moudle was not possible due to reference couning on
the same module.

The below patch makes a check and incrementes
the module refcount only if it is not a self
probed module.

We need to allow modules to probe themself -e.g.
kprobes performance measurements

This patch has been tested on several x86_64, ppc64
and IA64 architectures.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy>
-------------------------------------------------------

 include/linux/kprobes.h |    3 +++
 kernel/kprobes.c        |   42 ++++++++++++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 10 deletions(-)

Index: linux-2.6.15-mm1/include/linux/kprobes.h
===================================================================
--- linux-2.6.15-mm1.orig/include/linux/kprobes.h
+++ linux-2.6.15-mm1/include/linux/kprobes.h
@@ -67,6 +67,9 @@ struct kprobe {
 
 	/* list of kprobes for multi-handler support */
 	struct list_head list;
+	
+	/* Indicates that the corresponding module has been ref counted */
+	unsigned int mod_refcounted;
 
 	/*count the number of times this probe was temporarily disarmed */
 	unsigned long nmissed;
Index: linux-2.6.15-mm1/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/kernel/kprobes.c
+++ linux-2.6.15-mm1/kernel/kprobes.c
@@ -449,19 +449,32 @@ static int __kprobes in_kprobes_function
 	return 0;
 }
 
-int __kprobes register_kprobe(struct kprobe *p)
+static int __kprobes __register_kprobe(struct kprobe *p,
+	unsigned long called_from)
 {
 	int ret = 0;
 	struct kprobe *old_p;
-	struct module *mod;
+	struct module *probed_mod;
 
 	if ((!kernel_text_address((unsigned long) p->addr)) ||
 		in_kprobes_functions((unsigned long) p->addr))
 		return -EINVAL;
 
-	if ((mod = module_text_address((unsigned long) p->addr)) &&
-			(unlikely(!try_module_get(mod))))
-		return -EINVAL;
+	p->mod_refcounted = 0;
+	/* Check are we probing a module */
+	if ((probed_mod = module_text_address((unsigned long) p->addr))) {
+		struct module *calling_mod = module_text_address(called_from);
+		/* We must allow modules to probe themself and
+		 * in this case avoid incrementing the module refcount,
+		 * so as to allow unloading of self probing modules.
+		 */
+		if (calling_mod && (calling_mod != probed_mod)) {
+			if (unlikely(!try_module_get(probed_mod)))
+				return -EINVAL;
+			p->mod_refcounted = 1;
+		} else
+			probed_mod = NULL;
+	}
 
 	p->nmissed = 0;
 	down(&kprobe_mutex);
@@ -483,11 +496,17 @@ int __kprobes register_kprobe(struct kpr
 out:
 	up(&kprobe_mutex);
 
-	if (ret && mod)
-		module_put(mod);
+	if (ret && probed_mod)
+		module_put(probed_mod);
 	return ret;
 }
 
+int __kprobes register_kprobe(struct kprobe *p)
+{
+	return __register_kprobe(p,
+		(unsigned long)__builtin_return_address(0));
+}
+
 void __kprobes unregister_kprobe(struct kprobe *p)
 {
 	struct module *mod;
@@ -524,7 +543,8 @@ valid_p:
 	up(&kprobe_mutex);
 
 	synchronize_sched();
-	if ((mod = module_text_address((unsigned long)p->addr)))
+	if (p->mod_refcounted &&
+	    (mod = module_text_address((unsigned long)p->addr)))
 		module_put(mod);
 
 	if (cleanup_p) {
@@ -547,7 +567,8 @@ int __kprobes register_jprobe(struct jpr
 	jp->kp.pre_handler = setjmp_pre_handler;
 	jp->kp.break_handler = longjmp_break_handler;
 
-	return register_kprobe(&jp->kp);
+	return __register_kprobe(&jp->kp,
+		(unsigned long)__builtin_return_address(0));
 }
 
 void __kprobes unregister_jprobe(struct jprobe *jp)
@@ -587,7 +608,8 @@ int __kprobes register_kretprobe(struct 
 
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
-	if ((ret = register_kprobe(&rp->kp)) != 0)
+	if ((ret = __register_kprobe(&rp->kp, 
+		(unsigned long)__builtin_return_address(0))) != 0)
 		free_rp_inst(rp);
 	return ret;
 }
