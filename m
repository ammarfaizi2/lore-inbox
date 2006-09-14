Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWINQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWINQzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWINQzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:55:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:16245 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750741AbWINQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:55:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SiD2WWtJH17vLyUwDF54U36yMC7MbcNPQXfRL6y/txNP2R9I5VaEgEubg/TIGWo0Xsh7lzwGM1DwItCF2aeCYhBy66NrEB6p/1pvROmazbVXEdq13jW1LT6b55PU0wDi4J23BnSdrYlr4aGVJTRFBztPIZBLWj/n8pJfrEgHoZY=
Message-ID: <b324b5ad0609140955r46964e6aq6d31f1ac8b483057@mail.gmail.com>
Date: Thu, 14 Sep 2006 09:55:17 -0700
From: "David Singleton" <daviado@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: OpPoint summary
Cc: linux-pm@lists.osdl.org, "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060914055529.GA18031@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/06, Greg KH <greg@kroah.com> wrote:
> On Wed, Sep 13, 2006 at 04:50:43PM -0700, David Singleton wrote:
> > Greg,
> >   here's a few paragraphs about the power management code I'm working on.
> > The OpPoint patch set is a fully functionaly power management solution,
> > from kernel operating state support to userland power manager.
>
> Thanks for the summary, but it was a bit longer than just "one
> paragraph" :)
>
> > OpPoint constructs operating points for all supported frequency, voltage
> > and suspend states for PC and SoC solutions running Linux.  OpPoint
> > does not break or replace cpufreq.  It leverages cpufreq code to provide
> > the same driver scaling functions when cpu frequency changes affect drivers.
>
> So it works with cpufreq?  That's a good thing, as it is a requirement.
> We can't just break current usages.
>
> > OpPoint is a fully functional solution ready for testing and evaluation
> > in Andrew's or your tree.
> >
> > The kernel patches are available at:
> >
> >        http://source.mvista.com/~dsingleton/2.6.1-rc6
>
> I get a 404 with that link :(
>
> Care to resend your patches in the proper format, through email so that
> we can see them, and possibly get some testing in -mm if they look sane?

Whoops, there are in the 2.6.18-rc6 directory.  Here's the core patch inlined:


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 drivers/base/driver.c        |    1
 drivers/base/power/Makefile  |    2
 drivers/base/power/oppoint.c |   74 +++++++++
 include/linux/pm.h           |   34 ++++
 kernel/power/main.c          |  328 +++++++++++++++++++++++++++++++++++++------
 kernel/power/power.h         |    2
 6 files changed, 397 insertions(+), 44 deletions(-)

Index: linux-2.6.17/kernel/power/main.c
===================================================================
--- linux-2.6.17.orig/kernel/power/main.c
+++ linux-2.6.17/kernel/power/main.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/console.h>
+#include <linux/module.h>

 #include "power.h"

@@ -49,7 +50,7 @@ void pm_set_ops(struct pm_ops * ops)
  *     the platform can enter the requested state.
  */

-static int suspend_prepare(suspend_state_t state)
+static int suspend_prepare(struct oppoint * state)
 {
        int error = 0;
        unsigned int free_pages;
@@ -82,7 +83,7 @@ static int suspend_prepare(suspend_state
        }

        if (pm_ops->prepare) {
-               if ((error = pm_ops->prepare(state)))
+               if ((error = pm_ops->prepare(state->type)))
                        goto Thaw;
        }

@@ -94,7 +95,7 @@ static int suspend_prepare(suspend_state
        return 0;
  Finish:
        if (pm_ops->finish)
-               pm_ops->finish(state);
+               pm_ops->finish(state->type);
  Thaw:
        thaw_processes();
  Enable_cpu:
@@ -104,7 +105,7 @@ static int suspend_prepare(suspend_state
 }


-int suspend_enter(suspend_state_t state)
+int suspend_enter(struct oppoint * state)
 {
        int error = 0;
        unsigned long flags;
@@ -115,7 +116,7 @@ int suspend_enter(suspend_state_t state)
                printk(KERN_ERR "Some devices failed to power down\n");
                goto Done;
        }
-       error = pm_ops->enter(state);
+       error = pm_ops->enter(state->type);
        device_power_up();
  Done:
        local_irq_restore(flags);
@@ -131,36 +132,98 @@ int suspend_enter(suspend_state_t state)
  *     console that we've allocated. This is not called for suspend-to-disk.
  */

-static void suspend_finish(suspend_state_t state)
+static void suspend_finish(struct oppoint * state)
 {
        device_resume();
        resume_console();
        thaw_processes();
        enable_nonboot_cpus();
        if (pm_ops && pm_ops->finish)
-               pm_ops->finish(state);
+               pm_ops->finish(state->type);
        pm_restore_console();
 }


+struct oppoint *current_state;
+struct oppoint pm_states = {
+       .name = "default",
+       .type = PM_SUSPEND_ON,
+};
+
+static struct oppoint standby = {
+       .name = "standby",
+       .type = PM_SUSPEND_STANDBY,
+};
+struct oppoint *oppoint_standby;

+static struct oppoint mem = {
+       .name = "mem",
+       .type = PM_SUSPEND_MEM,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 150,
+};
+struct oppoint *oppoint_mem;

-static const char * const pm_states[PM_SUSPEND_MAX] = {
-       [PM_SUSPEND_STANDBY]    = "standby",
-       [PM_SUSPEND_MEM]        = "mem",
 #ifdef CONFIG_SOFTWARE_SUSPEND
-       [PM_SUSPEND_DISK]       = "disk",
-#endif
+struct oppoint disk = {
+       .name = "disk",
+       .type = PM_SUSPEND_DISK,
 };
+#endif

-static inline int valid_state(suspend_state_t state)
+/*
+ *
+ */
+static int pm_change_state(struct oppoint *state)
+{
+       int error = 0;
+
+       printk("OpPoint: changing from %s to %s\n", current_state->name,
+            state->name);
+       /*
+        * compare to current operating point.
+        * if different change to new operating point.
+        */
+       if (current_state == state)
+               goto out;
+
+       /*
+        * prepare_transition does device constraint checking.  If
+        * a new operating point will put a device in an unsupported
+        * state, lcd clock too low, NIC bus too low, etc.  the new state
+        * cannot be entered (until the constrainded device is suspended).
+        * If prepare_transition fails we don't go to the new operating
+        * point.
+        */
+       if ((error = state->prepare_transition(current_state, state)))
+               goto out;
+
+       /*
+        * if the transition fails we call the finish transistion
+        * with the current state as the new state, causing
+        * the finish to return to the current_state.
+        */
+
+       if ((error = state->transition(current_state, state)))
+               state = current_state;
+
+       if ((state->finish_transition(current_state, state)) == 0)
+               current_state = state;
+
+out:
+       printk("OpPoint: State change returned %d\n", error);
+       return error;
+}
+
+static inline int valid_state(struct oppoint * state)
 {
        /* Suspend-to-disk does not really need low-level support.
         * It can work with reboot if needed. */
-       if (state == PM_SUSPEND_DISK)
+       if (state->type == PM_SUSPEND_DISK)
                return 1;

-       if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
+       if (pm_ops && pm_ops->valid && !pm_ops->valid(state->type))
                return 0;
        return 1;
 }
@@ -168,7 +231,7 @@ static inline int valid_state(suspend_st

 /**
  *     enter_state - Do common work of entering low-power state.
- *     @state:         pm_state structure for state we're entering.
+ *     @state:         oppoint structure for state we're entering.
  *
  *     Make sure we're the only ones trying to enter a sleep state. Fail
  *     if someone has beat us to it, since we don't want anything weird to
@@ -177,7 +240,7 @@ static inline int valid_state(suspend_st
  *     we've woken up).
  */

-static int enter_state(suspend_state_t state)
+static int enter_state(struct oppoint *state)
 {
        int error;

@@ -186,16 +249,21 @@ static int enter_state(suspend_state_t s
        if (down_trylock(&pm_sem))
                return -EBUSY;

-       if (state == PM_SUSPEND_DISK) {
+       if (state->type == PM_SUSPEND_DISK) {
                error = pm_suspend_disk();
                goto Unlock;
        }

-       pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
+       if (state->type == PM_FREQ_CHANGE || state->type == PM_VOLT_CHANGE) {
+               error = pm_change_state(state);
+               goto Unlock;
+       }
+
+       pr_debug("PM: Preparing system for %s sleep\n", state->name);
        if ((error = suspend_prepare(state)))
                goto Unlock;

-       pr_debug("PM: Entering %s sleep\n", pm_states[state]);
+       pr_debug("PM: Entering %s sleep\n", state->name);
        error = suspend_enter(state);

        pr_debug("PM: Finishing wakeup.\n");
@@ -211,7 +279,15 @@ static int enter_state(suspend_state_t s
  */
 int software_suspend(void)
 {
-       return enter_state(PM_SUSPEND_DISK);
+       struct oppoint *this, *next;
+       struct list_head *head = &pm_states.list;
+       int error = 0;
+
+       list_for_each_entry_safe(this, next, head, list) {
+               if (this->type == PM_SUSPEND_DISK)
+                       error= enter_state(this);
+       }
+       return error;
 }


@@ -223,9 +299,9 @@ int software_suspend(void)
  *     structure, and enter (above).
  */

-int pm_suspend(suspend_state_t state)
+int pm_suspend(struct oppoint * state)
 {
-       if (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX)
+       if (state->type > PM_SUSPEND_ON && state->type <= PM_SUSPEND_MAX)
                return enter_state(state);
        return -EINVAL;
 }
@@ -248,36 +324,29 @@ decl_subsys(power,NULL,NULL);

 static ssize_t state_show(struct subsystem * subsys, char * buf)
 {
-       int i;
        char * s = buf;

-       for (i = 0; i < PM_SUSPEND_MAX; i++) {
-               if (pm_states[i] && valid_state(i))
-                       s += sprintf(s,"%s ", pm_states[i]);
-       }
-       s += sprintf(s,"\n");
+       s += sprintf(s,"%s\n", current_state->name);
        return (s - buf);
 }

 static ssize_t state_store(struct subsystem * subsys, const char *
buf, size_t n)
 {
-       suspend_state_t state = PM_SUSPEND_STANDBY;
-       const char * const *s;
+       struct oppoint *this, *next;
+       struct list_head *head = &pm_states.list;
        char *p;
-       int error;
+       int error = -EINVAL;
        int len;

        p = memchr(buf, '\n', n);
        len = p ? p - buf : n;
-
-       for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
-               if (*s && !strncmp(buf, *s, len))
+       list_for_each_entry_safe(this, next, head, list) {
+               if ((strlen(this->name) == len) &&
+                  (!strncmp(this->name, buf, len))) {
+                       error = enter_state(this);
                        break;
+               }
        }
-       if (state < PM_SUSPEND_MAX && *s)
-               error = enter_state(state);
-       else
-               error = -EINVAL;
        return error ? error : n;
 }

@@ -292,12 +361,191 @@ static struct attribute_group attr_group
        .attrs = g,
 };

+static struct kobject oppoint_kobj = {
+        .kset = &power_subsys.kset,
+};
+
+struct oppoint_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct kobject * kobj, char * buf);
+        ssize_t (*store)(struct kobject * kobj, const char * buf,
size_t count);
+};
+
+#define to_oppoint(obj) container_of(obj,struct oppoint,kobj)
+#define to_oppoint_attr(_attr) container_of(_attr,struct
oppoint_attribute,attr)
+/*
+ * the frequency, voltage and latency files are readonly
+ */
+
+static ssize_t oppoint_voltage_show(struct kobject * kobj, char * buf)
+{
+       ssize_t len;
+       struct oppoint *opt = to_oppoint(kobj);
+
+       len = sprintf(buf, "%8d\n", opt->voltage);
+
+       return len;
+}
+
+static ssize_t oppoint_voltage_store(struct kobject * kobj, const char * buf,
+       size_t n)
+{
+        return -EINVAL;
+
+}
+
+static ssize_t oppoint_frequency_show(struct kobject * kobj, char * buf)
+{
+       ssize_t len;
+       struct oppoint *opt = to_oppoint(kobj);
+
+       len = sprintf(buf, "%8d\n", opt->frequency);
+
+       return len;
+}
+
+static ssize_t oppoint_frequency_store(struct kobject * kobj,
+        const char * buf, size_t n)
+{
+        return -EINVAL;
+
+}
+
+static ssize_t oppoint_latency_show(struct kobject * kobj, char * buf)
+{
+       ssize_t len;
+       struct oppoint *opt = to_oppoint(kobj);
+
+       len = sprintf(buf, "%8d\n", opt->latency);
+
+       return len;
+}
+
+static ssize_t oppoint_latency_store(struct kobject * kobj,
+        const char * buf, size_t n)
+{
+        return -EINVAL;
+
+}
+
+static struct oppoint_attribute frequency_attr = {
+        .attr   = {
+                .name = "frequency",
+                .mode = 0400,
+        },
+        .show   = oppoint_frequency_show,
+        .store  = oppoint_frequency_store,
+};
+
+static struct oppoint_attribute voltage_attr = {
+        .attr   = {
+                .name = "voltage",
+                .mode = 0400,
+        },
+        .show   = oppoint_voltage_show,
+        .store  = oppoint_voltage_store,
+};
+
+static struct oppoint_attribute latency_attr = {
+        .attr   = {
+                .name = "latency",
+                .mode = 0400,
+        },
+        .show   = oppoint_latency_show,
+        .store  = oppoint_latency_store,
+};
+
+static ssize_t
+oppoint_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
+{
+       struct oppoint_attribute * opt_attr = to_oppoint_attr(attr);
+       ssize_t ret = 0;
+
+       if (opt_attr->show)
+               ret = opt_attr->show(kobj,buf);
+       return ret;
+}
+
+static ssize_t
+oppoint_attr_store(struct kobject * kobj, struct attribute * attr,
+             const char * buf, size_t count)
+{
+       return -EINVAL;
+}
+
+static void oppoint_kobj_release(struct kobject *kobj)
+{
+       return;
+}
+
+static struct sysfs_ops oppoint_sysfs_ops = {
+       .show   = oppoint_attr_show,
+       .store  = oppoint_attr_store,
+};
+
+static struct attribute * oppoint_default_attrs[] = {
+       &frequency_attr.attr,
+       &voltage_attr.attr,
+       &latency_attr.attr,
+       NULL,
+};
+
+static struct kobj_type ktype_operating_point = {
+        .release        = oppoint_kobj_release,
+        .sysfs_ops      = &oppoint_sysfs_ops,
+        .default_attrs  = oppoint_default_attrs,
+};
+
+int unregister_operating_point(struct oppoint *opt)
+{
+       down(&pm_sem);
+       list_del_init(&opt->list);
+       sysfs_remove_file(&opt->kobj, &frequency_attr.attr);
+       sysfs_remove_file(&opt->kobj, &voltage_attr.attr);
+       sysfs_remove_file(&opt->kobj, &latency_attr.attr);
+       up(&pm_sem);
+}
+EXPORT_SYMBOL(unregister_operating_point);
+
+int register_operating_point(struct oppoint *opt)
+{
+       down(&pm_sem);
+       kobject_set_name(&opt->kobj, opt->name);
+       opt->kobj.kset = &power_subsys.kset;
+       opt->kobj.parent = &oppoint_kobj;
+       opt->kobj.ktype = &ktype_operating_point;
+       kobject_register(&opt->kobj);
+
+       sysfs_create_file(&opt->kobj, &frequency_attr.attr);
+       sysfs_create_file(&opt->kobj, &voltage_attr.attr);
+       sysfs_create_file(&opt->kobj, &latency_attr.attr);
+
+       list_add_tail(&opt->list, &pm_states.list);
+       up(&pm_sem);
+       return 0;
+}
+EXPORT_SYMBOL(register_operating_point);

 static int __init pm_init(void)
 {
+
        int error = subsystem_register(&power_subsys);
-       if (!error)
+       if (!error) {
                error = sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
+               kobject_set_name(&oppoint_kobj, "operating_points");
+               kobject_register(&oppoint_kobj);
+       }
+
+
+       INIT_LIST_HEAD(&pm_states.list);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+       register_operating_point(&disk);
+#endif
+       register_operating_point(&mem);
+       register_operating_point(&standby);
+       current_state = &pm_states;
+
        return error;
 }

Index: linux-2.6.17/include/linux/pm.h
===================================================================
--- linux-2.6.17.orig/include/linux/pm.h
+++ linux-2.6.17/include/linux/pm.h
@@ -24,6 +24,7 @@
 #ifdef __KERNEL__

 #include <linux/list.h>
+#include <linux/kobject.h>
 #include <asm/atomic.h>

 /*
@@ -108,7 +109,36 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_STANDBY     ((__force suspend_state_t) 1)
 #define PM_SUSPEND_MEM         ((__force suspend_state_t) 3)
 #define PM_SUSPEND_DISK                ((__force suspend_state_t) 4)
-#define PM_SUSPEND_MAX         ((__force suspend_state_t) 5)
+#define PM_FREQ_CHANGE         ((__force suspend_state_t) 5)
+#define PM_VOLT_CHANGE         ((__force suspend_state_t) 6)
+#define PM_SUSPEND_MAX         ((__force suspend_state_t) 7)
+
+struct oppoint {
+       struct list_head list;
+       suspend_state_t type;
+       unsigned int flags;
+       char *name;
+       unsigned int frequency;         /* in KHz */
+       unsigned int voltage;           /* mV */
+       unsigned int latency;           /* transition latency in us */
+       int     (*prepare_transition)(struct oppoint *cur, struct oppoint *new);
+       int     (*transition)(struct oppoint *cur, struct oppoint *new);
+       int     (*finish_transition)(struct oppoint *cur, struct oppoint *new);
+
+       void *md_data;                  /* arch dependent data */
+       struct kobject kobj;
+};
+
+
+extern struct oppoint pm_states;
+extern struct oppoint *current_state;
+extern unsigned long oppoint_compute_lpj(unsigned long ref, u_int
div, u_int mult);
+extern int register_operating_point(struct oppoint *opt);
+extern int unregister_operating_point(struct oppoint *opt);
+struct notifier_block;
+extern void oppoint_register_scale(struct notifier_block *nb, int level);
+extern void oppoint_unregister_scale(struct notifier_block *nb, int level);
+extern int oppoint_driver_scale(int level, struct oppoint *new);

 typedef int __bitwise suspend_disk_method_t;

@@ -128,7 +158,7 @@ struct pm_ops {

 extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
-extern int pm_suspend(suspend_state_t state);
+extern int pm_suspend(struct oppoint *state);


 /*
Index: linux-2.6.17/kernel/power/power.h
===================================================================
--- linux-2.6.17.orig/kernel/power/power.h
+++ linux-2.6.17/kernel/power/power.h
@@ -113,4 +113,4 @@ extern int swsusp_resume(void);
 extern int swsusp_read(void);
 extern int swsusp_write(void);
 extern void swsusp_close(void);
-extern int suspend_enter(suspend_state_t state);
+extern int suspend_enter(struct oppoint * state);
Index: linux-2.6.17/drivers/base/driver.c
===================================================================
--- linux-2.6.17.orig/drivers/base/driver.c
+++ linux-2.6.17/drivers/base/driver.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/pm.h>
 #include "base.h"

 #define to_dev(node) container_of(node, struct device, driver_list)
Index: linux-2.6.17/drivers/base/power/Makefile
===================================================================
--- linux-2.6.17.orig/drivers/base/power/Makefile
+++ linux-2.6.17/drivers/base/power/Makefile
@@ -1,4 +1,4 @@
-obj-y                  := shutdown.o
+obj-y                  := shutdown.o oppoint.o
 obj-$(CONFIG_PM)       += main.o suspend.o resume.o runtime.o sysfs.o
 obj-$(CONFIG_PM_TRACE) += trace.o

Index: linux-2.6.17/drivers/base/power/oppoint.c
===================================================================
--- /dev/null
+++ linux-2.6.17/drivers/base/power/oppoint.c
@@ -0,0 +1,74 @@
+/*
+ * oppoint.c -- OpPoint ower Management support (hotplug events and device
+ * scaling).
+ *
+ * (c) 2006 MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express or
+ * implied.
+ */
+
+#include <linux/device.h>
+#include <linux/pm.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/notifier.h>
+
+#include "power.h"
+static RAW_NOTIFIER_HEAD(oppoint_scale_notifier);
+static DECLARE_MUTEX(oppoint_scale_sem);
+
+/* This function may be called by the platform frequency scaler before
+   or after a frequency change, in order to let drivers adjust any
+   clocks or calculations for the new frequency. */
+
+int oppoint_driver_scale(int level, struct oppoint *newop)
+{
+        if (down_trylock(&oppoint_scale_sem))
+                return 1;
+
+        raw_notifier_call_chain(&oppoint_scale_notifier, level, newop);
+        up(&oppoint_scale_sem);
+       return 0;
+}
+
+void oppoint_register_scale(struct notifier_block *nb, int level)
+{
+        down(&oppoint_scale_sem);
+        raw_notifier_chain_register(&oppoint_scale_notifier, nb);
+        up(&oppoint_scale_sem);
+}
+
+void oppoint_unregister_scale(struct notifier_block *nb, int level)
+{
+        down(&oppoint_scale_sem);
+        raw_notifier_chain_unregister(&oppoint_scale_notifier, nb);
+        up(&oppoint_scale_sem);
+}
+
+EXPORT_SYMBOL(oppoint_driver_scale);
+EXPORT_SYMBOL(oppoint_register_scale);
+EXPORT_SYMBOL(oppoint_unregister_scale);
+
+unsigned long oppoint_compute_lpj(unsigned long ref, u_int div, u_int mult)
+{
+       unsigned long new_jiffy_l, new_jiffy_h;
+
+       /*
+        * Recalculate loops_per_jiffy.  We do it this way to
+        * avoid math overflow on 32-bit machines.  Maybe we
+        * should make this architecture dependent?  If you have
+        * a better way of doing this, please replace!
+        *
+        *    new = old * mult / div
+        */
+        new_jiffy_h = ref / div;
+        new_jiffy_l = (ref % div) / 100;
+        new_jiffy_h *= mult;
+        new_jiffy_l = new_jiffy_l * mult / div;
+
+        return new_jiffy_h + new_jiffy_l * 100;
+}
+EXPORT_SYMBOL(oppoint_compute_lpj);


David
>
> thanks,
>
> greg k-h
>
