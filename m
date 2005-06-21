Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVFUXST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVFUXST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVFUXSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:18:06 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:33433 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262440AbVFUXPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:15:21 -0400
Date: Wed, 22 Jun 2005 01:15:18 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
In-Reply-To: <Pine.OSF.4.05.10506220109490.17063-100000@da410.phys.au.dk>
Message-Id: <Pine.OSF.4.05.10506220113250.17063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Esben Nielsen wrote:

> 
> On Tue, 21 Jun 2005, Ingo Molnar wrote:
> 
> > 
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > 
> > > I am seeing very high latencies on 2.6.12-RT-V0.7.50-04 with a 
> > > modified realfeel2: maximum is 246 us. Shouldn't it be in the order of 
> > > 50 us?
> > 
> > i never got reliable results from realfeel - it should do the kind of 
> > careful things rtc_wakeup does to avoid false positives.
> > 
> I tried with rtc_wakeup while I was at work (which is on my disk at home) 
> - but it crashed my machine (one have to be _very_ carefull about what you
> do when you run in a task with RT priority!). I have fixed it now (see
> below patch) and it is running for the night. Let us see if I get similar
> results. 
> 

Yep, just as I pressed sent before I saw the following:

./rtc_wakeup -n 1000000 
rtc_wakeup - press ctrl-c to stop - use -h to get help
freq:             1024
max # of irqs:    1000000
jitter threshold: 5% (48 usec)
output filename:  /dev/null
rt priority:      80(90)
aquiring rt privs
getting cpu speed
696948901.455 Hz (696.949 MHz)
# of cycles for "perfect" period: 680614 (976 usec)
setting up ringbuffer
setting up consumer thread
setting up /dev/rtc
locking memory
turning irq on
new max. jitter: 0.2% (1 usec)
new max. jitter: 0.5% (4 usec)
new max. jitter: 0.6% (5 usec)
new max. jitter: 0.7% (6 usec)
new max. jitter: 1.0% (9 usec)
new max. jitter: 1.7% (16 usec)
new max. jitter: 1.8% (17 usec)
new max. jitter: 1.9% (18 usec)
new max. jitter: 3.9% (37 usec)
threshold violated: 6.3% (61usec)
new max. jitter: 6.3% (61 usec)
threshold violated: 28.0% (273usec)
new max. jitter: 28.0% (273 usec)
threshold violated: 25.0% (243usec)

Esben

> Esben
> 
> diff -Naur wakeup.cc~ wakeup.cc
> --- wakeup.cc~  2004-12-10 13:41:59.000000000 +0100
> +++ wakeup.cc   2005-06-21 22:28:53.000000000 +0200
> @@ -359,8 +359,7 @@
>    cycles_t last_cycles_count;
>    double max_jitter = 0;
>  
> -  struct timespec pause;
> -  pause.tv_nsec = 10000;
> +  struct timespec pause = { 0, 10000};
>    
>    std::cout.flags(std::ios::fixed);
>    std::cout << std::setprecision(1);
> @@ -428,7 +427,11 @@
>        if (max_number_of_irqs > 0 && total_num_of_irqs >= max_number_of_irqs)
>         stopit = true;
>      }
> -    nanosleep(&pause,0);
> +    if(nanosleep(&pause,0))
> +      {
> +       perror("nanosleep:");
> +       exit(1);
> +      }
>    }
>    std::cout << "done." << std::endl;
>    std::cout << "total # of irqs:      " << total_num_of_irqs << std::endl;
> 
> 
> 

