Return-Path: <linux-kernel-owner+w=401wt.eu-S964784AbWLTKke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWLTKke (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWLTKkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:40:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53183 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964784AbWLTKkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:40:33 -0500
Date: Wed, 20 Dec 2006 02:37:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Yinghai Lu" <yinghai.lu@amd.com>,
       "ard@telegraafnet.nl" <ard@telegraafnet.nl>, take@libero.it,
       agalanin@mera.ru, linux-kernel@vger.kernel.org,
       bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Zhang Yanmin" <yanmin.zhang@intel.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-Id: <20061220023734.863825e1.akpm@osdl.org>
In-Reply-To: <200612200502_MC3-1-D5AF-1674@compuserve.com>
References: <200612200502_MC3-1-D5AF-1674@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 04:59:19 -0500
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> > On 12/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > > So an external interrupt occurred, the system tried to use interrupt
> > > descriptor #39 decimal (irq 7), but the descriptor was invalid.
> > 
> > but the irq is disabled at that time.
> > 
> > can you use attached diff to verify if the irq is enable somehow?
> 
> But it seems interrupts are on--look at the flags:
> 
>         RSP: 0018:ffffffff803cdf68  EFLAGS: 00010246
> 

down_write()->__down_write()->__down_write_nested()->spin_unlock_irq()->dead

Could someone please test this?


--- a/lib/rwsem-spinlock.c~a
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

