Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWJ0Ut1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWJ0Ut1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWJ0Ut1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:49:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751251AbWJ0Ut1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:49:27 -0400
Date: Fri, 27 Oct 2006 13:42:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
In-Reply-To: <20061027131529.980cd53e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610271323020.3849@g5.osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
 <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org>
 <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com>
 <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org>
 <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org>
 <20061027114729.49185fd2@freekitty> <20061027131529.980cd53e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2006, Andrew Morton wrote:
> 
> I couldn't work out a way of doing that.  I guess one could a) count the
> number of threads which are going to be started, b) start them all, c) do
> an up() when each thread ends and d) handle errors somehow.

No. First off, you want to _limit_ the maximum number of parallelism 
anyway (memory pressure and sanity), so you want to use the counting 
semaphore for that too.

The easiest way to do it would probably be something like this:

	#define PARALLELISM (10)

	static struct semaphore outstanding;

	struct thread_exec {
		int (*fn)(void *);
		void *arg;
		struct completion completion;
	};

	static void allow_parallel(int n)
	{
		while (--n >= 0)
			up(&outstanding);
	}

	static void wait_for_parallel(int n)
	{
		while (--n >= 0)
			down(&outstanding);
	}

	static int do_in_parallel(void *arg)
	{
		struct thread_exec *p = arg;
		int (*fn)(void *) = p->fn;
		void *arg = p->arg;
		int retval;

		/* Tell the caller we are done with the arguments */
		complete(&p->completion);

		/* Do the actual work in parallel */
		retval = p->fn(p->arg);

		/*
		 * And then tell the rest of the world that we've
		 * got one less parallel thing outstanding..
		 */
		up(&outstanding);
		return retval;
	}

	static void execute_in_parallel(int (*fn)(void *), void *arg)
	{
		struct thread_exec arg = { .fn = fn, .arg = arg };

		/* Make sure we can have more outstanding parallel work */
		down(&outstanding);

		arg.fn = fn;
		arg.arg = arg;
		init_completion(&arg.completion);

		kernel_thread(do_in_parallel, &arg);

		/* We need to wait until our "arg" is safe */
		wait_for_completion(&arg.completion)
	}

The above is ENTIRELY UNTESTED, but the point of it is that it should now 
allow you to do something like this:

	/* Set up how many parallel threads we can run */
	allow_parallel(PARALLELISM);

	...

	/*
	 * Run an arbitrary number of threads with that
	 * parallelism.
	 */
	for (i = 0; i < ... ; i++)
		execute_in_parallel(fnarray[i].function, 
				    fnarray[i].argument);

	...

	/* And wait for all of them to complete */
	wait_for_parallel(PARALLELISM);

and this is totally generic (ie this is useful for initcalls or anything 
else). Note also how you can set up the parallelism (and wait for it) 
totally independently (ie that can be done at some earlier stage, and the 
"execute_in_parallel()" can just be executed in any random situation in 
between - as many times as you like. It will always honor the parallelism.

By setting PARALLELISM to 1, you basically only ever allow one outstanding 
call at any time (ie it becomes serial), so you don't even have to make 
this a config option, you could do it as a runtime setup thing.

Hmm?

(And I repeat: the above code is untested, and was written in the email 
client. It has never seen a compiler, and not gotten a _whole_ lot of 
thinking).

		Linus

