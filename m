Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbUKDQNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUKDQNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUKDQNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:13:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4747 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262269AbUKDQNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:13:10 -0500
Date: Thu, 4 Nov 2004 17:13:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104161344.GA31082@elte.hu>
References: <OFBDA242F0.2AF7EADB-ON86256F42.00585112-86256F42.0058514C@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFBDA242F0.2AF7EADB-ON86256F42.00585112-86256F42.0058514C@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >does the ping phenomenon go away if you chrt both the networking IRQ
> >thread and both ksoftirqd's to above the RT task's priority?
> 
> For the most part, yes. I reran the test with -V0.7.7 and had
> continuous ping responses until the system locked up with yet another
> deadlock. This did NOT fix the display / mouse movement lockups. All
> IRQ and ksoftirqd tasks were RT 99 priority for this test. latencytest
> ran at RT 30 priority.

what priority does events/0 and events/1 have? keventd handles part of
the mouse/keyboard workload.

> The deadlock was between the two ksoftirqd tasks...

there was one place missing - does the patch below fix this type of
deadlock?

	Ingo

--- linux/net/ipv4/tcp_timer.c.orig2	
+++ linux/net/ipv4/tcp_timer.c	
@@ -208,6 +208,7 @@ static void tcp_delack_timer(unsigned lo
 	struct sock *sk = (struct sock*)data;
 	struct tcp_opt *tp = tcp_sk(sk);
 
+	rcu_read_lock_read(&ptype_lock);
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
@@ -261,6 +262,7 @@ out:
 		sk_stream_mem_reclaim(sk);
 out_unlock:
 	bh_unlock_sock(sk);
+	rcu_read_unlock_read(&ptype_lock);
 	sock_put(sk);
 }
 
