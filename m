Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUBYGWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 01:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbUBYGWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 01:22:18 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:30891 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262634AbUBYGWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 01:22:07 -0500
Message-ID: <403C3F04.20601@colorfullife.com>
Date: Wed, 25 Feb 2004 07:21:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Williams <dsw@gelato.unsw.edu.au>
CC: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory
 exceeds 2.5GB (correction)
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org> <403B8C78.2020606@colorfullife.com> <20040225005804.GE18070@cse.unsw.EDU.AU>
In-Reply-To: <20040225005804.GE18070@cse.unsw.EDU.AU>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Williams wrote:

>Hi Manfred
>
>I have updated to the latest bk and new output can be found at:
>http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
>kern-log-bk
>
>Also I am quite confident that it is not a hardware problem.
>
>I took a look at alloc_skb(..) and there is a reference to
>an atomic_t token with this being the most suspect
>
>150> atomic_set(&(skb_shinfo(skb)->dataref), 1);
>  
>
I don't think so:
The allocation that generates the error is skb->head: The cache name is 
"size-2048", thus the allocation is a kmalloc(1000-2000, probably 1536 
for one eth frame). The skb itself is allocated from the skbuff_head_cache.

I don't see a pattern in the virtual addresses:
 start=e000000101ee09a0, len=2048
 start=e000000101ee09a0, len=2048
 start=e000000101ee11b8, len=2048
 start=e000000101ee19d0, len=2048
 start=e000000101ee3218, len=2048
 start=e00000017eed1b90, len=2048
 start=e00000017eed23a8, len=2048
 start=e00000017eed2bc0, len=2048
 start=e00000017eed4308, len=2048
 start=e00000017eed5338, len=2048
 start=e00000017eed5338, len=2048
 start=e00000017eed5b50, len=2048
 start=e00000017eed5b50, len=2048
 start=e00000017eed6b80, len=2048
 start=e00000017eed82c8, len=2048
 start=e00000017eedc288, len=2048
 start=e00000017eedcaa0, len=2048
 start=e00000017eeddad0, len=2048
 start=e00000017eede2e8, len=2048
 start=e00000017eedeb00, len=2048
 start=e00000017ef60a60, len=2048
 start=e00000017ef61a90, len=2048
 start=e00000017ef622a8, len=2048
 start=e00000017ef62ac0, len=2048
 start=e00000017ef632d8, len=2048
 start=e00000017ef65a50, len=2048
 start=e00000017ef65a50, len=2048
 start=e00000017ef65a50, len=2048
 start=e00000017ef66a80, len=2048

That virtually rules out a bad memory chip.

But the corrupted byte is always at offset 0x620 into the allocation:
 Slab corruption: start=e00000017ef65a50, len=2048
 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
--
 Slab corruption: start=e000000101ee19d0, len=2048
 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
--
 Slab corruption: start=e000000101ee3218, len=2048
 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
--
 Slab corruption: start=e00000017ef66a80, len=2048
 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
--
 Slab corruption: start=e000000101ee11b8, len=2048
 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

0x620 (1568) is behind the end of the actual eth frame. Who could modify 
that?

Darren, which nic do you use? Could you try what happens if you reduce 
the MTU?

--
    Manfred

