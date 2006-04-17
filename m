Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWDQUFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWDQUFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWDQUFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:05:30 -0400
Received: from ns1.siteground.net ([207.218.208.2]:20386 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750724AbWDQUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:05:29 -0400
Date: Mon, 17 Apr 2006 13:06:06 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
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
       linux390@de.ibm.com, davem@davemloft.net, rusty@rustcorp.com.au,
       Christoph Lameter <clameter@engr.sgi.com>, dipankar@in.ibm.com
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-ID: <20060417200606.GA3945@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain> <17473.60411.690686.714791@cargo.ozlabs.ibm.com> <1145194804.27407.103.camel@localhost.localdomain> <200604161734.20256.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604161734.20256.arnd@arndb.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2006 at 05:34:18PM +0200, Arnd Bergmann wrote:
> On Sunday 16 April 2006 15:40, Steven Rostedt wrote:
> > I'll think more about this, but maybe someone else has some crazy ideas
> > that can find a solution to this that is both fast and robust.
> 
> Ok, you asked for a crazy idea, you're going to get it ;-)
> 
> You could take a fixed range from the vmalloc area (e.g. 1MB per cpu)
> and use that to remap pages on demand when you need per cpu data.
> 
> #define PER_CPU_BASE 0xe000000000000000UL /* arch dependant */
> #define PER_CPU_SHIFT 0x100000UL
> #define __per_cpu_offset(__cpu) (PER_CPU_BASE + PER_CPU_STRIDE * (__cpu))
> #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
> #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
> 
> This is a lot like the current sparc64 implementation already is.
> 
> The tricky part here is the remapping of pages. You'd need to 
> alloc_pages_node() new pages whenever the already reserved space is
> not enough for the module you want to load and then map_vm_area()
> them into the space reserved for them.
> 
> Advantages of this solution are:
> - no dependant load access for per_cpu()
> - might be flexible enough to implement a faster per_cpu_ptr()
> - can be combined with ia64-style per-cpu remapping

An implemenation similar to one you are mentioning was already proposed
sometime back.
http://lwn.net/Articles/119532/
The design was also meant to not restrict/limit per-cpu memory being
allocated from modules.  Maybe it was too early then, and maybe now is the 
right time, going by the interest in this thread :).  IMHO, a new solution
should fix both static and dynamic per-cpu allocators, 
- Avoid possibility of false sharing for dynamically allocated per-CPU data
(with current alloc percpu) 
- work early enough -- if alloc_percpu can work early enough, (we can use
that for counters like slab cachep stats which is currently racy; using 
atomic_t for them would be bad for performance)

An extra dereference in Steven's original proposal is bad, (I had done some
measurements earlier).  My implementation had one less reference compared to
static per-cpu allocators, but the performance of both were the same as
the __per_cpu_offset table is always cache hot.

> 
> Disadvantages are:
> - you can't use huge tlbs for mapping per cpu data like the
>   regular linear mapping -> may be slower on some archs

Yep, we waste a few tlb entries then, which is a bit of concern, but then we
might be able to use hugetlbs for blocks of per-cpu data and minimize the 
impact.

Thanks,
Kiran
