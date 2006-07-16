Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWGPLUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWGPLUU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 07:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWGPLUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 07:20:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:17634 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751566AbWGPLUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 07:20:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=ibBx8B8N65YFy7teD+tFadasLcMdB7wq/OgJXXuOI+JcK0UbRkPjOK7bZYyrp2HqwhNHJ7npxFVbxQv+ADE/ILRQyvl1q9FsUhDDLnVFpNdrji/cYLhhgLZUltyg9yEYE6HCJgSMuqlI+g8TVck/xFKBWaS9cCDE4a4nkw7t4oU=
Date: Sun, 16 Jul 2006 13:20:40 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Where is RLIMIT_RT_CPU?
In-Reply-To: <1153044864.6374.135.camel@idefix.homelinux.org>
Message-ID: <Pine.LNX.4.64.0607161254260.9870@localhost.localdomain>
References: <1152663825.27958.5.camel@localhost>  <1152809039.8237.48.camel@mindpipe>
  <1152869952.6374.8.camel@idefix.homelinux.org> 
 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain> 
 <1152919240.6374.38.camel@idefix.homelinux.org>  <1152971896.16617.4.camel@mindpipe>
  <1152973159.6374.59.camel@idefix.homelinux.org>  <1152974578.3114.24.camel@laptopd505.fenrus.org>
  <1152975857.6374.65.camel@idefix.homelinux.org>  <1152978284.16617.7.camel@mindpipe>
  <1153009392.6374.77.camel@idefix.homelinux.org> 
 <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
 <1153044864.6374.135.camel@idefix.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006, Jean-Marc Valin wrote:

>> You can't have "random" users scheduling thing at real-time priorities.
>> A real-time system can only work if it is set up as whole and all
>> real-time tasks are taken into consideration. If you allow a user to start
>> another real-time task, that task might destroy the real-time properties
>> of all the rest by taking too much cpu.
>>
>> As I see it the only thing you can do is to use sudo to run anything,
>> which needs real-time priority, with higher priviliges, than what a normal
>> user have. Then he can only start specific audio programs and can't crash
>> the system (unless those programs have a bug).
>
> I though we were past that point a long time ago. Of course you don't
> want *any* random user to have access to rt scheduling. However, you
> *do* want the user logged-in on the console be allowed to run tasks with
> rt priority (within some limits). Why? Because 1) you don't want to give
> root access to any user who needs RT for some apps and 2) you don't want
> to make all these apps suid root either.
>

Who said suid root? What about suid realtime or suid audio?

> Think about it, would you really feel safe with your sound daemon,
> Ekiga/Gnomemeeting, jackd, Amarok, mplayer, ... all being run setuid
> root. Yet all these apps (and many others) can benefit from being
> allowed a few percent CPU running at rt priority. Not to mention the
> fact that you may actually want to do rt *development* as a regular
> user. That's why people have come up with realtime-lsm, and more
> recently, with SCHED_ISO and rt-limit. What's currently missing is just
> the tiny bit that prevents the user from locking up the machine. Even
> that one was done by Ingo, but unfortunately not merged in the mainline
> kernel. Controlled properly, access to rt scheduling is no more
> dangerous (and probably less) than fork(), malloc() or mlock(), all of
> which can lock up a machine efficiently if unlimited use is allowed.

My point is not that they can lock up the machine. My point is that you 
just can't add a rt task to a rt system! A rt-system consists of a fixed 
set of threads, which in worst case can meet it's deadlines. If you add 
just one task you might break the whole system. Only someone with overview 
of the whole system can add those tasks.

It is very simple if you have only a audio application or only a driver 
needing low latencies. What if you have both? You have to make sure that 
the higher priority one leaves enough cpu for the lower priority one. And 
it is not a question of using a low percentage of cpu. It is a question of 
how long the cpu is used in one go and how often it can happen within the 
critical timeframe of the lower priority application.

You can make a system which checks that but it is much harder to do than 
a moving average. The only thing which makes sense is (a) square filter(s)
with a width equal to the required latency of the lower priority task(s).

So the sys-admin should somehow be able to give the right either to 
specific (audio) applications with specific priorities or a developer whom 
he trusts (and it does not make sense to give it to both as they would 
then mess it up for each other!)

We have discussed that total lock-up can be prevented with a simple 
watchdog. That solution doesn't need anything added into the scheduler.

Esben

>
> 	Jean-Marc
>
