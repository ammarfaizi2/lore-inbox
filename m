Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbQJ2BXx>; Sat, 28 Oct 2000 21:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129233AbQJ2BXn>; Sat, 28 Oct 2000 21:23:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13061 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129108AbQJ2BXd>; Sat, 28 Oct 2000 21:23:33 -0400
Date: Sat, 28 Oct 2000 21:25:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andi Kleen <ak@suse.de>
cc: "Dave S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: tcp_do_sendmsg() allocation still broken ?
In-Reply-To: <20001029021642.A16126@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0010282122240.1319-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Oct 2000, Andi Kleen wrote:

> On Sat, Oct 28, 2000 at 09:13:27PM -0200, Marcelo Tosatti wrote:
> > 
> > 
> > On Sun, 29 Oct 2000, Andi Kleen wrote:
> > 
> > > On Sat, Oct 28, 2000 at 07:12:44PM -0200, Marcelo Tosatti wrote:
> > > > 
> > > > David,
> > > > 
> > > > tcp_do_sendmsg() still allocates using GFP_KERNEL when it can't, it seems: 
> > > 
> > > tcp_do_sendmsg() should only be called from process context, because it can
> > > sleep for other reasons anyways. 
> > > 
> > > If someone calls it from interrupt context it needs to be fixed.
> > 
> > Andi,
> > 
> > Think about nbd. 
> 
> Making tcp_do_sendmsg use GFP_ATOMIC would make it too unreliable for other
> situations. Penalizing the whole system just for nbd is not a good idea.

I agree that using GFP_ATOMIC is bad there.

I've fixed 2.2 with GFP_BUFFER. 

> 
> > 
> > It allocates memory inside its request function, and since we do write
> > throttling in try_to_free_pages() we can end up with this deadlock in low 
> > memory conditions:
> > 
> > nbd_do_request -> nbd_send_req -> nbd_xmit -> sock_sendmsg -> ... ->
> > tcp_do_sendmsg -> tcp_send_skb -> skb_copy -> alloc_skb ->
> > kmalloc(GFP_KERNEL) -> kmem_cache_grow -> get_free_pages ->
> > try_to_free_pages -> shrink_mmap -> try_to_free_buffers ->
> > sync_page_buffers -> ll_rw_block -> make_request -> add_request ->
> > nbd_do_request -> nbd_send_req -> ...
> > 
> > until there are no more free requests on the request queue and writer
> > processes stuck on __get_request_wait.
> 
> Looks like a job for PF_MEMALLOC and making GFP_KERNEL fail earlier.

IMHO GFP_BUFFER is ok. 




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
