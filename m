Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVCVFuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVCVFuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVCVFrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:47:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12929 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262472AbVCVFng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:43:36 -0500
Date: Mon, 21 Mar 2005 21:43:45 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322054345.GB1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321090622.GA8430@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 10:06:22AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > got this early-bootup crash on an SMP box:
> > 
> > the same kernel image boots fine on an UP box, so it's an SMP bug.
> > 
> > note that the same occurs with your latest (synchronization barrier)
> > fixes applied as well.
> 
> i've uploaded my current tree (-V0.7.41-01) to:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> it includes the latest round of RCU fixes - but doesnt solve the SMP
> bootup crash.

Hello, Ingo,

Does the following help with the SMP problem?  This fix and the earlier
one make my old patch survive a few rounds of kernbench on a 4-CPU x86
box.  (Yes, I am still being cowardly!  But happy that the test system
is alive again!)  Without these fixes, it too dies during boot.

							Thanx, Paul

diff -urpN -X dontdiff linux-2.6.11.fixes2/kernel/rcupdate.c linux-2.6.11.fixes3/kernel/rcupdate.c
--- linux-2.6.11.fixes2/kernel/rcupdate.c	Mon Mar 21 08:17:00 2005
+++ linux-2.6.11.fixes3/kernel/rcupdate.c	Mon Mar 21 20:00:00 2005
@@ -633,7 +633,7 @@ void rcu_check_callbacks(int cpu, int us
 {
 	if ((unsigned long)(jiffies - rcu_ctrlblk.last_sk) > 
 	    HZ/GRACE_PERIODS_PER_SEC) {
-		synchronize_kernel();
+		_synchronize_kernel();
 		rcu_advance_callbacks();
 		rcu_process_callbacks();
 	}
