Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTIPXdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTIPXdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:33:46 -0400
Received: from [207.175.35.50] ([207.175.35.50]:44196 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262488AbTIPXdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:33:44 -0400
Message-ID: <3F679D97.5030400@eternal-systems.com>
Date: Tue, 16 Sep 2003 16:32:39 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com> <Pine.LNX.4.53.0309161533030.30081@chaos> <3F6770CE.8040802@eternal-systems.com> <20030916224151.GC30188@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Richard B. Johnson wrote:
> 
>>If I were to modify a low byte somewhere by subtracting 1,
>>would I know that the new checksum, excluding the inversion,
>>was 0x0000? No. It could be 0xffff.
> 
> 
> You're right about information being thrown away, but wrong because IP
> checksums are more rigidly defined than that.
> 
> RFC1624 was written because the earlier RFC actually got this wrong.
> 
> As long as at least one of the checksummed words is known to be
> non-zero, 0x0000 is not a possible value.  This is true of all IP checksums.
> 
> There is only one possible value of the non-complemented sum: 0xffff.
> 
> So when you subtract 1 from 0x0001, you get 0xffff.
> 
> To do this right, instead of subtracting a word, you add the
> complement of the word.  After carry-folding, this works out right.
> 
> Vishwas Raman wrote:
> 
>>Are you then suggesting that instead of trying to do an incremental 
>>update of the tcp checksum, I set it to 0 and recalculate it from 
>>scratch? But I thought that doing that was a big performance hit. Isn't it?
> 
> 
> You don't need to recalculate the sum.  All routers modify the IP
> header checksum when they decrement the TTL of a packet - it's a
> widely used algorithm.  Equation 3 from RFC1624 is correct :)

I was also under the belief that RFC1624 was handling this correctly.

> 
> Your code looks fine to me.  Are you sure you're verifying the
> checksum correctly?


This is how I am verifying the checksum. It seems to work in other 
cases. (by the way, I am working with the 2.4.20 kernel src code)

/* I do this check for only packets that are less than or equal to 76 
bytes in length. And I make sure the packets that I am dealing with are 
less than this length */

int tcpFailoverVerifyChecksum(struct sk_buff* skb)
{
     int len = skb->len - sizeof(struct iphdr);
     retValue = tcp_v4_check(skb->h.th, len,
                             skb->nh.iph->saddr, skb->nh.iph->daddr,
                             csum_partial((char *)skb->h.th, len, 0));
     return retValue;
}

Is the above function right? If not, what is the right way to verify the 
checksum of a tcp packet?


> 
> 
>>    while (cksum >> 16)
>>    {
>>        cksum = (cksum & 0xffff) + (cksum >> 16);
>>    }
> 
> 
> In general you need to add back the carry bits at most twice, btw.
> 
> 	cksum = (cksum & 0xffff) + (cksum >> 16);
> 	cksum += (cksum >> 16);

Ok...I will make the change... Thks...




