Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUGZTWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUGZTWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUGZTWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:22:14 -0400
Received: from nacho.alt.net ([207.14.113.18]:4004 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S266128AbUGZRl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 13:41:29 -0400
Date: Mon, 26 Jul 2004 10:41:24 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040703051534.GA4998@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0407261028470.21394-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004, Arjan van de Ven wrote:
> On Fri, Jul 02, 2004 at 01:00:19PM -0700, Chris Caputo wrote:
> > On Fri, 25 Jun 2004, Marcelo Tosatti wrote:
> > > On Wed, Jun 23, 2004 at 06:50:48PM -0700, Chris Caputo wrote:
> > > > Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
> > > > iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
> > > > to ask.
> > > 
> > > Pretty sure it is, used all over. You can try to use non-optimize version 
> > > at lib/dec_and_lock.c for a test.
> > 
> > My current theory is that occasionally when irqbalance changes CPU
> > affinities that the resulting set_ioapic_affinity() calls somehow cause
> > either inter-CPU locking or cache coherency or ??? to fail.
> 
> or.... some spinlock is just incorrect and having the irqbalance irqlayout
> unhides that.. irqbalance only balances very very rarely so I doubt it's the
> cause of anything...

It has been a while since I have been able to follow up on this but I want
to let you know that I _have been able_ to reproduce the problem (believed
to be IRQ twiddling resulting in failed spinlock protection) with a stock
kernel.

I would like to come up with a more reliable way to reproduce the problem
with a stock kernel (2.4.26), since it is presently very rare (less than
once per week) in the way I presently get it to happen, but as yet have
not done so.

My plan of attack is to remove irqbalance from the equation and repeatedly
change with random intervals /proc/irq entries directly from one user mode
program while another user mode program does things which inspire a lot of
fs/inode.c spinlock activity (since that is where I continue to see list
corruption).

A few questions which could help me with this:

  - Which IRQ (if any) is used by CPU's to coordinate inter-CPU locking?

  - What does it mean if a stack trace is incomplete?  For example, one I 
    have gotten is simply the tail end of the code snippet:

         0b 9a 00 5d c8

    And so I have wondered if the failure to make a full stack trace 
    indicates something in of itself.

Thanks for any assistance.  I hope to find more time to work on this in
the coming weeks.

Chris

