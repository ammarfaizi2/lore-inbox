Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUAMJ0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUAMJ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:26:17 -0500
Received: from [192.94.94.6] ([192.94.94.6]:26826 "EHLO reloaded.ext.ti.com")
	by vger.kernel.org with ESMTP id S263568AbUAMJ0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:26:12 -0500
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: linux-kernel@vger.kernel.org
X-Accept-Language: en-us, en
Message-ID: <4003B9A4.90406@ti.com>
Date: Tue, 13 Jan 2004 11:25:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: adding preallocated data to skb
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of other OSs I worked with (namely windows and VxWorks) has 
this sometimes
very convinient feature - you can allocate dma buffers and then, after 
DMA receive is finished,
you can allocate an empty mblock (which is a VxWorks skb) and just add 
preallocated data
to this empty mblock.

This is extremely convinient, especially for fragmented packets.

I could not find anything similar in Linux, however it seems to me that 
it should be quite
streightforward to implement.

All that needs to be done is to break alloc_skb() into two functions, 
similar to the following :
(it's just a C pseudo code, it does not compile - only demonstrates an idea)

struct sk_buff *alloc_empty_skb() {
    struct sk_buff *skb;

    if (in_interrupt() && (gfp_mask & __GFP_WAIT)) {
        static int count = 0;
        if (++count < 5) {
            printk(KERN_ERR "alloc_skb called nonatomically "
                   "from interrupt %p\n", NET_CALLER(size));
             BUG();
        }
        gfp_mask &= ~__GFP_WAIT;
    }

    /* Get the HEAD */
    skb = skb_head_from_pool();
    if (skb == NULL) {
        skb = kmem_cache_alloc(skbuff_head_cache, gfp_mask & ~__GFP_DMA);
        if (skb == NULL)
            goto nohead;
    }


    atomic_set(&skb->users, 1);

    return skb;

nohead:
    return NULL;
}



int skb_add_data(u8 * data, struct sk_buff * skb, int size) {
    if (data == NULL)
        goto nodata;

    /* XXX: does not include slab overhead */
    skb->truesize = size + sizeof(struct sk_buff);

    /* Load the data pointers. */
    skb->head = data;
    skb->data = data;
    skb->tail = data;
    skb->end = data + size;

    /* Set up other state */
    skb->len = 0;
    skb->cloned = 0;
    skb->data_len = 0;

    atomic_set(&(skb_shinfo(skb)->dataref), 1);
    skb_shinfo(skb)->nr_frags = 0;
    skb_shinfo(skb)->frag_list = NULL;
    return 0;
}


Any ideas why it should/should not work ?
Anybody ever implemented anything similar ?

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 

