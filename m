Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUIOJc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUIOJc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUIOJc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:32:27 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:29575 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S261875AbUIOJcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:32:23 -0400
Message-ID: <19084.195.245.190.94.1095240596.squirrel@195.245.190.94>
In-Reply-To: <1095210962.2406.79.camel@krustophenia.net>
References: <20040903120957.00665413@mango.fruits.de> 
    <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> 
    <1094597710.16954.207.camel@krustophenia.net> 
    <1094598822.16954.219.camel@krustophenia.net> 
    <32930.192.168.1.5.1094601493.squirrel@192.168.1.5> 
    <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu> 
    <37312.195.245.190.93.1094728166.squirrel@195.245.190.93>
    <1095210962.2406.79.camel@krustophenia.net>
Date: Wed, 15 Sep 2004 10:29:56 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Florian Schmidt" <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 15 Sep 2004 09:32:22.0016 (UTC) FILETIME=[E6F54800:01C49B06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Lee Revell wrote:
>
>Rui Nuno Capela wrote:
>>
>> 8) Indeed, only by disabling both softirq and hardirq preeemption I get
>> an usable VP+SMP kernel. But that's no surprise either, it has been
>> always like that until Q3, which was the latest VP+SMP combination that
>> didn't suffer with the Wacom tablet presence at boot/init time. I only
>> hoped the (soft|hard)irq trouble would be solved by R9 time.
>
> Rui, did you ever get this working?  Other testers are not reporting
> problems, it would be good to know if there are still bugs lurking.
>
> Have you tried booting with hard and softirq preemption disabled and
> enabling them one at a time?
>

I've beeing doing a lot experiments, the trial-and-error way, by tweaking
kernel config options on and off, and (re)building the
linux-2.6.9-rc1-bk12-S0 SMP kernel.

I have some news indeed. As you may recall, I'm trying to run jackd
realtime low-latency audio on a P4 2.80C HT (Hyperthreading), and I keep
CONFIG_SMP=y always set.

I found, almost by mistake, that whether CONFIG_SCHED_SMT is set makes a
lot of difference.

a) With CONFIG_SCHED_SMT=y, which I've being doing since ever, the system
behavior is that same one I've been complaining about: having
softirq-preempt=0 and hardirq-preempt=0 is the minimal setting to run
jackd in realtime mode without hard-locking the whole system. Even then, I
get the system completely frozen more times than I like, almost twice a
day! Can't figure out who's or what's the culprit here. It's quite random.

b) When CONFIG_SCHED_SMT is not set, I can run all along with
softirq-preempt=1, hardirq-preempt=1 et al. While running jackd in
realtime mode, I get NO hard-locks, but unfortunately XRUNs are plenty. A
real storm. However I've noticed that the whole seems pretty much stable,
as I didn't experience one single system hang. Regression to
softirq-preempt=0 and hardirq-preempt=0 dissolves the xrun storm to
nothing again.

All my experiments were done based on starting jackd -R -p 128 -n 2 ...
using an onboard Intel ICH5 soundcrap driven by snd-intel8x0 (alsa). Oh, I
forgot to say that it's been always with kernel-preempt=1 and
voluntary-preempt=1.

I'm preparing to take some latency traces later on, while regarding the
SMP=1 SMT=0 configuration and softirq=1 hardirq=1 setting, in a effort to
let that horrible XRUN flux getting out of the way somehow, someday ;)

So, bottomline is that the SMT-aware scheduler is not ready for VP, isn't
it? Does anyone care to confirm this out?

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

