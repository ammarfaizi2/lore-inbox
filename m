Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbUCOXK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUCOXK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:10:29 -0500
Received: from ns.suse.de ([195.135.220.2]:51902 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262912AbUCOXJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:09:52 -0500
Date: Tue, 16 Mar 2004 00:09:50 +0100
From: Kurt Garloff <garloff@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: dynamic sched timeslices
Message-ID: <20040315230950.GB4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040315224201.GX4452@tpkurt.garloff.de> <20040315225939.A23686@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1brTR8/mqxCEB6VZ"
Content-Disposition: inline
In-Reply-To: <20040315225939.A23686@infradead.org>
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1brTR8/mqxCEB6VZ
Content-Type: multipart/mixed; boundary="cUq9BFDytUJq8bQY"
Content-Disposition: inline


--cUq9BFDytUJq8bQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

quick response!
On Mon, Mar 15, 2004 at 10:59:39PM +0000, Christoph Hellwig wrote:
> Remove the silly desktop boot parameter and the patch looks basically
> okay to me.

See attachment.

> I remember we had a more complete patch to allow tuning the scheduler
> through sysctls in -mm once, though.  Questions is why that one wasn't
> merged and if the same reasons apply to a 'light' version.

Hmm, I fail to remember unfortunately. Probably it had too many knobs.
Andrew?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--cUq9BFDytUJq8bQY
Content-Type: text/plain; charset=us-ascii
Content-Description: dynamic-timeslice-2.diff
Content-Disposition: attachment; filename=dynamic-timeslice-2
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.6.4/include/linux/sched.h linux-2.6.4.dyn-timeslice/inclu=
de/linux/sched.h
--- linux-2.6.4/include/linux/sched.h	2004-03-16 00:03:52.000000000 +0100
+++ linux-2.6.4.dyn-timeslice/include/linux/sched.h	2004-03-16 00:05:14.000=
000000 +0100
@@ -176,6 +176,7 @@
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+extern int max_timeslice, min_timeslice;
=20
 struct namespace;
=20
diff -uNr linux-2.6.4/include/linux/sysctl.h linux-2.6.4.dyn-timeslice/incl=
ude/linux/sysctl.h
--- linux-2.6.4/include/linux/sysctl.h	2004-03-16 00:03:52.000000000 +0100
+++ linux-2.6.4.dyn-timeslice/include/linux/sysctl.h	2004-03-16 00:07:31.00=
0000000 +0100
@@ -134,6 +134,9 @@
 	KERN_KDB=3D64,		/* int: kdb on/off */
 	KERN_S390_HZ_TIMER=3D65,  /* int: hz timer on or off */
 	KERN_DUMP=3D66,		/* directory: dump parameters */
+	KERN_MAXTIMESLICE=3D67,	/* int: nice -20 max timeslice */
+	KERN_MINTIMESLICE=3D68,	/* int: nice +19 min timeslice */
+	KERN_HZ=3D69,		/* unsigned long: internal kernel HZ */
 };
=20
=20
diff -uNr linux-2.6.4/kernel/sched.c linux-2.6.4.dyn-timeslice/kernel/sched=
=2Ec
--- linux-2.6.4/kernel/sched.c	2004-03-16 00:03:52.000000000 +0100
+++ linux-2.6.4.dyn-timeslice/kernel/sched.c	2004-03-16 00:06:14.000000000 =
+0100
@@ -79,12 +79,17 @@
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
+/* the sysctl values are exported in usec units to userspace */
+int max_timeslice =3D __MAX_TIMESLICE, min_timeslice =3D __MIN_TIMESLICE;
+#define MAX_TIMESLICE ((max_timeslice * HZ + 999999) / 1000000)
+#define MIN_TIMESLICE ((min_timeslice * HZ + 999999) / 1000000)
+
 #define ON_RUNQUEUE_WEIGHT	 30
 #define CHILD_PENALTY		 95
 #define PARENT_PENALTY		100
diff -uNr linux-2.6.4/kernel/sysctl.c linux-2.6.4.dyn-timeslice/kernel/sysc=
tl.c
--- linux-2.6.4/kernel/sysctl.c	2004-03-16 00:03:52.000000000 +0100
+++ linux-2.6.4.dyn-timeslice/kernel/sysctl.c	2004-03-16 00:05:14.000000000=
 +0100
@@ -167,6 +167,7 @@
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
=20
+static unsigned long __HZ =3D HZ;
 /* The default sysctl tables: */
=20
 static ctl_table root_table[] =3D {
@@ -642,6 +643,30 @@
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

--cUq9BFDytUJq8bQY--

--1brTR8/mqxCEB6VZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVje+xmLh6hyYd04RAq1eAKCJWg/GkpsN5Em5F4UBbMrR522gVQCfa8fY
Yxgz3J3abM++COWBkwTTWIM=
=uiKR
-----END PGP SIGNATURE-----

--1brTR8/mqxCEB6VZ--
