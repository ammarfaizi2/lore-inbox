Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319626AbSIMMkc>; Fri, 13 Sep 2002 08:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319627AbSIMMkb>; Fri, 13 Sep 2002 08:40:31 -0400
Received: from 84e5e703.math.leidenuniv.nl ([132.229.231.3]:57802 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S319626AbSIMMk1>; Fri, 13 Sep 2002 08:40:27 -0400
Date: Fri, 13 Sep 2002 14:45:18 +0200
From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: bart.de.schuymer@pandora.be, linux-kernel@vger.kernel.org
Subject: bridge-netfilter patch (was: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34)
Message-ID: <20020913144518.A31318@math.leidenuniv.nl>
References: <200209130520.41862.bart.de.schuymer@pandora.be> <20020912.212959.114182683.davem@redhat.com> <200209130812.27093.bart.de.schuymer@pandora.be> <20020912.230916.96754743.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020912.230916.96754743.davem@redhat.com>; from davem@redhat.com on Thu, Sep 12, 2002 at 11:09:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 12, 2002 at 11:09:16PM -0700, David S. Miller wrote:

>    From: Bart De Schuymer <bart.de.schuymer@pandora.be>
>    Date: Fri, 13 Sep 2002 08:12:27 +0200
> 
>    It is not trivial however, 2 new fields to the sk_buff need to be 
>    added, a small change in the IP fragment code and a small change in 
>    ip_tables.c, a change to netfilter.h and netfilter.c.
> 
> I've seen these changes, they are very buggy.  The IPv4 copies added
> are just ugly and are buggy too, they potentially copy past the end
> of the packet buffer.

You mean this part?  This is the only copy added to generic code
that I can find.


--- linux-2.4.19/net/ipv4/ip_output.c   2002-08-03 02:39:46.000000000 +0200
+++ linux-2.4.19-brnf0.0.7/net/ipv4/ip_output.c 2002-09-11 17:40:25.000000000 +0200
@@ -883,6 +885,7 @@
                iph->tot_len = htons(len + hlen);

                ip_send_check(iph);
+               memcpy(skb2->data - 16, skb->data - 16, 16);

                err = output(skb2);
                if (err)


If this code is buggy, isn't the following bit from ip_output.c buggy
too?  (around line 170)

        if (hh) {
                read_lock_bh(&hh->hh_lock);
>>>             memcpy(skb->data - 16, hh->hh_data, 16);
                read_unlock_bh(&hh->hh_lock);
                skb_push(skb, hh->hh_len);
                return hh->hh_output(skb);
        } else if (dst->neighbour)


>    So, if you would accept br-nf, that would be great.
> 
> You need to remove the IPv4 bits, that copy of the MAC has to happen
> at a different layer, it does not belong in IPv4.  At best, everyone
> shouldn't eat that header copy.

What if I make the memcpy conditional on "if (skb->physindev != NULL)"?


cheers,
Lennert
