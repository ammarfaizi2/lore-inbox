Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVAWPDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVAWPDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 10:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVAWPDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 10:03:49 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:28342 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261311AbVAWPAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 10:00:00 -0500
Date: Sun, 23 Jan 2005 15:00:01 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: linux@dominikbrodowski.de, venkatesh.pallipadi@intel.com
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: [PATCH] cpufreq_(ondemand|conservative)
Message-ID: <20050123150000.GA3888@inskipp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi All,

Well after Dominik reminded me about the updates to cpufreq_ondemand I had
made some time back and also my cpufreq governor called cpufreq_conservativ=
e,
I dug out my coffee and started fixing them up for another round of peer
review.  My governor is pretty much a minor rewrite of the cpufreq_ondemand
governor but instead gracefully increases and decreases the cpufreq which
should make it much more suitable for battery power environments.

All the patches are for 2.6.11-rc1-mm1 but also apply cleanly to
2.6.11-rc1-mm2.  Unfortunately 2.6.11-rc1-mm2 oops'es in key_scancode
(drivers/char/keyboard.c) when I presses any keys on my text console (tty1)
after init has loaded so I am waiting till 2.6.11-rc2-mm1 appears before I
file a bug report.

The 'improvements' I have made to cpufreq_ondemand are:

1) cpufreq_ondemand-2.6.11-rc1-mm1-01_ignore-nice.diff
	this adds a new parameter in /sys called
	/sys/.../cpufreq/ondemand/ignore_nice which by default is set to '0'.
	Any 'nice' tasks running will be considered as idle time unless you=20
	set the value in ignore_nice to '1', then it will be simply=20
	considered as a regular cpu time sucking program.

	Last time I did this Venki mentioned some possible corner case=20
	conditions[1] and so this time I make it recalculate the idle times=20
	when the value of ignore_nice is flipped.  If I am right this should=20
	fix any possible issues that would have arisen from this...?

2) cpufreq_ondemand-2.6.11-rc1-mm1-02_check-rate-and-break-out.diff
	a very simple patch which prevents us from changing the cpufreq from=20
	'x' to 'x' un-necessarily.  No-one could find any problems with this=20
	so it has pretty much remained untouched.

3) cpufreq_ondemand-2.6.11-rc1-mm1-03_sys_freq_step.diff
	this feature also adds a new parameter in /sys called
	/sys/.../cpufreq/ondemand/freq_step which by default is set to '5'. =20
	You can change this to any value between '0' (why?) and '100' to=20
	alter how much the cpu will change its frequency by on the way down.

4) cpufreq_ondemand-2.6.11-rc1-mm1-04_ignore_steal.diff
	I noticed a new cpustat has appeared called 'steal'[2] which from=20
	what I can tell should be treated like an iowait stat.  'steal' only=20
	seems supported by S/390 but I think it should be 'considered'.  This=20
	is a minor patch and if I have gotten confused then obviously it=20
	should be removed (and from cpufreq_conservative)

5) cpufreq_ondemand-2.6.11-rc1-mm1-05_safe_down_skip.diff
	although I have not noticed any problems without it being done a=20
	little alarm bell fires off in my head about how down_skip really=20
	should be initialised (what if the cpu-freq is not at a minimum when=20
	we start off or ac power is unplugged and we get policy->min changing=20
	to a lower value?).  Again a minor patch, if not worth it obviously=20
	it can be removed and should also be from cpufreq_conservative

Now cpufreq_conservative started off as a copy of cpufreq_ondemand with all
the above patches and then amended from there.  If you install the patches
you can see with a diff (attached for _show_ and not use) that there is not
much in the way of difference between them.  It works by me creating and
initialising an array to each cpu's policy->cur (this could should be nice =
in=20
an SMP environment, bug reports would be appreciated) and then changing the=
=20
contents by freq_step each time we need to increase or decrease the cpufreq=
=2E =20
This results in a smoother transition on the way up and down.  Also by the=
=20
nature of this governor it polls 100 times fewer than cpufreq_ondemand.

Let me know what you think, the patches work for me, the question is do the=
y=20
work for you :)

Cheers all

Alex

[1] http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110013659005496&w=3D2
[2] http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109888788719020&w=3D2

--=20
 ________________________________________=20
/ A foolish consistency is the hobgoblin \
| of little minds.                       |
|                                        |
\ -- Ralph Waldo Emerson                 /
 ----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_ondemand-2.6.11-rc1-mm1-01_ignore-nice.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23=
 12:04:11.000000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23 11:5=
7:13.000000000 +0000
@@ -79,6 +79,7 @@
 	unsigned int		sampling_down_factor;
 	unsigned int		up_threshold;
 	unsigned int		down_threshold;
+	unsigned int		ignore_nice;
 };
=20
 static struct dbs_tuners dbs_tuners_ins =3D {
@@ -116,6 +117,7 @@
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
 show_one(down_threshold, down_threshold);
+show_one(ignore_nice, ignore_nice);
=20
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
 		const char *buf, size_t count)
@@ -194,6 +196,47 @@
 	return count;
 }
=20
+static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	unsigned int j;
+=09
+	ret =3D sscanf (buf, "%u", &input);
+	if ( ret !=3D 1 )
+		return -EINVAL;
+
+	if ( input > 1 )
+		input =3D 1;
+=09
+	down(&dbs_sem);
+	if ( input =3D=3D dbs_tuners_ins.ignore_nice ) { /* nothing to do */
+		up(&dbs_sem);
+		return count;
+	}
+	dbs_tuners_ins.ignore_nice =3D input;
+
+	/* we need to re-evaluate prev_cpu_idle_up and prev_cpu_idle_down */
+	for_each_cpu_mask(j, policy->cpus) {
+		struct cpu_dbs_info_s *j_dbs_info;
+		j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
+		j_dbs_info->cur_policy =3D policy;
+
+		j_dbs_info->prev_cpu_idle_up =3D
+			kstat_cpu(j).cpustat.idle +
+			kstat_cpu(j).cpustat.iowait;
+		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+			j_dbs_info->prev_cpu_idle_up +=3D
+				kstat_cpu(j).cpustat.nice;
+		j_dbs_info->prev_cpu_idle_down =3D j_dbs_info->prev_cpu_idle_up;
+	}
+	up(&dbs_sem);
+
+	return count;
+}
+
 #define define_one_rw(_name) \
 static struct freq_attr _name =3D \
 __ATTR(_name, 0644, show_##_name, store_##_name)
@@ -202,6 +245,7 @@
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
+define_one_rw(ignore_nice);
=20
 static struct attribute * dbs_attributes[] =3D {
 	&sampling_rate_max.attr,
@@ -210,6 +254,7 @@
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
 	&down_threshold.attr,
+	&ignore_nice.attr,
 	NULL
 };
=20
@@ -254,6 +299,9 @@
 	/* Check for frequency increase */
 	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait;
+	  /* consider 'nice' tasks as 'idle' time too if required */
+	  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
 	idle_ticks =3D total_idle_ticks -
 		this_dbs_info->prev_cpu_idle_up;
 	this_dbs_info->prev_cpu_idle_up =3D total_idle_ticks;
@@ -270,6 +318,9 @@
 		/* Check for frequency increase */
 		total_idle_ticks =3D kstat_cpu(j).cpustat.idle +
 			kstat_cpu(j).cpustat.iowait;
+		  /* consider 'nice' too? */
+		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+			   total_idle_ticks +=3D kstat_cpu(j).cpustat.nice;
 		tmp_idle_ticks =3D total_idle_ticks -
 			j_dbs_info->prev_cpu_idle_up;
 		j_dbs_info->prev_cpu_idle_up =3D total_idle_ticks;
@@ -298,6 +349,9 @@
=20
 	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait;
+	  /* consider 'nice' too? */
+	  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		  total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
 	idle_ticks =3D total_idle_ticks -
 		this_dbs_info->prev_cpu_idle_down;
 	this_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
@@ -313,6 +367,9 @@
 		/* Check for frequency increase */
 		total_idle_ticks =3D kstat_cpu(j).cpustat.idle +
 			kstat_cpu(j).cpustat.iowait;
+		  /* consider 'nice' too? */
+		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+			total_idle_ticks +=3D kstat_cpu(j).cpustat.nice;
 		tmp_idle_ticks =3D total_idle_ticks -
 			j_dbs_info->prev_cpu_idle_down;
 		j_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
@@ -398,10 +455,10 @@
 	=09
 			j_dbs_info->prev_cpu_idle_up =3D=20
 				kstat_cpu(j).cpustat.idle +
-				kstat_cpu(j).cpustat.iowait;
-			j_dbs_info->prev_cpu_idle_down =3D=20
-				kstat_cpu(j).cpustat.idle +
-				kstat_cpu(j).cpustat.iowait;
+				kstat_cpu(j).cpustat.iowait +
+				kstat_cpu(j).cpustat.nice;
+			j_dbs_info->prev_cpu_idle_down
+				=3D j_dbs_info->prev_cpu_idle_up;
 		}
 		this_dbs_info->enable =3D 1;
 		sysfs_create_group(&policy->kobj, &dbs_attr_group);
@@ -421,6 +478,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
+			dbs_tuners_ins.ignore_nice =3D 0;
=20
 			dbs_timer_init();
 		}

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_ondemand-2.6.11-rc1-mm1-02_check-rate-and-break-out.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.11-rc1-mm2.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-01-22=
 00:36:04.000000000 +0000
+++ linux-2.6.11-rc1-mm2/drivers/cpufreq/cpufreq_ondemand.c	2005-01-22 00:3=
6:36.000000000 +0000
@@ -335,6 +335,10 @@
 			sampling_rate_in_HZ(dbs_tuners_ins.sampling_rate);
=20
 	if (idle_ticks < up_idle_ticks) {
+		/* if we are already at full speed then break out early */
+		if (policy->cur =3D=3D policy->max)
+			return;
+	=09
 		__cpufreq_driver_target(policy, policy->max,=20
 			CPUFREQ_RELATION_H);
 		down_skip[cpu] =3D 0;
@@ -388,6 +392,10 @@
 			sampling_rate_in_HZ(freq_down_sampling_rate);
=20
 	if (idle_ticks > down_idle_ticks ) {
+		/* if we are already at the lowest speed then break out early */
+		if (policy->cur =3D=3D policy->min)
+			return;
+	=09
 		freq_down_step =3D (5 * policy->max) / 100;
=20
 		/* max freq cannot be less than 100. But who knows.... */

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_ondemand-2.6.11-rc1-mm1-03_sys_freq_step.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23=
 12:07:48.000000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23 12:2=
5:51.000000000 +0000
@@ -80,6 +80,7 @@
 	unsigned int		up_threshold;
 	unsigned int		down_threshold;
 	unsigned int		ignore_nice;
+	unsigned int		freq_step;
 };
=20
 static struct dbs_tuners dbs_tuners_ins =3D {
@@ -118,6 +119,7 @@
 show_one(up_threshold, up_threshold);
 show_one(down_threshold, down_threshold);
 show_one(ignore_nice, ignore_nice);
+show_one(freq_step, freq_step);
=20
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
 		const char *buf, size_t count)
@@ -237,6 +239,29 @@
 	return count;
 }
=20
+static ssize_t store_freq_step(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	ret =3D sscanf (buf, "%u", &input);
+
+	if ( ret !=3D 1 )
+		return -EINVAL;
+
+	if ( input > 100 )
+		input =3D 100;
+=09
+	/* no need to test here if freq_step is zero as the user might actually
+	 * want this, they would be crazy though :) */
+	down(&dbs_sem);
+	dbs_tuners_ins.freq_step =3D input;
+	up(&dbs_sem);
+
+	return count;
+}
+
 #define define_one_rw(_name) \
 static struct freq_attr _name =3D \
 __ATTR(_name, 0644, show_##_name, store_##_name)
@@ -246,6 +271,7 @@
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
 define_one_rw(ignore_nice);
+define_one_rw(freq_step);
=20
 static struct attribute * dbs_attributes[] =3D {
 	&sampling_rate_max.attr,
@@ -255,6 +281,7 @@
 	&up_threshold.attr,
 	&down_threshold.attr,
 	&ignore_nice.attr,
+	&freq_step.attr,
 	NULL
 };
=20
@@ -293,7 +320,7 @@
 	 *
 	 * Any frequency increase takes it to the maximum frequency.=20
 	 * Frequency reduction happens at minimum steps of=20
-	 * 5% of max_frequency=20
+	 * 5% (default) of max_frequency=20
 	 */
=20
 	/* Check for frequency increase */
@@ -392,18 +419,20 @@
 			sampling_rate_in_HZ(freq_down_sampling_rate);
=20
 	if (idle_ticks > down_idle_ticks ) {
-		/* if we are already at the lowest speed then break out early */
-		if (policy->cur =3D=3D policy->min)
+		/* if we are already at the lowest speed then break out early
+		 * or if we 'cannot' reduce the speed as the user might want
+		 * freq_step to be zero */
+		if (policy->cur =3D=3D policy->min || dbs_tuners_ins.freq_step =3D=3D 0)
 			return;
-	=09
-		freq_down_step =3D (5 * policy->max) / 100;
+
+		freq_down_step =3D (dbs_tuners_ins.freq_step * policy->max) / 100;
=20
 		/* max freq cannot be less than 100. But who knows.... */
 		if (unlikely(freq_down_step =3D=3D 0))
 			freq_down_step =3D 5;
=20
 		__cpufreq_driver_target(policy,
-			policy->cur - freq_down_step,=20
+			policy->cur - freq_down_step,
 			CPUFREQ_RELATION_H);
 		return;
 	}
@@ -487,6 +516,7 @@
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
 			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.freq_step =3D 5;
=20
 			dbs_timer_init();
 		}

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_ondemand-2.6.11-rc1-mm1-04_ignore_steal.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23=
 12:26:52.000000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23 12:2=
7:04.000000000 +0000
@@ -325,7 +325,7 @@
=20
 	/* Check for frequency increase */
 	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
-		kstat_cpu(cpu).cpustat.iowait;
+		kstat_cpu(cpu).cpustat.iowait + kstat_cpu(cpu).cpustat.steal;
 	  /* consider 'nice' tasks as 'idle' time too if required */
 	  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
 		total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
@@ -344,7 +344,8 @@
 		j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
 		/* Check for frequency increase */
 		total_idle_ticks =3D kstat_cpu(j).cpustat.idle +
-			kstat_cpu(j).cpustat.iowait;
+			kstat_cpu(j).cpustat.iowait +
+			kstat_cpu(j).cpustat.steal;
 		  /* consider 'nice' too? */
 		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
 			   total_idle_ticks +=3D kstat_cpu(j).cpustat.nice;
@@ -379,7 +380,7 @@
 		return;
=20
 	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
-		kstat_cpu(cpu).cpustat.iowait;
+		kstat_cpu(cpu).cpustat.iowait + kstat_cpu(cpu).cpustat.steal;
 	  /* consider 'nice' too? */
 	  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
 		  total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
@@ -397,7 +398,8 @@
 		j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
 		/* Check for frequency increase */
 		total_idle_ticks =3D kstat_cpu(j).cpustat.idle +
-			kstat_cpu(j).cpustat.iowait;
+			kstat_cpu(j).cpustat.iowait +
+			kstat_cpu(j).cpustat.steal;
 		  /* consider 'nice' too? */
 		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
 			total_idle_ticks +=3D kstat_cpu(j).cpustat.nice;
@@ -493,7 +495,8 @@
 			j_dbs_info->prev_cpu_idle_up =3D=20
 				kstat_cpu(j).cpustat.idle +
 				kstat_cpu(j).cpustat.iowait +
-				kstat_cpu(j).cpustat.nice;
+				kstat_cpu(j).cpustat.nice +
+				kstat_cpu(j).cpustat.steal;
 			j_dbs_info->prev_cpu_idle_down
 				=3D j_dbs_info->prev_cpu_idle_up;
 		}

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_ondemand-2.6.11-rc1-mm1-05_safe_down_skip.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23=
 13:21:54.000000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23 14:0=
3:18.000000000 +0000
@@ -299,6 +299,7 @@
 	unsigned int freq_down_step;
 	unsigned int freq_down_sampling_rate;
 	static int down_skip[NR_CPUS];
+	static unsigned short init_flag =3D 0;
 	struct cpu_dbs_info_s *this_dbs_info;
=20
 	struct cpufreq_policy *policy;
@@ -309,6 +310,14 @@
 		return;
=20
 	policy =3D this_dbs_info->cur_policy;
+
+	if ( init_flag =3D=3D 0 ) {
+		for ( /* NULL */; init_flag < NR_CPUS; init_flag++ ) {
+			down_skip[cpu] =3D 0;
+		}
+		init_flag =3D 1;
+	}
+
 	/*=20
 	 * The default safe range is 20% to 80%=20
 	 * Every sampling_rate, we check

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_conservative-2.6.11-rc1-mm1.diff"
Content-Transfer-Encoding: quoted-printable

diff -u -U 2 -r -N -d linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/Kconfig lin=
ux-2.6.11-rc1-mm1/drivers/cpufreq/Kconfig
--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/Kconfig	2005-01-23 12:04:11.0=
00000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/Kconfig	2005-01-23 13:24:41.000000=
000 +0000
@@ -116,3 +116,23 @@
 	  For details, take a look at linux/Documentation/cpu-freq.
=20
 	  If in doubt, say N.
+
+config CPU_FREQ_GOV_CONSERVATIVE
+	tristate "'conservative' cpufreq governor"
+	depends on CPU_FREQ
+	help
+	  'conservative' - this driver is rather similar to the 'ondemand'
+	  governor both in its source code and its purpose, the difference is
+	  its optimisation for better suitability in a battery powered
+	  environment.  The frequency is gracefully increased and decreased
+	  rather than jumping to 100% when speed is required.
+
+	  If you have a desktop machine then you should really be considering
+	  the 'ondemand' governor instead, however if you are using a laptop,
+	  PDA or even an AMD64 based computer (due to the unacceptable
+	  step-by-step latency issues between the minimum and maximum frequency=
=20
+	  transitions in the CPU) you will probably want to use this governor.
+
+	  For details, take a look at linux/Documentation/cpu-freq.
+
+	  If in doubt, say N.
diff -u -U 2 -r -N -d linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/Makefile li=
nux-2.6.11-rc1-mm1/drivers/cpufreq/Makefile
--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/Makefile	2005-01-23 12:04:11.=
000000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/Makefile	2005-01-23 12:45:32.00000=
0000 +0000
@@ -8,6 +8,7 @@
 obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+=3D cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+=3D cpufreq_userspace.o
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+=3D cpufreq_ondemand.o
+obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+=3D cpufreq_conservative.o
=20
 # CPUfreq cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+=3D freq_table.o
diff -u -U 2 -r -N -d linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/cpufreq_con=
servative.c linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.11-rc1-mm1.orig/drivers/cpufreq/cpufreq_conservative.c	1970-0=
1-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_conservative.c	2005-01-23 =
14:05:54.000000000 +0000
@@ -0,0 +1,620 @@
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
+ * the processor. Default polling frequency is 1000 times the transition
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
+#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(100000)
+#define DEF_SAMPLING_DOWN_FACTOR		(5)
+#define TRANSITION_LATENCY_LIMIT		(10 * 1000)
+#define sampling_rate_in_HZ(x)			(((x * HZ) < (1000 * 1000))?1:((x * HZ) /=
 (1000 * 1000)))
+
+static void do_dbs_timer(void *data);
+
+struct cpu_dbs_info_s {
+	struct cpufreq_policy 	*cur_policy;
+	unsigned int 		prev_cpu_idle_up;
+	unsigned int 		prev_cpu_idle_down;
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
+	unsigned int		ignore_nice;
+	unsigned int		freq_step;
+};
+
+static struct dbs_tuners dbs_tuners_ins =3D {
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
+static struct freq_attr _name =3D  				\
+__ATTR(_name, 0444, show_##_name, NULL)
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
+show_one(freq_step, freq_step);
+
+static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	if (ret !=3D 1 )
+		return -EINVAL;
+
+	down(&dbs_sem);
+	dbs_tuners_ins.sampling_down_factor =3D input;
+	up(&dbs_sem);
+
+	return count;
+}
+
+static ssize_t store_sampling_rate(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_SAMPLING_RATE || input < MIN_SAMPLING_RATE)=
 {
+		up(&dbs_sem);
+		return -EINVAL;
+	}
+
+	dbs_tuners_ins.sampling_rate =3D input;
+	up(&dbs_sem);
+
+	return count;
+}
+
+static ssize_t store_up_threshold(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_FREQUENCY_UP_THRESHOLD ||=20
+			input < MIN_FREQUENCY_UP_THRESHOLD ||
+			input <=3D dbs_tuners_ins.down_threshold) {
+		up(&dbs_sem);
+		return -EINVAL;
+	}
+
+	dbs_tuners_ins.up_threshold =3D input;
+	up(&dbs_sem);
+
+	return count;
+}
+
+static ssize_t store_down_threshold(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD ||=20
+			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
+			input >=3D dbs_tuners_ins.up_threshold) {
+		up(&dbs_sem);
+		return -EINVAL;
+	}
+
+	dbs_tuners_ins.down_threshold =3D input;
+	up(&dbs_sem);
+
+	return count;
+}
+
+static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	unsigned int j;
+=09
+	ret =3D sscanf (buf, "%u", &input);
+	if ( ret !=3D 1 )
+		return -EINVAL;
+
+	if ( input > 1 )
+		input =3D 1;
+=09
+	down(&dbs_sem);
+	if ( input =3D=3D dbs_tuners_ins.ignore_nice ) { /* nothing to do */
+		up(&dbs_sem);
+		return count;
+	}
+	dbs_tuners_ins.ignore_nice =3D input;
+
+	/* we need to re-evaluate prev_cpu_idle_up and prev_cpu_idle_down */
+	for_each_cpu_mask(j, policy->cpus) {
+		struct cpu_dbs_info_s *j_dbs_info;
+		j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
+		j_dbs_info->cur_policy =3D policy;
+
+		j_dbs_info->prev_cpu_idle_up =3D
+			kstat_cpu(j).cpustat.idle +
+			kstat_cpu(j).cpustat.iowait;
+		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+			j_dbs_info->prev_cpu_idle_up +=3D
+				kstat_cpu(j).cpustat.nice;
+		j_dbs_info->prev_cpu_idle_down =3D j_dbs_info->prev_cpu_idle_up;
+	}
+	up(&dbs_sem);
+
+	return count;
+}
+
+static ssize_t store_freq_step(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	ret =3D sscanf (buf, "%u", &input);
+
+	if ( ret !=3D 1 )
+		return -EINVAL;
+
+	if ( input > 100 )
+		input =3D 100;
+=09
+	/* no need to test here if freq_step is zero as the user might actually
+	 * want this, they would be crazy though :) */
+	down(&dbs_sem);
+	dbs_tuners_ins.freq_step =3D input;
+	up(&dbs_sem);
+
+	return count;
+}
+
+#define define_one_rw(_name) \
+static struct freq_attr _name =3D \
+__ATTR(_name, 0644, show_##_name, store_##_name)
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
+	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
+	unsigned int total_idle_ticks;
+	unsigned int freq_step;
+	unsigned int freq_down_sampling_rate;
+	static int down_skip[NR_CPUS];
+	static int requested_freq[NR_CPUS];
+	static unsigned short init_flag =3D 0;
+	struct cpu_dbs_info_s *this_dbs_info;
+	struct cpu_dbs_info_s *dbs_info;
+
+	struct cpufreq_policy *policy;
+	unsigned int j;
+
+	this_dbs_info =3D &per_cpu(cpu_dbs_info, cpu);
+	if (!this_dbs_info->enable)
+		return;
+
+	policy =3D this_dbs_info->cur_policy;
+
+	if ( init_flag =3D=3D 0 ) {
+		for ( /* NULL */; init_flag < NR_CPUS; init_flag++ ) {
+			dbs_info =3D &per_cpu(cpu_dbs_info, init_flag);
+			requested_freq[cpu] =3D dbs_info->cur_policy->cur;
+
+			down_skip[cpu] =3D 0;
+		}
+		init_flag =3D 1;
+	}
+=09
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
+	 * 5% (default) of max_frequency=20
+	 */
+
+	/* Check for frequency increase */
+	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
+		kstat_cpu(cpu).cpustat.iowait + kstat_cpu(cpu).cpustat.steal;
+	  /* consider 'nice' tasks as 'idle' time too if required */
+	  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
+	idle_ticks =3D total_idle_ticks -
+		this_dbs_info->prev_cpu_idle_up;
+	this_dbs_info->prev_cpu_idle_up =3D total_idle_ticks;
+=09
+
+	for_each_cpu_mask(j, policy->cpus) {
+		unsigned int tmp_idle_ticks;
+		struct cpu_dbs_info_s *j_dbs_info;
+
+		if (j =3D=3D cpu)
+			continue;
+
+		j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
+		/* Check for frequency increase */
+		total_idle_ticks =3D kstat_cpu(j).cpustat.idle +
+			kstat_cpu(j).cpustat.iowait +
+			kstat_cpu(j).cpustat.steal;
+		  /* consider 'nice' too? */
+		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+			   total_idle_ticks +=3D kstat_cpu(j).cpustat.nice;
+		tmp_idle_ticks =3D total_idle_ticks -
+			j_dbs_info->prev_cpu_idle_up;
+		j_dbs_info->prev_cpu_idle_up =3D total_idle_ticks;
+
+		if (tmp_idle_ticks < idle_ticks)
+			idle_ticks =3D tmp_idle_ticks;
+	}
+
+	/* Scale idle ticks by 100 and compare with up and down ticks */
+	idle_ticks *=3D 100;
+	up_idle_ticks =3D (100 - dbs_tuners_ins.up_threshold) *
+			sampling_rate_in_HZ(dbs_tuners_ins.sampling_rate);
+
+	if (idle_ticks < up_idle_ticks) {
+		/* if we are already at full speed then break out early */
+		if (requested_freq[cpu] =3D=3D policy->max)
+			return;
+	=09
+		freq_step =3D (dbs_tuners_ins.freq_step * policy->max) / 100;
+
+		/* max freq cannot be less than 100. But who knows.... */
+		if (unlikely(freq_step =3D=3D 0))
+			freq_step =3D 5;
+	=09
+		requested_freq[cpu] +=3D freq_step;
+		if (requested_freq[cpu] > policy->max)
+			requested_freq[cpu] =3D policy->max;
+
+		__cpufreq_driver_target(policy, requested_freq[cpu],=20
+			CPUFREQ_RELATION_H);
+		down_skip[cpu] =3D 0;
+		this_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
+		return;
+	}
+
+	/* Check for frequency decrease */
+	down_skip[cpu]++;
+	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
+		return;
+
+	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
+		kstat_cpu(cpu).cpustat.iowait + kstat_cpu(cpu).cpustat.steal;
+	  /* consider 'nice' too? */
+	  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		  total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
+	idle_ticks =3D total_idle_ticks -
+		this_dbs_info->prev_cpu_idle_down;
+	this_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
+
+	for_each_cpu_mask(j, policy->cpus) {
+		unsigned int tmp_idle_ticks;
+		struct cpu_dbs_info_s *j_dbs_info;
+
+		if (j =3D=3D cpu)
+			continue;
+
+		j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
+		/* Check for frequency increase */
+		total_idle_ticks =3D kstat_cpu(j).cpustat.idle +
+			kstat_cpu(j).cpustat.iowait +
+			kstat_cpu(j).cpustat.steal;
+		  /* consider 'nice' too? */
+		  if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+			total_idle_ticks +=3D kstat_cpu(j).cpustat.nice;
+		tmp_idle_ticks =3D total_idle_ticks -
+			j_dbs_info->prev_cpu_idle_down;
+		j_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
+
+		if (tmp_idle_ticks < idle_ticks)
+			idle_ticks =3D tmp_idle_ticks;
+	}
+
+	/* Scale idle ticks by 100 and compare with up and down ticks */
+	idle_ticks *=3D 100;
+	down_skip[cpu] =3D 0;
+
+	freq_down_sampling_rate =3D dbs_tuners_ins.sampling_rate *
+		dbs_tuners_ins.sampling_down_factor;
+	down_idle_ticks =3D (100 - dbs_tuners_ins.down_threshold) *
+			sampling_rate_in_HZ(freq_down_sampling_rate);
+
+	if (idle_ticks > down_idle_ticks ) {
+		/* if we are already at the lowest speed then break out early
+		 * or if we 'cannot' reduce the speed as the user might want
+		 * freq_step to be zero */
+		if (requested_freq[cpu] =3D=3D policy->min
+				|| dbs_tuners_ins.freq_step =3D=3D 0)
+			return;
+
+		freq_step =3D (dbs_tuners_ins.freq_step * policy->max) / 100;
+
+		/* max freq cannot be less than 100. But who knows.... */
+		if (unlikely(freq_step =3D=3D 0))
+			freq_step =3D 5;
+
+		requested_freq[cpu] -=3D freq_step;
+		if (requested_freq[cpu] < policy->min)
+			requested_freq[cpu] =3D policy->min;
+
+		__cpufreq_driver_target(policy,
+			requested_freq[cpu],
+			CPUFREQ_RELATION_H);
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
+	unsigned int j;
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
+		for_each_cpu_mask(j, policy->cpus) {
+			struct cpu_dbs_info_s *j_dbs_info;
+			j_dbs_info =3D &per_cpu(cpu_dbs_info, j);
+			j_dbs_info->cur_policy =3D policy;
+	=09
+			j_dbs_info->prev_cpu_idle_up =3D=20
+				kstat_cpu(j).cpustat.idle +
+				kstat_cpu(j).cpustat.iowait +
+				kstat_cpu(j).cpustat.nice +
+				kstat_cpu(j).cpustat.steal;
+			j_dbs_info->prev_cpu_idle_down
+				=3D j_dbs_info->prev_cpu_idle_up;
+		}
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
+			def_sampling_rate =3D (latency / 1000) *
+					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
+			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
+			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.freq_step =3D 5;
+
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
+struct cpufreq_governor cpufreq_gov_dbs =3D {
+	.name		=3D "conservative",
+	.governor	=3D cpufreq_governor_dbs,
+	.owner		=3D THIS_MODULE,
+};
+EXPORT_SYMBOL(cpufreq_gov_dbs);
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

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq_ondemand-to-cpufreq_conservative.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_ondemand.c	2005-01-23 14:0=
3:18.000000000 +0000
+++ linux-2.6.11-rc1-mm1/drivers/cpufreq/cpufreq_conservative.c	2005-01-23 =
14:13:54.000000000 +0000
@@ -1,9 +1,10 @@
 /*
- *  drivers/cpufreq/cpufreq_ondemand.c
+ *  drivers/cpufreq/cpufreq_conservative.c
  *
  *  Copyright (C)  2001 Russell King
  *            (C)  2003 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com=
>.
  *                      Jun Nakajima <jun.nakajima@intel.com>
+ *            (C)  2004 Alexander Clouter <alex-kernel@digriz.org.uk>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -54,8 +55,8 @@
 static unsigned int 				def_sampling_rate;
 #define MIN_SAMPLING_RATE			(def_sampling_rate / 2)
 #define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
-#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
-#define DEF_SAMPLING_DOWN_FACTOR		(10)
+#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(100000)
+#define DEF_SAMPLING_DOWN_FACTOR		(5)
 #define TRANSITION_LATENCY_LIMIT		(10 * 1000)
 #define sampling_rate_in_HZ(x)			(((x * HZ) < (1000 * 1000))?1:((x * HZ) /=
 (1000 * 1000)))
=20
@@ -107,7 +108,7 @@
 define_one_ro(sampling_rate_max);
 define_one_ro(sampling_rate_min);
=20
-/* cpufreq_ondemand Governor Tunables */
+/* cpufreq_conservative Governor Tunables */
 #define show_one(file_name, object)					\
 static ssize_t show_##file_name						\
 (struct cpufreq_policy *unused, char *buf)				\
@@ -287,7 +288,7 @@
=20
 static struct attribute_group dbs_attr_group =3D {
 	.attrs =3D dbs_attributes,
-	.name =3D "ondemand",
+	.name =3D "conservative",
 };
=20
 /************************** sysfs end ************************/
@@ -296,11 +297,13 @@
 {
 	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
 	unsigned int total_idle_ticks;
-	unsigned int freq_down_step;
+	unsigned int freq_step;
 	unsigned int freq_down_sampling_rate;
 	static int down_skip[NR_CPUS];
+	static int requested_freq[NR_CPUS];
 	static unsigned short init_flag =3D 0;
 	struct cpu_dbs_info_s *this_dbs_info;
+	struct cpu_dbs_info_s *dbs_info;
=20
 	struct cpufreq_policy *policy;
 	unsigned int j;
@@ -313,11 +316,14 @@
=20
 	if ( init_flag =3D=3D 0 ) {
 		for ( /* NULL */; init_flag < NR_CPUS; init_flag++ ) {
+			dbs_info =3D &per_cpu(cpu_dbs_info, init_flag);
+			requested_freq[cpu] =3D dbs_info->cur_policy->cur;
+
 			down_skip[cpu] =3D 0;
 		}
 		init_flag =3D 1;
 	}
-
+=09
 	/*=20
 	 * The default safe range is 20% to 80%=20
 	 * Every sampling_rate, we check
@@ -373,10 +379,20 @@
=20
 	if (idle_ticks < up_idle_ticks) {
 		/* if we are already at full speed then break out early */
-		if (policy->cur =3D=3D policy->max)
+		if (requested_freq[cpu] =3D=3D policy->max)
 			return;
 	=09
-		__cpufreq_driver_target(policy, policy->max,=20
+		freq_step =3D (dbs_tuners_ins.freq_step * policy->max) / 100;
+
+		/* max freq cannot be less than 100. But who knows.... */
+		if (unlikely(freq_step =3D=3D 0))
+			freq_step =3D 5;
+	=09
+		requested_freq[cpu] +=3D freq_step;
+		if (requested_freq[cpu] > policy->max)
+			requested_freq[cpu] =3D policy->max;
+
+		__cpufreq_driver_target(policy, requested_freq[cpu],=20
 			CPUFREQ_RELATION_H);
 		down_skip[cpu] =3D 0;
 		this_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
@@ -433,17 +449,22 @@
 		/* if we are already at the lowest speed then break out early
 		 * or if we 'cannot' reduce the speed as the user might want
 		 * freq_step to be zero */
-		if (policy->cur =3D=3D policy->min || dbs_tuners_ins.freq_step =3D=3D 0)
+		if (requested_freq[cpu] =3D=3D policy->min
+				|| dbs_tuners_ins.freq_step =3D=3D 0)
 			return;
=20
-		freq_down_step =3D (dbs_tuners_ins.freq_step * policy->max) / 100;
+		freq_step =3D (dbs_tuners_ins.freq_step * policy->max) / 100;
=20
 		/* max freq cannot be less than 100. But who knows.... */
-		if (unlikely(freq_down_step =3D=3D 0))
-			freq_down_step =3D 5;
+		if (unlikely(freq_step =3D=3D 0))
+			freq_step =3D 5;
+
+		requested_freq[cpu] -=3D freq_step;
+		if (requested_freq[cpu] < policy->min)
+			requested_freq[cpu] =3D policy->min;
=20
 		__cpufreq_driver_target(policy,
-			policy->cur - freq_down_step,
+			requested_freq[cpu],
 			CPUFREQ_RELATION_H);
 		return;
 	}
@@ -569,7 +590,7 @@
 }
=20
 struct cpufreq_governor cpufreq_gov_dbs =3D {
-	.name		=3D "ondemand",
+	.name		=3D "conservative",
 	.governor	=3D cpufreq_governor_dbs,
 	.owner		=3D THIS_MODULE,
 };
@@ -589,9 +610,10 @@
 }
=20
=20
-MODULE_AUTHOR ("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
-MODULE_DESCRIPTION ("'cpufreq_ondemand' - A dynamic cpufreq governor for "
-		"Low Latency Frequency Transition capable processors");
+MODULE_AUTHOR ("Alexander Clouter <alex-kernel@digriz.org.uk>");
+MODULE_DESCRIPTION ("'cpufreq_conservative' - A dynamic cpufreq governor f=
or "
+		"Low Latency Frequency Transition capable processors "
+		"optimised for use in a battery environment");
 MODULE_LICENSE ("GPL");
=20
 module_init(cpufreq_gov_dbs_init);

--9amGYk9869ThD9tj--

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB87vwNv5Ugh/sRBYRAm97AJ0WLc2OzAPDfQB1eE+hMaDYmCQvMwCdFmH4
pymr8V9OWU3oSEFiJNVghkQ=
=lfTF
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
