Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTA3BUZ>; Wed, 29 Jan 2003 20:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTA3BUZ>; Wed, 29 Jan 2003 20:20:25 -0500
Received: from [195.223.140.107] ([195.223.140.107]:59776 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267267AbTA3BUY>;
	Wed, 29 Jan 2003 20:20:24 -0500
Date: Thu, 30 Jan 2003 02:29:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: frlock and barrier discussion
Message-ID: <20030130012928.GM1237@dualathlon.random>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net> <20030128230639.A17385@twiddle.net> <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 05:15:55PM -0800, Stephen Hemminger wrote:
> On Tue, 2003-01-28 at 23:06, Richard Henderson wrote:
> > On Tue, Jan 28, 2003 at 03:42:21PM -0800, Stephen Hemminger wrote:
> > > +static inline void fr_write_begin(frlock_t *rw)
> > > +{
> > > +	preempt_disable();
> > > +	rw->pre_sequence++;
> > > +	wmb();
> > > +}
> > > +
> > > +static inline void fr_write_end(frlock_t *rw)
> > > +{
> > > +	wmb();
> > > +	rw->post_sequence++;
> > 
> > These need to be mb(), not wmb(), if you want the bits in between
> > to actually happen in between, as with your xtime example.  At
> > present there's nothing stoping xtime from being *read* before
> > your read from pre_sequence happens.
> 
> 
> First, write_begin/end can only be safely used when there is separate
> writer synchronization such as a spin_lock or semaphore.  
> As far as I know, semaphore or spin_lock guarantees a barrier.
> So xtime or anything else can not be read before the spin_lock.
> 
> Using mb() is more paranoid than necessary. 

yes, it should only generate a superflous lock on x86.

it shouldn't even be necessary in fr_write_trylock.

Andrea
