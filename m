Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWILPUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWILPUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWILPUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:20:44 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:23768 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030219AbWILPUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:20:43 -0400
In-Reply-To: <1158045200.15465.94.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain> <1157965071.23085.84.camel@localhost.localdomain> <1157966269.3879.23.camel@localhost.localdomain> <1157969261.23085.108.camel@localhost.localdomain> <m1pse17hzi.fsf@ebiederm.dsl.xmission.com> <1158040605.15465.70.camel@localhost.localdomain> <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com> <1158045200.15465.94.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8A2F9DF4-1A17-454C-8243-8F86CF04F763@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
Date: Tue, 12 Sep 2006 17:19:56 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, that's interesting because I need the exactly oposite on
> PowerPC I think.... That is people will -need- to do both a wc and a
> non-wc mapping if they want to be able to issue stores that are
> guaranteed not to be combined.

Or you do the sane thing and just not allow two threads of execution
access to the same I/O device at the same time.

> The problem I've seen is that at least one processor (the Cell) and
> maybe more seem to be combining between threads on the same CPU  
> (unless
> the stores are issues to a guarded mapping which prevents combining
> completely, that is the sort of mapping we currently do with ioremap).
>
> That means that it's impossible to prevent combining with explicit
> barriers. For example:

Now compare this with the similar scenario for "normal" MMIO, where
we do store;sync (or sync;store or even sync;store;sync) for every
writel() -- exactly the same problem.

> Again, it might just be a Cell CPU bug in which case we may have to  
> just
> disable use of WC on that processor, period. But it might be a more
> generic problem too, we need to investigate.

It's a bit like why IA64 has mmiowb().  Not quite the same, but similar.

> If the problem ends up being widespread, the only ways I see to  
> prevent
> the combining from happening are to do a dual mapping as I explained
> earlier, or maybe to have drivers always do the stores that must  
> not be
> combine as part of spinlocks, with appropriate use of
> io_to_lock_barrier() (mmiowb()).

Better lock at a higher level than just per instruction.

Some devices that want to support multiple clients at the same time
have multiple identical "register files", one for each client, to
prevent this and other problems (and it's useful anyway).

> Anyway, let's not pollute this discussion with that too much now :)

Au contraire -- if you're proposing to hugely invasively change some
core interface, and add millions of little barriers(*), you better
explain how this is going to help us tackle the problems (like WC) that
we are starting to see already, and that will be a big deal in the
near future.

Now I'm saying there's no way to make the barriers needed for write-
combining efficient, unless those barriers can take advantage of the
ordering rules of the path all the way from the CPU to the device;
i.e. make those barriers bus-specific.  The MMIO and memory-like-space
read/write accessors will have to follow suit.  Non-WC stuff can take
advantage of bus-specific rules as well, e.g. the things you are
proposing, which, face it, are really just designed for PCI.

And even today, only looking at PCI, we already have two different
kinds of drivers: the ones that use the PCI ordering rules, with
wmb() and mmiowb() [your #2 and #4; #1 is implicit on PCI (everything
pushes posted writes); and #3 is covered by the twi;isync we have
in readX()], which work correctly on PowerPC today; and on the other
hand, the drivers that pretend PCI is a bus arch where everything is
strongly ordered (even vs. main memory), which do not all work for
PowerPC in today's kernel [devices not doing DMA might seem to work
fine, since #4 is hard to break and even if you do it's not often
fatal or bad at all; heck we have this one device now where breaking
#2 "almost" works, it took almost two full kernel release cycles for
anyone to notice].

If you change the rules you'll have to audit *all* existing device
drivers.

So, again: unless we make the I/O accessors and barriers bus-specific,
we'll end up with millions(**) of slightly different barriers and
whatnot, in an attempt to get decent performance out of our devices;
and we will never reach that goal.  Also, no device driver author
will ever know what barrier to use where and when.

Now if we _do_ make it all bus-specific, we still might have quite
a few barriers in total, but only a few per bus type -- and they
can have descriptive names that explain where to use them.  Maybe,
just maybe, we'll for the first time see a device driver that gets
it right ;-)

I still like the idea of overloading the semantics of readX()/writeX()
to do whatever is needed for the region that is mapped for their
arguments, but you can introduce pci_readl() and friends for all I care,
it's a separate issue...  If you want to keep the nice short names
with different semantics though, well, have fun fixing device drivers
for the next twenty(***) years.


Segher



(*) Yes I know I'm exaggerating.
(**) It's a habit :-)
(***) Did it again...  It's more like fifteen years really.
