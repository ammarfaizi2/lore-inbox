Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313936AbSDKAPH>; Wed, 10 Apr 2002 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313937AbSDKAPG>; Wed, 10 Apr 2002 20:15:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8196 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313936AbSDKAPG>; Wed, 10 Apr 2002 20:15:06 -0400
Date: Thu, 11 Apr 2002 02:15:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>
Subject: Re: Event logging vs enhancing printk
Message-ID: <20020411021518.E14605@dualathlon.random>
In-Reply-To: <20020410032328.C6875@dualathlon.random> <2032894297.1018391336@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 10:28:57PM -0700, Martin J. Bligh wrote:
> >> Right - what I'm proposing would be a generic equivalent of the
> >> local staging buffer and sprintf - basically just a little wrapper
> >> that does this for you, keeping a per task buffer somewhere.
> > 
> > That still doesn't solve the race with the interrupt handlers, you'd
> > need a buffer for each irq handler and one the softirq too to make
> > printk buffered and coeherent coherent across newlines (doable but even
> > more tricky and in turn less robust and less self contained).
> 
> I was envisaging a larger buffer where the current location pointer 
> simply taken by the interrupt handler, and the remaining section of
> that buffer was used for the "inner printk". Which is really just 
> like a stack, so it makes more sense to just allocate this off the
> stack really .... I think this would work? We might need to flush
> on a certain size limit (128 chars, maybe?) to stop any risk of
> stack overflow.

that's equivalent with the big difference it will waste many nr_task
times more ram, you'd need to reserve some ram in each task-buffer for
the nr_irqs*(bufsize+1) nested printk. So for every task in the system
you wouldn't have only the overhead of bufsize but bufsize*(nr_irqs+2).
It doesn't sound a good idea to me. remember all irqs can be nested. The
kernel stack is just unsafe enough against nested irq (not anymore on
x86-64 luckily), printk should have a guaranteed bufsize instead. It
would be pointless to make printk robust against \n and overflowing
trivially with nested irq, then you'd be unreliable again.

> > Some other code may omit it by mistake, leading to the other cpus
> > blackholed and data lost after the buffer on the other cpus overflowed
> > so at least we should put a timer that spawns an huge warning if a cpu
> > doesn't flush the buffer in a rasonable amount of time so we can catch
> > those places.
> 
> It seems that 99.9% of these cases are just assembling a line of output 
> a few characters at a time. There might be a few odd miscreants around,
> but not enough to worry about - I think it's overkill to do the runtime
> timer check, but we could always run like this to test it, or try to
> work some sort of automated code inspection (though that sounds hard to
> do 100% reliably).

Doing the check at runtime would be better, it will catch binary-only
module bugs and drivers out of the kernel bugs too. It should be
possible to disable the debugging feature with an #ifdef though.

But again, the above is all assuming we will change it, but I'm not
suggesting to change printk, I think atomicity printk-against-printk is
enough because of the non-segfaulting-human-parsing and because of the
low rate and in turn near zero probability for races (so basically zero
wasted time while reading the logs).

An high bandwith logging channel were such race starts to matter could
be built with PF_NETLINK or something like that, without using printk,
you need to store the plenty of data into a file and read it later, all
the console stuff is overhead for such a load, printk isn't high
bandwith in production, also think all the serial consoles out there.

Andrea
