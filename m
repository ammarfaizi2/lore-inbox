Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUJQW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUJQW3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUJQW3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 18:29:30 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:64973 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S269310AbUJQW3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 18:29:09 -0400
Date: Sun, 17 Oct 2004 23:29:16 +0100
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq_ondemand
Message-ID: <20041017222916.GA30841@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After playing with the cpufreq_ondemand governor (many thanks to those whom=
=20
made it) I made a number of alterations which suit me at least.  Really=20
looking for feedback and of course once people have fixed any bugs they fin=
d=20
and made the code look neater, possible inclusion?

The improvements (well I think they are) I have made:

1. I have replaced the algoritm it used to one which calculates the number =
of
	cpu idle cycles that have passed and compares it to the number of cpu
	cycles it would have expected to pass (for, the defaults, 20%/80%)

	this means a couple of divisions have been removed, which is always=20
	nice and it lead to clearer code (for me at least), that was=20
	until I added the handful of 'if' conditionals though.... :-/

2. controllable through=20
	/sys/.../ondemand/ignore_nice, you can tell it to consider 'nice'=20
	time as also idle cpu cycles.  Set it to '1' to treat 'nice' as cpu=20
	in an active state.

3. (major) the scaling up and down of the cpufreq is now smoother.  I found=
=20
	it really nasty that if it tripped < 20% idle time that the freq was=20
	set to 100%.  This code smoothly increases the cpufreq as well as=20
	doing a better job of decreasing it too

4. (minor) I changed DEF_SAMPLING_RATE_LATENCY_MULTIPLIER to 50000 and
	DEF_SAMPLING_DOWN_FACTOR to 5 as I found the defaults a bit annoying=20
	on my system and resulted in the cpufreq constantly jumping.

	For my patch it works far better if the sampling rate is much lower=20
	anyway, which can only be good for cpu efficiency in the long run

5. the grainity of how much cpufreq is increased or decreased is controlled=
=20
	with sending a percentage to /sys/.../ondemand/freq_step_percent

6. debugging (with 'watch -n1 cat /sys/.../ondemand/requested_freq') and=20
	backwards 'compatibility' to act like the 'userspace' governor is=20
	avaliable with /sys/.../ondemand/requested_freq if=20
	'freq_step_percent' is set to zero

7. there are extra checks to not bother to try increasing/decreasing the=20
	cpufreq if there is nothing to do, or even can be done as it might=20
	already be at min/max (or freq_step_percent is zero)

The code seems to work for me fine.  This is my first patch and the first=
=20
thing I have really posted here so be gentle with me :)

Comments and improvements are of course more than welcome.

Of course full thanks go to all the original authors, my C coding is naff a=
nd=20
I would of not been able to do this if it was not for the pretty much=20
complete (for my needs) cpufreq_ondemand module; Venkatesh did say we could=
=20
rip out the core algorithm and replace it with our own easily, he was right=
=20
:)

Cheers

Alex

--=20
 ___________________________________=20
< Two is company, three is an orgy. >
 -----------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="updated-ondemand.diff"
Content-Transfer-Encoding: quoted-printable

diff -u -U 2 -r -N -d linux-2.6.9-rc4.orig/drivers/cpufreq/cpufreq_ondemand=
=2Ec linux-2.6.9-rc4/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.9-rc4.orig/drivers/cpufreq/cpufreq_ondemand.c	2004-10-11 03:5=
8:49.000000000 +0100
+++ linux-2.6.9-rc4/drivers/cpufreq/cpufreq_ondemand.c	2004-10-17 18:32:28.=
000000000 +0100
@@ -56,8 +56,8 @@
 static unsigned int 				def_sampling_rate;
 #define MIN_SAMPLING_RATE			(def_sampling_rate / 2)
 #define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
-#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
-#define DEF_SAMPLING_DOWN_FACTOR		(10)
+#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(50000)
+#define DEF_SAMPLING_DOWN_FACTOR		(5)
 #define TRANSITION_LATENCY_LIMIT		(10 * 1000)
 #define sampling_rate_in_HZ(x)			(((x * HZ) < (1000 * 1000))?1:((x * HZ) /=
 (1000 * 1000)))
=20
@@ -65,8 +65,8 @@
=20
 struct cpu_dbs_info_s {
 	struct cpufreq_policy 	*cur_policy;
-	unsigned int 		prev_cpu_idle_up;
-	unsigned int 		prev_cpu_idle_down;
+	unsigned int 		prev_cpu_ticks;
+	unsigned int		prev_cpu_idle_ticks;
 	unsigned int 		enable;
 };
 static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
@@ -81,6 +81,9 @@
 	unsigned int		sampling_down_factor;
 	unsigned int		up_threshold;
 	unsigned int		down_threshold;
+	unsigned int		requested_freq;
+	unsigned int		freq_step_percent;
+	unsigned int		ignore_nice;
 };
=20
 struct dbs_tuners dbs_tuners_ins =3D {
@@ -116,6 +119,22 @@
 {									\
 	return sprintf(buf, "%u\n", dbs_tuners_ins.object);		\
 }
+
+static ssize_t show_requested_freq(struct cpufreq_policy *policy, char *bu=
f)
+{
+	return sprintf (buf, "%u\n", dbs_tuners_ins.requested_freq);
+}
+
+static ssize_t show_freq_step_percent(struct cpufreq_policy *policy, char =
*buf)
+{
+	return sprintf (buf, "%u\n", dbs_tuners_ins.freq_step_percent);
+}
+
+static ssize_t show_ignore_nice(struct cpufreq_policy *policy, char *buf)
+{
+	return sprintf (buf, "%u\n", dbs_tuners_ins.ignore_nice);
+}
+
 show_one(sampling_rate, sampling_rate);
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
@@ -189,6 +208,63 @@
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
+static ssize_t store_freq_step_percent(struct cpufreq_policy *unused,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if ( ret =3D=3D 1 ) {
+		/* someone might find 'freq_step_percent =3D 0' useful so this is
+		 * why I have added support to manually set the freq also; I
+		 * guess this would then permit a userland tool to jump in
+		 * without rmmod/insmod'ing.  show/store_requested_freq is also
+		 * darn handy for debugging
+		 */
+		if ( input > 100 )
+			input =3D 100;
+		dbs_tuners_ins.freq_step_percent =3D input;
+	}
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_requested_freq(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if ( ret =3D=3D 1 ) {
+		if ( input < policy->min )
+			input =3D policy->min;
+		if ( input > policy->max )
+			input =3D policy->max;
+		dbs_tuners_ins.requested_freq =3D input;
+		__cpufreq_driver_target(policy, input, CPUFREQ_RELATION_H);
+	}
+	up(&dbs_sem);
+	return count;
+}
+
 #define define_one_rw(_name) 					\
 static struct freq_attr _name =3D { 				\
 	.attr =3D { .name =3D __stringify(_name), .mode =3D 0644 }, 	\
@@ -200,6 +276,9 @@
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
+define_one_rw(requested_freq);
+define_one_rw(freq_step_percent);
+define_one_rw(ignore_nice);
=20
 static struct attribute * dbs_attributes[] =3D {
 	&sampling_rate_max.attr,
@@ -208,6 +287,9 @@
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
 	&down_threshold.attr,
+	&requested_freq.attr,
+	&freq_step_percent.attr,
+	&ignore_nice.attr,
 	NULL
 };
=20
@@ -220,10 +302,9 @@
=20
 static void dbs_check_cpu(int cpu)
 {
-	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
-	unsigned int total_idle_ticks;
-	unsigned int freq_down_step;
-	unsigned int freq_down_sampling_rate;
+	unsigned int total_ticks, total_idle_ticks;
+	unsigned int ticks, idle_ticks;
+	unsigned int freq_step;
 	static int down_skip[NR_CPUS];
 	struct cpu_dbs_info_s *this_dbs_info;
=20
@@ -242,26 +323,82 @@
 	 *
 	 * Any frequency increase takes it to the maximum frequency.=20
 	 * Frequency reduction happens at minimum steps of=20
-	 * 5% of max_frequency=20
+	 * 5% (default) of max_frequency=20
+	 *
+	 * My modified routine compares the number of idle ticks with the
+	 * expected number of idle ticks for the boundaries and acts accordingly
+	 * - Alexander Clouter <alex-kernel@digriz.org.uk>
 	 */
-	/* Check for frequency increase */
-	total_idle_ticks =3D kstat_cpu(cpu).cpustat.idle +
+
+	/* get various cpu stats */
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
 		kstat_cpu(cpu).cpustat.iowait;
-	idle_ticks =3D total_idle_ticks -
-		this_dbs_info->prev_cpu_idle_up;
-	this_dbs_info->prev_cpu_idle_up =3D total_idle_ticks;
=20
-	/* Scale idle ticks by 100 and compare with up and down ticks */
-	idle_ticks *=3D 100;
-	up_idle_ticks =3D (100 - dbs_tuners_ins.up_threshold) *
-			sampling_rate_in_HZ(dbs_tuners_ins.sampling_rate);
+	/* if the /sys says we need to consider nice tasks as 'idle' time too */
+	if (dbs_tuners_ins.ignore_nice =3D=3D 0)
+		total_idle_ticks +=3D kstat_cpu(cpu).cpustat.nice;
+=09
+	ticks =3D (total_ticks -
+		this_dbs_info->prev_cpu_ticks) * 100;
+	idle_ticks =3D (total_idle_ticks -
+		this_dbs_info->prev_cpu_idle_ticks) * 100;
+=09
+	this_dbs_info->prev_cpu_ticks =3D total_ticks;
+	this_dbs_info->prev_cpu_idle_ticks =3D total_idle_ticks;
+=09
+	/* nothing to do if we cannot shift the frequency */
+	if (dbs_tuners_ins.freq_step_percent =3D=3D 0)
+		return;
+=09
+	/* checks to see if we have anything to do or can do and breaks out if:
+	 *  - we are within the 20% <-> 80% region
+	 *  - if the cpu freq needs increasing we are not already at max
+	 *  - if the cpu freq needs decreasing we are not already at min
+	 *
+	 *  you have to love those parentheses.... :)
+	 */
+	if (!( ( (ticks-idle_ticks) > (dbs_tuners_ins.up_threshold*idle_ticks)
+			&& dbs_tuners_ins.requested_freq
+				!=3D this_dbs_info->cur_policy->max
+	       )
+  	    || ( (ticks-idle_ticks) < (dbs_tuners_ins.down_threshold*idle_ticks)
+			&& dbs_tuners_ins.requested_freq
+				!=3D this_dbs_info->cur_policy->min
+	       ) ) )
+		return;
=20
-	if (idle_ticks < up_idle_ticks) {
+	/* max freq cannot be less than 100. But who knows.... */
+	if (unlikely(this_dbs_info->cur_policy->max < 100)) {
+		freq_step =3D dbs_tuners_ins.freq_step_percent;
+	} else {
+		freq_step =3D (dbs_tuners_ins.freq_step_percent *
+				this_dbs_info->cur_policy->max) / 100;
+	}
+
+	/* Check for frequency increase */
+	if ( (ticks-idle_ticks) > (dbs_tuners_ins.up_threshold*idle_ticks) ) {
+		dbs_tuners_ins.requested_freq +=3D freq_step;
+		if (dbs_tuners_ins.requested_freq >
+				this_dbs_info->cur_policy->max)
+			dbs_tuners_ins.requested_freq =3D
+				this_dbs_info->cur_policy->max;
+
+		/* printk("up: %u->%u\n",
+				this_dbs_info->cur_policy->cur,
+				dbs_tuners_ins.requested_freq); */
 		__cpufreq_driver_target(this_dbs_info->cur_policy,
-			this_dbs_info->cur_policy->max,=20
-			CPUFREQ_RELATION_H);
+        	       	dbs_tuners_ins.requested_freq,
+        	       	CPUFREQ_RELATION_H);
 		down_skip[cpu] =3D 0;
-		this_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
 		return;
 	}
=20
@@ -270,27 +407,19 @@
 	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
 		return;
=20
-	idle_ticks =3D total_idle_ticks -
-		this_dbs_info->prev_cpu_idle_down;
-	/* Scale idle ticks by 100 and compare with up and down ticks */
-	idle_ticks *=3D 100;
 	down_skip[cpu] =3D 0;
-	this_dbs_info->prev_cpu_idle_down =3D total_idle_ticks;
-
-	freq_down_sampling_rate =3D dbs_tuners_ins.sampling_rate *
-		dbs_tuners_ins.sampling_down_factor;
-	down_idle_ticks =3D (100 - dbs_tuners_ins.down_threshold) *
-			sampling_rate_in_HZ(freq_down_sampling_rate);
-
-	if (idle_ticks > down_idle_ticks ) {
-		freq_down_step =3D (5 * this_dbs_info->cur_policy->max) / 100;
-
-		/* max freq cannot be less than 100. But who knows.... */
-		if (unlikely(freq_down_step =3D=3D 0))
-			freq_down_step =3D 5;
-
+	if ( (ticks-idle_ticks) < (dbs_tuners_ins.down_threshold*idle_ticks) ) {
+		dbs_tuners_ins.requested_freq -=3D freq_step;
+		if (dbs_tuners_ins.requested_freq <
+				this_dbs_info->cur_policy->min)
+			dbs_tuners_ins.requested_freq =3D
+				this_dbs_info->cur_policy->min;
+	=09
+		/* printk("down: %u->%u\n",
+				this_dbs_info->cur_policy->cur,
+				dbs_tuners_ins.requested_freq); */
 		__cpufreq_driver_target(this_dbs_info->cur_policy,
-			this_dbs_info->cur_policy->cur - freq_down_step,=20
+			dbs_tuners_ins.requested_freq,=20
 			CPUFREQ_RELATION_H);
 		return;
 	}
@@ -344,10 +473,16 @@
 		down(&dbs_sem);
 		this_dbs_info->cur_policy =3D policy;
 	=09
-		this_dbs_info->prev_cpu_idle_up =3D=20
+		this_dbs_info->prev_cpu_ticks =3D
+				kstat_cpu(cpu).cpustat.user +
+				kstat_cpu(cpu).cpustat.nice +
+				kstat_cpu(cpu).cpustat.system +
+				kstat_cpu(cpu).cpustat.softirq +
+				kstat_cpu(cpu).cpustat.irq +
 				kstat_cpu(cpu).cpustat.idle +
 				kstat_cpu(cpu).cpustat.iowait;
-		this_dbs_info->prev_cpu_idle_down =3D=20
+		this_dbs_info->prev_cpu_idle_ticks =3D=20
+				kstat_cpu(cpu).cpustat.nice +
 				kstat_cpu(cpu).cpustat.idle +
 				kstat_cpu(cpu).cpustat.iowait;
 		this_dbs_info->enable =3D 1;
@@ -368,7 +503,10 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-
+			dbs_tuners_ins.requested_freq
+				=3D this_dbs_info->cur_policy->cur;
+			dbs_tuners_ins.freq_step_percent =3D 5;
+			dbs_tuners_ins.ignore_nice =3D 0;
 			dbs_timer_init();
 		}
 	=09

--sdtB3X0nJg68CQEu--

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcvI8Nv5Ugh/sRBYRArohAJ49rNGCJ3uPwNQlrkHrjbQ+xqfKNQCeMBJs
WoKltq4g6pHxtaxm1aNlQl4=
=pbAZ
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
