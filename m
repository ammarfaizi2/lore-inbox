Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUCOWof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUCOWn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:43:57 -0500
Received: from ns.suse.de ([195.135.220.2]:10409 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262840AbUCOWmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:42:08 -0500
Date: Mon, 15 Mar 2004 23:42:01 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: dynamic sched timeslices
Message-ID: <20040315224201.GX4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="krsqJi1PDCheOQxO"
Content-Disposition: inline
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--krsqJi1PDCheOQxO
Content-Type: multipart/mixed; boundary="YvxfeT9y/1FRS2+9"
Content-Disposition: inline


--YvxfeT9y/1FRS2+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

attached patch allows userspace to tune the scheduling timeslices.
It can be used for a couple of things:
* Tune a workload for batch processing:
  You'd probably wnat to use long timeslices in order to not reschedule
  as often to make good use of your CPU caches
* Tune a workload for interactive use:
  Under load, you may want to reduce the scedulilng latencies by using
  shorter timeslices (and there are situations where the interactiviy
  tweak -- even if they were perfect -- can't save you).
* Tune the ration betweeen maximum and minimum timeslices to make
  nice much nicer e.g.

The patch exports /proc/sys/kernel/max_timeslice and min_timeslice,
unites are us. It also exports HZ (readonly).
The patch implementes the desktop boot parameter which introduces=20
shorter timeslices.

Patch is from andrea and is in our 2.4 tree; 2.6 port was done by me and
straightforward.=20

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--YvxfeT9y/1FRS2+9
Content-Type: text/plain; charset=us-ascii
Content-Description: dynamic-timeslice.diff
Content-Disposition: attachment; filename=dynamic-timeslice
Content-Transfer-Encoding: quoted-printable

diff -uNrp linux-2.6.4/include/linux/sched.h linux-2.6.4.sched/include/linu=
x/sched.h
--- linux-2.6.4/include/linux/sched.h	2004-03-11 21:01:41.746772792 +0100
+++ linux-2.6.4.sched/include/linux/sched.h	2004-03-11 21:24:41.208062800 +=
0100
@@ -176,6 +176,7 @@ extern unsigned long cache_decay_ticks;
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+extern int max_timeslice, min_timeslice;
=20
 struct namespace;
=20
diff -uNrp linux-2.6.4/include/linux/sysctl.h linux-2.6.4.sched/include/lin=
ux/sysctl.h
--- linux-2.6.4/include/linux/sysctl.h	2004-03-11 21:01:41.747772640 +0100
+++ linux-2.6.4.sched/include/linux/sysctl.h	2004-03-11 21:32:32.968344336 =
+0100
@@ -134,6 +134,9 @@ enum
 	KERN_KDB=3D64,		/* int: kdb on/off */
 	KERN_S390_HZ_TIMER=3D65,  /* int: hz timer on or off */
 	KERN_DUMP=3D66,		/* directory: dump parameters */
+	KERN_MAXTIMESLICE=3D67,	/* int: nice -20 max timeslice */
+	KERN_MINTIMESLICE=3D68,	/* int: nice +19 min timeslice */
+	KERN_HZ=3D69,		/* unsigned long: interal kernel HZ */
 };
=20
=20
diff -uNrp linux-2.6.4/kernel/sched.c linux-2.6.4.sched/kernel/sched.c
--- linux-2.6.4/kernel/sched.c	2004-03-11 21:01:41.752771880 +0100
+++ linux-2.6.4.sched/kernel/sched.c	2004-03-11 22:06:26.166251272 +0100
@@ -79,12 +79,19 @@ EXPORT_SYMBOL(dump_oncpu);
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
- * maximum timeslice is 200 msecs. Timeslices get refilled after
- * they expire.
- */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
+ * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
+ * maximum timeslice is 300 msecs. Timeslices get refilled after
+ * they expire.=20
+ */
+#define __MIN_TIMESLICE		  10000
+#define __MAX_TIMESLICE		 300000
+#define __MIN_TIMESLICE_DESKTOP	   2000
+#define __MAX_TIMESLICE_DESKTOP	  60000
+/* the sysctl values are exported in usec units to userspace */
+int max_timeslice =3D __MAX_TIMESLICE, min_timeslice =3D __MIN_TIMESLICE;
+#define MAX_TIMESLICE ((max_timeslice * HZ + 999999) / 1000000)
+#define MIN_TIMESLICE ((min_timeslice * HZ + 999999) / 1000000)
+
 #define ON_RUNQUEUE_WEIGHT	 30
 #define CHILD_PENALTY		 95
 #define PARENT_PENALTY		100
@@ -2965,3 +2972,13 @@ task_t *kdb_cpu_curr(int cpu)
 	return(cpu_curr(cpu));
 }
 #endif
+
+static int __init init_desktop(char *str)
+{
+	min_timeslice =3D __MIN_TIMESLICE_DESKTOP;
+	max_timeslice =3D __MAX_TIMESLICE_DESKTOP;
+	return 1;
+}
+__setup("desktop", init_desktop);
+
+
diff -uNrp linux-2.6.4/kernel/sysctl.c linux-2.6.4.sched/kernel/sysctl.c
--- linux-2.6.4/kernel/sysctl.c	2004-03-11 21:01:37.983344920 +0100
+++ linux-2.6.4.sched/kernel/sysctl.c	2004-03-11 21:36:26.253879544 +0100
@@ -167,6 +167,7 @@ static void register_proc_table(ctl_tabl
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
=20
+static unsigned long __HZ =3D HZ;
 /* The default sysctl tables: */
=20
 static ctl_table root_table[] =3D {
@@ -642,6 +643,30 @@ static ctl_table kern_table[] =3D {
 		.mode		=3D 0444,
 		.proc_handler	=3D &proc_dointvec,
 	},
+	{
+		.ctl_name	=3D KERN_MAXTIMESLICE,=20
+		.procname	=3D "max-timeslice",
+		.data		=3D  &max_timeslice,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D &proc_dointvec,
+	},
+	{
+		.ctl_name	=3D KERN_MINTIMESLICE,=20
+		.procname	=3D "min-timeslice",
+		.data		=3D &min_timeslice,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D &proc_dointvec,
+	},
+	{
+		.ctl_name	=3D KERN_HZ,=20
+		.procname	=3D "HZ",
+		.data		=3D &__HZ,
+		.maxlen		=3D sizeof(long),
+		.mode		=3D 0444,
+		.proc_handler	=3D &proc_dointvec,
+	},
 	{ .ctl_name =3D 0 }
 };
=20

--YvxfeT9y/1FRS2+9--

--krsqJi1PDCheOQxO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVjE5xmLh6hyYd04RAgmvAJ9yINwBMyibHQ9EPNY3kBZXgXLrqQCfYl6t
4mwtPkOQZQLKy6jaJ1+98yg=
=Q0ey
-----END PGP SIGNATURE-----

--krsqJi1PDCheOQxO--
