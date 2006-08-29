Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWH2Txb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWH2Txb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWH2Txb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:53:31 -0400
Received: from helium.samage.net ([83.149.67.129]:30356 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1751317AbWH2Tx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:53:29 -0400
Message-ID: <3618.81.207.0.53.1156881199.squirrel@81.207.0.53>
In-Reply-To: <1156844981.23000.75.camel@twins>
References: <20060825153946.24271.42758.sendpatchset@twins> 
    <20060825153957.24271.6856.sendpatchset@twins> 
    <1396.81.207.0.53.1156559843.squirrel@81.207.0.53> 
    <1156760564.23000.31.camel@twins> 
    <3720.81.207.0.53.1156780999.squirrel@81.207.0.53> 
    <1156786344.23000.47.camel@twins> 
    <3994.81.207.0.53.1156809691.squirrel@81.207.0.53>
    <1156844981.23000.75.camel@twins>
Date: Tue, 29 Aug 2006 21:53:19 +0200 (CEST)
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, August 29, 2006 11:49, Peter Zijlstra said:
> On Tue, 2006-08-29 at 02:01 +0200, Indan Zupancic wrote:
>> Good that you're aware of it. Thing is, how much sense does the split-up into
>> adjust_memalloc_reserve() and sk_adjust_memalloc() make at this point? Why not
>> merge the code of adjust_memalloc_reserve() with sk_adjust_memalloc() and only
>> add adjust_memalloc_reserve() when it's really needed? It saves an export.
>
> mm/ vs net/core/

I thought var_free_kbytes was exported too, but it isn't, so merging those two
won't save an export, scrap the idea.

If sk_adjust_memalloc() can be called with socks == 0 then a check for that needs
to be added, or else bugginess ensues (my fault ;-):

void sk_adjust_memalloc(int socks, int tx_reserve_pages)
{
	unsigned long flags;
	int nr_socks;

	if (socks){
		nr_socks = atomic_add_return(socks, &vmio_socks);
		BUG_ON(nr_socks < 0);

		if (nr_socks == socks)
			tx_reserve_pages += RX_RESERVE_PAGES;
		if (nr_socks == 0)
			tx_reserve_pages -= RX_RESERVE_PAGES;
	}
	spin_lock_irqsave(&memalloc_lock, flags);

	adjust_memalloc_reserve(tx_reserve_pages);

	spin_unlock_irqrestore(&memalloc_lock, flags);
}


> Well, perhaps, its merit is that is allows for full service for a few
> sockets even under severe memory pressure. And it provides the
> primitives to solve this problem for all instances, (NBD, iSCSI, NFS,
> AoE, ...) hence framework.
>
> Evgeniy's allocator does not cater for this, so even if it were to
> replace all the allocation stuff, we would still need the SOCK_VMIO and
> all protocol hooks this patch introduces.

At least what I understood of it, the appealing thing was that it would make
the whole networking stack robust, as network operations will never fail.
So not only for VMIO sockets, but for all. Only thing that's missing then is
a way to guarantee that there's always forward progress. The ironic thing
is that to achieve that skbs/mem needs to be dropped/refused again, in the
case of blocking senders.

VMIO makes the choice what to refuse by making some skbs/sockets more important
than others and, indirectly, the kernel more important than userspace. A
different choice could be made. If one can be made which works for all, then
the VM deadlock problem is solved too.

Great if the VM deadlock problem is solved, but what about user space applications
that want to keep working under heavy memory pressure? Say, more or less all
decently written network servers. For those incoming data in general means more
work to do, and hence more memory to use and data to send. What they need is
receive throttling under memory pressure so that enough free memory is available
to handle the data that is received. A reliable network stack gives them nothing
if after receiving the data they can't do anything with it because the free
memory is up. So in that regard splitting the network allocator from the normal
allocator might only increase the problem.

(Swap only makes matters worse, as a program will slow down when it's used under
heavy memory pressure without knowing that there's any memory pressure. Failed
memory allocations are a good sign that there's memory pressure, but unfortunately
when that point is reached all performance is gone already and the application
can't really do anything useful, as it can't allocate nay memory. Something like
MAP_NONBLOCK, but which works with MAP_ANONYMOUS and let the mmap fail if swap
would be used may be helpful, because then the flow of new work can be throttled
earlier by the app. But coordination with malloc would be better.
Of course most can already be done by tuning the system and careful coding.
Sucks to be userspace I guess.)

>> - If Evgeniy's network allocator is as good as it looks, then why can't it
>> replace the existing one? Just adding private subsystem specific memory
>> allocators seems wrong. I might be missing the big picture, but it looks
>> like memory allocator things should be at least synchronized and discussed
>> with Christoph Lameter and his "modular slab allocator" patch.
>
> SLAB is very very good in that is will not suffer from external
> fragmentation (one could suffer from external fragmentation when viewing
> the slab allocator from the page allocation layer - but most of that is
> avoidable by allocation strategies in the slab layer), it does however
> suffer from internal fragmentation - by design.
>
> For variable size allocators it has been proven that for each allocator
> there is an allocation pattern that will defeat it. And figuring the
> pattern out and proving it will not happen in a long-running system is
> hard hard work.
>
> (free block coalescence is not a guarantee against fragmentation; there
> is even evidence that delayed coalescence will reduce fragmentation - it
> introduces history and this extra information can help predict the
> future.)
>
> This is exactly why long running systems (like our kernel) love slabs.
>
> For those interested in memory allocators, this paper is a good (albeit
> a bit dated) introduction:
> 	http://citeseer.ist.psu.edu/wilson95dynamic.html
>
> That said, it might be that Evgeniy's allocator works out for our
> network load - only time will tell, the math is not tractable afaik.

Thanks for the pointer, the paper is interesting, but doesn't give a lot
of new info, more a shocking insight in the absense of quantitative
allocator research. Lots of words, but few numbers from them too, slightly
disappointing. Besides, more or less everything in the paper is only
relevant for unmovable, variable sized objects allocation. Things like
page handling aren't researched, they limited it to research of allocators
using one big lump of virtual memory. Worth the read though.

Sorry for the rambling. :-)

Greetings,

Indan


