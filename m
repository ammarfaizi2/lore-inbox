Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUF3Q7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUF3Q7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUF3Q7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:59:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15028 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266775AbUF3Q7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:59:43 -0400
Date: Wed, 30 Jun 2004 12:57:56 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040630165756.GX21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040630152651.GW21264@devserv.devel.redhat.com> <200406301632.i5UGW3Ai011182@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406301632.i5UGW3Ai011182@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 12:32:03PM -0400, Paul Davis wrote:
> >One thing to note is that NPTL defaults to PTHREAD_INHERIT_SCHED
> >while LinuxThreads defaults to PTHREAD_EXPLICIT_SCHED.
> >So, if you care about what scheduling created threads will have
> >and want it to work with both NPTL and LinuxThreads, you want
> >pthread_attr_setinheritsched (&attr, PTHREAD_*_SCHED);
> >explicitely.
> 
> But since we always set the scheduling class explicitly, should the
> inherited scheduler class make any difference?

Of course.
If you say
pthread_attr_init (&attr);
pthread_attr_setschedpolicy (&attr, SCHED_FIFO);
pthread_attr_setschedparam (&attr, &param);
pthread_create (&th, &attr, fn, arg);
then with LinuxThreads the thread will have FIFO policy while with
NPTL it won't unless the current thread has it.
If you:
pthread_attr_init (&attr);
pthread_attr_setschedpolicy (&attr, SCHED_FIFO);
pthread_attr_setschedparam (&attr, &param);
pthread_attr_setinheritsched (&attr, PTHREAD_INHERIT_SCHED);
pthread_create (&th, &attr, fn, arg);
then the thread will inherit scheduling parameters from current thread,
so unless it has FIFO the the fn thread will not have FIFO policy.
If you:
pthread_attr_init (&attr);
pthread_attr_setschedpolicy (&attr, SCHED_FIFO);
pthread_attr_setschedparam (&attr, &param);
pthread_attr_setinheritsched (&attr, PTHREAD_EXPLICIT_SCHED);
pthread_create (&th, &attr, fn, arg);
then thread will have FIFO policy in both NPTL and LinuxThreads.
For details see
http://www.opengroup.org/onlinepubs/009695399/functions/pthread_attr_getinheritsched.html

The reason why LinuxThreads defaults to PTHREAD_EXPLICIT_SCHED and
NPTL defaults to PTHREAD_INHERIT_SCHED is that those are the cheaper
variants.  LinuxThreads has a manager thread which creates the child
threads, so for INHERIT_SCHED it needs to issue some syscalls to query
scheduling parameters of the thread which called pthread_create.
In addition to this, no matter what inheritsched setting was, if the
desired sched parameters are different from the initial thread, it
needs to issue a system call to set it for the new thread.
NPTL doesn't have a manager thread and a child thread inherits parent
thread's settings without any syscalls anywhere.  For
PTHREAD_EXPLICIT_SCHED, it needs to issue a system call to set scheduling
params to the desired ones.

	Jakub
