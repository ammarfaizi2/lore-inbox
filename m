Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSFRRNf>; Tue, 18 Jun 2002 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSFRRNd>; Tue, 18 Jun 2002 13:13:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37108 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317505AbSFRRN0>; Tue, 18 Jun 2002 13:13:26 -0400
Subject: Re: Question about sched_yield()
From: Robert Love <rml@tech9.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: David Schwartz <davids@webmaster.com>, mgix@mgix.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D0F669C.89596EC0@nortelnetworks.com>
References: <20020618093644.AAA9337@shell.webmaster.com@whenever> 
	<3D0F669C.89596EC0@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 10:13:20 -0700
Message-Id: <1024420400.3090.202.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 09:58, Chris Friesen wrote:

> David Schwartz wrote:
>
> >         What would you expect?
> 
> If there is only the one task, then sure it's going to be 100% cpu on that
> task.
> 
> However, if there is anything else other than the idle task that wants to
> run, then it should run until it exhausts its timeslice.
> 
> One process looping on sched_yield() and another one doing calculations
> should result in almost the entire system being devoted to calculations.

Exactly.  The reason the behavior is odd is not because the sched_yield
task is getting any CPU, David.  I realize sched_yield is not equivalent
to blocking.

The reason this behavior is suspect is because the task is receiving a
similar amount of CPU to tasks that are _not_ yielding but in fact doing
useful work for the entire duration of their timeslice.

A task that continually uses its timeslice vs one that yields should
easily receive a greater amount of CPU, but this is not the case.

As someone who works in the scheduler, this points out that sched_yield
is, well, broken.  First guess would be it is queuing to the front of
the runqueue (it once did this but I thought it was fixed) or otherwise
exhausting the timeslice wrong.

Someone pointed out this bug existed similarly in 2.5, although it was a
bit different.  2.5 has a different (and better, imo) sched_yield
implementation that tries to overcome certain shortcomings and also
perform optimally and fairly.

	Robert Love

