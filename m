Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263951AbSIQJih>; Tue, 17 Sep 2002 05:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263963AbSIQJig>; Tue, 17 Sep 2002 05:38:36 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:11763 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263951AbSIQJiP>; Tue, 17 Sep 2002 05:38:15 -0400
Date: Tue, 17 Sep 2002 11:31:15 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.35] CPUfreq core (1/5)
Message-ID: <20020917113115.D25385@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq core for 2.5.35
include/linux/cpufreq.h		CPUFreq header
kernel/Makefile			add cpufreq.c if necessary
kernel/cpufreq.c		CPUFreq core


diff -ruN linux-2535original/include/linux/cpufreq.h linux/include/linux/cp=
ufreq.h
--- linux-2535original/include/linux/cpufreq.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/cpufreq.h	Tue Sep 17 10:01:53 2002
@@ -0,0 +1,158 @@
+/*
+ *  linux/include/linux/cpufreq.h
+ *
+ *  Copyright (C) 2001 Russell King
+ *            (C) 2002 Dominik Brodowski <devel@brodo.de>
+ *           =20
+ *
+ * $Id: cpufreq.h,v 1.25 2002/09/14 22:42:57 rmk Exp $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _LINUX_CPUFREQ_H
+#define _LINUX_CPUFREQ_H
+
+#include <linux/config.h>
+#include <linux/notifier.h>
+#include <linux/threads.h>
+
+
+/*********************************************************************
+ *                     CPUFREQ NOTIFIER INTERFACE                    *
+ *********************************************************************/
+
+int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list=
);
+int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int li=
st);
+
+#define CPUFREQ_TRANSITION_NOTIFIER     (0)
+#define CPUFREQ_POLICY_NOTIFIER         (1)
+
+#define CPUFREQ_ALL_CPUS        ((NR_CPUS))
+
+
+/********************** cpufreq policy notifiers *********************/
+
+#define CPUFREQ_POLICY_POWERSAVE        (1)
+#define CPUFREQ_POLICY_PERFORMANCE      (2)
+
+/* values here are CPU kHz so that hardware which doesn't run with some
+ * frequencies can complain without having to guess what per cent / per
+ * mille means. */
+struct cpufreq_policy {
+	unsigned int            cpu;    /* cpu nr or CPUFREQ_ALL_CPUS */
+	unsigned int            min;    /* in kHz */
+	unsigned int            max;    /* in kHz */
+        unsigned int            policy; /* see above */
+	unsigned int            max_cpu_freq; /* for information */
+};
+
+#define CPUFREQ_ADJUST          (0)
+#define CPUFREQ_INCOMPATIBLE    (1)
+#define CPUFREQ_NOTIFY          (2)
+
+
+/******************** cpufreq transition notifiers *******************/
+
+#define CPUFREQ_PRECHANGE	(0)
+#define CPUFREQ_POSTCHANGE	(1)
+
+struct cpufreq_freqs {
+	unsigned int cpu;      /* cpu nr or CPUFREQ_ALL_CPUS */
+	unsigned int old;
+	unsigned int new;
+};
+
+
+/**
+ * cpufreq_scale - "old * mult / div" calculation for large values (32-bit=
-arch safe)
+ * @old:   old value
+ * @div:   divisor
+ * @mult:  multiplier
+ *
+ * Needed for loops_per_jiffy and similar calculations.  We do it=20
+ * this way to avoid math overflow on 32-bit machines.  This will
+ * become architecture dependent once high-resolution-timer is
+ * merged (or any other thing that introduces sc_math.h).
+ *
+ *    new =3D old * mult / div
+ */
+static inline unsigned long cpufreq_scale(unsigned long old, u_int div, u_=
int mult)
+{
+	unsigned long val, carry;
+
+	mult /=3D 100;
+	div  /=3D 100;
+        val   =3D (old / div) * mult;
+        carry =3D old % div;
+	carry =3D carry * mult / div;
+
+	return carry + val;
+};
+
+
+/*********************************************************************
+ *                      DYNAMIC CPUFREQ INTERFACE                    *
+ *********************************************************************/
+#ifdef CONFIG_CPU_FREQ_DYNAMIC
+/* TBD */
+#endif /* CONFIG_CPU_FREQ_DYNAMIC */
+
+
+/*********************************************************************
+ *                      CPUFREQ DRIVER INTERFACE                     *
+ *********************************************************************/
+
+typedef void (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
+
+struct cpufreq_driver {
+	/* needed by all drivers */
+	cpufreq_policy_t        verify;
+	cpufreq_policy_t        setpolicy;
+	struct cpufreq_policy   *policy;
+#ifdef CONFIG_CPU_FREQ_DYNAMIC
+	/* TBD */
+#endif
+	/* 2.4. compatible API */
+#ifdef CONFIG_CPU_FREQ_24_API
+	unsigned int            cpu_min_freq;
+	unsigned int            cpu_cur_freq[NR_CPUS];
+#endif
+};
+
+int cpufreq_register(struct cpufreq_driver *driver_data);
+int cpufreq_unregister(void);
+
+void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int s=
tate);
+
+
+static inline void cpufreq_verify_within_limits(struct cpufreq_policy *pol=
icy, unsigned int min, unsigned int max)=20
+{
+	if (policy->min < min)
+		policy->min =3D min;
+	if (policy->max < min)
+		policy->max =3D min;
+	if (policy->min > max)
+		policy->min =3D max;
+	if (policy->max > max)
+		policy->max =3D max;
+	if (policy->min > policy->max)
+		policy->min =3D policy->max;
+	return;
+}
+
+/*********************************************************************
+ *                        CPUFREQ 2.6. INTERFACE                     *
+ *********************************************************************/
+int cpufreq_set_policy(struct cpufreq_policy *policy);
+int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
+
+#ifdef CONFIG_CPU_FREQ_26_API
+#ifdef CONFIG_PM
+int cpufreq_restore(void);
+#endif
+#endif
+
+
+#endif /* _LINUX_CPUFREQ_H */
diff -ruN linux-2535original/kernel/Makefile linux/kernel/Makefile
--- linux-2535original/kernel/Makefile	Tue Sep 17 09:24:04 2002
+++ linux/kernel/Makefile	Tue Sep 17 09:30:59 2002
@@ -10,7 +10,7 @@
 O_TARGET :=3D kernel.o
=20
 export-objs =3D signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o=
 \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o cpufreq.o
=20
 obj-y     =3D sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -22,6 +22,7 @@
 obj-$(CONFIG_UID16) +=3D uid16.o
 obj-$(CONFIG_MODULES) +=3D ksyms.o
 obj-$(CONFIG_PM) +=3D pm.o
+obj-$(CONFIG_CPU_FREQ) +=3D cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) +=3D acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) +=3D suspend.o
=20
diff -ruN linux-2535original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-2535original/kernel/cpufreq.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/cpufreq.c	Tue Sep 17 10:29:16 2002
@@ -0,0 +1,678 @@
+/*
+ *  linux/kernel/cpufreq.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *            (C) 2002 Dominik Brodowski <devel@brodo.de>
+ *
+ *  $Id: cpufreq.c,v 1.42 2002/09/07 21:42:07 db Exp $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/ctype.h>
+
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_CPU_FREQ_26_API
+#include <linux/proc_fs.h>
+#endif
+
+
+
+/**
+ * The "cpufreq driver" - the arch- or hardware-dependend low
+ * level driver of CPUFreq support, and its locking mutex.=20
+ * cpu_max_freq is in kHz.
+ */
+static struct cpufreq_driver   	*cpufreq_driver;
+static DECLARE_MUTEX            (cpufreq_driver_sem);
+
+
+/**
+ * Two notifier lists: the "policy" list is involved in the=20
+ * validation process for a new CPU frequency policy; the=20
+ * "transition" list for kernel code that needs to handle
+ * changes to devices when the CPU clock speed changes.
+ * The mutex locks both lists. If both cpufreq_driver_sem
+ * and cpufreq_notifier_sem need to be hold, get cpufreq_driver_sem
+ * first.
+ */
+static struct notifier_block    *cpufreq_policy_notifier_list;
+static struct notifier_block    *cpufreq_transition_notifier_list;
+static DECLARE_MUTEX            (cpufreq_notifier_sem);
+
+
+/**
+ * The cpufreq default policy. Can be set by a "cpufreq=3D..." command
+ * line option.
+ */
+static struct cpufreq_policy default_policy =3D {
+	.cpu    =3D CPUFREQ_ALL_CPUS,
+	.min    =3D 0,
+	.max    =3D 0,
+	.policy =3D 0,
+};
+
+
+
+/*********************************************************************
+ *                              2.6. API                             *
+ *********************************************************************/
+
+/**
+ * cpufreq_parse_policy - parse a policy string
+ * @input_string: the string to parse.
+ * @policy: the policy written inside input_string
+ *
+ * This function parses a "policy string" - something the user echo'es into
+ * /proc/cpufreq or gives as boot parameter - into a struct cpufreq_policy.
+ * If there are invalid/missing entries, they are replaced with current
+ * cpufreq policy.
+ */
+static int cpufreq_parse_policy(char input_string[42], struct cpufreq_poli=
cy *policy)
+{
+	unsigned int            min =3D 0;
+	unsigned int            max =3D 0;
+	unsigned int            cpu =3D 0;
+	char			policy_string[42] =3D {'\0'};
+	struct cpufreq_policy   current_policy;
+	unsigned int            result =3D -EFAULT;
+	unsigned int            i =3D 0;
+
+	if (!policy)
+		return -EINVAL;
+
+	policy->min =3D 0;
+	policy->max =3D 0;
+	policy->policy =3D 0;
+	policy->cpu =3D CPUFREQ_ALL_CPUS;
+
+	if (sscanf(input_string, "%d:%d:%d:%s", &cpu, &min, &max, policy_string) =
=3D=3D 4)=20
+	{
+		policy->min =3D min;
+		policy->max =3D max;
+		policy->cpu =3D cpu;
+		result =3D 0;
+		goto scan_policy;
+	}
+	if (sscanf(input_string, "%d%%%d%%%d%%%s", &cpu, &min, &max, policy_strin=
g) =3D=3D 4)
+	{
+		if (!cpufreq_get_policy(&current_policy, cpu)) {
+			policy->min =3D (min * current_policy.max_cpu_freq) / 100;
+			policy->max =3D (max * current_policy.max_cpu_freq) / 100;
+			policy->cpu =3D cpu;
+			result =3D 0;
+			goto scan_policy;
+		}
+	}
+
+	if (sscanf(input_string, "%d:%d:%s", &min, &max, policy_string) =3D=3D 3)=
=20
+	{
+		policy->min =3D min;
+		policy->max =3D max;
+		result =3D 0;
+		goto scan_policy;
+	}
+
+	if (sscanf(input_string, "%d%%%d%%%s", &min, &max, policy_string) =3D=3D =
3)
+	{
+		if (!cpufreq_get_policy(&current_policy, cpu)) {
+			policy->min =3D (min * current_policy.max_cpu_freq) / 100;
+			policy->max =3D (max * current_policy.max_cpu_freq) / 100;
+			result =3D 0;
+			goto scan_policy;
+		}
+	}
+
+	return -EINVAL;
+
+scan_policy:
+
+	for (i=3D0;i<sizeof(policy_string);i++){
+		if (policy_string[i]=3D=3D'\0')
+			break;
+		policy_string[i] =3D tolower(policy_string[i]);
+	}
+
+	if (!strncmp(policy_string, "powersave", 6) || =20
+            !strncmp(policy_string, "eco", 3) ||      =20
+	    !strncmp(policy_string, "batter", 6) ||
+	    !strncmp(policy_string, "low", 3))=20
+	{
+		result =3D 0;
+		policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
+	}
+	else if (!strncmp(policy_string, "performance",6) ||
+	    !strncmp(policy_string, "high",4) ||
+	    !strncmp(policy_string, "full",4))
+	{
+		result =3D 0;
+		policy->policy =3D CPUFREQ_POLICY_PERFORMANCE;
+	}
+	else if (!cpufreq_get_policy(&current_policy, policy->cpu))
+	{
+		policy->policy =3D current_policy.policy;
+	}
+	else
+	{
+		policy->policy =3D 0;
+	}
+
+	return result;
+}
+
+
+/*
+ * cpufreq command line parameter.  Must be hard values (kHz)
+ *  cpufreq=3D1000000:2000000:PERFORMANCE  =20
+ * to set the default CPUFreq policy.
+ */
+static int __init cpufreq_setup(char *str)
+{
+	cpufreq_parse_policy(str, &default_policy);
+	default_policy.cpu =3D CPUFREQ_ALL_CPUS;
+	return 1;
+}
+__setup("cpufreq=3D", cpufreq_setup);
+
+
+#ifdef CONFIG_CPU_FREQ_26_API
+#ifdef CONFIG_PROC_FS
+
+/**
+ * cpufreq_proc_read - read /proc/cpufreq
+ *
+ * This function prints out the current cpufreq policy.
+ */
+static int cpufreq_proc_read (
+	char			*page,
+	char			**start,
+	off_t			off,
+	int 			count,
+	int 			*eof,
+	void			*data)
+{
+	char			*p =3D page;
+	int			len =3D 0;
+	struct cpufreq_policy   policy;
+	unsigned int            min_pctg =3D 0;
+	unsigned int            max_pctg =3D 0;
+	unsigned int            i =3D 0;
+
+	if (off !=3D 0)
+		goto end;
+
+	p +=3D sprintf(p, "          minimum CPU frequency  -  maximum CPU freque=
ncy  -  policy\n");
+	for (i=3D0;i<NR_CPUS;i++) {
+		if (!cpu_online(i))
+			continue;
+
+		cpufreq_get_policy(&policy, i);
+		min_pctg =3D (policy.min * 100) / policy.max_cpu_freq;
+		max_pctg =3D (policy.max * 100) / policy.max_cpu_freq;
+
+		p +=3D sprintf(p, "CPU%3d    %9d kHz (%3d %%)  -  %9d kHz (%3d %%)  -  ",
+			     i , policy.min, min_pctg, policy.max, max_pctg);
+		switch (policy.policy) {
+		case CPUFREQ_POLICY_POWERSAVE:
+			p +=3D sprintf(p, "powersave\n");
+			break;
+		case CPUFREQ_POLICY_PERFORMANCE:
+			p +=3D sprintf(p, "performance\n");
+			break;
+		default:
+			p +=3D sprintf(p, "INVALID\n");
+			break;
+		}
+	}
+end:
+	len =3D (p - page);
+	if (len <=3D off+count)=20
+		*eof =3D 1;
+	*start =3D page + off;
+	len -=3D off;
+	if (len>count)=20
+		len =3D count;
+	if (len<0)=20
+		len =3D 0;
+
+	return len;
+}
+
+
+/**
+ * cpufreq_proc_write - handles writing into /proc/cpufreq
+ *
+ * This function calls the parsing script and then sets the policy
+ * accordingly.
+ */
+static int cpufreq_proc_write (
+        struct file		*file,
+        const char		*buffer,
+        unsigned long		count,
+        void			*data)
+{
+	int                     result =3D 0;
+	char			proc_string[42] =3D {'\0'};
+	struct cpufreq_policy   policy;
+
+
+	if ((count > sizeof(proc_string) - 1))
+		return -EINVAL;
+=09
+	if (copy_from_user(proc_string, buffer, count))
+		return -EFAULT;
+=09
+	proc_string[count] =3D '\0';
+
+	result =3D cpufreq_parse_policy(proc_string, &policy);
+	if (result)
+		return -EFAULT;
+
+	cpufreq_set_policy(&policy);
+
+	return count;
+}
+
+
+/**
+ * cpufreq_proc_init - add "cpufreq" to the /proc root directory
+ *
+ * This function adds "cpufreq" to the /proc root directory.
+ */
+static unsigned int cpufreq_proc_init (void)
+{
+	struct proc_dir_entry *entry =3D NULL;
+
+        /* are these acceptable values? */
+	entry =3D create_proc_entry("cpufreq", S_IFREG|S_IRUGO|S_IWUSR,=20
+				  &proc_root);
+
+	if (!entry) {
+		printk(KERN_ERR "unable to create /proc/cpufreq entry\n");
+		return -EIO;
+	} else {
+		entry->read_proc =3D cpufreq_proc_read;
+		entry->write_proc =3D cpufreq_proc_write;
+	}
+
+	return 0;
+}
+
+
+/**
+ * cpufreq_proc_exit - removes "cpufreq" from the /proc root directory.
+ *
+ * This function removes "cpufreq" from the /proc root directory.
+ */
+static void cpufreq_proc_exit (void)
+{
+	remove_proc_entry("cpufreq", &proc_root);
+	return;
+}
+#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_CPU_FREQ_26_API */
+
+
+
+/*********************************************************************
+ *                     NOTIFIER LISTS INTERFACE                      *
+ *********************************************************************/
+
+/**
+ *	cpufreq_register_notifier - register a driver with cpufreq
+ *	@nb: notifier function to register
+ *      @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER
+ *
+ *	Add a driver to one of two lists: either a list of drivers that=20
+ *      are notified about clock rate changes (once before and once after
+ *      the transition), or a list of drivers that are notified about
+ *      changes in cpufreq policy.
+ *
+ *	This function may sleep, and has the same return conditions as
+ *	notifier_chain_register.
+ */
+int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
+{
+	int ret;
+
+	down(&cpufreq_notifier_sem);
+	switch (list) {
+	case CPUFREQ_TRANSITION_NOTIFIER:
+		ret =3D notifier_chain_register(&cpufreq_transition_notifier_list, nb);
+		break;
+	case CPUFREQ_POLICY_NOTIFIER:
+		ret =3D notifier_chain_register(&cpufreq_policy_notifier_list, nb);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+	up(&cpufreq_notifier_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpufreq_register_notifier);
+
+
+/**
+ *	cpufreq_unregister_notifier - unregister a driver with cpufreq
+ *	@nb: notifier block to be unregistered
+ *      @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER
+ *
+ *	Remove a driver from the CPU frequency notifier list.
+ *
+ *	This function may sleep, and has the same return conditions as
+ *	notifier_chain_unregister.
+ */
+int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int li=
st)
+{
+	int ret;
+
+	down(&cpufreq_notifier_sem);
+	switch (list) {
+	case CPUFREQ_TRANSITION_NOTIFIER:
+		ret =3D notifier_chain_unregister(&cpufreq_transition_notifier_list, nb);
+		break;
+	case CPUFREQ_POLICY_NOTIFIER:
+		ret =3D notifier_chain_unregister(&cpufreq_policy_notifier_list, nb);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+	up(&cpufreq_notifier_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpufreq_unregister_notifier);
+
+
+
+/*********************************************************************
+ *                          POLICY INTERFACE                         *
+ *********************************************************************/
+
+/**
+ * cpufreq_get_policy - get the current cpufreq_policy
+ * @policy: struct cpufreq_policy into which the current cpufreq_policy is=
 written
+ *
+ * Reads the current cpufreq policy.
+ */
+int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
+{
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver  || !policy ||=20
+	    (cpu >=3D NR_CPUS) || (!cpu_online(cpu))) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+=09
+	policy->min    =3D cpufreq_driver->policy[cpu].min;
+	policy->max    =3D cpufreq_driver->policy[cpu].max;
+	policy->policy =3D cpufreq_driver->policy[cpu].policy;
+	policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
+	policy->cpu    =3D cpu;
+
+	up(&cpufreq_driver_sem);
+
+	return 0;
+}
+
+
+/**
+ *	cpufreq_set_policy - set a new CPUFreq policy
+ *	@policy: policy to be set.
+ *
+ *	Sets a new CPU frequency and voltage scaling policy.
+ */
+int cpufreq_set_policy(struct cpufreq_policy *policy)
+{
+	unsigned int i;
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver || !cpufreq_driver->verify ||=20
+	    !cpufreq_driver->setpolicy || !policy ||
+	    (policy->cpu > NR_CPUS)) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+
+	down(&cpufreq_notifier_sem);
+
+	policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
+
+	/* verify the cpu speed can be set within this limit */
+	cpufreq_driver->verify(policy);
+
+	/* adjust if neccessary - all reasons */
+	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_ADJUST,
+			    policy);
+
+	/* adjust if neccessary - hardware incompatibility*/
+	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_INCOMPATIBLE,
+			    policy);
+
+	/* verify the cpu speed can be set within this limit,
+	   which might be different to the first one */
+	cpufreq_driver->verify(policy);
+
+	/* notification of the new policy */
+	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_NOTIFY,
+			    policy);
+
+	up(&cpufreq_notifier_sem);
+
+	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS) {
+		for (i=3D0;i<NR_CPUS;i++) {
+			cpufreq_driver->policy[i].min    =3D policy->min;
+			cpufreq_driver->policy[i].max    =3D policy->max;
+			cpufreq_driver->policy[i].policy =3D policy->policy;
+		}=20
+	} else {
+		cpufreq_driver->policy[policy->cpu].min    =3D policy->min;
+		cpufreq_driver->policy[policy->cpu].max    =3D policy->max;
+		cpufreq_driver->policy[policy->cpu].policy =3D policy->policy;
+	}
+=09
+	cpufreq_driver->setpolicy(policy);
+=09
+	up(&cpufreq_driver_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL(cpufreq_set_policy);
+
+
+
+/*********************************************************************
+ *                    DYNAMIC CPUFREQ SWITCHING                      *
+ *********************************************************************/
+#ifdef CONFIG_CPU_FREQ_DYNAMIC
+/* TBD */
+#endif /* CONFIG_CPU_FREQ_DYNAMIC */
+
+
+
+/*********************************************************************
+ *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
+ *********************************************************************/
+
+/**
+ * adjust_jiffies - adjust the system "loops_per_jiffy"
+ *
+ * This function alters the system "loops_per_jiffy" for the clock
+ * speed change. Note that loops_per_jiffy is only updated if all
+ * CPUs are affected - else there is a need for per-CPU loops_per_jiffy
+ * values which are provided by various architectures.=20
+ */
+static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs =
*ci)
+{
+	if ((val =3D=3D CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
+	    (val =3D=3D CPUFREQ_POSTCHANGE && ci->old > ci->new))
+		if (ci->cpu =3D=3D CPUFREQ_ALL_CPUS)
+			loops_per_jiffy =3D cpufreq_scale(loops_per_jiffy, ci->old, ci->new);
+}
+
+
+/**
+ * cpufreq_notify_transition - call notifier chain and adjust_jiffies on f=
requency transition
+ *
+ * This function calls the transition notifiers and the "adjust_jiffies" f=
unction. It is called
+ * twice on all CPU frequency changes that have external effects.=20
+ */
+void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int s=
tate)
+{
+	down(&cpufreq_notifier_sem);
+	switch (state) {
+	case CPUFREQ_PRECHANGE:
+		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_PRECHANGE=
, freqs);
+		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);	=09
+		break;
+	case CPUFREQ_POSTCHANGE:
+		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
+		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANG=
E, freqs);
+		break;
+	}
+	up(&cpufreq_notifier_sem);
+}
+EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
+
+
+
+/*********************************************************************
+ *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
+ *********************************************************************/
+
+/**
+ * cpufreq_register - register a CPU Frequency driver
+ * @driver_data: A struct cpufreq_driver containing the values submitted b=
y the CPU Frequency driver.
+ *
+ *   Registers a CPU Frequency driver to this core code. This code=20
+ * returns zero on success, -EBUSY when another driver got here first
+ * (and isn't unregistered in the meantime).=20
+ *
+ */
+int cpufreq_register(struct cpufreq_driver *driver_data)
+{
+	unsigned int            ret;
+
+	if (cpufreq_driver)
+		return -EBUSY;
+=09
+	if (!driver_data || !driver_data->verify ||=20
+	    !driver_data->setpolicy)
+		return -EINVAL;
+
+	down(&cpufreq_driver_sem);
+	cpufreq_driver        =3D driver_data;
+=09
+	if (!default_policy.policy)
+		default_policy.policy =3D driver_data->policy[0].policy;
+	if (!default_policy.min)
+		default_policy.min =3D driver_data->policy[0].min;
+	if (!default_policy.max)
+		default_policy.max =3D driver_data->policy[0].max;
+	default_policy.cpu =3D CPUFREQ_ALL_CPUS;
+
+	up(&cpufreq_driver_sem);
+
+	ret =3D cpufreq_set_policy(&default_policy);
+
+#ifdef CONFIG_CPU_FREQ_26_API
+	cpufreq_proc_init();
+#endif
+
+	if (ret) {
+		down(&cpufreq_driver_sem);
+		cpufreq_driver =3D NULL;
+		up(&cpufreq_driver_sem);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_register);
+
+
+/**
+ * cpufreq_unregister - unregister the current CPUFreq driver
+ *
+ *    Unregister the current CPUFreq driver. Only call this if you have=20
+ * the right to do so, i.e. if you have succeeded in initialising before!
+ * Returns zero if successful, and -EINVAL if the cpufreq_driver is
+ * currently not initialised.
+ */
+int cpufreq_unregister(void)
+{
+	down(&cpufreq_driver_sem);
+
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+
+	cpufreq_driver =3D NULL;
+
+	up(&cpufreq_driver_sem);
+
+#ifdef CONFIG_CPU_FREQ_26_API
+	cpufreq_proc_exit();
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_unregister);
+
+
+#ifdef CONFIG_PM
+/**
+ *	cpufreq_restore - restore the CPU clock frequency after resume
+ *
+ *	Restore the CPU clock frequency so that our idea of the current
+ *	frequency reflects the actual hardware.
+ */
+int cpufreq_restore(void)
+{
+	struct cpufreq_policy policy;
+	unsigned int i;
+
+	if (in_interrupt())
+		panic("cpufreq_restore() called from interrupt context!");
+
+	for (i=3D0;i<NR_CPUS;i++) {
+		if (!cpu_online(i))
+			continue;
+
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return 0;
+		}
+=09
+		policy.min    =3D cpufreq_driver->policy[i].min;
+		policy.max    =3D cpufreq_driver->policy[i].max;
+		policy.policy =3D cpufreq_driver->policy[i].policy;
+		policy.cpu    =3D i;
+		up(&cpufreq_driver_sem);
+
+#ifdef CONFIG_CPU_FREQ_26_API
+		cpufreq_set_policy(&policy);
+#endif
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_restore);
+#else
+#define cpufreq_restore()
+#endif /* CONFIG_PM */
+

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9hvZiZ8MDCHJbN8YRAnl8AJ9VtrRI6O2VCvQbeYm3YSMfKP/N7wCeKYkf
wHrYdiwOc9HiXYdFYF+h32g=
=1BUO
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
