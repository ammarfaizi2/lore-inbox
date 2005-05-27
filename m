Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVE0Ut0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVE0Ut0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVE0Ut0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:49:26 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:34789 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S262583AbVE0Up4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:45:56 -0400
Message-ID: <42978730.4040205@stud.feec.vutbr.cz>
Date: Fri, 27 May 2005 22:46:40 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, Joe King <atom_bomb@rocketmail.com>,
       ganzinger@mvista.com, Lee Revell <rlrevell@joe-job.com>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz>
In-Reply-To: <4294E24E.8000003@stud.feec.vutbr.cz>
Content-Type: multipart/mixed;
 boundary="------------040605090609010207070109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040605090609010207070109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I wrote:
> I'm attaching a patch which changes a semaphore in cpufreq into a 
> completion. With this patch, my system runs OK even with cpufreqd.
> 

Although the patch worked for me, it was probably bogus.
The real reason why cpufreq caused problems was that it does:
   init_MUTEX_LOCKED(&policy->lock);
and later:
   up(&policy->lock);
where policy->lock is declared as:
   struct semaphore        lock;

In PREEMPT_RT, the init_MUTEX_LOCKED is defined in include/linux/rt_lock.h :
   /*
    * No locked initialization for RT semaphores:
    */
   #define init_MUTEX_LOCKED(sem) compat_init_MUTEX_LOCKED(sem)
(BTW, I don't understand why we have init_MUTEX but no init_MUTEX_LOCKED 
for RT semaphores).

Therefore we have an inconsistency - the up() gets translated into 
rt_up() because the lock is of type struct semaphore. However, 
compat_init_MUTEX_LOCKED assumes that it has a struct compat_semaphore.
The compiler actually warns about incompatible pointers but I missed 
that warning at first.
So the fix is to change the lock type into compat_semaphore. I'm 
attaching the patch. It works for me with 2.6.12-rc5-RT-V0.7.47-12.

Regards
Michal

--------------040605090609010207070109
Content-Type: text/plain;
 name="cpufreq-rt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq-rt.diff"

diff -Nurp -X linux-RT4/Documentation/dontdiff linux-RT4/include/linux/cpufreq.h linux-RT3/include/linux/cpufreq.h
--- linux-RT4/include/linux/cpufreq.h	2005-05-27 22:00:11.000000000 +0200
+++ linux-RT3/include/linux/cpufreq.h	2005-05-27 21:54:52.000000000 +0200
@@ -81,7 +81,7 @@ struct cpufreq_policy {
         unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 
- 	struct semaphore	lock;   /* CPU ->setpolicy or ->target may
+ 	struct compat_semaphore	lock;   /* CPU ->setpolicy or ->target may
 					   only be called once a time */
 
 	struct work_struct	update; /* if update_policy() needs to be

--------------040605090609010207070109--
