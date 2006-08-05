Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422799AbWHEJ7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbWHEJ7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 05:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWHEJ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 05:59:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:60880 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1422794AbWHEJ7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 05:59:38 -0400
Date: Sat, 5 Aug 2006 13:58:46 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Chris Leech <chris.leech@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, arnd@arndnet.de, olel@ans.pl,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060805095846.GA17867@2ka.mipt.ru>
References: <41b516cb0608031334s6e159e99tb749240f44ae608d@mail.gmail.com> <E1G8sif-0003oY-00@gondolin.me.apana.org.au> <20060804061513.GB413@2ka.mipt.ru> <41b516cb0608040834o1d433f23v2f2ba1a1b05ccbc6@mail.gmail.com> <20060804194209.GA25167@2ka.mipt.ru> <4807377b0608041402p10149bfbrd9e5f3b8849d3f56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4807377b0608041402p10149bfbrd9e5f3b8849d3f56@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 05 Aug 2006 13:58:48 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 02:02:51PM -0700, Jesse Brandeburg (jesse.brandeburg@gmail.com) wrote:
> >> So how many skb allocation schemes do you code into a single driver?
> >> Kmalloc everything, page alloc everything, combination of kmalloc and
> >> page buffers for hardware that does header split?  That's three
> >> versions of the drivers receive processing and skb allocation that
> >> need to be maintained.
> >
> >At least try to create scheme which will not end up in 32k allocation in
> >atomic context. Generally I would recommend to use frag_list as much as
> >possible (or you can reuse skb list).
> 
> this is exactly what we ran into, you can't use skb list because the
> ip fragmentation reassembly code overwrites it.  If someone is feeling
> particularly miffed by this i would love to see a patch that used
> alloc_page() for all of our receive buffers for the legacy receive
> path (e1000_clean_rx_irq) then we would be able to use nr_frags and
> frag_list for receives.
> 
> Oh, except that eth_type_trans can't handle the entire packet in the
> frag_list (it wants the header in the skb->data)

Yes, part of the packet must live in skb->data, but it does not differ
from frag_list management - place part of the data in skb->data and the
rest into frag_list.
If you can create several skbs and link them togeter you defenitely can
organize pages into frag_list, just get pages from different skb->data
and free those skbs.

> anyway, this is not as easy a problem to solve as it would seem on the 
> surface.

No one says it is easy or not, but I'me 100% sure that 32k allocation
for 9k jumbo frame in atomic context is not what people expect from
high-performance NIC.

> Jesse
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
	Evgeniy Polyakov
