Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWE2RyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWE2RyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWE2RyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:54:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:50653 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751143AbWE2RyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:54:14 -0400
In-Reply-To: <Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
References: <20060526151214.GA5190@skynet.ie> <20060526094924.10efc515.akpm@osdl.org> <20060529154923.GA9025@skynet.ie> <2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org> <Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd attempt)
Date: Mon, 29 May 2006 19:56:21 +0200
To: Mel Gorman <mel@csn.ul.ie>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>  #define push_end(res, size) do { unsigned long __sz = (size) ; \
>>> -	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
>>> +	resource_size_t farEnd = (res->end + __sz); \
>>> +	do_div(farEnd, (__sz + 1)); \
>>> +	res->end = farEnd * (__sz + 1) + __sz; \
>>>      } while (0)
>>
>> Size here is a) a misnomer (size + 1 is the actual size) and b) 
>> always a power
>> of two minus one.  So instead, do
>>
>> #define push_end(res, mask) res->end = -(-res->end & ~(unsigned 
>> long)mask)
>>
>> (with a do { } while(0) armour if you prefer).
>>
>
> It's not doing the same as the old code so is your suggested fix a 
> correct replacement?
>
> For example, given 0xfff for size the current code rounds res->end to 
> the next 0x1000 boundary and adds 0xfff. Your propose fix just rounds 
> it to the next 0x1000 if I'm reading it correctly but is what the code 
> was meant to do in the first place? Using masks, the equivilant of the 
> current code is something like;
>
> #define push_end(res, mask) do { \
> 	res->end = -(-res->end & ~(unsigned long)mask); \
> 	res->end += mask; \
> } while (0)

Yeah forgot a bit, this looks fine.


Segher

