Return-Path: <linux-kernel-owner+willy=40w.ods.org-S317205AbUKBFeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S317205AbUKBFeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S774346AbUKBFeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:34:01 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:20202 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S376787AbUKBFcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 00:32:08 -0500
Message-ID: <41871BA7.6070300@kolivas.org>
Date: Tue, 02 Nov 2004 16:31:19 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] optional non-interactive mode for cpu scheduler
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig231ECA23F38B9A9A98A94BB1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig231ECA23F38B9A9A98A94BB1
Content-Type: multipart/mixed;
 boundary="------------080500050308020103030605"

This is a multi-part message in MIME format.
--------------080500050308020103030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

optional non-interactive mode for cpu scheduler



--------------080500050308020103030605
Content-Type: text/x-patch;
 name="sched-optional_non-interactive.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-optional_non-interactive.diff"

Some environments desire strict control over cpu resources based on nice
values without interactive determination.

Add a sysctl (/proc/sys/kernel/interactive) to disable dynamic priority
behaviour and interactive reinsertion.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2.orig/include/linux/sched.h	2004-11-02 13:20:03.000000000 +1100
+++ linux-2.6.10-rc1-mm2/include/linux/sched.h	2004-11-02 16:03:53.807209246 +1100
@@ -738,6 +738,7 @@ extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
+extern int sched_interactive;
 
 void yield(void);
 
Index: linux-2.6.10-rc1-mm2/include/linux/sysctl.h
===================================================================
--- linux-2.6.10-rc1-mm2.orig/include/linux/sysctl.h	2004-11-02 13:19:19.000000000 +1100
+++ linux-2.6.10-rc1-mm2/include/linux/sysctl.h	2004-11-02 16:07:46.071023189 +1100
@@ -134,6 +134,7 @@ enum
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
+	KERN_INTERACTIVE=67,	/* int: dynamic priorities */
 };
 
 
Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 14:52:51.000000000 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 16:13:48.419712248 +1100
@@ -150,8 +150,8 @@
 #define DELTA(p) \
 	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
 
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+#define TASK_INTERACTIVE(p) ((sched_interactive) && \
+	((p)->prio <= (p)->static_prio - DELTA(p)))
 
 #define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
@@ -602,6 +602,13 @@ static inline void enqueue_task_head(str
 }
 
 /*
+ * This is a sysctl which allows dynamic priorities to be applied based on
+ * interactive behaviour, and selective interactive reinsertion into the
+ * active array despite timeslice expiration.
+ */
+int sched_interactive = 1;
+
+/*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
@@ -622,6 +629,10 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
+	/* Dynamic priorities are not used with interactive mode off */
+	if (!sched_interactive)
+		return p->static_prio;
+
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
Index: linux-2.6.10-rc1-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sysctl.c	2004-11-02 13:19:19.000000000 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sysctl.c	2004-11-02 16:06:27.621555227 +1100
@@ -624,6 +624,14 @@ static ctl_table kern_table[] = {
 		.proc_handler   = &proc_unknown_nmi_panic,
 	},
 #endif
+	{
+		.ctl_name	= KERN_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &sched_interactive,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 


--------------080500050308020103030605--

--------------enig231ECA23F38B9A9A98A94BB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhxupZUg7+tp6mRURAvRKAJ0SIpvrVPPr+sT7n+5bRkyar+j9MgCeMd3C
iXa9hAwVpW4a4pWpr5FcoI8=
=fOok
-----END PGP SIGNATURE-----

--------------enig231ECA23F38B9A9A98A94BB1--
