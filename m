Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTFRO3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTFRO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:29:24 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:43714 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265252AbTFRO3W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:29:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.72 O(1) interactivity bugfix
Date: Thu, 19 Jun 2003 00:43:00 +1000
User-Agent: KMail/1.5.2
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306190043.14291.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ingo, all

While messing with the interactivity code I found what appears to be an 
uninitialised variable (p->sleep_avg), which is responsible for all the 
boost/penalty in the scheduler. Initialising this variable to 0 seems to have 
made absolutely massive improvements to system responsiveness under load
and completely removed audio skips up to doing a make -j64 on my uniprocessor 
P4 (beyond which swap starts being used), without changing the scheduler 
timeslices. This seems to help all 2.4 O(1) based kernels as well. Attached 
is a patch against 2.5.72 but I'm not sure about the best place to initialise 
it.


diff -Naurp linux-2.5.72/kernel/fork.c linux-2.5.72-test/kernel/fork.c
- --- linux-2.5.72/kernel/fork.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/fork.c	2003-06-19 00:30:26.000000000 +1000
@@ -864,6 +864,7 @@ struct task_struct *copy_process(unsigne
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
+	p->sleep_avg = 0;

 	retval = -ENOMEM;
 	if ((retval = security_task_alloc(p)))
diff -Naurp linux-2.5.72/kernel/sched.c linux-2.5.72-test/kernel/sched.c
- --- linux-2.5.72/kernel/sched.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/sched.c	2003-06-19 00:28:19.000000000 +1000
@@ -1755,6 +1755,7 @@ static int setscheduler(pid_t pid, int p
 	if (array)
 		deactivate_task(p, task_rq(p));
 	retval = 0;
+	p->sleep_avg = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	if (policy != SCHED_NORMAL)


I hope this is correct.

Regards,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+8Hp0F6dfvkL3i1gRAr/fAKCYbJ/yQhshqV7G43f+mQP4rZoKWgCfdD69
QuqYH58q6PdbD3qGFvjUKSs=
=huFo
-----END PGP SIGNATURE-----

