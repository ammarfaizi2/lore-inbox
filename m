Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVAUWou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVAUWou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVAUWou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:44:50 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:39387 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262550AbVAUWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:44:15 -0500
Message-ID: <41F185AF.9040507@kolivas.org>
Date: Sat, 22 Jan 2005 09:43:59 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched: account rt_tasks as iso_ticks
References: <20050119213818.55b14bb0.akpm@osdl.org>
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D7622297CCCE743F7BA6810"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D7622297CCCE743F7BA6810
Content-Type: multipart/mixed;
 boundary="------------060907060908080304010602"

This is a multi-part message in MIME format.
--------------060907060908080304010602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


SCHED_ISO tasks should have their cpu accounting be a proportion of 
ticks that would normally be available for SCHED_NORMAL tasks.

Add ticks consumed by rt_tasks to the iso_ticks variable and comments.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--------------060907060908080304010602
Content-Type: text/x-diff;
 name="account_rt_tasks_in_iso_ticks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="account_rt_tasks_in_iso_ticks.diff"

Index: linux-2.6.11-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.11-rc1-mm2.orig/kernel/sched.c	2005-01-22 09:36:27.000000000 +1100
+++ linux-2.6.11-rc1-mm2/kernel/sched.c	2005-01-22 09:36:49.000000000 +1100
@@ -2499,7 +2499,13 @@ void scheduler_tick(void)
 	task_t *p = current;
 
 	rq->timestamp_last_tick = sched_clock();
-	if (iso_task(p) && !rq->iso_refractory)
+	/*
+	 * The iso_ticks accounting is incremented only when a SCHED_ISO task
+	 * is running in soft rt mode. Running rt_tasks are also accounted
+	 * to make the iso_cpu a proportion of cpu available for SCHED_NORMAL
+	 * tasks only.
+	 */
+	if (rt_task(p) || (iso_task(p) && !rq->iso_refractory))
 		inc_iso_ticks(rq, p);
 	else
 		dec_iso_ticks(rq, p);

--------------060907060908080304010602--

--------------enig5D7622297CCCE743F7BA6810
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8YWvZUg7+tp6mRURAq5IAJ96xoJDyzL7QaHNUObmHo8Dc0byXwCgglbk
rCN8bAoiRbmERPu7lTPl4gs=
=jIg2
-----END PGP SIGNATURE-----

--------------enig5D7622297CCCE743F7BA6810--
