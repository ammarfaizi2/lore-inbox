Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264545AbSIQTDc>; Tue, 17 Sep 2002 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264543AbSIQTDc>; Tue, 17 Sep 2002 15:03:32 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:30119 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S264539AbSIQTD3> convert rfc822-to-8bit; Tue, 17 Sep 2002 15:03:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: bridge-netfilter patch
Date: Tue, 17 Sep 2002 21:10:06 +0200
X-Mailer: KMail [version 1.4]
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
References: <200209140905.40816.bart.de.schuymer@pandora.be> <200209162341.17032.bart.de.schuymer@pandora.be> <20020916.162123.116935622.davem@redhat.com>
In-Reply-To: <20020916.162123.116935622.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209172110.06121.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    net/ipv4/ip_output.c:ip_fragment()
>    In this function the copy of the Ethernet frame is added for each
> fragment (by the br-nf patch).
>
> 'output' callback arg to ip_fragment() must generate correct hardware
> headers when necessary.  This hack usage of it via netfilter, in this
> weird bridging case, is violating this requirement.
>
> Normally ip_finish_output2() is going to make this.
>
> If it can't do the job properly, pass instead a routine that can do
> what netfilter needs.

Aha. In our case, the output function is
net/bridge/br_forward.c:__dev_queue_push_xmit(). This is because 
__br_forward_finish() (same file) uses this as okfn. Remember the IP hooks 
are "faked" on the bridge hooks, so functions attached to NF_IP_POST_ROUTING 
are called when the IP packet/frame passes the NF_BR_POST_ROUTING hook. They 
are not called earlier. All of this assuming that the destination device 
according to the routing table is a (logical) bridge device. If not, the 
packets go through the IP code and netfilter hooks normally.

So, what if we were to add the following code to the start of 
__dev_queue_push_xmit():

	if (skb->protocol == __constant_htons(ETH_P_IP)) {
		struct dst_entry *dst = skb->dst;
		if (hh) {
			read_lock_bh(&hh->hh_lock);
  			memcpy(skb->data - 16, hh->hh_data, 16);
			read_unlock_bh(&hh->hh_lock);
		}
	}

hh being NULL for an unfragmented IP packet and else non-NULL? Do realize that 
I (I can't speak for Lennert ofcourse) am not very familiar to the workings 
of the IP code.

Then we can remove the memcpy from ip_fragment(). Does that make sense?

-- 
cheers,
Bart

