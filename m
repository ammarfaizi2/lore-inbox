Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132583AbRDERGq>; Thu, 5 Apr 2001 13:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132901AbRDERGg>; Thu, 5 Apr 2001 13:06:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49024 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132583AbRDERGU>; Thu, 5 Apr 2001 13:06:20 -0400
Date: Thu, 5 Apr 2001 12:52:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Fremlin <chief@bandits.org>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: how to let all others run
In-Reply-To: <m2itkjwdbt.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.3.95.1010405124737.15946A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Apr 2001, John Fremlin wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > On 4 Apr 2001, John Fremlin wrote:
> > > 
> > > Hi Oliver!
> > > 
> > >  Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> writes:
> > > 
> > > > is there a way to let all other runable tasks run until they block
> > > > or return to user space, before the task wishing to do so is run
> > > > again ?
> > > 
> > > Are you trying to do this in kernel or something? From userspace you
> > > can use nice(2) then sched_yield(2), though I don't know if the linux
> > > implementations will guarrantee anything.
> > > 
> > 
> > I recommend using usleep(0) instead of sched_yield(). Last time I
> > checked, sched_yield() seemed to spin and eat CPU cycles, usleep(0)
> > always gives up the CPU.
> 
> What is wrong with this? sched_yield only yields to processes with
> lower priority (hence suggestion to use nice(2)). Does sched_yield()
> fail to yield in cases when a higher priority process wants to run? 
> usleep() wastes time if no other such process is waiting, surely?
> 
> [...]

Only an observation:


main()
{
    nice(19);
    for(;;)
        sched_yield(); 
}

does...

[H[J[H[1m 12:45pm  up 19:10,  6 users,  load average: 0.66, 0.19, 0.06[K
31 processes: 29 sleeping, 2 running, 0 zombie, 0 stopped[K
CPU states: 44.1% user, 56.9% system, 99.1% nice,  0.0% idle[K
Mem:  320368K av, 309608K used,  10760K free,      0K shrd,  12688K buff[K
Swap:      0K av,      0K used,      0K free                188272K cached[K
[m[K
[7m  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND[K[m
15902 root      20  19   212  212   176 R N     0 99.1  0.0   1:05 xxx[K
15921 root      13   0   568  568   432 R       0  1.9  0.1   0:00 top[K
    1 root       8   0   148  148   116 S       0  0.0  0.0   0:00 init[K

It consumes 99.1 percent CPU, just spinning.


However,

	for(;;)
            usleep(0);

Doesn't even show on `top`. Further, it gets the CPU about 100 times
a second (HZ). This is normally what you want for something that
polls, buts needs to give up the CPU so that whatever it's waiting
for can get done as soon as possible.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


