Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVEDSRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVEDSRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEDSQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:16:59 -0400
Received: from alog0132.analogic.com ([208.224.220.147]:15316 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261269AbVEDSQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:16:37 -0400
Date: Wed, 4 May 2005 14:16:24 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Olivier Croquette <ocroquette@free.fr>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
In-Reply-To: <4279084C.9030908@free.fr>
Message-ID: <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
References: <4279084C.9030908@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Olivier Croquette wrote:

> Hello
>
> On a 2.6.11 x86 system, I am SIGSTOP'ing processes which have started
> several threads before.
>
> As expected, all threads are suspended.
>
> But surprisingly, it can happen that some threads are still scheduled
> after the SIGSTOP has been issued.
>
> Typically, they get scheduled 2 times within the next 5ms, before being
> really stopped.
>
> Sadly, I could not reproduce that in a smaller example yet.
>
> As this behaviour is IMA against the SIGSTOP concept, I tried to analyze
> the kernel code responsible for that. I could not really find the exact
> lines.
>
> So here are my questions:
>
> 1. do you know any reason for which the SIGSTOP would not stop
> immediatly all threads of a process?
>
> 2. where do the threads get suspended exactly in the kernel? I think it
> is in signal.c but I am not sure exactly were.
>
> 3. can you confirm that the bug MUST be in my code? :)
>
> Thanks!
>
> Best regards
>
> Olivier


The kernel doesn't do SIGSTOP or SIGCONT. Within init, there is
a SIGSTOP and SIGCONT handler. These can be inherited by others
unless changed, perhaps by a 'C' runtime library. Basically,
the SIGSTOP handler executes pause() until the SIGCONT signal
is received.

Any delay in stopping is the time necessary for the signal to
be delivered. It is possible that the section of code that
contains the STOP/CONT handler was paged out and needs to be
paged in before the signal can be delivered.

You might quicken this up by installing your own handler for
SIGSTOP and SIGCONT....

static int stp;

static void contsig(int sig)	// SIGCONT handler
{
    stp = 0;
}

static void stopsig(int sig)  // SIGSTOP handler
{
     stp = 1;
     while(stp)
         pause();
}

Put this near the code that will be executing most of the time.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
