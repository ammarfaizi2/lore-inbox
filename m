Return-Path: <linux-kernel-owner+w=401wt.eu-S932752AbXAQUcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbXAQUcD (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 15:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXAQUcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 15:32:03 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9411 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932752AbXAQUcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 15:32:01 -0500
Message-ID: <45AE87BC.4030404@fr.ibm.com>
Date: Wed, 17 Jan 2007 21:31:56 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Daniel Hokka Zakrisson <daniel@hozac.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, akpm@osdl.org,
       trond.myklebust@fys.uio.no,
       Linux Containers <containers@lists.osdl.org>
Subject: Re: NFS causing oops when freeing namespace
References: <57238.192.168.101.6.1169029688.squirrel@intranet> <m18xg1akmd.fsf@ebiederm.dsl.xmission.com> <51072.192.168.101.6.1169039633.squirrel@intranet> <20070117185823.GA878@tv-sign.ru> <45AE7705.4040603@fr.ibm.com> <20070117194632.GA1071@tv-sign.ru>
In-Reply-To: <20070117194632.GA1071@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 01/17, Cedric Le Goater wrote:
>> Oleg Nesterov wrote:
>>> On 01/17, Daniel Hokka Zakrisson wrote:
>>>> It was the only semi-plausible explanation I could come up with. I added a
>>>> printk in do_exit right before exit_task_namespaces, where sighand was
>>>> still set, and one right before the spin_lock_irq in lockd_down, where it
>>>> had suddenly been set to NULL.
>>> I can't reproduce the problem, but
>> I did on a 2.6.20-rc4-mm1.
>>
>>> 	do_exit:
>>> 		exit_notify(tsk);
>>> 		exit_task_namespaces(tsk);
>>>
>>> the task could be reaped by its parent in between.
>> indeed. while it goes spleeping in lockd_down() just before it does
>>
>> 	spin_lock_irq(&current->sighand->siglock);
>>
>> current->sighand is valid before interruptible_sleep_on_timeout() and
>> not after.
>>
>>> We should not use ->signal/->sighand after exit_notify().
>>>
>>> Can we move exit_task_namespaces() up?
>> yes but I moved it down because it invalidates ->nsproxy ...
> 
> Well, we can fix the symptom if we change lockd_down() to use
> lock_task_sighand(), or something like this,
> 
> 	--- NFS/fs/lockd/svc.c~lockd_down	2006-11-27 21:20:11.000000000 +0300
> 	+++ NFS/fs/lockd/svc.c	2007-01-17 22:39:47.000000000 +0300
> 	@@ -314,6 +314,7 @@ void
> 	 lockd_down(void)
> 	 {
> 		static int warned;
> 	+	int sigpending;
> 	
> 		mutex_lock(&nlmsvc_mutex);
> 		if (nlmsvc_users) {
> 	@@ -334,16 +335,15 @@ lockd_down(void)
> 		 * Wait for the lockd process to exit, but since we're holding
> 		 * the lockd semaphore, we can't wait around forever ...
> 		 */
> 	-	clear_thread_flag(TIF_SIGPENDING);
> 	+	sigpending = test_and_clear_thread_flag(TIF_SIGPENDING);
> 		interruptible_sleep_on_timeout(&lockd_exit, HZ);
> 		if (nlmsvc_pid) {
> 			printk(KERN_WARNING
> 				"lockd_down: lockd failed to exit, clearing pid\n");
> 			nlmsvc_pid = 0;
> 		}
> 	-	spin_lock_irq(&current->sighand->siglock);
> 	-	recalc_sigpending();
> 	-	spin_unlock_irq(&current->sighand->siglock);
> 	+	if (sigpending)	/* can be wrong at this point, harmless */
> 	+		set_thread_flag(TIF_SIGPENDING);
> 	 out:
> 		mutex_unlock(&nlmsvc_mutex);
> 	 }
> 
> but this is not good anyway.

your first analysis was correct : exit_task_namespaces() should be moved 
above exit_notify(tsk). It will require some extra fixes for nsproxy 
though.

C.
