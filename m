Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317515AbSFML6K>; Thu, 13 Jun 2002 07:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317459AbSFML6J>; Thu, 13 Jun 2002 07:58:09 -0400
Received: from mail.webmaster.com ([216.152.64.131]:21938 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317441AbSFML6I> convert rfc822-to-8bit; Thu, 13 Jun 2002 07:58:08 -0400
From: David Schwartz <davids@webmaster.com>
To: <kernel@tekno-soft.it>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 13 Jun 2002 04:58:07 -0700
In-Reply-To: <5.1.1.6.0.20020613122534.02efe850@mail.tekno-soft.it>
Subject: Re: Developing multi-threading applications
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020613115808.AAA1253@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Depending by the applications. With my simulation/emulation program I need
>to create
>many thread because each thread resolve/manage/compute a specific problem 
and
>it's live depend by some factors. Each thread is create only if needed to
>avoid the
>overhead. The simulation/emulation is a "merge" of many and many object,
>each object
>work to resolve/manage/compute a specific problem. All the low objects are
>grouped to
>resolve a specific problem and are managed by a thread controller that
>should take some
>decision or doing some work. Some thread controller are grouped and managed
>by another
>thread controller and so on. Do not think that I need always 400 threads
>active they are
>create only if need by the controller. You must thinks this
>simulation/emulation as collection
>of many and many object that should interoperate, and the model is designed
>to scale easily
>on a distribuite environment.

	If it's a simulation, you don't *really* need the threads, you just need to 
be able to act as if you had them. After all, what are you simulating if what 
work gets done when is up to the random vagaries of the OS scheduler?

	If it's a real application wanting real performance, the suggestions I made 
stand -- you don't want many more threads working than you have CPUs and you 
don't want a lot of threads sitting around waiting for work (and thus forcing 
bazillions of extra context switches).

	It sounds to me like your design is broken, needlessly mapping threads to 
I/Os that are being waited for one-to-one. This is a common error among 
programmers who consciously or subconsciously have accepted the 'more threads 
can do more work' philosophy.

	What you need to do is take whatever it is you're thinking of as a 'thread' 
right now, which I'd roughly define as 'one logical task, from start to 
completion' and realize that there is absolutely no reason to map this 
one-to-one to actual pthreads threads and every reason in the world not to.

	This will conserve resources (12 thread stacks instead of 300, 12 KSEs 
instead of 300), reduce context switches (context switches will only occur 
when there's no work to do at all or a thread uses up its entire timeslice 
rather than every time we change which client/task we're doing work for/on), 
improve scheduler efficiency (because the number of ready threads will not 
exceed the number of CPUs by much) and more often than not, clean up a lot of 
ugliness in your architecture (because threads are probably being used 
instead of a sane abstraction for 'work to be done' or 'a client I'm doing 
work for').

	DS


