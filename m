Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUKGIft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUKGIft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 03:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUKGIft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 03:35:49 -0500
Received: from mk-smarthost-1.mail.uk.tiscali.com ([212.74.114.37]:10771 "EHLO
	mk-smarthost-1.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id S261559AbUKGIdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 03:33:05 -0500
Date: Sun, 7 Nov 2004 08:32:25 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq_ondemand tweaks (round two)
Message-ID: <20041107083225.GA17793@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi All,

After listening to all your points a couple of weeks back I found the time =
to
break up my patches to 'ondemand' into three smaller patches and my clean my
tweaks up a little.  I also went ahead with the suggestion to create a
completely new governor ('conservative', better name suggestions welcome)
which has the major alteration so that the change in frequency is made
gradually in both directions; this, I feel, being much more suitable for
battery powered environments.

I also included the relevant cleanup code by Adrian Bunk ([2.6 patch] small
cpufreq cleanup 2004-10-30 7:22:46) into the conservative governor.

As a side note, Venkatesh might want to consider dropping the default
sampling rate an order of magnitude as on my laptop its constantly flicking
between min and max and is a bit too trigger happy whilst the cpu use at
around 5%; for me at least.  Bruno Ducrot pointed out that the amd64's "do
have unacceptable latency between min and max freq transition, due to the
step-by-step requirements (200MHz IIRC)".  For me its just a a cosmetic
annoyance in /proc/cpuinfo :)

Let me know what you think.

Regards

Alex

------------------------------------------
01_ignore-nice.diff
-------------------
Adds support so that you can choose to consider (default) or ignore 'nice'ed
processes.

02_check-rate-and-break-out.diff
--------------------------------
If it is decided that cpu needs to be sped up a notch but yet the cpu frequ=
ency
is already at max (or reduce speed but already at its lowest frequency) the=
n we
break out without wasting cpu cycles and (possible?) latency issues attempt=
ing
to make changes that have no effect.

03_sys_freq_step.diff
---------------------
the step down frequency is now tweakable through /sys.  It takes an unsigne=
d int
between zero and (((max - min) * 100) / max), the percentage equal to the
difference between min and max.  The advantage of this is that all the divi=
sions
are moved out of the main loop when it comes to working out whas frequency =
in
khz the cpu should be lowered by.
------------------------------

--=20
 ________________________________________=20
/ Nullum magnum ingenium sine mixtura    \
| dementiae fuit.                        |
|                                        |
| [There is no great genius without some |
| touch of madness.]                     |
|                                        |
\ -- Seneca                              /
 ----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_ignore-nice.diff"
Content-Transfer-Encoding: quoted-printable

diff -u -U 2 -r -N -d linux-2.6.9.orig/drivers/cpufreq/cpufreq_ondemand.c l=
inux-2.6.9/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.9.orig/drivers/cpufreq/cpufreq_ondemand.c	2004-10-18 22:55:27=
=2E000000000 +0100
+++ linux-2.6.9/drivers/cpufreq/cpufreq_ondemand.c	2004-11-06 13:08:46.0000=
00000 +0000
@@ -81,6 +81,7 @@
 	unsigned int		sampling_down_factor;
 	unsigned int		up_threshold;
 	unsigned int		down_threshold;
+	unsigned int		ignore_nice;
 };
=20
 struct dbs_tuners dbs_tuners_ins =3D {
@@ -120,6 +121,7 @@
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
 show_one(down_threshold, down_threshold);
+show_one(ignore_nice, ignore_nice);
=20
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
 		const char *buf, size_t count)
@@ -189,6 +191,22 @@
 	return count;
 }
=20
+static ssize_t store_ignore_nice(struct cpufreq_policy *unused,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if ( ret =3D=3D 1 ) {
+		if ( input > 1 )
+			input =3D 1;
+		dbs_tuners_ins.ignore_nice =3D input;
+	}
+	up(&dbs_sem);
+	return count;
+}
+
 #define define_one_rw(_name) 					\
 static struct freq_attr _name =3D { 				\
 	.attr =3D { .name =3D __stringify(_name), .mode =3D 0644 }, 	\
@@ -200,6 +218,7 @@
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
+define_one_rw(ignore_nice);
=20
 static struct attribute * dbs_attributes[] =3D {
 	&sampling_rate_max.attr,
@@ -208,6 +227,7 @@
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
 	&down_threshold.attr,
+	&ignore_nice.attr,
 	NULL
 };
=20
@@ -247,6 +267,10 @@
 	/* Check for frequency increase */
 	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait;
+	/* consider 'nice' tasks as 'idle' time too if required */
+	if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
+=09
 	idle_ticks =3D total_idle_ticks -
 		this_dbs_info->prev_cpu_idle_up;
 	this_dbs_info->prev_cpu_idle_up =3D total_idle_ticks;
@@ -346,10 +370,12 @@
 	=09
 		this_dbs_info->prev_cpu_idle_up =3D=20
 				kstat_cpu(cpu).cpustat.idle +
-				kstat_cpu(cpu).cpustat.iowait;
+				kstat_cpu(cpu).cpustat.iowait +
+				kstat_cpu(cpu).cpustat.nice;
 		this_dbs_info->prev_cpu_idle_down =3D=20
 				kstat_cpu(cpu).cpustat.idle +
-				kstat_cpu(cpu).cpustat.iowait;
+				kstat_cpu(cpu).cpustat.iowait +
+				kstat_cpu(cpu).cpustat.nice;
 		this_dbs_info->enable =3D 1;
 		sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable++;
@@ -368,6 +394,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
+			dbs_tuners_ins.ignore_nice =3D 0;
=20
 			dbs_timer_init();
 		}

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02_check-rate-and-break-out.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.9.orig/drivers/cpufreq/cpufreq_ondemand.c	2004-11-06 22:13:49=
=2E000000000 +0000
+++ linux-2.6.9/drivers/cpufreq/cpufreq_ondemand.c	2004-11-06 22:13:16.0000=
00000 +0000
@@ -281,6 +281,9 @@
 			sampling_rate_in_HZ(dbs_tuners_ins.sampling_rate);
=20
 	if (idle_ticks < up_idle_ticks) {
+		if (this_dbs_info->cur_policy->cur
+				=3D=3D this_dbs_info->cur_policy->max)
+			return;
 		__cpufreq_driver_target(this_dbs_info->cur_policy,
 			this_dbs_info->cur_policy->max,=20
 			CPUFREQ_RELATION_H);
@@ -307,6 +310,9 @@
 			sampling_rate_in_HZ(freq_down_sampling_rate);
=20
 	if (idle_ticks > down_idle_ticks ) {
+		if (this_dbs_info->cur_policy->cur
+				=3D=3D this_dbs_info->cur_policy->min)
+			return;
 		freq_down_step =3D (5 * this_dbs_info->cur_policy->max) / 100;
=20
 		/* max freq cannot be less than 100. But who knows.... */

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="03_sys_freq_step.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.9.orig/drivers/cpufreq/cpufreq_ondemand.c	2004-11-06 23:15:57=
=2E000000000 +0000
+++ linux-2.6.9/drivers/cpufreq/cpufreq_ondemand.c	2004-11-06 23:16:20.0000=
00000 +0000
@@ -82,6 +82,7 @@
 	unsigned int		up_threshold;
 	unsigned int		down_threshold;
 	unsigned int		ignore_nice;
+	unsigned int		freq_step;
 };
=20
 struct dbs_tuners dbs_tuners_ins =3D {
@@ -123,6 +124,13 @@
 show_one(down_threshold, down_threshold);
 show_one(ignore_nice, ignore_nice);
=20
+static ssize_t show_freq_step(struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int percent =3D (dbs_tuners_ins.freq_step * 100) / policy->max;
+
+	return sprintf (buf, "%u\n", percent);
+}
+
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
 		const char *buf, size_t count)
 {
@@ -207,6 +215,29 @@
 	return count;
 }
=20
+static ssize_t store_freq_step(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	unsigned int freq_step =3D dbs_tuners_ins.freq_step;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if ( ret =3D=3D 1 ) {
+		if (input > (((policy->max - policy->min) * 100)
+					/ policy->max)) {
+			freq_step =3D policy->max - policy->min;
+		} else {
+			/* no need to test here if freq_step is zero as the user
+			 * might actually want this */
+			freq_step =3D (input * policy->max) / 100;
+		}
+		dbs_tuners_ins.freq_step =3D freq_step;
+	}
+	up(&dbs_sem);
+	return count;
+}
+
 #define define_one_rw(_name) 					\
 static struct freq_attr _name =3D { 				\
 	.attr =3D { .name =3D __stringify(_name), .mode =3D 0644 }, 	\
@@ -219,6 +250,7 @@
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
 define_one_rw(ignore_nice);
+define_one_rw(freq_step);
=20
 static struct attribute * dbs_attributes[] =3D {
 	&sampling_rate_max.attr,
@@ -228,6 +260,7 @@
 	&up_threshold.attr,
 	&down_threshold.attr,
 	&ignore_nice.attr,
+	&freq_step.attr,
 	NULL
 };
=20
@@ -242,7 +275,6 @@
 {
 	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
 	unsigned int total_idle_ticks;
-	unsigned int freq_down_step;
 	unsigned int freq_down_sampling_rate;
 	static int down_skip[NR_CPUS];
 	struct cpu_dbs_info_s *this_dbs_info;
@@ -262,7 +294,7 @@
 	 *
 	 * Any frequency increase takes it to the maximum frequency.=20
 	 * Frequency reduction happens at minimum steps of=20
-	 * 5% of max_frequency=20
+	 * 5% (default) of max_frequency=20
 	 */
 	/* Check for frequency increase */
 	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
@@ -313,14 +345,10 @@
 		if (this_dbs_info->cur_policy->cur
 				=3D=3D this_dbs_info->cur_policy->min)
 			return;
-		freq_down_step =3D (5 * this_dbs_info->cur_policy->max) / 100;
-
-		/* max freq cannot be less than 100. But who knows.... */
-		if (unlikely(freq_down_step =3D=3D 0))
-			freq_down_step =3D 5;
=20
 		__cpufreq_driver_target(this_dbs_info->cur_policy,
-			this_dbs_info->cur_policy->cur - freq_down_step,=20
+			this_dbs_info->cur_policy->cur
+				- dbs_tuners_ins.freq_step,
 			CPUFREQ_RELATION_H);
 		return;
 	}
@@ -401,7 +429,12 @@
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
 			dbs_tuners_ins.ignore_nice =3D 0;
-
+			dbs_tuners_ins.freq_step =3D (5 * policy->max ) / 100;
+		=09
+			/* max freq cannot be less than 100. But who knows... */
+			if (unlikely(dbs_tuners_ins.freq_step =3D=3D 0))
+				dbs_tuners_ins.freq_step =3D 5;
+		=09
 			dbs_timer_init();
 		}
 	=09

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_conservative.diff"
Content-Transfer-Encoding: quoted-printable

diff -u -U 2 -r -N -d linux-2.6.9.orig/drivers/cpufreq/cpufreq_conservative=
=2Ec linux-2.6.9/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.9.orig/drivers/cpufreq/cpufreq_conservative.c	1970-01-01 01:0=
0:00.000000000 +0100
+++ linux-2.6.9/drivers/cpufreq/cpufreq_conservative.c	2004-11-07 08:05:56.=
000000000 +0000
@@ -0,0 +1,525 @@
+/*
+ *  drivers/cpufreq/cpufreq_conservative.c
+ *
+ *  Copyright (C)  2001 Russell King
+ *            (C)  2003 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com=
>.
+ *                      Jun Nakajima <jun.nakajima@intel.com>
+ *            (C)  2004 Alexander Clouter <alex-kernel@digriz.org.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ctype.h>
+#include <linux/cpufreq.h>
+#include <linux/sysctl.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/sysfs.h>
+#include <linux/sched.h>
+#include <linux/kmod.h>
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>
+#include <linux/config.h>
+#include <linux/kernel_stat.h>
+#include <linux/percpu.h>
+
+/*
+ * dbs is used in this file as a shortform for demandbased switching
+ * It helps to keep variable names smaller, simpler
+ */
+
+#define DEF_FREQUENCY_UP_THRESHOLD		(80)
+#define MIN_FREQUENCY_UP_THRESHOLD		(0)
+#define MAX_FREQUENCY_UP_THRESHOLD		(100)
+
+#define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
+#define MIN_FREQUENCY_DOWN_THRESHOLD		(0)
+#define MAX_FREQUENCY_DOWN_THRESHOLD		(100)
+
+/*=20
+ * The polling frequency of this governor depends on the capability of=20
+ * the processor. Default polling frequency is 50000 times the transition
+ * latency of the processor. The governor will work on any processor with=
=20
+ * transition latency <=3D 10mS, using appropriate sampling=20
+ * rate.
+ * For CPUs with transition latency > 10mS (mostly drivers with CPUFREQ_ET=
ERNAL)
+ * this governor will not work.
+ * All times here are in uS.
+ */
+static unsigned int 				def_sampling_rate;
+#define MIN_SAMPLING_RATE			(def_sampling_rate / 2)
+#define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
+#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
+#define DEF_SAMPLING_DOWN_FACTOR		(5)
+#define TRANSITION_LATENCY_LIMIT		(10 * 1000)
+#define sampling_rate_in_HZ(x)			(((x * HZ) < (1000 * 1000))?1:((x * HZ) /=
 (1000 * 1000)))
+
+static void do_dbs_timer(void *data);
+
+struct cpu_dbs_info_s {
+	struct cpufreq_policy 	*cur_policy;
+	unsigned int 		prev_cpu_ticks;
+	unsigned int 		prev_cpu_idle_ticks;
+	unsigned int 		enable;
+};
+static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
+
+static unsigned int dbs_enable;	/* number of CPUs using this policy */
+
+static DECLARE_MUTEX 	(dbs_sem);
+static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
+
+struct dbs_tuners {
+	unsigned int 		sampling_rate;
+	unsigned int		sampling_down_factor;
+	unsigned int		up_threshold;
+	unsigned int		down_threshold;
+	unsigned int		requested_freq;
+	unsigned int		ignore_nice;
+	unsigned int		freq_step;
+};
+
+struct dbs_tuners dbs_tuners_ins =3D {
+	.up_threshold 		=3D DEF_FREQUENCY_UP_THRESHOLD,
+	.down_threshold 	=3D DEF_FREQUENCY_DOWN_THRESHOLD,
+	.sampling_down_factor 	=3D DEF_SAMPLING_DOWN_FACTOR,
+};
+
+/************************** sysfs interface ************************/
+static ssize_t show_sampling_rate_max(struct cpufreq_policy *policy, char =
*buf)
+{
+	return sprintf (buf, "%u\n", MAX_SAMPLING_RATE);
+}
+
+static ssize_t show_sampling_rate_min(struct cpufreq_policy *policy, char =
*buf)
+{
+	return sprintf (buf, "%u\n", MIN_SAMPLING_RATE);
+}
+
+#define define_one_ro(_name) 					\
+static struct freq_attr _name =3D { 				\
+	.attr =3D { .name =3D __stringify(_name), .mode =3D 0444 }, 	\
+	.show =3D show_##_name, 					\
+}
+
+define_one_ro(sampling_rate_max);
+define_one_ro(sampling_rate_min);
+
+/* cpufreq_conservative Governor Tunables */
+#define show_one(file_name, object)					\
+static ssize_t show_##file_name						\
+(struct cpufreq_policy *unused, char *buf)				\
+{									\
+	return sprintf(buf, "%u\n", dbs_tuners_ins.object);		\
+}
+show_one(sampling_rate, sampling_rate);
+show_one(sampling_down_factor, sampling_down_factor);
+show_one(up_threshold, up_threshold);
+show_one(down_threshold, down_threshold);
+show_one(ignore_nice, ignore_nice);
+
+static ssize_t show_freq_step(struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int percent =3D (dbs_tuners_ins.freq_step * 100) / policy->max;
+
+	return sprintf (buf, "%u\n", percent);
+}
+
+static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 )
+		goto out;
+
+	dbs_tuners_ins.sampling_down_factor =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_sampling_rate(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_SAMPLING_RATE || input < MIN_SAMPLING_RATE)
+		goto out;
+
+	dbs_tuners_ins.sampling_rate =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_up_threshold(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_FREQUENCY_UP_THRESHOLD ||=20
+			input < MIN_FREQUENCY_UP_THRESHOLD ||
+			input <=3D dbs_tuners_ins.down_threshold)
+		goto out;
+
+	dbs_tuners_ins.up_threshold =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_down_threshold(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD ||=20
+			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
+			input >=3D dbs_tuners_ins.up_threshold)
+		goto out;
+
+	dbs_tuners_ins.down_threshold =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_ignore_nice(struct cpufreq_policy *unused,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if ( ret =3D=3D 1 ) {
+		if ( input > 1 )
+			input =3D 1;
+		dbs_tuners_ins.ignore_nice =3D input;
+	}
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_freq_step(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	unsigned int freq_step =3D dbs_tuners_ins.freq_step;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if ( ret =3D=3D 1 ) {
+		if (input > (((policy->max - policy->min) * 100)
+					/ policy->max)) {
+			freq_step =3D policy->max - policy->min;
+		} else {
+			/* no need to test here if freq_step is zero as the user
+			 * might actually want this */
+			freq_step =3D (input * policy->max) / 100;
+		}
+		dbs_tuners_ins.freq_step =3D freq_step;
+	}
+	up(&dbs_sem);
+	return count;
+}
+
+#define define_one_rw(_name) 					\
+static struct freq_attr _name =3D { 				\
+	.attr =3D { .name =3D __stringify(_name), .mode =3D 0644 }, 	\
+	.show =3D show_##_name, 					\
+	.store =3D store_##_name, 				\
+}
+
+define_one_rw(sampling_rate);
+define_one_rw(sampling_down_factor);
+define_one_rw(up_threshold);
+define_one_rw(down_threshold);
+define_one_rw(ignore_nice);
+define_one_rw(freq_step);
+
+static struct attribute * dbs_attributes[] =3D {
+	&sampling_rate_max.attr,
+	&sampling_rate_min.attr,
+	&sampling_rate.attr,
+	&sampling_down_factor.attr,
+	&up_threshold.attr,
+	&down_threshold.attr,
+	&ignore_nice.attr,
+	&freq_step.attr,
+	NULL
+};
+
+static struct attribute_group dbs_attr_group =3D {
+	.attrs =3D dbs_attributes,
+	.name =3D "conservative",
+};
+
+/************************** sysfs end ************************/
+
+static void dbs_check_cpu(int cpu)
+{
+	unsigned int total_ticks, total_idle_ticks;
+	unsigned int ticks, idle_ticks;
+	static int down_skip[NR_CPUS];
+	struct cpu_dbs_info_s *this_dbs_info;
+
+	this_dbs_info =3D &per_cpu(cpu_dbs_info, cpu);
+	if (!this_dbs_info->enable)
+		return;
+
+	/*=20
+	 * The default safe range is 20% to 80%=20
+	 * Every sampling_rate, we check
+	 * 	- If current idle time is less than 20%, then we try to=20
+	 * 	  increase frequency
+	 * Every sampling_rate*sampling_down_factor, we check
+	 * 	- If current idle time is more than 80%, then we try to
+	 * 	  decrease frequency
+	 *
+	 * Any frequency increase takes it to the maximum frequency.=20
+	 * Frequency reduction happens at minimum steps of=20
+	 * 5% (default) of max_frequency
+	 *
+	 * My modified routine compares the number of idle ticks with the
+	 * expected number of idle ticks for the boundaries and acts accordingly
+	 * - Alex
+	 */
+	total_ticks =3D
+		kstat_cpu(cpu).cpustat.user +
+		kstat_cpu(cpu).cpustat.nice +
+		kstat_cpu(cpu).cpustat.system +
+		kstat_cpu(cpu).cpustat.softirq +
+		kstat_cpu(cpu).cpustat.irq +
+		kstat_cpu(cpu).cpustat.idle +
+		kstat_cpu(cpu).cpustat.iowait;
+	total_idle_ticks =3D
+		kstat_cpu(cpu).cpustat.idle +
+		kstat_cpu(cpu).cpustat.iowait;
+	/* consider 'nice' tasks as 'idle' time too if required */
+	if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
+=09
+	ticks =3D (total_ticks -
+			this_dbs_info->prev_cpu_ticks) * 100;
+	idle_ticks =3D (total_idle_ticks -
+			this_dbs_info->prev_cpu_idle_ticks) * 100;
+
+	this_dbs_info->prev_cpu_ticks =3D total_ticks;
+	this_dbs_info->prev_cpu_idle_ticks =3D total_idle_ticks;
+
+	/* nothing to do if we cannot shift the frequency */
+	if (dbs_tuners_ins.freq_step =3D=3D 0)
+		return;
+=09
+	if ((ticks - idle_ticks)
+			> (dbs_tuners_ins.up_threshold * idle_ticks)) {
+		if (this_dbs_info->cur_policy->cur
+				=3D=3D this_dbs_info->cur_policy->max)
+			return;
+	=09
+		dbs_tuners_ins.requested_freq +=3D dbs_tuners_ins.freq_step;
+		if (dbs_tuners_ins.requested_freq >
+				this_dbs_info->cur_policy->max)
+			dbs_tuners_ins.requested_freq =3D
+				this_dbs_info->cur_policy->max;
+	=09
+		__cpufreq_driver_target(this_dbs_info->cur_policy,
+			dbs_tuners_ins.requested_freq, CPUFREQ_RELATION_H);
+		down_skip[cpu] =3D 0;
+		return;
+	}
+
+	/* Check for frequency decrease */
+	down_skip[cpu]++;
+	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
+		return;
+
+	if ((ticks - idle_ticks)
+			< (dbs_tuners_ins.down_threshold * idle_ticks)) {
+		if (this_dbs_info->cur_policy->cur
+				=3D=3D this_dbs_info->cur_policy->min)
+			return;
+
+		dbs_tuners_ins.requested_freq -=3D dbs_tuners_ins.freq_step;
+		if (dbs_tuners_ins.requested_freq <
+				this_dbs_info->cur_policy->min)
+			dbs_tuners_ins.requested_freq =3D
+				this_dbs_info->cur_policy->min;
+
+		__cpufreq_driver_target(this_dbs_info->cur_policy,
+			dbs_tuners_ins.requested_freq, CPUFREQ_RELATION_H);
+		down_skip[cpu] =3D 0;
+		return;
+	}
+}
+
+static void do_dbs_timer(void *data)
+{=20
+	int i;
+	down(&dbs_sem);
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			dbs_check_cpu(i);
+	schedule_delayed_work(&dbs_work,=20
+			sampling_rate_in_HZ(dbs_tuners_ins.sampling_rate));
+	up(&dbs_sem);
+}=20
+
+static inline void dbs_timer_init(void)
+{
+	INIT_WORK(&dbs_work, do_dbs_timer, NULL);
+	schedule_work(&dbs_work);
+	return;
+}
+
+static inline void dbs_timer_exit(void)
+{
+	cancel_delayed_work(&dbs_work);
+	return;
+}
+
+static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event)
+{
+	unsigned int cpu =3D policy->cpu;
+	struct cpu_dbs_info_s *this_dbs_info;
+
+	this_dbs_info =3D &per_cpu(cpu_dbs_info, cpu);
+
+	switch (event) {
+	case CPUFREQ_GOV_START:
+		if ((!cpu_online(cpu)) ||=20
+		    (!policy->cur))
+			return -EINVAL;
+
+		if (policy->cpuinfo.transition_latency >
+				(TRANSITION_LATENCY_LIMIT * 1000))
+			return -EINVAL;
+		if (this_dbs_info->enable) /* Already enabled */
+			break;
+		=20
+		down(&dbs_sem);
+		this_dbs_info->cur_policy =3D policy;
+	=09
+		this_dbs_info->prev_cpu_ticks =3D=20
+				kstat_cpu(cpu).cpustat.user +
+				kstat_cpu(cpu).cpustat.nice +
+				kstat_cpu(cpu).cpustat.system +
+				kstat_cpu(cpu).cpustat.softirq +
+				kstat_cpu(cpu).cpustat.irq +
+				kstat_cpu(cpu).cpustat.idle +
+				kstat_cpu(cpu).cpustat.iowait;
+		this_dbs_info->prev_cpu_idle_ticks =3D=20
+				kstat_cpu(cpu).cpustat.idle +
+				kstat_cpu(cpu).cpustat.iowait +
+				kstat_cpu(cpu).cpustat.nice;
+		this_dbs_info->enable =3D 1;
+		sysfs_create_group(&policy->kobj, &dbs_attr_group);
+		dbs_enable++;
+		/*
+		 * Start the timerschedule work, when this governor
+		 * is used for first time
+		 */
+		if (dbs_enable =3D=3D 1) {
+			unsigned int latency;
+			/* policy latency is in nS. Convert it to uS first */
+
+			latency =3D policy->cpuinfo.transition_latency;
+			if (latency < 1000)
+				latency =3D 1000;
+
+			def_sampling_rate =3D (latency / 10) *
+					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
+			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
+			dbs_tuners_ins.requested_freq
+				=3D this_dbs_info->cur_policy->cur;
+			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.freq_step =3D (5 * policy->max ) / 100;
+		=09
+			/* max freq cannot be less than 100. But who knows... */
+			if (unlikely(dbs_tuners_ins.freq_step =3D=3D 0))
+				dbs_tuners_ins.freq_step =3D 5;
+		=09
+			dbs_timer_init();
+		}
+	=09
+		up(&dbs_sem);
+		break;
+
+	case CPUFREQ_GOV_STOP:
+		down(&dbs_sem);
+		this_dbs_info->enable =3D 0;
+		sysfs_remove_group(&policy->kobj, &dbs_attr_group);
+		dbs_enable--;
+		/*
+		 * Stop the timerschedule work, when this governor
+		 * is used for first time
+		 */
+		if (dbs_enable =3D=3D 0)=20
+			dbs_timer_exit();
+	=09
+		up(&dbs_sem);
+
+		break;
+
+	case CPUFREQ_GOV_LIMITS:
+		down(&dbs_sem);
+		if (policy->max < this_dbs_info->cur_policy->cur)
+			__cpufreq_driver_target(
+					this_dbs_info->cur_policy,
+				       	policy->max, CPUFREQ_RELATION_H);
+		else if (policy->min > this_dbs_info->cur_policy->cur)
+			__cpufreq_driver_target(
+					this_dbs_info->cur_policy,
+				       	policy->min, CPUFREQ_RELATION_L);
+		up(&dbs_sem);
+		break;
+	}
+	return 0;
+}
+
+static struct cpufreq_governor cpufreq_gov_dbs =3D {
+	.name		=3D "conservative",
+	.governor	=3D cpufreq_governor_dbs,
+	.owner		=3D THIS_MODULE,
+};
+
+static int __init cpufreq_gov_dbs_init(void)
+{
+	return cpufreq_register_governor(&cpufreq_gov_dbs);
+}
+
+static void __exit cpufreq_gov_dbs_exit(void)
+{
+	/* Make sure that the scheduled work is indeed not running */
+	flush_scheduled_work();
+
+	cpufreq_unregister_governor(&cpufreq_gov_dbs);
+}
+
+
+MODULE_AUTHOR ("Alexander Clouter <alex-kernel@digriz.org.uk>");
+MODULE_DESCRIPTION ("'cpufreq_conservative' - A dynamic cpufreq governor f=
or "
+		"Low Latency Frequency Transition capable processors "
+		"optimised for use in a battery environment");
+MODULE_LICENSE ("GPL");
+
+module_init(cpufreq_gov_dbs_init);
+module_exit(cpufreq_gov_dbs_exit);
diff -u -U 2 -r -N -d linux-2.6.9.orig/drivers/cpufreq/Kconfig linux-2.6.9/=
drivers/cpufreq/Kconfig
--- linux-2.6.9.orig/drivers/cpufreq/Kconfig	2004-10-18 22:55:07.000000000 =
+0100
+++ linux-2.6.9/drivers/cpufreq/Kconfig	2004-11-07 00:34:25.000000000 +0000
@@ -84,6 +84,24 @@
=20
 	  If in doubt, say N.
=20
+config CPU_FREQ_GOV_CONSERVATIVE
+	tristate "'conservative' cpufreq policy governor"
+	depends on CPU_FREQ
+	help
+	  'conservative' - this driver is quite identical to the 'ondemand'
+	  governor both in its source code and purpose, the difference is that
+	  it has been designed to be much more suitable in a battery powered
+	  environment.  The frequency is gracefully increased and decreased
+	  rather than jumping to 100% when speed is required and dropping back
+	  aggressively.  It also polls 100 times fewer times than 'ondemand'.
+	 =20
+	  For details, take a look at linux/Documentation/cpu-freq.
+	 =20
+	  If you have a desktop machine then you should consider really the
+	  'ondemand' governor instead, however if you are using a laptop, PDA or
+	  even an AMD64 based desktop (due to latency issues) you probably will
+	  want to use this governor.  If in doubt, say N.
+
 config CPU_FREQ_24_API
 	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
 	depends on CPU_FREQ && SYSCTL && CPU_FREQ_GOV_USERSPACE
diff -u -U 2 -r -N -d linux-2.6.9.orig/drivers/cpufreq/Makefile linux-2.6.9=
/drivers/cpufreq/Makefile
--- linux-2.6.9.orig/drivers/cpufreq/Makefile	2004-10-18 22:55:36.000000000=
 +0100
+++ linux-2.6.9/drivers/cpufreq/Makefile	2004-11-06 23:39:41.000000000 +0000
@@ -6,6 +6,7 @@
 obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+=3D cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+=3D cpufreq_userspace.o
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+=3D cpufreq_ondemand.o
+obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+=3D cpufreq_conservative.o
=20
 # CPUfreq cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+=3D freq_table.o

--oyUTqETQ0mS9luUI--

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBjd2ZNv5Ugh/sRBYRAkKMAJ9t4Iu7FAKLDVC5umkUBuAs98gTBACeN/wz
7Ttq3E6XjH/5/w/SawCmXJw=
=1q/+
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
