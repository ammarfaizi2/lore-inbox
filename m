Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVEDTKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVEDTKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVEDTKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:10:47 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:28571 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261381AbVEDTKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:10:40 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
From: Alexander Nyberg <alexn@dsv.su.se>
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4279084C.9030908@free.fr>
References: <4279084C.9030908@free.fr>
Content-Type: text/plain
Date: Wed, 04 May 2005 21:10:22 +0200
Message-Id: <1115233822.2562.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

The following scenario is possible:
program1 with a thread thread1

1) you send SIGSTOP to program1
2) thread1 is now scheduled and run.
3) program1 is now run and before it is scheduled off it notices it has
a signal set, makes sure all threads in the group gets SIGSTOP set.
4) thread1 is now scheduled and run again. now before it is scheduled
off it will find a signal pending and set itself in SIGSTOP.

There are absolutely no guarantees when a signal will be delivered.
Signals are delivered asynchronously.

> 2. where do the threads get suspended exactly in the kernel? I think it 
> is in signal.c but I am not sure exactly were.

do_notify_resume()
	do_signal()
		get_signal_to_deliver()
			do_signal_stop()
				finish_stop()

> 3. can you confirm that the bug MUST be in my code? :)

You'll have to use reliable mechanisms to achieve what you're looking
for.

