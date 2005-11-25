Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVKYU4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKYU4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 15:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVKYU4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 15:56:43 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42239 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750820AbVKYU4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 15:56:42 -0500
Subject: [RFC][PATCH] Runtime switching to idle_poll (was: Re: 2.6.14-rt13)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       Andrew Morton <akpm@osdl.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051124150731.GD2717@elte.hu>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <20051118220755.GA3029@elte.hu>
	 <1132353689.4735.43.camel@cmn3.stanford.edu>
	 <1132367947.5706.11.camel@localhost.localdomain>
	 <20051124150731.GD2717@elte.hu>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 15:56:31 -0500
Message-Id: <1132952191.24417.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 16:07 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> > Ingo, This could be a temporary patch until we come up with a better 
> > solution.  This adds /sys/kernel/idle/idle_poll, which if idle=poll is 
> > _not_ set, it still lets you switch the machine to idle=poll on the 
> > fly, as well as turn it off. If you have idle=poll, this doesn't even 
> > show up.
> 
> ok, i've applied this one too. Could you also submit it upstream (and 
> implement it for x86)? It makes sense to enable/disable the 
> polling-based idle routine runtime.

As a request from Ingo, I fixed up this patch a little to allow both
x86_64 and i386 to switch to and from idle_poll at runtime.  I noticed
that the APCI driver in drivers/acpi/processor_idle.c may cause some
race condition with this patch so I added some protection there.
Basically, if the acpi code changes pm_idle, then you can't change to
idle_poll, and vice-versa.

What this patch does is creates an entry
into /sys/kernel/idle/idle_poll.  It will show whether or not the
idle_poll is being used as a runtime idle routine.  It is also used to
set the runtime idle.

with:

# echo 1 > /sys/kernel/idle/idle_poll
  or
# echo on > /sys/kernel/idle/idle_poll

The system will switch to the idle_poll idle routine.

with:

# echo 0 > /sys/kernel/idle/idle_poll
  or
# echo off > /sys/kernel/idle/idle_poll

The system will switch out of idle poll.  Note that if the command line
states "idle=poll" then this will not be implemented.

This is still a work-in-progress.  Since I only own a x86_64 and i386
that is all I ported the code for and tested.  Looking for who else
exports pm_idle I see that the following archs may also need to be
updated:

arm, arm26, i64, sparc.

I also have not yet protected the pm_idle in arch/i386/kernel/apm.c

I figure that I should get some comments before I spend any more time on
this.

Thanks,

-- Steve

Index: linux-2.6.15-rc2-git5/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/i386/kernel/Makefile	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.15-rc2-git5/arch/i386/kernel/Makefile	2005-11-25 11:56:25.000000000 -0500
@@ -34,6 +34,7 @@
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_SYSFS)		+= switch2poll.o
 
 EXTRA_AFLAGS   := -traditional
 
Index: linux-2.6.15-rc2-git5/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/i386/kernel/process.c	2005-11-25 10:58:53.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/i386/kernel/process.c	2005-11-25 12:18:12.000000000 -0500
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -64,6 +65,12 @@
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
 
+spinlock_t pm_idle_switch_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(pm_idle_switch_lock);
+
+int pm_idle_locked = 0;
+EXPORT_SYMBOL(pm_idle_locked);
+
 /*
  * Return saved PC of a blocked thread.
  */
@@ -126,7 +133,7 @@
  * to poll the ->work.need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
-static void poll_idle (void)
+void poll_idle (void)
 {
 	local_irq_enable();
 
Index: linux-2.6.15-rc2-git5/arch/i386/kernel/switch2poll.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-git5/arch/i386/kernel/switch2poll.c	2005-11-25 11:55:19.000000000 -0500
@@ -0,0 +1,5 @@
+/*
+ * Same type of hack used for early_printk.  This keeps the code
+ * in one place.
+ */
+#include "../../x86_64/kernel/switch2poll.c"
Index: linux-2.6.15-rc2-git5/arch/x86_64/kernel/Makefile
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/x86_64/kernel/Makefile	2005-11-22 12:13:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/x86_64/kernel/Makefile	2005-11-25 11:56:40.000000000 -0500
@@ -30,6 +30,7 @@
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
+obj-$(CONFIG_SYSFS)		+= switch2poll.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 
Index: linux-2.6.15-rc2-git5/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/arch/x86_64/kernel/process.c	2005-11-25 10:58:53.000000000 -0500
+++ linux-2.6.15-rc2-git5/arch/x86_64/kernel/process.c	2005-11-25 12:17:53.000000000 -0500
@@ -36,6 +36,7 @@
 #include <linux/utsname.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -60,6 +61,12 @@
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
 
+spinlock_t pm_idle_switch_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(pm_idle_switch_lock);
+
+int pm_idle_locked = 0;
+EXPORT_SYMBOL(pm_idle_locked);
+
 /*
  * Powermanagement idle function, if any..
  */
@@ -110,7 +117,7 @@
  * to poll the ->need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
-static void poll_idle (void)
+void poll_idle (void)
 {
 	local_irq_enable();
 
Index: linux-2.6.15-rc2-git5/arch/x86_64/kernel/switch2poll.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-git5/arch/x86_64/kernel/switch2poll.c	2005-11-25 12:23:22.000000000 -0500
@@ -0,0 +1,112 @@
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/spinlock.h>
+#include <linux/pm.h>
+
+extern void poll_idle (void);
+
+#define KERNEL_ATTR_RW(_name) \
+static struct subsys_attribute _name##_attr = \
+	__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static struct idlep_kobject
+{
+	struct kobject kobj;
+	int is_poll;
+	void (*idle)(void);
+} idle_kobj;
+
+static ssize_t idle_poll_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", (idle_kobj.is_poll ? "on" : "off"));
+}
+
+static ssize_t idle_poll_store(struct subsystem *subsys,
+			       const char *buf, size_t len)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pm_idle_switch_lock, flags);
+
+	/*
+	 * If power management is handling the idle function,
+	 * then leave it be.
+	 */
+	if (pm_idle_locked) {
+		len = -EBUSY;
+		goto out;
+	}
+
+	if (strncmp(buf,"1",1)==0 ||
+	    (len >=2 && strncmp(buf,"on",2)==0)) {
+		if (idle_kobj.is_poll != 1) {
+			idle_kobj.is_poll = 1;
+			boot_option_idle_override = 1;
+			idle_kobj.idle = pm_idle;
+			pm_idle = poll_idle;
+		}
+	} else if (strncmp(buf,"0",1)==0 ||
+		   (len >= 3 && strncmp(buf,"off",3)==0)) {
+		if (idle_kobj.is_poll != 0) {
+			boot_option_idle_override = 0;
+			idle_kobj.is_poll = 0;
+			pm_idle = idle_kobj.idle;
+		}
+	}
+
+out:
+	spin_unlock_irqrestore(&pm_idle_switch_lock, flags);
+
+	return len;
+}
+
+
+KERNEL_ATTR_RW(idle_poll);
+
+static struct attribute * idle_attrs[] = {
+	&idle_poll_attr.attr,
+	NULL
+};
+
+static struct attribute_group idle_attr_group = {
+	.attrs = idle_attrs,
+};
+
+static int __init idle_poll_set_init(void)
+{
+	int err;
+
+	/*
+	 * If the default is alread poll_idle then
+	 * don't even bother with this.
+	 */
+	if (pm_idle == poll_idle)
+		return 0;
+
+	memset(&idle_kobj, 0, sizeof(idle_kobj));
+
+	idle_kobj.is_poll = 0;
+	idle_kobj.idle = pm_idle;
+
+	err = kobject_set_name(&idle_kobj.kobj, "%s", "idle");
+	if (err)
+		goto out;
+
+	idle_kobj.kobj.parent = &kernel_subsys.kset.kobj;
+	err = kobject_register(&idle_kobj.kobj);
+	if (err)
+		goto out;
+
+	err = sysfs_create_group(&idle_kobj.kobj,
+				 &idle_attr_group);
+	if (err)
+		goto out;
+
+	return 0;
+out:
+	printk(KERN_INFO "Problem setting up sysfs idle_poll\n");
+	return 0;
+}
+
+late_initcall(idle_poll_set_init);
Index: linux-2.6.15-rc2-git5/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.15-rc2-git5.orig/drivers/acpi/processor_idle.c	2005-11-22 12:13:24.000000000 -0500
+++ linux-2.6.15-rc2-git5/drivers/acpi/processor_idle.c	2005-11-25 13:15:59.000000000 -0500
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/spinlock.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -990,6 +991,7 @@
 	static int first_run = 0;
 	struct proc_dir_entry *entry = NULL;
 	unsigned int i;
+	unsigned long flags;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_power_init");
 
@@ -1023,6 +1025,7 @@
 	 * Note that we use previously set idle handler will be used on
 	 * platforms that only support C1.
 	 */
+	spin_lock_irqsave(&pm_idle_switch_lock, flags);
 	if ((pr->flags.power) && (!boot_option_idle_override)) {
 		printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
 		for (i = 1; i <= pr->power.count; i++)
@@ -1034,8 +1037,13 @@
 		if (pr->id == 0) {
 			pm_idle_save = pm_idle;
 			pm_idle = acpi_processor_idle;
+			/*
+			 * Don't allow switching of the pm_idle to poll.
+			 */
+			pm_idle_locked = 1;
 		}
 	}
+	spin_unlock_irqrestore(&pm_idle_switch_lock, flags);
 
 	/* 'power' [R] */
 	entry = create_proc_entry(ACPI_PROCESSOR_FILE_POWER,
@@ -1078,5 +1086,7 @@
 		cpu_idle_wait();
 	}
 
+	pm_idle_locked = 0;
+
 	return_VALUE(0);
 }
Index: linux-2.6.15-rc2-git5/include/linux/pm.h
===================================================================
--- linux-2.6.15-rc2-git5.orig/include/linux/pm.h	2005-11-25 12:05:33.000000000 -0500
+++ linux-2.6.15-rc2-git5/include/linux/pm.h	2005-11-25 12:17:17.000000000 -0500
@@ -25,6 +25,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/atomic.h>
 
 /*
@@ -102,6 +103,8 @@
  */
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
+extern spinlock_t pm_idle_switch_lock;
+extern int pm_idle_locked;
 
 typedef int __bitwise suspend_state_t;
 


