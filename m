Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWDQCSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWDQCSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 22:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWDQCSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 22:18:11 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:20422 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750958AbWDQCSJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 22:18:09 -0400
Date: Sun, 16 Apr 2006 22:17:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Arnd Bergmann <arnd@arndb.de>
cc: Paul Mackerras <paulus@samba.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, rusty@rustcorp.com.au
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <200604170407.26111.arnd@arndb.de>
Message-ID: <Pine.LNX.4.58.0604162211430.3718@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <200604161734.20256.arnd@arndb.de> <1145234750.27828.8.camel@localhost.localdomain>
 <200604170407.26111.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Apr 2006, Arnd Bergmann wrote:

> Am Monday 17 April 2006 02:45 schrieb Steven Rostedt:
> > > - does not work in real mode, so percpu data can't be used
> > >   inside exception handlers on some architectures.
> >
> > This is probably a big issue.  I believe interrupt context in hrtimers
> > uses per_cpu variables.
>
> If it's just about hrtimers, it should be harmless, since they
> are run in softirq context. Even regular interrupt handlers are
> always called with paging enabled, otherwise you could not
> have them im modules.

Ah, you're right. You said exceptions, I'm thinking interrupts.  I was a
little confused why it wouldn't work.

>
> > > - memory consumption is rather high when PAGE_SIZE is large
> >
> > That's also something that I'm trying to solve.  To use the least amount
> > of memory and still have the performance.
> >
> > Now, I've also thought about allocating per_cpu and when a module is
> > loaded, reallocate more memory and copy it again.  Use something like
> > the kstopmachine to sync the system so that the CPUS don't update any
> > per_cpu variables while this is happening, so that things can't get out
> > of sync.
>
> I guess this breaks if someone holds a pointer to a per-cpu variable
> while a module gets loaded.
>

Argh, good point, I didn't think about that.  Hmm, this solution is
looking harder and harder.  Darn, I was really hoping this could be a
little better in space savings and robustness. It's starting to seem
clearer that Rusty's little hack, may be the best solution.

If that's the case, I can at least take comfort in knowing that the time I
spent on this is documented in LKML archives, and perhaps can keep others
from spending the time too.  That said, I haven't quite given up, and may
spend a couple more sleepless nights pondering this.

-- Steve

