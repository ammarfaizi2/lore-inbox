Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbTALJsL>; Sun, 12 Jan 2003 04:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTALJsD>; Sun, 12 Jan 2003 04:48:03 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:12193 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267355AbTALJsA>; Sun, 12 Jan 2003 04:48:00 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Fixing the tty layer was Re: any chance of 2.6.0-test*?
References: <20030110165441$1a8a@gated-at.bofh.it>
	<20030110165505$38d9@gated-at.bofh.it>
	<20030112094007$1647@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <20030112094007$1647@gated-at.bofh.it>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 12 Jan 2003 10:56:37 +0100
Message-ID: <m3iswuk7xm.fsf_-_@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[forgot to cc linux-kernel in the first try, sorry if you see it twice]

Greg KH <greg@kroah.com> writes:

> On Fri, Jan 10, 2003 at 05:19:08PM +0000, Alan Cox wrote:
> > The entire tty layer locking is terminally broken and nobody has even
> > started fixing it. Just try a mass of parallel tty/pty activity . It
> > was problematic before, pre-empt has taken it  to dead, defunct and
> > buried. 
> 
> I've looked into this, and wow, it's not a simple fix :(

it has to be fixed for 2.6, no argument.

I took a look at it. I think the easiest strategy would be:

- Make sure all the process context code holds BKL
(most of it does, but not all - sometimes it is buggy like in 
disassociate_tty) 
I have some patches for that for tty_io.c at least

The local_irq_save in there are buggy, they need to take 
a lock.

- Audit the data structures that are touched by interrupts
and add spinlocks.
At least for n_tty.c probably just tty->read_lock needs to be 
extended.
Perhaps some can be just "fixed" by ignoring latency and pushing
softirq functions into keventd
(modern CPUs should be fast enough for that) 

- Possibly disable module unloading for ldiscs (seems to be rather broken,
although Rusty's new unload algorithm may avoid the worst - not completely
sure)

Probably all doable with some concentrated effort.

Anyone interested in helping ?

-Andi
