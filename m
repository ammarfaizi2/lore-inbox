Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWBOVBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWBOVBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWBOVBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:01:03 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:62604 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751290AbWBOVBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:01:01 -0500
Date: Wed, 15 Feb 2006 21:59:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060215205910.GA11130@elte.hu>
References: <20060215151711.GA31569@elte.hu> <200602151942.20494.ak@suse.de> <43F385C1.9020508@nortel.com> <200602152102.12795.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602152102.12795.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Wednesday 15 February 2006 20:49, Christopher Friesen wrote:
> 
> > The goal is for the kernel to unlock the mutex, but the next task to 
> > aquire it gets some special notification that the status is unknown.  At 
> > that point the task can either validate/clean up the data and reset the 
> > mutex to clean (if it can) or it can give up the mutex and pass it on to 
> > some other task that does know how to validate/clean up.
> 
> The "send signal when any mapper dies" proposal would do that. The 
> other process could catch the signal and do something with it.

the last time we had special signals for glibc-internal purpose it was 
called 'LinuxThreads'. The concept sucked big big time. Using internal 
signals means playing with the signal mask - this could conflict with 
the application, etc. etc. It's simply out of question to play signal 
games. Not to mention the problem of multiple mappers dying. Should thus 
queued signals be used? How about if the signal queue overflows.

Signals are really not for stuff like this. Signals are an old, 
semantics-laden and thus fragile concept that are not suited for 
abstractions like that.

Another flaw with your suggestion is that the mapper _might not know_ at 
the time of mmap() that this memory includes a robust futex. So that 
brings us back to the per-lock registration syscall approach (and 
overhead) that our patch avoids. Furthermore, glibc would have to track 
whether a thread used a robust mutex for the first time - which means 
external object to pthread_mutex_t - additional complications, overhead 
and design weaknesses.

If you take a look at the list-based robust futex code and the concept, 
you'll see that a lightweight userspace list of futexes, optionally 
parsed by the kernel, mixes very well with the existing futex philosophy 
and methodology. It doesnt have any of these complications and 
cornercases, precisely because its design aligns naturally with the 
futex philosophy: futexes are primarily memory based objects. They are 
not signals. They are not in-kernel structures. They are primarily a 
piece of userspace memory.

	Ingo
