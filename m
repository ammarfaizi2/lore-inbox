Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSFEU4n>; Wed, 5 Jun 2002 16:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFEU4m>; Wed, 5 Jun 2002 16:56:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33551 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313898AbSFEU4l>; Wed, 5 Jun 2002 16:56:41 -0400
Date: Wed, 5 Jun 2002 13:55:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Benjamin LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <p73vg8xcvco.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0206051352130.1471-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Jun 2002, Andi Kleen wrote:
> > 
> > Ah, you're right.  If anyone uses current_thread_info from IRQ context 
> > it will set the flags in the wrong structure.  However, it actually 
> > works because nobody does that currently: all of the _thread_flag users 
> 
> preemptive kernels do use current_thread_info() for every spinlock.
> this required me to change its implementation on x86-64 from stack
> arithmetic to access the base register. 

Note that this part is ok, as long as we make sure that the irq stack gets
initialized with a preempt_count > 0 (we must not preempt an interrupt
handler anyway, it wouldn't work), _and_ we make sure that taking the
interrupt also increments the "process native" preempt_count (so that
anybody looking at that preempt_count to determine whether it could be
preempted will also get a "nope, don't preempt me").

So that part doesn't look like a fundamental problem to me. It's just a 
"need to be careful" thing.

		Linus

