Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUHINze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUHINze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUHINyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:54:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9435 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266573AbUHINx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:53:29 -0400
Date: Mon, 9 Aug 2004 08:49:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andi Kleen <ak@suse.de>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mpm@selenic.com
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / x86_64
Message-ID: <20040809114912.GA5287@logos.cnet>
References: <Pine.LNX.4.58.0408072217170.19619@montezuma.fsmlabs.com> <Pine.LNX.4.58.0408080156550.19619@montezuma.fsmlabs.com> <20040809132308.7312656b.ak@suse.de> <20040809114138.GB5191@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809114138.GB5191@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 08:41:38AM -0300, Marcelo Tosatti wrote:
> On Mon, Aug 09, 2004 at 01:23:08PM +0200, Andi Kleen wrote:
> > On Sun, 8 Aug 2004 02:08:30 -0400 (EDT)
> > Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> > 
> > >  arch/x86_64/Kconfig           |   10 ++++++++++
> > >  arch/x86_64/lib/Makefile      |    1 +
> > >  arch/x86_64/lib/spinlock.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > >  include/asm-x86_64/spinlock.h |   22 ++++++++++++++++++++--
> > >  4 files changed, 69 insertions(+), 2 deletions(-)
> > > 
> > > Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig
> > > ===================================================================
> > > RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/Kconfig,v
> > > retrieving revision 1.1.1.1
> > > diff -u -p -B -r1.1.1.1 Kconfig
> > > --- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig	5 Aug 2004 16:37:48 -0000	1.1.1.1
> > > +++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig	7 Aug 2004 22:47:30 -0000
> > > @@ -438,6 +438,16 @@ config DEBUG_SPINLOCK
> > >  	  best used in conjunction with the NMI watchdog so that spinlock
> > >  	  deadlocks are also debuggable.
> > > 
> > > +config COOL_SPINLOCK
> > > +	bool "Completely out of line spinlocks"
> > > +	depends on SMP
> > > +	default y
> > > +	help
> > > +	  Say Y here to build spinlocks which have common text for contended
> > > +	  and uncontended paths. This reduces kernel text size by at least
> > > +	  50k on most configurations, plus there is the additional benefit
> > > +	  of better cache utilisation.
> > 
> > I think the 50k number is wrong. I took a look at it and the big 
> > difference is only seen when you enable interrupts during spinning, which
> > we didn't do before.  If you compare it to the old implementation the
> > difference is much less.
> > 
> > I don't really like the config option. Either it's a good idea
> > then it should be done by default without option or it should not be done at all.
> > 
> > Did you do any lock intensive benchmarks that could show a slowdown?
> 
> Out of curiosity, also, have you ran any lock intensive benchmarks to get some
> numbers out of the increased cacheline hits due to uninlining? 
> 
> I think you can measure the hits/misses precisely with Mikael's perfcounters.

Hi Zwane, 

Just seen your bonnie++ results (should have the whole thread before replying), 
looks great, except a slight reduction in sequential output:

out-of-line spinlocks:
Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
stp2-000         2G  7018  99 64560  36 21694  16  6789  97 43729  14 340.6   1
stp2-000         2G  7055  99 64836  39 21899  16  6752  97 44827  17 330.8   2
stp2-000         2G  7023  99 64525  38 22987  17  6704  96 44777  14 337.3   1

mainline:
Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
stp2-000         2G  7048  99 64912  38 22510  17  6732  96 43900  14 332.0   1
stp2-000         2G  7018  99 63821  39 21732  16  6787  97 44889  17 326.7   2
stp2-000         2G  7063  99 63834  38 22361  17  6738  97 43310  14 338.3   1
                    ------Sequential Create------ --------Random Create--------

Probably just noise, still I think its worth mentioning.

