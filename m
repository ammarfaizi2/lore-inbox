Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTIPUWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTIPUWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:22:40 -0400
Received: from [207.175.35.50] ([207.175.35.50]:38004 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262051AbTIPUWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:22:37 -0400
Message-ID: <3F6770CE.8040802@eternal-systems.com>
Date: Tue, 16 Sep 2003 13:21:34 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com> <Pine.LNX.4.53.0309161533030.30081@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard B. Johnson wrote:
> On Tue, 16 Sep 2003, Vishwas Raman wrote:
> 
> 
>>Hi all,
>>
>>I have a very simple question, which a lot of you would have solved. I
>>am intercepting a TCP packet, which I would like to change slightly.
>>
>>Let's say, I change the doff field of the tcp-header (for eg: increase
>>it by 1). I know it is wrong just to change the doff field without
>>increasing the packet length, but lets say I do it just as a test. Since
>>I changed a portion of the tcp header, I have to update the tcp checksum
>>too right!!! If so, what is the best way to do so, without having to
>>recalculate the entire tcp checksum (I know how to recalculate the
>>checksum from scratch).
>>
>>Can anyone out there tell me the algorithm to update the checksum
>>without having to recalculate it.
>>
>>I tried the following algorithm but it didnt work. The packet got
>>rejected as a packet with bad cksum.
>>
>>void changePacket(struct sk_buff* skb)
>>{
>>     struct tcphdr *tcpHdr = skb->h.th;
>>     // Verifying the tcp checksum works here...
>>     tcpHeader->doff += 1;
>>     long cksum = (~(tcpHdr->check))&0xffff;
>>     cksum += 1;
>>     while (cksum >> 16)
>>     {
>>         cksum = (cksum & 0xffff) + (cksum >> 16);
>>     }
>>     tcpHeader->check = ~cksum;
>>     // Verifying tcp checksum here fails with bad cksum
>>}
>>
>>Any pointers/help in this regard will be highly appreciated...
> 
> 
> The TCP/IP checksum is a WORD sum (unsigned short) in which
> any overflow out of the word causes the word to be incremented.
> The final sum is then inverted to become the checksum. Note that
> many algorithms sum into a long then fold-back the bits. It's
> the same thing, different method.
> 
> Therefore:
> 	Given an existing checksum of 0xffff, if the
> 	next word to be summed is 0x0001, the result
> 	will be 0x0001 because adding 1 to 0xffff makes
> 	it 0, causing an overflow which propagates to
> 	become 0x0001.
> So:
> 	Clearly, information is lost because one doesn't
> 	know how the 0x0001 was obtained.
> 
> If I were to modify a low byte somewhere by subtracting 1,
> would I know that the new checksum, excluding the inversion,
> was 0x0000? No. It could be 0xffff.
> 
> This presents a problem when trying to modify existing checksums.
> It's certainly easier to set the existing checksum to 0, then
> re-checksum the whole packet. It's probably faster than some
> looping algorithm that attempts to unwind a previous checksum.

Are you then suggesting that instead of trying to do an incremental 
update of the tcp checksum, I set it to 0 and recalculate it from 
scratch? But I thought that doing that was a big performance hit. Isn't it?

> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
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

