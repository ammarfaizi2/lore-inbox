Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVCVFpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVCVFpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVCVFm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:42:29 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57527 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262387AbVCVFkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:40:24 -0500
Date: Mon, 21 Mar 2005 21:40:25 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322054025.GA1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <423F5456.5010908@fbab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F5456.5010908@fbab.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 12:10:14AM +0100, Magnus Naeslund(t) wrote:
> Ingo Molnar wrote:
> >
> >i've uploaded my current tree (-V0.7.41-01) to:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> >
> >it includes the latest round of RCU fixes - but doesnt solve the SMP
> >bootup crash.
> >
> >	Ingo
> 
> With this kernel I can run for some 20 minutes, then the ip_dst_cache 
> overflows.
> I gather it has something to do with RCU...
> 
> If I just let it run and grep ip_dst_cache /proc/slab it goes up to 4096 
> (max) and then the printk's are starting, and the networks stops.
> After i up the limit to the double (echo "8192" > 
> /proc/sys/net/ipv4/route/max_size) network starts to work again.
> But of course, after a while it overflows again:
> 
> # grep ip_dst_cache /proc/slabinfo
> ip_dst_cache        8192   8205    256   15    1 : tunables   16    8 
>  0 : slabdata    547    547      0
> 
> I haven't tried the vanilla 2.6.12-rc2 kernel, and I don't have the time 
> to do that right now, but i figured it would have something to do with 
> your patch. Older 2.6.8 works just fine.

Hello, Magnus,

I believe that my earlier patch might take care of this (included again
for convenience).

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.11.fixes/kernel/rcupdate.c linux-2.6.11.fixes2/kernel/rcupdate.c
--- linux-2.6.11.fixes/kernel/rcupdate.c	Mon Mar 21 08:14:47 2005
+++ linux-2.6.11.fixes2/kernel/rcupdate.c	Mon Mar 21 08:17:00 2005
@@ -620,7 +620,7 @@ static void rcu_process_callbacks(void)
 		return;
 	}
 	rdp->donelist = NULL;
-	rdp->donetail = &rdp->waitlist;
+	rdp->donetail = &rdp->donelist;
 	put_cpu_var(rcu_data);
 	while (list) {
 		next = list->next;
