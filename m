Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130651AbRCIUFm>; Fri, 9 Mar 2001 15:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130644AbRCIUFd>; Fri, 9 Mar 2001 15:05:33 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:34876 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130662AbRCIUFV>; Fri, 9 Mar 2001 15:05:21 -0500
Message-ID: <3AA936B2.D2F26847@mvista.com>
Date: Fri, 09 Mar 2001 12:01:54 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Reinelt <reinelt@eunet.at>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep question
In-Reply-To: <3AA607E7.6B94D2D@eunet.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reinelt wrote:
> 
> Hi,
> 
> I've got a question regarding the nanosleep() system call.
> 
> I'm writing a little tool called lcd4linux
> (http://lcd4linux.sourceforge.net), where I have to drive displays
> connected to the parallel port. I'm doing this in userland, using
> outb().
> 
> Some of this displays require quite short delays (e.g. 40 microseconds),
> which cannot be done with normal nanosleep() because of the 10 msec
> timer resolution.
> 
> At the moment I implemented by own delay loop using a small assembler
> loop similar to the one used in the kernel. This has two disadvantages:
> assembler isn't that portable, and the loop has to be calibrated.

Why not use C?  As long as you calibrate it, it should do just fine.  On
the other hand, since you are looping anyway, why not loop on a system
time of day call and have the loop exit when you have the required time
in hand.  These calls have microsecond resolution.
> 
> I took a look at the nanosleep() implementation in the kernel, and found
> that it is possible to get very small delays, but only if I set the
> scheduling type to SCHED_RR or SCHED_FIFO.
> 
> Here are my questions:
> 
> - why are small delays only possible up to 2 msec? what if I needed a
> delay of say 5msec? I can't get it?

The system does these delays by looping in the task.  I.e. NO one else
gets to use the time.  I, for one, would like to see this go away.  See
: http://sourceforge.net/projects/high-res-timers/
In any case the limit is to put "some" bound on the "time out" from
doing useful work.

If you want other times, you can always make more than one call to
nanosleep.
> 
> - how dangerous is it to run a process with SCHED_RR? As far as I
> understood the nanosleep man page, it _is_ dangerous (if the process
> gets stuck in an endless loop, you can't even kill it if you don't have
> a shell which has a higher static priority than the stuck process
> itself).

That is the nature of real time.  You could code your task to insure
that the father process was of higher priority.  This, of course,
assumes that you can continue to communicate with that task via, e.g. X
which is usually running SCHED_OTHER.  In other words, to keep control,
you need to have all the tasks in the communication loop at higher (or
at least equal for SCHED_RR) priority than the bad guy.
> 
> - is it possible to switch between different scheduling modes? I cound
> run the program with normal SCHED_OTHER, and switch to SCHED_RR whenever
> I need to write data to the parallel port? Does this make sense?

Depends.  It is certainly possible.  The question is: Can your task
stand the loss of the processor to another task?  This is what happens
at normal SCHED_OTHER priority.
> 
> - what's the reason why these small delays is not possible with
> SCHED_OTHER?

Just a guess, but I would say because SCHED_OTHER tasks should not be so
time critical.

George
