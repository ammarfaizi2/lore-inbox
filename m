Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUG0PE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUG0PE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUG0PE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:04:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20096 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266362AbUG0PEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:04:25 -0400
Date: Tue, 27 Jul 2004 11:19:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040727141935.GB17456@logos.cnet>
References: <20040703051534.GA4998@devserv.devel.redhat.com> <Pine.LNX.4.44.0407261028470.21394-100000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407261028470.21394-100000@nacho.alt.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jul 26, 2004 at 10:41:24AM -0700, Chris Caputo wrote:
> On Sat, 3 Jul 2004, Arjan van de Ven wrote:
> > On Fri, Jul 02, 2004 at 01:00:19PM -0700, Chris Caputo wrote:
> > > On Fri, 25 Jun 2004, Marcelo Tosatti wrote:
> > > > On Wed, Jun 23, 2004 at 06:50:48PM -0700, Chris Caputo wrote:
> > > > > Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
> > > > > iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
> > > > > to ask.
> > > > 
> > > > Pretty sure it is, used all over. You can try to use non-optimize version 
> > > > at lib/dec_and_lock.c for a test.
> > > 
> > > My current theory is that occasionally when irqbalance changes CPU
> > > affinities that the resulting set_ioapic_affinity() calls somehow cause
> > > either inter-CPU locking or cache coherency or ??? to fail.
> > 
> > or.... some spinlock is just incorrect and having the irqbalance irqlayout
> > unhides that.. irqbalance only balances very very rarely so I doubt it's the
> > cause of anything...

Hi Chris,

> It has been a while since I have been able to follow up on this but I want
> to let you know that I _have been able_ to reproduce the problem (believed
> to be IRQ twiddling resulting in failed spinlock protection) with a stock
> kernel.

Well, no manipulation of the inode lists are done under IRQ context. 

What you think might be happening is that an IRQ comes in __refile_inode() 
(and other paths) and that causes a problem? 

Thats perfectly fine. Again, no manipulation of the lists are done in 
IRQ context.

> I would like to come up with a more reliable way to reproduce the problem
> with a stock kernel (2.4.26), since it is presently very rare (less than
> once per week) in the way I presently get it to happen, but as yet have
> not done so. 

What is your workload? I'm more than willing to use the SMP boxes I have 
access to try to reproduce this. 

You said you also reproduced the same inode_unused corruption with 2.4.24, yes?

> My plan of attack is to remove irqbalance from the equation and repeatedly
> change with random intervals /proc/irq entries directly from one user mode
> program while another user mode program does things which inspire a lot of
> fs/inode.c spinlock activity (since that is where I continue to see list
> corruption).
> 
> A few questions which could help me with this:
> 
>   - Which IRQ (if any) is used by CPU's to coordinate inter-CPU locking?

None as far as spinlocks are concerned. On x86 spinlock just does "lock ; dec $x" 
operation which guarantees the atomicity of the "dec". 

I feel I'm not answering your question, still. What do you mean?

>   - What does it mean if a stack trace is incomplete?  For example, one I 
>     have gotten is simply the tail end of the code snippet:
> 
>          0b 9a 00 5d c8
> 
>     And so I have wondered if the failure to make a full stack trace 
>     indicates something in of itself.

Dont know the answer. I also usually see incomplete stack traces
that I can make no sense of. 

> Thanks for any assistance.  I hope to find more time to work on this in
> the coming weeks.

I'm willing to help. Just please do not mix report data which includes
your own filesystem/modified kernel. Lets work with stock kernels and 
only that, to make it as simple as possible.

Thanks!

