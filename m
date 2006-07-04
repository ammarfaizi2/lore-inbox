Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWGDKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWGDKZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWGDKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:25:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:49239 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751249AbWGDKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:25:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=UKpAIRPZx4W9Pl7HJPg5/YuQkZmY7lrR9JbSNu2P07LNvINVVkqyEc38iQBsd4nwPegVWi6eUQR8LDhV0KSh/T8UMiaAER2RaMITvqehI4igJ2DOghi1HIpHnta8AedDPwnu2OVGPXIdcwUWnDsuQnu2DyaRkFUFwm2LVR/FpFA=
Message-ID: <44AA4216.4040407@gmail.com>
Date: Tue, 04 Jul 2006 12:25:03 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, linux-pm@osdl.org
Subject: Re: swsusp regression
References: <44A99DFB.50106@gmail.com>	<44A99FE5.6020806@gmail.com>	<20060703161034.a5c4fba9.akpm@osdl.org>	<44A9AD48.5020400@gmail.com> <20060703172455.d45edb0a.akpm@osdl.org>
In-Reply-To: <20060703172455.d45edb0a.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton napsal(a):
> On Tue, 04 Jul 2006 01:50:09 +0159
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Andrew Morton napsal(a):
>>> On Tue, 04 Jul 2006 00:53:02 +0159
>>> Jiri Slaby <jirislaby@gmail.com> wrote:
>>>
>>>> Jiri Slaby napsal(a):
>>>>> Hello,
>>>>>
>>>>> when suspending machine with hyperthreading, only Freezing cpus appears and then
>>>> Note: suspending to disk; done by:
>>>> echo reboot > /sys/power/disk
>>>> echo disk > /sys/power/state
>>>>
>>>>> it loops somewhere. I tried to catch some more info by pressing sysrq-p. Here
>>>>> are some captures:
>>>>> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
>>>>> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif
>>>> One more from some previous kernels (cutted sysrq-t):
>>>> http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg
>>>>
>>> If you replace kernel/stop_machine.c with the version from 2.6.17, does it
>>> help?
>> Yup. It seems so.
>>
> 
> OK.  I don't see what the problem is - let's just revert it.

I dag into that deeply and:
struct task_struct *__stop_machine_run(int (*fn)(void *), void *data,
                                       unsigned int cpu)
{
[...]
        p = kthread_create(do_stop, &smdata, "kstopmachine");
        if (!IS_ERR(p)) {
                kthread_bind(p, cpu);
                wake_up_process(p);
                wait_for_completion(&smdata.done);
[...]
So here the thread is created and kernel waits for completion. OK.


static int do_stop(void *_smdata)
{
[...]
        /* We're done: you can kthread_stop us now */
        complete(&smdata->done);

This is called, some work is done, so call complete:
void fastcall complete(struct completion *x)
{
        unsigned long flags;

        spin_lock_irqsave(&x->wait.lock, flags);
        x->done++;
        __wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
                         1, 0, NULL);
        spin_unlock_irqrestore(&x->wait.lock, flags);
}
Nice, but spin_unlock_irqrestore never returns -- it loops in preempt_enable(),
why? Is TIF_NEED_RESCHED set all the time? Wouldn't be this the culprit?

regards,
-- 
Jiri Slaby        www.fi.muni.cz/~xslaby/
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
