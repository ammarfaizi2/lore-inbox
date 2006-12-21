Return-Path: <linux-kernel-owner+w=401wt.eu-S1423068AbWLUURY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423068AbWLUURY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423074AbWLUURX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:17:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36927 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423068AbWLUURV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:17:21 -0500
Date: Thu, 21 Dec 2006 12:11:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-Id: <20061221121150.710fea0e.akpm@osdl.org>
In-Reply-To: <20061221195240.GS31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
	<20061221195240.GS31882@telegraafnet.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 20:52:40 +0100
Ard -kwaak- van Breemen <ard@telegraafnet.nl> wrote:

> Hello,
> 
> On Thu, Dec 21, 2006 at 04:04:04PM +0800, Zhang, Yanmin wrote:
> > I couldn't reproduce it on my EM64T machine. I instrumented function start_kernel and
> > didn't find irq was enabled before calling init_IRQ. It'll be better if the reporter could
> > instrument function start_kernel to capture which function enables irq.
> Just diving into the sources.
> Is that something like:
> if(!raw_irqs_disabled_flags) printk "irqs are enabled";
> 
> (At that moment it might have crashed already.. :-)).
> 
> I don't see the complete context yet, but I hope the irq is
> triggered after the irq is somehow enabled.
> 
> BTW: the panic occurs on half of my boards on tyan S2891 with 2
> opterons, of which the only difference seems to be the purchase
> date (and hence probably the motherboard revisions). (Haven't got
> time yet to pull them out of the rack and compare the
> motherboards).

please, I'm still waiting for someone to tell me whether this "fixes" it:


--- a/lib/rwsem-spinlock.c~down_write-preserve-local-irqs
+++ a/lib/rwsem-spinlock.c
@@ -195,13 +195,14 @@ void fastcall __sched __down_write_neste
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
+	unsigned long flags;
 
-	spin_lock_irq(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity = -1;
-		spin_unlock_irq(&sem->wait_lock);
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 		goto out;
 	}
 
@@ -216,7 +217,7 @@ void fastcall __sched __down_write_neste
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock_irq(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	/* wait to be given the lock */
 	for (;;) {
_

