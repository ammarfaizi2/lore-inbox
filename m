Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTLLIDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 03:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTLLIDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 03:03:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19377 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264504AbTLLICb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 03:02:31 -0500
Date: Fri, 12 Dec 2003 00:00:50 -0800
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: mukansai@emailplus.org, scott.feldman@intel.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: TSO and netfilter (Re: Extremely slow network with e1000 &
 ip_conntrack)
Message-Id: <20031212000050.0cad7469.davem@redhat.com>
In-Reply-To: <20031212070131.GN15606@sunbeam.de.gnumonks.org>
References: <20031204213030.2B75.MUKANSAI@emailplus.org>
	<20031205122819.25ac14ab.davem@redhat.com>
	<20031211110315.GJ22826@sunbeam.de.gnumonks.org>
	<20031211174136.1ed23e2e.davem@redhat.com>
	<20031212070131.GN15606@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003 08:01:31 +0100
Harald Welte <laforge@netfilter.org> wrote:

> So what about the networking core exporting an [inline] function
> that recalculates tso_segs and tso_size (like the 'Hack zone' code
> fragment in ip_queue_xmit() right now), called skb_tso_recalc() or
> whatever name you prefer.

This might work.

> Or even better (since I assume TSO can only happen with
> locally-originated datagrams), why don't we move the tso_size/tso_segs
> calculation to happen after the LOCAL_OUT netfilter hook?  This way we
> also get the ip_select_ident_more() right, which we couldn't easily
> update from the proposed skb_tso_recalc() function.
>
> yes, in that case we would need to have some fake code like
> 	if (skb->len > mtu && (sk->sk_route_caps&NETIF_F_TSO))
> 		skb_shinfo(skb)->tso_segs = 1;
> in order to make the newly-created check for refragmentation in
> conntrack still work.  Alternatively, create some inline function that 
> gives a yes/no return if the skb would later become TSO or not.

I don't know about this.  The local-out hook always had a fully
functional finalized packet to work with, and I doubt we should change
that.

Also, dst_output() might invoke IPSEC encapsulators which absolutely
must have the final packet in hand when they run (f.e. you can't
choose the IP ID after encryption of the IP header).

Anyways, that leaves us with the helper function idea, does this
(untested) look like what you want?

--- include/linux/skbuff.h.~1~	Thu Dec 11 23:55:43 2003
+++ include/linux/skbuff.h	Thu Dec 11 23:57:45 2003
@@ -1155,6 +1155,17 @@
 #endif
 }
 
+static __inline__ void skb_tso_recalc(struct sk_buff *skb, struct dst_entry *dst)
+{
+	unsigned int hlen = ((skb->h.raw-skb->data)+(skb->h.th->doff<<2));
+	u32 mtu = dst_pmtu(dst);;
+
+	skb_shinfo(skb)->tso_size = mtu - hlen;
+	skb_shinfo(skb)->tso_segs =
+		(skb->len - hlen + skb_shinfo(skb)->tso_size - 1) /
+		skb_shinfo(skb)->tso_size - 1;
+}
+
 #define skb_queue_walk(queue, skb) \
 		for (skb = (queue)->next, prefetch(skb->next);	\
 		     (skb != (struct sk_buff *)(queue));	\
