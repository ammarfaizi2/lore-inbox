Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUJ1SDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUJ1SDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUJ1SDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:03:54 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:18923 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S263018AbUJ1SDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:03:12 -0400
Date: Thu, 28 Oct 2004 20:02:35 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac2
Message-ID: <20041028180235.GD3646@dualathlon.random>
References: <1098379853.17095.160.camel@localhost.localdomain> <20041021123404.1d947ee0.davem@davemloft.net> <1098389527.17096.166.camel@localhost.localdomain> <20041028145931.GE5741@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028145931.GE5741@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 12:59:31PM -0200, Marcelo Tosatti wrote:
> On Thu, Oct 21, 2004 at 09:12:08PM +0100, Alan Cox wrote:
> > On Iau, 2004-10-21 at 20:34, David S. Miller wrote:
> > > 2.4.x will need this one as well, at least the AF_PACKET
> > > case.  Would you mind if I pushed that to Marcelo?
> > 
> > Not at all. Andrea has proposed fixing it a little differently. 
> > For 2.6 making remap_page_range DTRT itself is ok but for 2.4 the
> > vma isn't passed.
> 
> get_user_pages() is screwed, I'm just not sure
> about failing get_user_pages() if PageReserved page
> is encountered. 
> 
> I'm more worried about make_pages_present(), which is 
> called by find_extend_vma/do_mmap_pgoff. Is it valid
> to have PageReserved pages on the zones handled 
> by these functions anyway?

make_pages_present passes a null pages array, so it won't run the below
code.

> This is equivalent of Andrea's fix for mainline.

yes.

> Andrea, this in SuSE's tree for a while correct?

Yes, in another form but the below is the one against mainline.

In SUSE tree I fixed a COW memory corruption issue (something I should
submit for mainline 2.4 integration ASAP), so the patch looks different
there. pinning the page only at the struct page level and delaying
writepage until the page is mapped, works in all cases, except when
there are threads and a COW is generated while one thread is executing a
rawio/O_DIRECT read and the anon page receiving the I/O gets unmapped by
some memory pressure. The only way to fix it is to prevent the VM unmap
pages that are under rawio, so I had to add a PG_pinned that
unfortunately serializes the rawio page against page, in 2.6 I could fix
it trivially without any serialization by comparing page->count with
page->mapcount (with 2.6.7+ VM, and that's already merged in mainline
since 2.6.7/8 or so). I did fix it in time for 2.6.5 SLES9 too.

the biggest pain to make the PG_pinned work has been to implement a
wait_on_page_pte_pinned asynchronous, otherwise keventd was executing
wait_on_page_pte_pinned it was getting stuck and the I/O wasn't
submitted since keventd itself had other events pending generating a
deadlock. This is all fixed by the async version of
wait_on_page_pte_pinned, and it's all in SLES8 latest, so that even aio
cannot generate memory corruption anymore (most people don't notice this
since they don't use threads and they don't do I/O with anonymous memory
as destination but to close all pratical corruption holes this was
technically required). But 2.4 mainline has no async-io, so adding
PG_pinned there is fairly easy (modulo reject big pain).
