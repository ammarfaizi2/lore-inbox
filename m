Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADEKc>; Wed, 3 Jan 2001 23:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132676AbRADEKX>; Wed, 3 Jan 2001 23:10:23 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:38660 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S129324AbRADEKG>;
	Wed, 3 Jan 2001 23:10:06 -0500
Date: Thu, 4 Jan 2001 09:39:43 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: Andi Kleen <ak@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: is eth header is not transmitted
In-Reply-To: <20010104044141.A16489@gruyere.muc.suse.de>
Message-ID: <Pine.SOL.3.96.1010104091857.10702A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ya, I also noticed if it is skb_push() it may work, but where is
skb_push() called?? ...  the following
is part of the  fn. call  trace for udp send :

	in ip_build_xmit()

	sock_alloc_send_skb()  -- allocates the sk_buff
	skb_reserve()   -- advances the data pointer to by
			   sizeof(hard_hdr)  amt.
	skb_put()       -- puts the ip_hdr
	>> getfrag() --> udp_getfrag_nosum()(assuming chksum off) --
			 sets udp_hdr.
	memcpy_fromiovecend() --  puts the data after that.

	r->u.dst.output() -- > dev_queue_xmit() -- queues the pkt.
	
	still the data ptr is after hh_hdr, ie. as follows :

	+------------------------------------------------------+
	| hh_hdr | ip_hdr | udp_hdr |         payload          |
	+------------------------------------------------------+
	^        ^                                             ^
	|        |                                             |
  sk->head  sk->data                                     sk->end

	On a hadr_start_xmit(), ie say for rtl8129_start_xmit(), the 
data sending takes place from skb->data and not from head. So is hh_hdr
not transmitted?? 
	
	Another question is why in sock_alloc_send_skb() , 15 is added to
length field?

	Sorry to disturb u like this :)

sourav

On Thu, 4 Jan 2001, Andi Kleen wrote:

> On Thu, Jan 04, 2001 at 09:08:06AM +0530, Sourav Sen wrote:
> > 
> > Hi,
> > 	How can it be skb_put(), it only increments the tail/len ptr ??
> 
> Oops typo, it's skb_push() for the header.
> 
> 
> 
> -Andi
> 
> > sourav
> > 
> > On Wed, 3 Jan 2001, Andi Kleen wrote:
> > 
> > > On Wed, Jan 03, 2001 at 10:59:48PM +0530, Sourav Sen wrote:
> > > > 
> > > > Hi,
> > > > 	In the function ip_build_xmit(), immediately after
> > > > sk_alloc_send_skb(), skb_reserve(skb, hh_len) is called. Now
> > > > skb_reserve(skb,len) only increment the data pointer and tail pointer by 
> > > > len amt.
> > > > 
> > > > 	Now in a particular hard_start_xmit() say for rtl8139, the data
> > > > transfer is taking place from skb->data :
> > > > 	outl(virt_to_bus(skb->data), ioaddr + TxAddr0 + entry*4)
> > > > 
> > > > So, I cannot understand, if transfer starts from data and not head, is
> > > > ethrnet header not transmitted? what I am missing? 
> > > 
> > > An skb_put() 
> > > 
> > > 
> > > -Andi
> > > 
> > 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
