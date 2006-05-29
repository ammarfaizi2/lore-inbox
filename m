Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWE2Ri2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWE2Ri2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWE2Ri2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:38:28 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:57791 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750727AbWE2Ri1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:38:27 -0400
Date: Mon, 29 May 2006 18:38:23 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
 attempt)
In-Reply-To: <2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
References: <20060526151214.GA5190@skynet.ie> <20060526094924.10efc515.akpm@osdl.org>
 <20060529154923.GA9025@skynet.ie> <2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006, Segher Boessenkool wrote:

>>>>  arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function 
>>>> `vrsqrtefp':
>>>>  : undefined reference to `__udivdi3'
>>>>  arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function 
>>>> `vrsqrtefp':
>>>>  : undefined reference to `__udivdi3'
>>>>  make: *** [.tmp_vmlinux1] Error 1
>>> 
>>> A function with a name like that doesn't _deserve_ to compile.
>
> Would vector_reciprocal_square_root_estimate_floating_point() be any 
> better...
> Anyway, this is just a machine insn mnemonic, so the function name is fine
> I believe.
>
>>  #define push_end(res, size) do { unsigned long __sz = (size) ; \
>> -	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
>> +	resource_size_t farEnd = (res->end + __sz); \
>> +	do_div(farEnd, (__sz + 1)); \
>> +	res->end = farEnd * (__sz + 1) + __sz; \
>>      } while (0)
>
> Size here is a) a misnomer (size + 1 is the actual size) and b) always a 
> power
> of two minus one.  So instead, do
>
> #define push_end(res, mask) res->end = -(-res->end & ~(unsigned long)mask)
>
> (with a do { } while(0) armour if you prefer).
>

It's not doing the same as the old code so is your suggested fix a correct 
replacement?

For example, given 0xfff for size the current code rounds res->end to the 
next 0x1000 boundary and adds 0xfff. Your propose fix just rounds it to 
the next 0x1000 if I'm reading it correctly but is what the code was meant 
to do in the first place? Using masks, the equivilant of the current code 
is something like;

#define push_end(res, mask) do { \
 	res->end = -(-res->end & ~(unsigned long)mask); \
 	res->end += mask; \
} while (0)

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
