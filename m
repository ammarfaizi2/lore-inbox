Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUFLAal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUFLAal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFLAal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:30:41 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:56490 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264488AbUFLAah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:30:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] Performance regression in 2.6.7-rc3
Date: Sat, 12 Jun 2004 10:28:00 +1000
User-Agent: KMail/1.6.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q4kyAbdSBstgmrD"
Message-Id: <200406121028.06812.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Q4kyAbdSBstgmrD
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all

The OSDL robot monkeys revealed a massive reproducible regression in the=20
dbt3-pgsql benchmark which could be related to MBligh's measure regression.


2.6.7-rc2: http://khack.osdl.org/stp/293625/
Composite 	Query Processing Power 	Throughput Numerical Quantity
199.38 	152.52 	260.63

vs

2.6.7-rc3: http://khack.osdl.org/stp/293704/
Composite 	Query Processing Power 	Throughput Numerical Quantity
152.13 	146.36 	158.12


with a little bit of detective work and help from Wli we tracked down that=
=20
this patch caused it:
[PATCH] sched: improve wakeup-affinity
A massive increase in idle time was observed and the throughput dropped by =
40%
Reversing this patch gave these results:

backsched1: http://khack.osdl.org/stp/293865/
Composite 	Query Processing Power 	Throughput Numerical Quantity
193.93 	145.95 	257.67


It may be best to reverse this patch until the regression is better=20
understood.
Here is a patch reversing it:

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyk4SZUg7+tp6mRURAk5RAKCKIxzmRS3u+gs8W5gVyGgvL6glUgCeNggF
8mBUT4HtP4g5d/MViraZ9ds=3D
=3Dvj+s
=2D----END PGP SIGNATURE-----

--Boundary-00=_Q4kyAbdSBstgmrD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="backsched1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="backsched1.patch"

--- linux-2.6.7-rc3-base/kernel/sched.c	2004-06-10 23:29:04.000000000 +1000
+++ linux-2.6.7-rc3-backsched/kernel/sched.c	2004-06-12 02:11:13.600754377 +1000
@@ -770,8 +770,7 @@ static int try_to_wake_up(task_t * p, un
 		this_load -= SCHED_LOAD_SCALE;
 
 	/* Don't pull the task off an idle CPU to a busy one */
-	if (load < SCHED_LOAD_SCALE && load + this_load > SCHED_LOAD_SCALE
-			&& this_load > load)
+	if (load < SCHED_LOAD_SCALE/2 && this_load > SCHED_LOAD_SCALE/2)
 		goto out_set_cpu;
 
 	new_cpu = this_cpu; /* Wake to this CPU if we can */
@@ -1633,7 +1632,8 @@ nextgroup:
 	return busiest;
 
 out_balanced:
-	if (busiest && idle != NOT_IDLE && max_load > SCHED_LOAD_SCALE) {
+	if (busiest && (idle == NEWLY_IDLE ||
+			(idle == IDLE && max_load > SCHED_LOAD_SCALE)) ) {
 		*imbalance = 1;
 		return busiest;
 	}

--Boundary-00=_Q4kyAbdSBstgmrD--
