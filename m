Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUHINxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUHINxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUHINxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:53:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7643 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266572AbUHINxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:53:22 -0400
Date: Mon, 9 Aug 2004 08:41:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andi Kleen <ak@suse.de>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mpm@selenic.com
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / x86_64
Message-ID: <20040809114138.GB5191@logos.cnet>
References: <Pine.LNX.4.58.0408072217170.19619@montezuma.fsmlabs.com> <Pine.LNX.4.58.0408080156550.19619@montezuma.fsmlabs.com> <20040809132308.7312656b.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809132308.7312656b.ak@suse.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 01:23:08PM +0200, Andi Kleen wrote:
> On Sun, 8 Aug 2004 02:08:30 -0400 (EDT)
> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> 
> >  arch/x86_64/Kconfig           |   10 ++++++++++
> >  arch/x86_64/lib/Makefile      |    1 +
> >  arch/x86_64/lib/spinlock.c    |   38 ++++++++++++++++++++++++++++++++++++++
> >  include/asm-x86_64/spinlock.h |   22 ++++++++++++++++++++--
> >  4 files changed, 69 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig
> > ===================================================================
> > RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/Kconfig,v
> > retrieving revision 1.1.1.1
> > diff -u -p -B -r1.1.1.1 Kconfig
> > --- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig	5 Aug 2004 16:37:48 -0000	1.1.1.1
> > +++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig	7 Aug 2004 22:47:30 -0000
> > @@ -438,6 +438,16 @@ config DEBUG_SPINLOCK
> >  	  best used in conjunction with the NMI watchdog so that spinlock
> >  	  deadlocks are also debuggable.
> > 
> > +config COOL_SPINLOCK
> > +	bool "Completely out of line spinlocks"
> > +	depends on SMP
> > +	default y
> > +	help
> > +	  Say Y here to build spinlocks which have common text for contended
> > +	  and uncontended paths. This reduces kernel text size by at least
> > +	  50k on most configurations, plus there is the additional benefit
> > +	  of better cache utilisation.
> 
> I think the 50k number is wrong. I took a look at it and the big 
> difference is only seen when you enable interrupts during spinning, which
> we didn't do before.  If you compare it to the old implementation the
> difference is much less.
> 
> I don't really like the config option. Either it's a good idea
> then it should be done by default without option or it should not be done at all.
> 
> Did you do any lock intensive benchmarks that could show a slowdown?

Out of curiosity, also, have you ran any lock intensive benchmarks to get some
numbers out of the increased cacheline hits due to uninlining? 

I think you can measure the hits/misses precisely with Mikael's perfcounters.

> 
> > Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c
> > ===================================================================
> > RCS file: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c
> > diff -N linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c
> > --- /dev/null	1 Jan 1970 00:00:00 -0000
> > +++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c	8 Aug 2004 05:39:04 -0000
> > @@ -0,0 +1,38 @@
> > +#include <linux/module.h>
> 
> You should make this file assembly only. 
