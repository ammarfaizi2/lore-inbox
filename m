Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271889AbRIDElm>; Tue, 4 Sep 2001 00:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271891AbRIDElV>; Tue, 4 Sep 2001 00:41:21 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54290 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271889AbRIDElU>;
	Tue, 4 Sep 2001 00:41:20 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15252.21426.787059.469270@cargo.ozlabs.ibm.com>
Date: Tue, 4 Sep 2001 14:08:18 +1000 (EST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Richard Henderson <rth@twiddle.net>, David Mosberger <davidm@hpl.hp.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
In-Reply-To: <20010904043151.H699@athlon.random>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010903131436.A16069@twiddle.net>
	<15251.59286.154267.431231@napali.hpl.hp.com>
	<20010903134125.B16069@twiddle.net>
	<15252.13330.652765.959658@cargo.ozlabs.ibm.com>
	<20010904043151.H699@athlon.random>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> On Tue, Sep 04, 2001 at 11:53:22AM +1000, Paul Mackerras wrote:
> > For alpha, the thing that my patch does that might hurt is the change
> > from flush_icache_page to flush_icache_range in kernel/ptrace.c.  Any
> > comment on that?
> 
> For the alpha such change will imply a performance penablity (will throw
> away the whole icache, not only the one belonging to the ptraced task).

OK then maybe we need a flush_icache_user_range or something.

> We cannot change flush_icache_range to bump the asn because there's no
> vma in the flush_icache_range API (flush_icache_range in short is for
> the kernel side, like with vmalloc and kernel modules where a
> vma/mm/tsk wouldn't make sense anyways).

Yes, that is what Documentation/cachetlb.txt says.  I note that
currently flush_icache_range is used on user addresses in
binfmt_aout.c, and in fs/binfmt_elf.c in the load_aout_interp()
function.  But nobody uses a.out these days so that doesn't matter. :)

> what's the point of such change? The whole point of the patch is to work

flush_icache_page is not a good function to use because it is called
in do_swap_page and in do_no_page in mm/memory.c and in those cases
the page might already be i-cache clean and so we don't want to do any
flush.  In those cases, if the page does actually get read in from
disk then we do want to do the flush, if it was in the page cache or
swap cache and has been flushed before then we don't want to do the
flush.  (Actually doesn't that mean that on alpha you are throwing
away the whole icache for the process every time it faults in an
executable page?)

flush_icache_page is also not a good choice because it is overkill to
flush a whole page when you have just written one word, to put in a
breakpoint or something.

> with pages not with virtual addresses so you can do the bitflag
> bookeeping on the page structure, so I don't see why would you want to
> do the opposite change there.

I would be happy with an interface that took a struct page *, and
preferably an offset and length within the page.  That would be a new
interface though.  Note that the caller of access_process_vm can't
easily do the flush without duplicating most of the logic of
access_process_vm.

Paul.
