Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQL0P5w>; Wed, 27 Dec 2000 10:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQL0P5n>; Wed, 27 Dec 2000 10:57:43 -0500
Received: from jalon.able.es ([212.97.163.2]:36544 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129573AbQL0P53>;
	Wed, 27 Dec 2000 10:57:29 -0500
Date: Wed, 27 Dec 2000 16:26:55 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Semaphores slow???
Message-ID: <20001227162655.A783@werewolf.able.es>
In-Reply-To: <200012271415.PAA18730@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200012271415.PAA18730@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Wed, Dec 27, 2000 at 15:15:35 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2000.12.27 Rogier Wolff wrote:
> We have a typical semaphore application that has a producer and a
> consumer.
> 
> Without the semaphores we are limited by the rest of the stuff to
> 10000 times around the loop per second. That's good.
> 
> When we put the "push the semaphore" call in there, the rate drops to
> around 8000 per second. I'm not happy about that, but ok. When we add
> the "wait for bufferspace" semaphore wait in there, the rate drops to
> 4000 per second. This is way too low.
> 

Look (s==write_sem, bs==write_buffer_sem):

cons        prod
====================
            wait(bs)
post(bs)    
wait(s)     <wake>
            <work>
            post(s)
<wake>      wait(bs)
<work>
post(bs)    
wait(s)     <wake>
            <work>
            post(s)
<wake>      wait(bs)
<work>
post(bs)    
wait(s)     <wake>
.................

So there is no way that <work> can be done at the same time on
producer and consumer. So if you measure the loops per sec of the
producer (for example), in 'free run' you get 10k, in synchro run
with consumer you have just the half, because really prod and cons
are running sequentially, one after the other.

You need to thighten the mutexed zone for the thing to work in parallel
in an efficient way.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3-aa3 #3 SMP Wed Dec 27 10:25:32 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
