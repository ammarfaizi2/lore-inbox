Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTHUQoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTHUQoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:44:23 -0400
Received: from [207.175.35.50] ([207.175.35.50]:23632 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262784AbTHUQoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:44:21 -0400
Message-ID: <3F44F6E4.10903@eternal-systems.com>
Date: Thu, 21 Aug 2003 09:44:20 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Netfiltering - NF_IP_LOCAL_OUT - how it works???
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> Hi Vishwas, sorry for the late reply.  Most netfilter developers have
> been to the netfilter developer workshop, I guess.
> 
> you should ask this question on the netfilter-devel mailinglist, where
> it is more on-topic than on lkml.
> 
> On Thu, Aug 14, 2003 at 03:06:26PM -0700, Vishwas Raman wrote:
> 
> 
>>While initializing the module, I register a NF_IP_LOCAL_OUT hook for the 
>>outgoing packet and change skb->dst->output to my_ip_output() instead of 
>>ip_output() in that hook function. After loading the module, I see 
>>control being transferred to my_ip_output() for all outgoing packets 
>>which in turn calls ip_output() and everything seems to work well.
>>
>>The exit function of the module also unregisters the hook that I am using.
>>
>>The problem is that after I unload the module, which in turn unregisters 
>>the hook, I have a kernel panic happening each time I use TCP.
>>
>>The panic occurs at the following point, ip_build_and_send_pkt() in 
>>ip_output.c where it is trying to call
>>
>>    NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, rt->u.dst.dev,
>>                    output_maybe_reroute);
>>
>>I thought once the unregistering of the hook is done, it no longer looks 
>>for that hook function. I have no idea why it is failing. May be I am 
>>doing something grossly wrong with netfiltering. Anyone who is familiar 
>>with netfiltering and has registered and unregistered hooks before might 
>>be able to guide me regarding this.
> 
> 
> I think either you are doing something wrong while unregistering from
> the netfilter hook - or you are running into a race condition.  It might
> happen, that you assign the skb->dst->output function of a packet to
> your function, and then you remove the module before that packet is
> actually sent.

Actually I did solve the problem. All I had to do was reset 
skb->dst->output() to ip_output() in my_ip_output() which is defined in 
my module. The problem was that even after my module was unloaded the 
destination cache was still pointing to my_ip_output() which was 
non-existent...

Thanks,

-Vishwas.




> 
> 
>>-Vishwas.
> 
> 



-- 
--
Vishwas Raman
Software Engineer, Eternal Systems, Inc,
5290 Overpass Rd, Bldg D, Santa Barbara. CA 93111
Email: vishwas@eternal-systems.com
Tel:   (805) 696-9051 x246
Fax:   (805) 696-9083
URL:   http://www.eternal-systems.com/

