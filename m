Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270713AbUJUOiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbUJUOiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270698AbUJUOeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:34:00 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:40099
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270692AbUJUOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:30:40 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041021132717.GA29153@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098368557.27089.3.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 16:22:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 15:27, Ingo Molnar wrote:
> i have released the -U9 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 

impi watchdog conversion to completion api.

tglx

diff --exclude='*~' -urN
2.6.9-rc4-mm1-RT-U9/drivers/char/ipmi/ipmi_watchdog.c
2.6.9-rc4-mm1-U9-E0/drivers/char/ipmi/ipmi_watchdog.c
--- 2.6.9-rc4-mm1-RT-U9/drivers/char/ipmi/ipmi_watchdog.c	2004-10-21
15:47:23.000000000 +0200
+++ 2.6.9-rc4-mm1-U9-E0/drivers/char/ipmi/ipmi_watchdog.c	2004-10-21
15:41:53.000000000 +0200
@@ -386,16 +386,16 @@
    when both messages are free. */
 static atomic_t heartbeat_tofree = ATOMIC_INIT(0);
 static DECLARE_MUTEX(heartbeat_lock);
-static DECLARE_MUTEX(heartbeat_wait_lock);
+static DECLARE_COMPLETION(heartbeat_received);
 static void heartbeat_free_smi(struct ipmi_smi_msg *msg)
 {
     if (atomic_dec_and_test(&heartbeat_tofree))
-	    up(&heartbeat_wait_lock);
+	    complete(&heartbeat_received);
 }
 static void heartbeat_free_recv(struct ipmi_recv_msg *msg)
 {
     if (atomic_dec_and_test(&heartbeat_tofree))
-	    up(&heartbeat_wait_lock);
+	    complete(&heartbeat_received);
 }
 static struct ipmi_smi_msg heartbeat_smi_msg =
 {
@@ -473,7 +473,7 @@
 	}
 
 	/* Wait for the heartbeat to be sent. */
-	down(&heartbeat_wait_lock);
+	wait_for_completion(&heartbeat_received);
 
 	if (heartbeat_recv_msg.msg.data[0] != 0) {
 	    /* Got an error in the heartbeat response.  It was already


