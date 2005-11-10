Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbVKJDoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbVKJDoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbVKJDoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:44:32 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:17478 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751740AbVKJDob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:44:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MnTgZ4tt0ZWL9NAbSylkO3pFGjookWF//E9h2vf+XZ+PLiB5VE4DgHIjolLD80Lb5MCpe5KPjpEcMjCKUY1Q0qT39Pm7+9WOeYbuHkwKeqyUFjygdQ7yeydMrFS54OWUWsZrTGrMZ0p6YQ9P2NgYGK+dzavy+lnGt+ldOpWgPG8=
Message-ID: <4372C198.6010306@gmail.com>
Date: Thu, 10 Nov 2005 11:42:16 +0800
From: Tony <tony.uestc@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context at mm/slab.c:2126
References: <111020050307.1697.4372B974000B129D000006A1220073544600009A9B9CD3040A029D0A05@comcast.net>
In-Reply-To: <111020050307.1697.4372B974000B129D000006A1220073544600009A9B9CD3040A029D0A05@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
>>I'm writing a net_device driver. I want to send a packet when the timer 
>>is out. I get the following warning. It seems that I should not call 
>>alloc_skb. Can anyone tell me how to get rid of this? Thanks in advance.
>>
> 
> 
> You are calling alloc_skb which in turn calls kmem_cache_alloc in interrupt context where things can't sleep and kmem_cache_alloc can sleep.  The reason for this is that you are passing GFP_KERNEL to alloc_skb. Try passing GFP_ATOMIC instead.
> 
> Other alternative is to may be use a precreated pool of skbs - may be this can be done in driver init function or any other safe context. But I don't know how much feasible that is in your situation.
> 
> HTH
> Parag
> 
> 
> 
Thanks a lot. Another question.

My interface is a virtual interface which represent a radio connected to 
the host using ethernet NIC. I designed my own L2 protocol on top of 
802.3, which must be used, since the radio and the host are connected by 
ethernet.

Now, my radio_hard_header will only add my L2 header, and my 
radio_hard_start_xmit will do (simplified):
1) ajust the headroom space
     hh_len = LL_RESERVED_SPACE(bdev);
     if (unlikely(skb_headroom(skb) < hh_len && bdev->hard_header)) {
		struct sk_buff *skb2;

		skb2 = skb_realloc_headroom(skb, LL_RESERVED_SPACE(dev));
		if (skb2 == NULL) {
             stats->tx_dropped++;
			dev_kfree_skb(skb);
			return 0;
		}
		if (skb->sk)
			skb_set_owner_w(skb2, skb->sk);
		dev_kfree_skb(skb);
		skb = skb2;
	}

2) call eth0->hard_header
3) skb->dev = eth0
    return dev_queue_xmit()

The problem is when system try to retransmit the packet, I add another 
ethernet header mistakenly.

I have two question:
1) I do not modify the skb passed to hard_start_xmit if 
skb_realloc_headroom is executed. only in this case the retransmission 
runs well. Is my understanding right?
2) Should I do this way or add the ethernet header in my 
radio_hard_header? If I choose the later, the problem will be how should 
I handle it when eth_hard_header return a negative number, when ARP is 
needed.

Thx
