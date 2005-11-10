Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVKJCiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVKJCiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKJCiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:38:12 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:44128 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750734AbVKJCiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:38:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=RqoOgqMMpTK1kGwJCR9M2b5miF1wsjj61hHq8vECu9Labwpp0QvQgIfvmPQvWxn9lURC2cbavdvWx57fXM51EHnB0BZRZuKF6VhFgYV6cntylYTWloCQduxh/1fBQC1Tig6wbChm5gIbWv9gPyC8VkQHF/JJwXX+Zpjg+c7tbWk=
Message-ID: <4372B20F.7000407@gmail.com>
Date: Thu, 10 Nov 2005 10:35:59 +0800
From: Tony <tony.uestc@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Debug: sleeping function called from invalid context at mm/slab.c:2126
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a net_device driver. I want to send a packet when the timer 
is out. I get the following warning. It seems that I should not call 
alloc_skb. Can anyone tell me how to get rid of this? Thanks in advance.

Nov 10 08:54:33 localhost kernel: Debug: sleeping function called from 
invalid context at mm/slab.c:2126
Nov 10 08:54:33 localhost kernel: in_atomic():1, irqs_disabled():0
Nov 10 08:54:33 localhost kernel:  [<c015c27e>] kmem_cache_alloc+0x3c/0x49
Nov 10 08:54:33 localhost kernel:  [<c0301b02>] alloc_skb+0x14/0xc1
Nov 10 08:54:33 localhost kernel:  [<cc8d3056>] rcp_match+0x0/0x1ef [rd]
Nov 10 08:54:33 localhost kernel:  [<cc8d3077>] rcp_match+0x21/0x1ef [rd]
Nov 10 08:54:33 localhost kernel:  [<c012c9ae>] cascade+0x21/0x3b
Nov 10 08:54:33 localhost kernel:  [<cc8d3056>] rcp_match+0x0/0x1ef [rd]
Nov 10 08:54:33 localhost kernel:  [<c012cf73>] 
run_timer_softirq+0x10b/0x472
Nov 10 08:54:33 localhost kernel:  [<c0103c0e>] common_interrupt+0x1a/0x20
Nov 10 08:54:33 localhost kernel:  [<c01282de>] __do_softirq+0x3e/0x8a
Nov 10 08:54:33 localhost kernel:  [<c0105c29>] do_softirq+0x3e/0x42
Nov 10 08:54:33 localhost kernel:  =======================
Nov 10 08:54:33 localhost kernel:  [<c0105b24>] do_IRQ+0x51/0x82
Nov 10 08:54:33 localhost kernel:  [<c0105b24>] do_IRQ+0x51/0x82
Nov 10 08:54:33 localhost kernel:  [<c0103c0e>] common_interrupt+0x1a/0x20
Nov 10 08:54:33 localhost kernel:  [<c010101a>] default_idle+0x0/0x29
Nov 10 08:54:33 localhost kernel:  [<c0101040>] default_idle+0x26/0x29
Nov 10 08:54:33 localhost kernel:  [<c01010a6>] cpu_idle+0x34/0x4c
Nov 10 08:54:33 localhost kernel:  [<c042472a>] start_kernel+0x15f/0x1b9
Nov 10 08:54:33 localhost kernel:  [<c04242fe>] unknown_bootoption+0x0/0x1cd


the timeout function is as below:

static void rcp_match(unsigned long dummy)
{
     struct sk_buff *skb;
     struct net_device *dev;
     struct rcpchdr *h;
     struct rcpopt *o;
     int res;
     static uint8_t broadcast[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

#if DEBUG_LEVEL < 1
     printk(KERN_WARNING "-> rcp_match\n");
#endif

     if (rcp_match_count++ >= RCP_MATCH_RETRY)
         goto stop;

     skb = alloc_skb(512, GFP_KERNEL);
     if (skb == NULL) {
         printk(KERN_WARNING "rcp_match: not enough sk_buff\n");
         goto stop;
     }

     dev = dev_get_by_name("eth0");
     if (dev == NULL) {
         printk(KERN_WARNING "rcp_match: net_device not found (%s)\n", 
"eth0");
         goto stop;
     }

     skb_reserve(skb, dev->hard_header_len);
     h = (struct rcpchdr *)skb_put(skb, sizeof (struct rcpchdr));
     h->h_type = RCPC_TYPE_QUERY;
     h->h_index = RCPC_INDEX_ALL;
     o = (struct rcpopt *)skb_put(skb, sizeof (struct rcpopt));
     memset(o, 8, sizeof(struct rcpopt));

     skb->protocol = htons(ETH_P_RADIO_CONTROL);
     skb->nh.raw = skb->data;
     skb->dev = dev;

     res = dev->hard_header(skb, dev, ETH_P_RADIO_CONTROL, broadcast, 
NULL, skb->len);
     if (res < 0) {
         dev_kfree_skb(skb);
         dev_put(dev);
         return;
     }
     res = dev_queue_xmit(skb);
     dev_put(dev);

     rcp_match_timer.expires = jiffies + RCP_MATCH_TIMEO;
     add_timer(&rcp_match_timer);
     return;

stop:
     del_timer_sync(&rcp_match_timer);
     rcp_match_count = 0;
     return;
}

