Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVAKU0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVAKU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAKU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:26:12 -0500
Received: from [202.141.25.89] ([202.141.25.89]:40615 "EHLO
	pridns.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S262577AbVAKUYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:24:37 -0500
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: SCHED_BATCH not stopped (swsusp fails)
References: <m3oeg1uk1y.fsf@rajsekar.pc> <20050110223213.GC1343@elf.ucw.cz>
	<41E30D4E.1070007@kolivas.org> <20050110234456.GC1444@elf.ucw.cz>
	<m38y70t7lo.fsf@rajsekar.pc> <41E3D6B4.2080706@kolivas.org>
From: Rajsekar <rajsekar@cse.iitm.ernet.in>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 12 Jan 2005 01:53:46 +0530
In-Reply-To: <41E3D6B4.2080706@kolivas.org> (Con Kolivas's message of "Wed,
 12 Jan 2005 00:37:56 +1100")
Message-ID: <m3d5wbd8a5.fsf@rajsekar.pc>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Con Kolivas <kernel@kolivas.org> writes:

> Rajsekar wrote:
>> Pavel Machek <pavel@ucw.cz> writes:
>>
>>>Hi!
>>>
>>>
>>>>>>SCHED_BATCH processes dont seem to heed the `stop' request (order?) by
>>>>>>swsusp.  I run httpd and mysqld (for my wiki page) with SCHED_BATCH (so
>>>>>>that I can work on my computer even if the load is very high) but when I
>>>>>>try to suspend the system, it tries to stop the tasks and simply returns.
>>>>>>Here is the dmesg output (paritial)
>>>>>
>>>>>
>>>>>Aha, so if it mysqld is not running SCHED_BATCH priority, stopping
>>>>>mysqld will work ok?
>>>>
>>>>That makes sense.
>>>>
>>>> Sorry, SCHED_BATCH is unique to my tree at the moment so this is my mistake for not considering it. I'll have to
>>>> transiently schedule SCHED_BATCH tasks as SCHED_NORMAL if we are going into swsusp. It's something I'll have to work
>>>> on. In the interim, a workaround would be to convert all httpd threads to SCHED_NORMAL before shutting down in your
>>>> scripts somewhere and convert them back after resuming.
>>>>
>>>>Cheers,
>>>>Con
>>>>
>>>> P.S. Raj the --cutme-- thing in your email is very annoying for those of us who reply to up to 300 emails a day (and
>>>> yes I do know why you do it, but if you keep doing it people will stop replying directly to you).
>>>
>>>Seconded. And by now your email address is in l-k, so you might simply
>>>give it up :-).
>>>								Pavel
>>> -- 
>>>People were complaining that M$ turns users into beta-testers...
>>>...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
>> Can you give me some ideas on how to go about it? Or why exactly
>> SCHED_BATCH does not respond to SIGSTOP (is it because of UNINTERRUPTIBLE
>> sleep)?
>
> I'm trying a patch to help it work properly; I haven't been able to test it. It is going into ck3. If you want you can
> try just that patch on your current kernel or download ck3.
>
> The small patch is attached.
>
> Cheers,
> Con
>
> Index: linux-2.6.10-ck3/kernel/power/process.c
> ===================================================================
> --- linux-2.6.10-ck3.orig/kernel/power/process.c	2005-01-11 22:44:13.000000000 +1100
> +++ linux-2.6.10-ck3/kernel/power/process.c	2005-01-11 22:58:39.367058561 +1100
> @@ -68,6 +68,12 @@ int freeze_processes(void)
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			unsigned long flags;
> +			if (batch_task(p))
> +				p->flags |= PF_UISLEEP;
> +				/*
> +				 * This will make batch tasks run SCHED_NORMAL
> +				 * too allow them to be frozen.
> +				 */
>  			if (!freezeable(p))
>  				continue;
>  			if ((p->flags & PF_FROZEN) ||
>
>

Your patch did not solve the problem.
The problem is that after you set the PF_UISLEEP flag, but no where else is it
checked.  My idea is to ignore freezing the PF_UISLEEP processes (hoping
they wont wake up in the mean time) and just adding another condition.  I
had add just one more line of code to make it work.  May be that it has
been added in swsusp and mine is out of date.

Could you tell me if what I have done is right?


--=-=-=
Content-Disposition: inline; filename=patch
Content-Description: Patch File

diff -Naur orig/kernel/power/process.c changed/kernel/power/process.c
--- orig/kernel/power/process.c	2005-01-12 01:49:52.846791528 +0530
+++ changed/kernel/power/process.c	2005-01-12 01:50:02.800278368 +0530
@@ -23,6 +23,7 @@
 {
 	if ((p == current) || 
 	    (p->flags & PF_NOFREEZE) ||
+	    (p->flags & PF_UISLEEP) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
 	    (p->state == TASK_STOPPED) ||
@@ -68,6 +69,12 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
+			if (batch_task(p))
+				p->flags |= PF_UISLEEP;
+				/*
+				 * This will make batch tasks run SCHED_NORMAL
+				 * too allow them to be frozen.
+				 */
 			if (!freezeable(p))
 				continue;
 			if ((p->flags & PF_FROZEN) ||

--=-=-=



-- 
    Rajsekar Manokaran
    IIT Madras

--=-=-=--

