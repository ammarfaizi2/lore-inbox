Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVARSLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVARSLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVARSLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:11:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:4792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261358AbVARSL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:11:29 -0500
Date: Tue, 18 Jan 2005 10:11:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pipe performance regression on ia64
In-Reply-To: <200501181741.j0IHfGf30058@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Jan 2005, Luck, Tony wrote:
> David Mosberger:
> >
> >So, when we run bw_pipe on a low load SMP machine, the kernel running in
> >a way load balancer always trying to spread out 2 processes while the
> >wake_up_interruptible_sync() is always trying to draw them back into
> >1 cpu.
> >
> >Linus's patch will reduce the change to call wake_up_interruptible_sync()
> >a lot.
> >
> >For bw_pipe writer or reader, the buffer size is 64k.  In a 16k page
> >kernel. The old kernel will call wake_up_interruptible_sync 4 times but
> >the new kernel will call wakeup only 1 time.

Yes, it will depend on the buffer size, and on whether the writer actually 
does any _work_ to fill it, or just writes it.

The thing is, in real life, the "wake_up()" tends to be preferable, 
because even though we are totally synchronized on the pipe semaphore 
(which is a locking issue in itself that might be worth looking into), 
most real loads will actually do something to _generate_ the write data in 
the first place, and thus you actually want to spread the load out over 
CPU's.

The lmbench pipe benchmark is kind of special, since the writer literally 
does nothing but write and the reader does nothing but read, so there is 
nothing to parallellize.

The "wake_up_sync()" hack only helps for the special case where we know 
the writer is going to write more. Of course, we could make the pipe code 
use that "synchronous" write unconditionally, and benchmarks would look 
better, but I suspect it would hurt real life.

The _normal_ use of a pipe, after all, is having a writer that does real
work to generate the data (like 'cc1'), and a sink that actually does real
work with it (like 'as'), and having less synchronization is a _good_ 
thing.

I don't know how to make the benchmark look repeatable and good, though.  
The CPU affinity thing may be the right thing.

For example, if somebody blocks on a semaphore, we actually do have some
code to try to wake it up on the same CPU that released the semaphore (in 
"try_to_wake_up()", but again, that in this case tends to be fought by the 
idle balancing there too.. And again, that does tend to be the right thing 
to do if the process has _other_ data than the stuff protected by the 
semaphore. It's just that pipe_bw doesn't have that..

(pipe_bw() also makes zero-copy pipes with VM tricks look really good, 
because it never does a store operation to the buffer it uses to write the 
data, so VM tricks never see any COW faults, and can just move pages 
around without any cost. Again, that is not what real life does, so 
optimizing for the benchmark does the wrong thing).

		Linus
