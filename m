Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312364AbSDJBnL>; Tue, 9 Apr 2002 21:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSDJBnK>; Tue, 9 Apr 2002 21:43:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17487 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312364AbSDJBnJ>; Tue, 9 Apr 2002 21:43:09 -0400
Date: Wed, 10 Apr 2002 03:23:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>
Subject: Re: Event logging vs enhancing printk
Message-ID: <20020410032328.C6875@dualathlon.random>
In-Reply-To: <3CB222AB.64005F3B@zip.com.au> <1934841354.1018293283@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 07:14:44PM -0700, Martin J. Bligh wrote:
> > Ah.  Yes, that will definitely happen.  We only have atomicity
> > at the level of a single printk call.
> > 
> > It would be feasible to introduce additional locking so that
> > multiple printks can be made atomic.  This should be resisted
> > though - printk needs to be really robust, and needs to have
> > a good chance of working even when the machine is having hysterics.
> > It's already rather complex.
> > 
> > For the rare cases which you cite we can use a local staging
> > buffer and sprintf, or just live with it, I suspect.
> 
> Right - what I'm proposing would be a generic equivalent of the
> local staging buffer and sprintf - basically just a little wrapper
> that does this for you, keeping a per task buffer somewhere.

That still doesn't solve the race with the interrupt handlers, you'd
need a buffer for each irq handler and one the softirq too to make
printk buffered and coeherent coherent across newlines (doable but even
more tricky and in turn less robust and less self contained).

> The reason I want to do it like this, rather than what you suggest,
> is that there are over 5000 of these "rare cases" of a printk without
> a newline, according to the IBM RAS group's code search ;-) I don't
> fancy changing that for 5000 instances (obviously some of those are
> grouped together, but the count is definitely non-trivial). I'd 
> attach the report they sent me, but it's 657K long ;-) 

Pavel omits the newline intentionally during debugging, to avoid losing
80% of the persistent stoarge in the framebuffer, but ok we could
implement a printk_flush that flushes the buffer afterwards no matte
what. Some other code may omit it by mistake, leading to the other cpus
blackholed and data lost after the buffer on the other cpus overflowed
so at least we should put a timer that spawns an huge warning if a cpu
doesn't flush the buffer in a rasonable amount of time so we can catch
those places.

Given the overcomplexity and the fact the logs should be parsed by
humans and the low probability for the race, I'm not sure if the above
is worthwhile.

If what you need is a high bandwith logging system, where with an high
frequency of posted events the races could become more likely to
trigger, printk is not the way to go for high bandwith anyways.

Andrea
