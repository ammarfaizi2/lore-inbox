Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUFQOgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUFQOgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUFQOgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:36:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46217 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266511AbUFQOgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:36:16 -0400
Date: Thu, 17 Jun 2004 10:16:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Steven Dake <sdake@mvista.com>
Cc: Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.logos.cnet, akpm@osdl.org
Subject: [2.4] page->buffers vanished in journal_try_to_free_buffers() 
Message-ID: <20040617131600.GB3029@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel> <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com> <20040615131650.GA13697@logos.cnet> <1087322198.8117.10.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087322198.8117.10.camel@persist.az.mvista.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 15, 2004 at 10:56:38AM -0700, Steven Dake wrote:
> On Tue, 2004-06-15 at 06:16, Marcelo Tosatti wrote:
> > On Mon, Jun 14, 2004 at 10:07:05AM -0700, Steven Dake wrote:
> > > Marcelo and Stian,
> > > 
> > > I have also seen this oops relating to low memory situations.  I think
> > > ext3 allocates some data, has a null return, sets something to null, and
> > > then later it is dereferenced in kwapd.
> > > 
> > > Anyone have a patch for this problem?
> 
> > Steven, 
> > 
> > For what I remember Stian oopses were happening in random places in the VM freeing 
> > routines. That makes me belive what he was seeing was some kind of hardware issue, 
> > because otherwise the oopses would be happening in the same place (in case it was 
> > a software bug). The codepaths which he saw trying to access invalid addresses are 
> > executed flawlessly by all 2.4.x mainline users. He was also seeing oopses with v2.6.
> > 
> > Assuming his HW is not faulty, I can think of some driver corrupting his memory. 
> > 
> > Do you have any traces of the oopses you are seeing?  
> > 
> > Stian, you told us switched servers now, I assume the problem is gone? 
> > Are you still running v2.4 on that server?
> > 
> 
> Marcelo,
> 
> Stian responded saying he upgraded to 2.6 and also removed the memory
> intensive script and his problems went away.  I suspect removing the
> memory intesive script did the trick.  2.6 could also be fixed, who
> knows?
> 
> After reading lkml, there are about 4-5 Oops in the same function at the
> same location.  The people report they were heavily using memory (low
> memory situation) in some of the bug reports.
> 
> I have tracked down the problem to a null dereference during a buffer
> cache rebalance (which occurs during low memory situations).  Here is
> the info I have.  Unfortunately I don't know much about how vm handles
> low memory situations with the vfs, so if you have any ideas, it would
> be helpful. :)
> 
> nable to handle kernel NULL pointer dereference at virtual address
> 00000028
> <4> printing eip:
> <4>c018aa67
> <1>*pde = 00000000
> <4>Oops: 0000
> <4>CPU:	 2
> <4>EIP:	 0010:[<c018aa67>]    Not tainted
> <4>EFLAGS: 00010203
> <4>eax: 00000000	 ebx: 00000000	 ecx: c0380490	 edx: c217a540
> <4>esi: f2757a80	 edi: 00000001	 ebp: 00000000	 esp: f7bd1ee8
> <4>ds: 0018   es: 0018   ss: 0018
> <4>Process kswapd (pid: 11, stackpage=f7bd1000)
> <4>Stack: 00000000 00000000 c217a600 00000000 00000202 00000000 c217a540 000001d0
> <4>	c217a540 000102ec c018144f f7abe400 c217a540 000001d0 c0155006 c217a540
> <4>	000001d0 f7bd0000 00000000 c0147f0a c217a540 000001d0 f7bd0000 f7bd0000
> <4>Call Trace: [<c018144f>] [<c0155006>] [<c0147f0a>]
> [<c014832b>] [<c0148398>]
> <4>   [<c0148431>] [<c014847f>] [<c0148593>] [<c0105000>]
> [<c010578a>] [<c01484f8>]
> <4>
> <4>Code: 8b 5b 28 f6 40 19 02 75 47 39 f3 75 f1 c6 05 80 24 38 c0 01
> 
> 
> >>EIP; c018aa67 <journal_try_to_free_buffers+45/f4>   <=====
> Trace; c018144f <ext3_releasepage+2d/32>
> Trace; c0155006 <try_to_release_page+4e/78>
> Trace; c0147f0a <shrink_cache+270/4f6>
> Trace; c014832b <shrink_caches+61/98>
> Trace; c0148398 <try_to_free_pages+36/54>
> Trace; c0148431 <kswapd_balance_pgdat+51/8a>
> Trace; c014847f <kswapd_balance+15/2c>
> Trace; c0148593 <kswapd+9b/b6>
> Trace; c0105000 <_stext+0/0>
> Trace; c010578a <kernel_thread+2e/40>
> Trace; c01484f8 <kswapd+0/b6>
> 
> The problem is that in this function:
> 
> int journal_try_to_free_buffers(journal_t *journal,
> 		struct page *page, int gfp_mask)
> {
>     struct buffer_head *bh;
>     struct buffer_head *tmp;
>     int locked_or_dirty = 0;
>     int call_ttfb = 1;
> 
>     J_ASSERT(PageLocked(page));
> 
>     bh = page->buffers;
>     tmp = bh;
>     spin_lock(&journal_datalist_lock);
>     do {
> 	struct buffer_head *p = tmp;
> 
> 	tmp = tmp->b_this_page;
>     ...
> 
> tmp (page->buffers) above is null.  b_this_page is at offset 0x28 (the accessed address in the oops).  This means that
> page->buffers is set to null by some other routine which results in the oops.
> 
> I read the page allocate code
> (ext3_read_page->block_read_full_page->create_emty_buffers->create_buffers), and it appears that it is not possible to allocate a page->buffers value of zero in the allocate function.  I am having difficulty reproducing and cannot debug further, however.  Can page->buffers be set to zero somewhere else?  
>Perhaps kswapd and some other thread are racing on the free?

Steve, 

Hum, I'm starting to believe we might have an issue here.

Searching lkml archives I find other similar oopses at the same place 
(trying to access 00000028, tmp->b_this_page), as you said.

However I wonder what other kernel codepath could remove the page buffers
under us, the page MUST be locked here. In the backtrace above the page 
is locked by shrink_cache(). And with the page locked, we guarantee the VM
freeing routines (shrink_cache) wont try to mess with the page.

Can you reproduce the oopsen?

Stephen, Andrew, do you have any idea how the buffers could have vanished
under us with the page locked? That should not be possible. 

I dont see how this "page->buffers = NULL" could be caused by hardware problem, 
which is usually one or two bit flip.

Thanks everyone
