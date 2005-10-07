Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVJGILF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVJGILF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVJGILF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:11:05 -0400
Received: from mail.parbin.co.uk ([213.162.111.43]:38546 "EHLO
	mail.parbin.co.uk") by vger.kernel.org with ESMTP id S1751012AbVJGILC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:11:02 -0400
Date: Fri, 7 Oct 2005 09:09:44 +0100
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: [patch 1/1] cpufreq_ondemand/conservative: invert meaning of 'ignore_nice'
Message-ID: <20051007080944.GA3409@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The use of the 'ignore_nice' sysfs file is confusing to anyone using.  This
patch makes it so when you now set it to the default value of 1, process ni=
ce
time is also ignored in the cpu 'busyness' calculation.  We also rename=20
'ignore_nice' to 'ignore_nice_task' so that userland tools notice the inver=
se=20
behaviour sooner.

Prior to this patch to set it to '1' to make process nice time count...even
confused me :)

WARNING: this obvious breaks any userland tools that expect things to be the
other way round; hence why, as suggested, the rename of the 'ignore_nice'=
=20
file to 'ignore_nice_tasks'

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_inverse_ignore_nice_flag.diff"
Content-Transfer-Encoding: quoted-printable

diff -r -u -d linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_conservative.c =
linux-2.6.14-rc2/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_conservative.c	2005-10-03=
 20:05:30.742334750 +0100
+++ linux-2.6.14-rc2/drivers/cpufreq/cpufreq_conservative.c	2005-10-06 21:1=
0:47.785133750 +0100
@@ -93,7 +93,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ?=20
+		( dbs_tuners_ins.ignore_nice ?=20
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -127,7 +127,7 @@
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
 show_one(down_threshold, down_threshold);
-show_one(ignore_nice, ignore_nice);
+show_one(ignore_nice_tasks, ignore_nice);
 show_one(freq_step, freq_step);
=20
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
@@ -207,7 +207,7 @@
 	return count;
 }
=20
-static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+static ssize_t store_ignore_nice_tasks(struct cpufreq_policy *policy,
 		const char *buf, size_t count)
 {
 	unsigned int input;
@@ -272,7 +272,7 @@
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
-define_one_rw(ignore_nice);
+define_one_rw(ignore_nice_tasks);
 define_one_rw(freq_step);
=20
 static struct attribute * dbs_attributes[] =3D {
@@ -282,7 +282,7 @@
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
 	&down_threshold.attr,
-	&ignore_nice.attr,
+	&ignore_nice_tasks.attr,
 	&freq_step.attr,
 	NULL
 };
@@ -515,7 +515,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.ignore_nice =3D 1;
 			dbs_tuners_ins.freq_step =3D 5;
=20
 			dbs_timer_init();
diff -r -u -d linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_ondemand.c linu=
x-2.6.14-rc2/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-10-03 20:=
05:30.742334750 +0100
+++ linux-2.6.14-rc2/drivers/cpufreq/cpufreq_ondemand.c	2005-10-06 21:10:23=
=2E979646000 +0100
@@ -86,7 +86,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ?=20
+		( dbs_tuners_ins.ignore_nice ?=20
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -119,7 +119,7 @@
 show_one(sampling_rate, sampling_rate);
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
-show_one(ignore_nice, ignore_nice);
+show_one(ignore_nice_tasks, ignore_nice);
=20
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused,=
=20
 		const char *buf, size_t count)
@@ -179,7 +179,7 @@
 	return count;
 }
=20
-static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+static ssize_t store_ignore_nice_tasks(struct cpufreq_policy *policy,
 		const char *buf, size_t count)
 {
 	unsigned int input;
@@ -220,7 +220,7 @@
 define_one_rw(sampling_rate);
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
-define_one_rw(ignore_nice);
+define_one_rw(ignore_nice_tasks);
=20
 static struct attribute * dbs_attributes[] =3D {
 	&sampling_rate_max.attr,
@@ -228,7 +228,7 @@
 	&sampling_rate.attr,
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
-	&ignore_nice.attr,
+	&ignore_nice_tasks.attr,
 	NULL
 };
=20
@@ -424,7 +424,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.ignore_nice =3D 1;
=20
 			dbs_timer_init();
 		}

--J2SCkAp4GZ/dPZZf--

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFDRi1INv5Ugh/sRBYRAr1rAJ90M9j4NT4BZ1iC6jl3hTVRjXLUzACY72kA
b7wk7gNtu6yOQyHSzJYG8w==
=SMNa
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
