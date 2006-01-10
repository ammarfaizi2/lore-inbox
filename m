Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWAJNId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWAJNId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWAJNId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:08:33 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:56747 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750995AbWAJNIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:08:32 -0500
Message-ID: <43C3C3B5.61D5641@tv-sign.ru>
Date: Tue, 10 Jan 2006 17:24:53 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rcu: fix hotplug-cpu ->donelist leak
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru> <20060109195933.GE14738@us.ibm.com> <20060110095811.GA30159@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pointed out by Srivatsa Vaddagiri <vatsa@in.ibm.com>.

rcu_do_batch() stops after processing maxbatch callbacks
on ->donelist leaving rcu_tasklet in TASKLET_STATE_SCHED
state.

If CPU_DEAD event happens remaining ->donelist entries are
lost, rcu_offline_cpu() kills this tasklet.

With this patch ->donelist migrates along with ->curlist
and ->nxtlist to the current cpu.

Compile tested.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/rcupdate.c~4_HPFIX	2006-01-10 19:06:38.000000000 +0300
+++ 2.6.15/kernel/rcupdate.c	2006-01-10 19:15:01.000000000 +0300
@@ -343,8 +343,9 @@ static void __rcu_offline_cpu(struct rcu
 	spin_unlock_bh(&rcp->lock);
 	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
 	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
-
+	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
 }
+
 static void rcu_offline_cpu(int cpu)
 {
 	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
