Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSKBVKA>; Sat, 2 Nov 2002 16:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSKBVKA>; Sat, 2 Nov 2002 16:10:00 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:12090 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261404AbSKBVJ7>; Sat, 2 Nov 2002 16:09:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Anu <avaidya@unity.ncsu.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: an idling kernel
Date: Sat, 2 Nov 2002 23:16:31 +0100
User-Agent: KMail/1.4.3
References: <Pine.GSO.4.44.0211021518290.6197-100000@sun.cesr.ncsu.edu>
In-Reply-To: <Pine.GSO.4.44.0211021518290.6197-100000@sun.cesr.ncsu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211022316.31977.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well.. this mailing list is not that bad for questions like this. You got the 
idea somewhat right though it is implemented quite different. The big word 
here is scheduling. A scheduler is a piece of code that determines what 
thread is to be executed next. How this is done is something entire books are 
written about, and a topic that will be discussed on the lkml often.

With linux, the idle thread is entered when the scheduler finds no threads 
ready for executing. (Not only sleeping, but also waiting for Disk etc) With 
some BSD clones, there is something of an idle queue, a list of threads that 
is only to be executed when the system is actually idle. When the scheduler 
access this queue, you know it has nothing important to do anymore. Linux 
uses priority queueing (see the nice manual for info on that). But, for both 
solutions holds: as soon as the scheduler reaches the end of the queue(Linux) 
/ queues (some BSDs) without finding a thread that can be executed, the 
scheduler enters the real idle thread.

In short: you don't really have to count. You only have to check if you reach 
the end of your thread list. Checking if a thread is able to run is what your 
scheduler already does.

See the scheduler code for more info.

Jos


On Saturday 02 November 2002 21:37, Anu wrote:
> disclaimer: if this is the wrong ng to be posting this to, its only due to
> ignorance.. I dont know the first thing about where to post this
> question..
>
> ----------------------------------------------------------------------
>
> Hello,
> 	Im ready to be beaten up for asking this question ( I am not sure
> which group to post to -- all this is new to me) but, I was wondering how
> one could figure out if the kernel was in idle mode (or idling).
>
> I *have* tried to look for the answer and here is waht I have come up with
> so far :
>
> Process 0 is the idle process.. but, I dont understand how you can tell if
> this means that the kernel is in idle mode. Do we just probe the state
> field of all process entries and check to see if everyone is sleeping and
> conclude that the kernel is idling??
>
> for_each_process(p)
>  {
>     if(process->state == S)
>      {
>         countup;
>      }
>  }
>
> if countup == number of processes, then the kernel was idling?
>
>
> -anu
>
> ***************************************************************************
>*****
>
> 			     Think, Train, Be
>
> ***************************************************************************
>****
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


