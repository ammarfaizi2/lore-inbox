Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUBBRv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUBBRv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:51:59 -0500
Received: from keskus.netlab.hut.fi ([130.233.154.176]:12223 "EHLO
	keskus.netlab.hut.fi") by vger.kernel.org with ESMTP
	id S265742AbUBBRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:51:53 -0500
Message-ID: <401E8E33.7050305@netlab.hut.fi>
Date: Mon, 02 Feb 2004 19:51:47 +0200
From: Emmanuel Guiton <emmanuel@netlab.hut.fi>
Reply-To: emmanuel@netlab.hut.fi
Organization: HUT Networking Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Freeing skbuff (was: Re: Sending built-by-hand packet and kernel
 panic.)
References: <401E62C3.60503@netlab.hut.fi> <200402021602.56242.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks a lot for pointing out these problems. I had completely missed them.
However, my overall problem is not solved. As far as my investigations 
led me, my sk_buff structure is never released after having been sent on 
the wire. So I guess I need an explicit destructor function in my 
sk_buff as the following is present in the definition of struct sk_buff:
void         (*destructor)(struct sk_buff *);    /* Destruct function    
    */

Well, until now what I tried lead to even more quicker kernel panics. If 
anyone has a good advice, I'd appreciate a lot.

'Thank you again,

         Emmanuel


Duncan Sands wrote:

>Hi Emmanuel, I don't know anything about network programming
>but I did notice a few strange things:
>
>  
>
>>        /* skb is allocated 56 bytes = TCP message with no data
>>(detailed hereafter)
>>         * + 2 extra bytes before the ethernet header (see hereafter)
>>         */
>>    skb = alloc_skb(56, GFP_ATOMIC);
>>    
>>
>
>Why is this GFP_ATOMIC when you use GFP_KERNEL later on?
>
>  
>
>>    skb_reserve(skb, 2); /* for 16-bit alignment*/
>>        /* ethernet header is 14 byte long */
>>    eth = (__u8 *) skb_put(skb, 14);
>>        /* ip header is 20 byte long */
>>    iph = (struct iphdr *)skb_put(skb, sizeof(struct iphdr));
>>        /* tcp header (no options) is 20 byte long */
>>    tcph = (struct tcphdr *)skb_put(skb, sizeof(struct tcphdr));
>>
>>    /* skb->dst AND skb->dev (the latter is set by the former) */
>>    if (ip_route_output(&rt, ip_dst, 0, 0, 0) != 0)
>>    {
>>        printk("ip_route_output failed.\n");
>>        return -1;
>>    }
>>    skb->dst = (struct rt_entry *) rt; /* A trick from ip_route_input.c */
>>    skb->dev = skb->dst->dev;
>>
>>    /* Socket allocation. */
>>    if (sock_create(PF_INET, SOCK_RAW, IPPROTO_RAW, &sending_socket) < 0)
>>    {
>>        printk("Error socket creation.\n");
>>        sock_release(sending_socket);
>>        return -1;
>>    }
>>    sk = kmalloc(sizeof(struct sock), GFP_KERNEL);
>>    memcpy(&(sending_socket->sk), sk, sizeof(struct sock));
>>    
>>
>
>Here you are copying the (uninitialized) sk into sending_socket->sk.
>I guess you got the arguments to memcpy the wrong way round.
>
>  
>
>>    sock_release(sending_socket);
>>    
>>
>
>Maybe this drops reference counts to various objects, in which
>case it is wrong to reference them via sk.
>
>  
>
>>    if (sk == NULL)
>>    {
>>        printk("Error: sk == NULL\n");
>>        return -1;
>>    }
>>        /* Now, set the sock field. */
>>    skb->sk = sk;
>>
>>    /* TRANSPORT HEADER: TCP */
>>        /* here, TCP header data is filled in tcph. */
>>    skb->h.th = tcph;
>>    /* NETWORK HEADER: IP */
>>        /* here, IP header data is filled in iph*/
>>    skb->nh.iph = iph;
>>    /* LINK HEADER: ETHERNET */
>>        /* here, ethernet header data is filled in iph*/
>>    skb->mac.ethernet = ((u8 *)iph) - 14;
>>
>>    /* Fix me:
>>     * Scheduling priority put at max, choose more correct value.
>>     */
>>    skb->priority = 15;
>>    /* To choose right pkt_type when receiving a packet.
>>     * We're not receivng anything, but I set the value like the guys
>>     * in pktgen.c did, there should be a reason for that.
>>     */
>>    skb->protocol = __constant_htons(ETH_P_IP);
>>
>>    /* TIMESTAMP */
>>        /* last, so it's closest to sending time. */
>>    do_gettimeofday(&skb->stamp);
>>
>>printk("Going to send initialized skb! ...\n");
>>//    if (NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, skb->dev,
>>output_maybe_reroute) < 0)
>>    NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, skb->dev,
>>ip_finish_output) < 0
>>    
>>
>
>All the best,
>
>Duncan.
>  
>



