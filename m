Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVD2NQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVD2NQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVD2NQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:16:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262559AbVD2NPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:15:33 -0400
Date: Fri, 29 Apr 2005 14:15:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Colin Leroy <colin@colino.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.12-rc3 cpufreq compile error on ppc32
Message-ID: <20050429131519.GA6158@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Colin Leroy <colin@colino.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20050421092611.37df940b@colin.toulouse> <1114129070.5996.36.camel@gaston> <20050425222039.5421fa64@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425222039.5421fa64@jack.colino.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:20:39PM +0200, Colin Leroy wrote:
> > > One of Ben's patches ("ppc32: Fix cpufreq problems") went in 2.6.12-
> > > rc3, but it depended on another patch that's still in -mm only: 
> > > add-suspend-method-to-cpufreq-core.patch
> > > 
> > > In addition to this, there's a third patch in -mm that fixes
> > > warnings and line length to the previous patch, but it doesn't
> > > apply cleanly anymore. It's named add-suspend-method-to-cpufreq-
> > > core-warning-fix.patch
> > 
> > Yup, please, Andrew, get those 2 to Linus.
> 
> Just a heads-up : I didn't see these go into the git tree?

still not in.  Linus, can you please put in the patch below from benh?


Index: linux-work/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-work.orig/drivers/cpufreq/cpufreq.c	2005-03-30 09:42:18.000000000 +1000
+++ linux-work/drivers/cpufreq/cpufreq.c	2005-03-30 09:47:22.000000000 +1000
@@ -223,7 +223,7 @@
 	}
 	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
 	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new) ||
-	    (val == CPUFREQ_RESUMECHANGE)) {
+	    (val == CPUFREQ_RESUMECHANGE || val == CPUFREQ_SUSPENDCHANGE)) {
 		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
 		dprintk("scaling loops_per_jiffy to %lu for frequency %u kHz\n", loops_per_jiffy, ci->new);
 	}
@@ -866,16 +866,96 @@
 
 
 /**
+ *	cpufreq_suspend - let the low level driver prepare for suspend
+ */
+
+static int cpufreq_suspend(struct sys_device * sysdev, u32 state)
+{
+	int cpu = sysdev->id;
+	unsigned int ret = 0;
+	unsigned int cur_freq = 0;
+	struct cpufreq_policy *cpu_policy;
+
+	dprintk("resuming cpu %u\n", cpu);
+
+	if (!cpu_online(cpu))
+		return 0;
+
+	/* we may be lax here as interrupts are off. Nonetheless
+	 * we need to grab the correct cpu policy, as to check
+	 * whether we really run on this CPU.
+	 */
+
+	cpu_policy = cpufreq_cpu_get(cpu);
+	if (!cpu_policy)
+		return -EINVAL;
+
+	/* only handle each CPU group once */
+	if (unlikely(cpu_policy->cpu != cpu)) {
+		cpufreq_cpu_put(cpu_policy);
+		return 0;
+	}
+
+	if (cpufreq_driver->suspend) {
+		ret = cpufreq_driver->suspend(cpu_policy, state);
+		if (ret) {
+			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
+					"step on CPU %u\n", cpu_policy->cpu);
+			cpufreq_cpu_put(cpu_policy);
+			return ret;
+		}
+	}
+
+
+	if (cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)
+		goto out;
+
+	if (cpufreq_driver->get)
+		cur_freq = cpufreq_driver->get(cpu_policy->cpu);
+
+	if (!cur_freq || !cpu_policy->cur) {
+		printk(KERN_ERR "cpufreq: suspend failed to assert current "
+		       "frequency is what timing core thinks it is.\n");
+		goto out;
+	}
+
+	if (unlikely(cur_freq != cpu_policy->cur)) {
+		struct cpufreq_freqs freqs;
+
+		if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
+			printk(KERN_DEBUG "Warning: CPU frequency is %u, "
+			       "cpufreq assumed %u kHz.\n",
+			       cur_freq, cpu_policy->cur);
+
+		freqs.cpu = cpu;
+		freqs.old = cpu_policy->cur;
+		freqs.new = cur_freq;
+
+		notifier_call_chain(&cpufreq_transition_notifier_list,
+				    CPUFREQ_SUSPENDCHANGE, &freqs);
+		adjust_jiffies(CPUFREQ_SUSPENDCHANGE, &freqs);
+
+		cpu_policy->cur = cur_freq;
+	}
+
+ out:
+	cpufreq_cpu_put(cpu_policy);
+	return 0;
+}
+
+/**
  *	cpufreq_resume -  restore proper CPU frequency handling after resume
  *
  *	1.) resume CPUfreq hardware support (cpufreq_driver->resume())
  *	2.) if ->target and !CPUFREQ_CONST_LOOPS: verify we're in sync
- *	3.) schedule call cpufreq_update_policy() ASAP as interrupts are restored.
+ *	3.) schedule call cpufreq_update_policy() ASAP as interrupts are
+ *	    restored.
  */
 static int cpufreq_resume(struct sys_device * sysdev)
 {
 	int cpu = sysdev->id;
 	unsigned int ret = 0;
+	unsigned int cur_freq = 0;
 	struct cpufreq_policy *cpu_policy;
 
 	dprintk("resuming cpu %u\n", cpu);
@@ -908,32 +988,34 @@
 		}
 	}
 
-	if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-		unsigned int cur_freq = 0;
-
-		if (cpufreq_driver->get)
-			cur_freq = cpufreq_driver->get(cpu_policy->cpu);
-
-		if (!cur_freq || !cpu_policy->cur) {
-			printk(KERN_ERR "cpufreq: resume failed to assert current frequency is what timing core thinks it is.\n");
-			goto out;
-		}
-
-		if (unlikely(cur_freq != cpu_policy->cur)) {
-			struct cpufreq_freqs freqs;
+	if (cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)
+		goto out;
 
-			printk(KERN_WARNING "Warning: CPU frequency is %u, "
-			       "cpufreq assumed %u kHz.\n", cur_freq, cpu_policy->cur);
+	if (cpufreq_driver->get)
+		cur_freq = cpufreq_driver->get(cpu_policy->cpu);
 
-			freqs.cpu = cpu;
-			freqs.old = cpu_policy->cur;
-			freqs.new = cur_freq;
+	if (!cur_freq || !cpu_policy->cur) {
+		printk(KERN_ERR "cpufreq: resume failed to assert current "
+		       "frequency is what timing core thinks it is.\n");
+		goto out;
+	}
 
-			notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_RESUMECHANGE, &freqs);
-			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
+	if (unlikely(cur_freq != cpu_policy->cur)) {
+		struct cpufreq_freqs freqs;
 
-			cpu_policy->cur = cur_freq;
-		}
+		if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
+			printk(KERN_DEBUG "Warning: CPU frequency is %u, "
+			       "cpufreq assumed %u kHz.\n",
+			       cur_freq, cpu_policy->cur);
+
+		freqs.cpu = cpu;
+		freqs.old = cpu_policy->cur;
+		freqs.new = cur_freq;
+
+		notifier_call_chain(&cpufreq_transition_notifier_list,
+				    CPUFREQ_RESUMECHANGE, &freqs);
+		adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
+		cpu_policy->cur = cur_freq;
 	}
 
 out:
@@ -945,6 +1027,7 @@
 static struct sysdev_driver cpufreq_sysdev_driver = {
 	.add		= cpufreq_add_dev,
 	.remove		= cpufreq_remove_dev,
+	.suspend	= cpufreq_suspend,
 	.resume		= cpufreq_resume,
 };
 
Index: linux-work/include/linux/cpufreq.h
===================================================================
--- linux-work.orig/include/linux/cpufreq.h	2005-03-30 09:42:18.000000000 +1000
+++ linux-work/include/linux/cpufreq.h	2005-03-30 09:46:25.000000000 +1000
@@ -103,6 +103,7 @@
 #define CPUFREQ_PRECHANGE	(0)
 #define CPUFREQ_POSTCHANGE	(1)
 #define CPUFREQ_RESUMECHANGE	(8)
+#define CPUFREQ_SUSPENDCHANGE	(9)
 
 struct cpufreq_freqs {
 	unsigned int cpu;	/* cpu nr */
@@ -200,6 +201,7 @@
 
 	/* optional */
 	int	(*exit)		(struct cpufreq_policy *policy);
+	int	(*suspend)	(struct cpufreq_policy *policy, u32 state);
 	int	(*resume)	(struct cpufreq_policy *policy);
 	struct freq_attr	**attr;
 };
@@ -211,7 +213,8 @@
 #define CPUFREQ_CONST_LOOPS 	0x02	/* loops_per_jiffy or other kernel
 					 * "constants" aren't affected by
 					 * frequency transitions */
-
+#define CPUFREQ_PM_NO_WARN	0x04	/* don't warn on suspend/resume speed
+					 * mismatches */
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
