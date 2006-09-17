Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWIQFHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWIQFHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIQFHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:07:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:63814 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932162AbWIQFHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:07:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=udWUjjQ4Pg2z6pvAOm1jMXg9knQpzZd+1la+ZPmLNSsGDiJKiLhaNd/dWGE4mSau2987K800EOYS/eEC97pOgUMs5qI30UOazaMVzXug4U+VZO5K3/9azVdu/dQyTi/0hD7Rk/zNlhlQRwh9rywY3a5t7emJlUdFvpO9vuMWcP4=
Message-ID: <b324b5ad0609162207o269c826cuae051ecfa61c4362@mail.gmail.com>
Date: Sat, 16 Sep 2006 22:07:15 -0700
From: "David Singleton" <daviado@gmail.com>
To: "Greg KH" <greg@kroah.com>, pavel@ucw.cz
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

Pavel and Greg,

I've incorporated Pavels suggestions and only put suspend states
in the /sys/power/state file.  The control file for frequency and
voltage operating
point transitions is now in /sys/power/operating_points/current_point.

The /sys/power/operating_points dirctory still contains the operating
points themselves, with a frequency, voltage and latency file
for each operating point.

The oppointd power manager has been changed to use the
new control file for operating points.  It has been tested on
a centrino laptop, the 4 way Xeon server and the arm-pxa27x.

I finally got SMP tested on a 4 way Xeon server.  The patch
that supports SMP Xeon's is the oppoint-x86-p4.patch in the series.

The only files in the core framework patch now are:

        kernel/power/main.c
        include/linux/pm.h
        kernel/power/power.h

The full patch set is at

        http://source.mvista.com/~dsingleton/2.6.18-rc7

The power manager source and patch is at:

        http://source.mvista.com/~dsingleton/oppointd-1.2.3

Attached is the oppoint-core.patch.

David

Signed-Off-by: David Singleton <dsingleton@mvista.com>

 include/linux/pm.h   |   30 +++-
 kernel/power/main.c  |  361 +++++++++++++++++++++++++++++++++++++++++++++------
 kernel/power/power.h |    2
 3 files changed, 350 insertions(+), 43 deletions(-)

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
@@ -131,36 +132,82 @@ int suspend_enter(suspend_state_t state)
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

+struct list_head pm_list;
+static struct oppoint standby = {
+       .name = "standby",
+       .type = PM_SUSPEND_STANDBY,
+};

+static struct oppoint mem = {
+       .name = "mem",
+       .type = PM_SUSPEND_MEM,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 150,
+};

-
-static const char * const pm_states[PM_SUSPEND_MAX] = {
-       [PM_SUSPEND_STANDBY]    = "standby",
-       [PM_SUSPEND_MEM]        = "mem",
 #ifdef CONFIG_SOFTWARE_SUSPEND
-       [PM_SUSPEND_DISK]       = "disk",
+struct oppoint disk = {
+       .name = "disk",
+       .type = PM_SUSPEND_DISK,
+};
 #endif
+
+struct oppoint pm_states = {
+       .name = "default",
+       .type = PM_FREQ_CHANGE,
 };
+struct oppoint *current_state;
+
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
+       if ((error = state->prepare_transition(current_state, state)))
+               goto out;
+
+       if ((error = state->transition(current_state, state)))
+                state = current_state;
+
+       if ((error = state->finish_transition(current_state, state)) == 0)
+               current_state = state;
+
+out:
+       printk("OpPoint: State change returned %d\n", error);
+       return error;
+}

-static inline int valid_state(suspend_state_t state)
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
@@ -168,7 +215,7 @@ static inline int valid_state(suspend_st

 /**
  *     enter_state - Do common work of entering low-power state.
- *     @state:         pm_state structure for state we're entering.
+ *     @state:         oppoint structure for state we're entering.
  *
  *     Make sure we're the only ones trying to enter a sleep state. Fail
  *     if someone has beat us to it, since we don't want anything weird to
@@ -177,7 +224,7 @@ static inline int valid_state(suspend_st
  *     we've woken up).
  */

-static int enter_state(suspend_state_t state)
+static int enter_state(struct oppoint *state)
 {
        int error;

@@ -186,16 +233,21 @@ static int enter_state(suspend_state_t s
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
@@ -211,7 +263,15 @@ static int enter_state(suspend_state_t s
  */
 int software_suspend(void)
 {
-       return enter_state(PM_SUSPEND_DISK);
+       struct oppoint *this, *next;
+       struct list_head *head = &mem.list;
+       int error = 0;
+
+       list_for_each_entry_safe(this, next, head, list) {
+               if (this->type == PM_SUSPEND_DISK)
+                       error= enter_state(this);
+       }
+       return error;
 }


@@ -223,9 +283,9 @@ int software_suspend(void)
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
@@ -248,36 +308,35 @@ decl_subsys(power,NULL,NULL);

 static ssize_t state_show(struct subsystem * subsys, char * buf)
 {
-       int i;
-       char * s = buf;
+       struct oppoint *this, *next;
+       struct list_head *head = &pm_list;
+       char *s = buf;
+
+       list_for_each_entry_safe(this, next, head, list)
+               s += sprintf(s,"%s ", this->name);

-       for (i = 0; i < PM_SUSPEND_MAX; i++) {
-               if (pm_states[i] && valid_state(i))
-                       s += sprintf(s,"%s ", pm_states[i]);
-       }
        s += sprintf(s,"\n");
+
        return (s - buf);
 }

 static ssize_t state_store(struct subsystem * subsys, const char *
buf, size_t n)
 {
-       suspend_state_t state = PM_SUSPEND_STANDBY;
-       const char * const *s;
+       struct oppoint *this, *next;
+       struct list_head *head = &mem.list;
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

@@ -292,12 +351,234 @@ static struct attribute_group attr_group
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
+static ssize_t oppoint_point_show(struct kobject * kobj, char * buf)
+{
+       ssize_t len;
+
+       len = sprintf(buf, "%s\n", current_state->name);
+
+       return len;
+}
+
+static ssize_t oppoint_point_store(struct kobject * kobj, const char * buf,
+       size_t n)
+{
+        struct oppoint *this, *next;
+        struct list_head *head = &pm_states.list;
+        char *p;
+        int error = -EINVAL;
+        int len;
+
+        p = memchr(buf, '\n', n);
+        len = p ? p - buf : n;
+        list_for_each_entry_safe(this, next, head, list) {
+                if ((strlen(this->name) == len) &&
+                   (!strncmp(this->name, buf, len))) {
+                        error = enter_state(this);
+                        break;
+                }
+        }
+        return error ? error : n;
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
+static struct oppoint_attribute point_attr = {
+        .attr   = {
+                .name = "current_point",
+                .mode = 0600,
+        },
+        .show   = oppoint_point_show,
+        .store  = oppoint_point_store,
+};
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
+
+       return 0;
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
+               sysfs_create_file(&oppoint_kobj, &point_attr.attr);
+       }
+
+
+       INIT_LIST_HEAD(&pm_states.list);
+       INIT_LIST_HEAD(&pm_list);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+       list_add(&disk.list, &pm_list);
+#endif
+       list_add(&standby.list, &pm_list);
+       list_add(&mem.list, &pm_list);
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
@@ -108,7 +109,32 @@ typedef int __bitwise suspend_state_t;
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
+       char *name;
+       unsigned int flags;
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
+extern int register_operating_point(struct oppoint *opt);
+extern int unregister_operating_point(struct oppoint *opt);
+struct notifier_block;

 typedef int __bitwise suspend_disk_method_t;

@@ -128,7 +154,7 @@ struct pm_ops {

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
