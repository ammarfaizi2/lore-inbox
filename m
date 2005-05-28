Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVE1F6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVE1F6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVE1F6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 01:58:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58782 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261971AbVE1F6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 01:58:08 -0400
Date: Sat, 28 May 2005 07:53:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050528055322.GA14867@elte.hu>
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <42978730.4040205@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42978730.4040205@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> I wrote:
> >I'm attaching a patch which changes a semaphore in cpufreq into a 
> >completion. With this patch, my system runs OK even with cpufreqd.
> >
> 
> Although the patch worked for me, it was probably bogus.

no, it was quite fine i think.

> The real reason why cpufreq caused problems was that it does:
>   init_MUTEX_LOCKED(&policy->lock);
> and later:
>   up(&policy->lock);
> where policy->lock is declared as:
>   struct semaphore        lock;
> 
> In PREEMPT_RT, the init_MUTEX_LOCKED is defined in include/linux/rt_lock.h :
>   /*
>    * No locked initialization for RT semaphores:
>    */
>   #define init_MUTEX_LOCKED(sem) compat_init_MUTEX_LOCKED(sem)
> (BTW, I don't understand why we have init_MUTEX but no init_MUTEX_LOCKED 
> for RT semaphores).

RT semaphores have stricter semantics than Linux semaphores. One 
property is that there always needs to be an owner of a semaphore. If a 
semaphore gets initialized as init_MUTEX_LOCKED, it is a fair indication
that the semaphore is really used as a completion object - with no
stable owner.  (e.g. at insmod time when the init_MUTEX_LOCKED is done,
the insmod thread will go away after some time, leaving the semaphore
'orphaned')

> So the fix is to change the lock type into compat_semaphore. I'm 
> attaching the patch. It works for me with 2.6.12-rc5-RT-V0.7.47-12.

it would be nice to get the conversion to completions upstream. It is a 
perfectly fine solution. The compat_semaphore thing is another, easier 
solution.

	Ingo
