Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUC3Uhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUC3Uhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:37:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8129 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261171AbUC3Uhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:37:31 -0500
Date: Tue, 30 Mar 2004 22:38:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sched patch] more sync wakeups, 2.6.5-rc3-mm1
Message-ID: <20040330203802.GA5966@elte.hu>
References: <20040330185409.GA4214@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20040330185409.GA4214@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


(patch attached now.)

* Ingo Molnar <mingo@elte.hu> wrote:

> the attached patch extends sync wakeups to the process sys_exit() path
> too: the chldwait wakeup can be done sync, since we know that the
> process is going to exit (and thus deschedule).
> 
> the most visible effect of this change is strace's behavior on SMP
> systems: it now stays on a single CPU, together with the traced child. 
> (previously it would run in parallel to the child, bouncing around
> madly.)
> 
> compiled & tested.
> 
> 	Ingo

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-more-sync-wakeups.patch"

--- linux/kernel/signal.c.orig	
+++ linux/kernel/signal.c	
@@ -1386,12 +1386,12 @@ static inline void __wake_up_parent(stru
 	 * Fortunately this is not necessary for thread groups:
 	 */
 	if (p->tgid == tsk->tgid) {
-		wake_up_interruptible(&tsk->wait_chldexit);
+		wake_up_interruptible_sync(&tsk->wait_chldexit);
 		return;
 	}
 
 	do {
-		wake_up_interruptible(&tsk->wait_chldexit);
+		wake_up_interruptible_sync(&tsk->wait_chldexit);
 		tsk = next_thread(tsk);
 		if (tsk->signal != parent->signal)
 			BUG();

--82I3+IH0IqGh5yIs--
