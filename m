Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRADEe0>; Wed, 3 Jan 2001 23:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132454AbRADEeG>; Wed, 3 Jan 2001 23:34:06 -0500
Received: from Cantor.suse.de ([194.112.123.193]:43529 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129436AbRADEd7>;
	Wed, 3 Jan 2001 23:33:59 -0500
Date: Thu, 4 Jan 2001 05:33:52 +0100
From: Andi Kleen <ak@suse.de>
To: Sourav Sen <sourav@csa.iisc.ernet.in>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: is eth header is not transmitted
Message-ID: <20010104053352.A16847@gruyere.muc.suse.de>
In-Reply-To: <20010104044141.A16489@gruyere.muc.suse.de> <Pine.SOL.3.96.1010104091857.10702A-100000@kohinoor.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1010104091857.10702A-100000@kohinoor.csa.iisc.ernet.in>; from sourav@csa.iisc.ernet.in on Thu, Jan 04, 2001 at 09:39:43AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 09:39:43AM +0530, Sourav Sen wrote:
> 
> Ya, I also noticed if it is skb_push() it may work, but where is
> skb_push() called?? ...  the following
> is part of the  fn. call  trace for udp send :
> 
> 	in ip_build_xmit()
> 
> 	sock_alloc_send_skb()  -- allocates the sk_buff
> 	skb_reserve()   -- advances the data pointer to by
> 			   sizeof(hard_hdr)  amt.
> 	skb_put()       -- puts the ip_hdr
> 	>> getfrag() --> udp_getfrag_nosum()(assuming chksum off) --
> 			 sets udp_hdr.
> 	memcpy_fromiovecend() --  puts the data after that.
> 
> 	r->u.dst.output() -- > dev_queue_xmit() -- queues the pkt.

dst.output() normally points to ip_output(), which fills the hh in (using
appropiate other neighbour callbacks or the hh cache) 


> 	Another question is why in sock_alloc_send_skb() , 15 is added to
> length field?

So that you can use long word accesses and it doesn't fault when the packet
happens to be at the end of memory. Actually it is not required anymore with
the current memory allocator.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
