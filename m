Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTLVBXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLVBVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:21:50 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:50059
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S264278AbTLVBUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:20:31 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, gnomemeeting-devel-list@gnome.org
In-Reply-To: <20031221085716.GA21322@elte.hu>
References: <200312201355.08116.kernel@kolivas.org>
	 <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au>
	 <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au>
	 <1071897314.1363.43.camel@localhost> <20031220111917.GA18267@elte.hu>
	 <1071938978.1025.48.camel@localhost> <20031220174232.GA29189@elte.hu>
	 <1071970825.1025.87.camel@localhost>  <20031221085716.GA21322@elte.hu>
Content-Type: text/plain
Message-Id: <1072055962.999.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 02:19:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-21 at 09:57, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > I tried to verify your suggestion and found that the P_RTEMS symbol is
> > not defined on Linux. It seems to be some other kind of realtime
> > operating system. So the code in question already uses usleep. Now I'm
> > still digging for other occurances of sched_yield in the pwlib
> > sources.
> 
> could you try to strace -f gnomemeeting? Maybe there's no sched_yield()
> at all. Could you also try to run the non-yielding loop code via:
> 
> 	nice -19 ./loop &
> 
> do a couple of such loops still degrade gnomemeeting?

I found the culprit. It's sched_yield again. When I straced gnomemeeting
even without load I saw a lot of sched_yields. So I googled around for
2.6 and sched_yield and found among others
http://www.hpl.hp.com/research/linux/kernel/o1-openmp.php by David
Mosberger. I tried gnomemeeting with the romp hack at the end of the
article which changes all sched_yields to noops via library preloading.
The difference was _really_ impressive. No matter how many non-yield
loops and kernel compiles I ran gnomemeeting didn't even skip once.

So the questionable code in pwlib is probably: 

> BOOL PSemaphore::Wait(const PTimeInterval & waitTime)
> {
>   if (waitTime == PMaxTimeInterval) {
>     Wait();
>     return TRUE;
>   }
>                                                                                 
>   // create absolute finish time
>   PTime finishTime;
>   finishTime += waitTime;
>                                                                                 
> #ifdef P_HAS_SEMAPHORES
>                                                                                 
>   // loop until timeout, or semaphore becomes available
>   // don't use a PTimer, as this causes the housekeeping
>   // thread to get very busy
>   do {
>     if (sem_trywait(&semId) == 0)
>       return TRUE;
>                                                                                 
>     PThread::Yield(); // One time slice
>   } while (PTime() < finishTime);
>  
>   return FALSE;

Defining Yield to noop and building a new libpt solved the problem
permanently for me.

It seems that not all people have got problems with gnomemeeting and
2.6. Damien Sandras (the gnomemeeting maintainer) for example reported
that he hasn't got any problems with gnomemeeting on 2.6 while compiling
in parallel. So I guess it's depending on the frequency of sched_yields
one gets in gnomemeeting. Which is probably depending on the processor
speed, etc.

That just leaves the question what is the proper fix, to send it
upstream and to note the phenomenon down in a faq.

Thanks to all who helped me with debugging advice and if anybody needs
further information just ask.


				Christian

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




