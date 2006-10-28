Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWJ1XxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWJ1XxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 19:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWJ1XxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 19:53:19 -0400
Received: from [61.49.148.168] ([61.49.148.168]:24754 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S964934AbWJ1XxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 19:53:19 -0400
Date: Sun, 29 Oct 2006 07:50:47 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200610282350.k9SNoljL020236@freya.yggdrasil.com>
To: torvalds@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Cc: akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-28 19:41:50, Linus Torvalds wrote:
>On Sat, 28 Oct 2006, Adam J. Richter wrote:
>
>> On Fri, 27 Oct 2006 13:42:44 -0700 (PDT), Linus Torvals wrote:
>> >        static struct semaphore outstanding;
>> [...]
>> >        static void allow_parallel(int n)
>> [...]
>> >        static void wait_for_parallel(int n)
>> [...]
>> >        static void execute_in_parallel(int (*fn)(void *), void *arg)
>> 
>>       This interface would have problems with nesting.
>
>You miss the point.
>
>They _wouldn't_ be nested.
>
>The "allow_parallel()" and "wait_for_parallel()" calls would be at some 
>top-level situation (ie initcalls looping).
>
>Nobody else than the top level would _ever_ use them. Anything under that 
>level would just say "I want to do this in parallel" - which is just a 
>statement, and has no nesting issues in itself.

	If only calls to execute_in_parallel nest, your original
implementation would always deadlock when the nesting depth exceeds
the allowed number of threads, and also potentially in some shallower
nesting depths given a very unlucky order of execution.  In your
original message, you mentioned allowing the parallelism limit to be
set as low as 1.

	One solution to this problem would be to have
execute_in_parallel execute the function directly when no threads are
available to do it, rather than blocking.  The disadvantage is that,
if no thread is immediately available, the call to
execute_in_parallel would not return until the function that was
passed in finishes, even if more threads become available much sooner.

	Here is what I am referring to, again completely untested:


	static void execute_in_parallel(int (*fn)(void *), void *arg)
	{
		struct thread_exec arg = { .fn = fn, .arg = arg };

		/* If no threads are available, call the function directly. */
		if (down_trylock(&outstanding) != 0) {
			fn(arg);
			return;
		}

		arg.fn = fn;
		arg.arg = arg;
		init_completion(&arg.args_copied);

		kernel_thread(do_in_parallel, &arg);

		/* We need to wait until our "arg" is safe */
		wait_for_completion(&arg.args_copied)
	}


Adam Richter
