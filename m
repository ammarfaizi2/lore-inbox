Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbQJ2BRC>; Sat, 28 Oct 2000 21:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131482AbQJ2BQx>; Sat, 28 Oct 2000 21:16:53 -0400
Received: from Cantor.suse.de ([194.112.123.193]:46610 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131439AbQJ2BQp>;
	Sat, 28 Oct 2000 21:16:45 -0400
Date: Sun, 29 Oct 2000 02:16:42 +0100
From: Andi Kleen <ak@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andi Kleen <ak@suse.de>, "Dave S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tcp_do_sendmsg() allocation still broken ?
Message-ID: <20001029021642.A16126@gruyere.muc.suse.de>
In-Reply-To: <20001029020311.A16003@gruyere.muc.suse.de> <Pine.LNX.4.21.0010282108150.1319-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010282108150.1319-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Oct 28, 2000 at 09:13:27PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 09:13:27PM -0200, Marcelo Tosatti wrote:
> 
> 
> On Sun, 29 Oct 2000, Andi Kleen wrote:
> 
> > On Sat, Oct 28, 2000 at 07:12:44PM -0200, Marcelo Tosatti wrote:
> > > 
> > > David,
> > > 
> > > tcp_do_sendmsg() still allocates using GFP_KERNEL when it can't, it seems: 
> > 
> > tcp_do_sendmsg() should only be called from process context, because it can
> > sleep for other reasons anyways. 
> > 
> > If someone calls it from interrupt context it needs to be fixed.
> 
> Andi,
> 
> Think about nbd. 

Making tcp_do_sendmsg use GFP_ATOMIC would make it too unreliable for other
situations. Penalizing the whole system just for nbd is not a good idea.

> 
> It allocates memory inside its request function, and since we do write
> throttling in try_to_free_pages() we can end up with this deadlock in low 
> memory conditions:
> 
> nbd_do_request -> nbd_send_req -> nbd_xmit -> sock_sendmsg -> ... ->
> tcp_do_sendmsg -> tcp_send_skb -> skb_copy -> alloc_skb ->
> kmalloc(GFP_KERNEL) -> kmem_cache_grow -> get_free_pages ->
> try_to_free_pages -> shrink_mmap -> try_to_free_buffers ->
> sync_page_buffers -> ll_rw_block -> make_request -> add_request ->
> nbd_do_request -> nbd_send_req -> ...
> 
> until there are no more free requests on the request queue and writer
> processes stuck on __get_request_wait.

Looks like a job for PF_MEMALLOC and making GFP_KERNEL fail earlier.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
