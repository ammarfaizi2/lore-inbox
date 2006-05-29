Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWE2QV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWE2QV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWE2QV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 12:21:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:36060 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750887AbWE2QV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 12:21:29 -0400
In-Reply-To: <20060529154923.GA9025@skynet.ie>
References: <20060526151214.GA5190@skynet.ie> <20060526094924.10efc515.akpm@osdl.org> <20060529154923.GA9025@skynet.ie>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd attempt)
Date: Mon, 29 May 2006 18:22:33 +0200
To: mel@csn.ul.ie (Mel Gorman)
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>  arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function 
>>> `vrsqrtefp':
>>>  : undefined reference to `__udivdi3'
>>>  arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function 
>>> `vrsqrtefp':
>>>  : undefined reference to `__udivdi3'
>>>  make: *** [.tmp_vmlinux1] Error 1
>>
>> A function with a name like that doesn't _deserve_ to compile.

Would vector_reciprocal_square_root_estimate_floating_point() be any 
better...
Anyway, this is just a machine insn mnemonic, so the function name is 
fine
I believe.

>  #define push_end(res, size) do { unsigned long __sz = (size) ; \
> -	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
> +	resource_size_t farEnd = (res->end + __sz); \
> +	do_div(farEnd, (__sz + 1)); \
> +	res->end = farEnd * (__sz + 1) + __sz; \
>      } while (0)

Size here is a) a misnomer (size + 1 is the actual size) and b) always 
a power
of two minus one.  So instead, do

#define push_end(res, mask) res->end = -(-res->end & ~(unsigned 
long)mask)

(with a do { } while(0) armour if you prefer).


Segher

