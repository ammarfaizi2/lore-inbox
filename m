Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTJZSB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTJZSB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:01:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:48808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263369AbTJZSBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:01:25 -0500
Date: Sun, 26 Oct 2003 10:01:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Randolph Chung <tausq@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix __div64_32 to do division properly
In-Reply-To: <20031026152412.GK24406@tausq.org>
Message-ID: <Pine.LNX.4.44.0310260931501.934-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Oct 2003, Randolph Chung wrote:
>
> Hi Linus, this was sent to lkml a few days ago. Pls consider applying
> for 2.6 :-)

As far as I can tell, this one is buggy and can cause total lockups with 
an infinite loop:

> +	if (b > 0) {
> +		while (b < rem) {
> +			b <<= 1;
> +			d <<= 1;
> +		}
> +	}

The "shift up until big enough" is _not_ valid: if the thing we divide is 
large (high bit set and some other bits set too), then shifting 'b' up may 
never make 'b' bigger than 'rem'.

It looks like this should be trivially triggerable by just dividing ~0ULL 
with pretty much anything.

Or did I miss something?

Also, I have to say that it seems silly to do the old "one bit at a time"  
thing when most hardware will have at least a 32/32 divide (and even if it
doesn't have a hardware 32-bit divide, the "one bit at a time"  algorithm
will be faster for regular 32-bit values).

Note that the reduction of the high 32 bits can be done with all 32-bit 
math.

So with the overflow case fixed, and with a 32/32 initial reduction of the 
high bits, the thing would look something like this:

	uint32_t __div64_32(uint64_t *n, uint32_t base)
	{
		uint64_t rem = *n;
		uint64_t b = base;
		uint64_t res, d = 1;
		uint32_t high = rem >> 32;
		uint64_t top;
	
		/* Reduce the thing a bit first */
		res = 0;
		if (high >= base) {
			high /= base;
			res = (uint64_t) high << 32;
			rem -= (uint64_t) (high*base) << 32;
		}

		while ((int64_t)b > 0 && b < rem) {
			b <<= 1;
			d <<= 1;
		}
	
		do {
			if (rem >= b) {
				rem -= b;
				res += d;
			}
			b >>= 1;
			d >>= 1;
		} while (d);
	
		*n = res;
		return rem;
	}
	
but I have not really verified this for any reasonable amount of values..

If you can verify this some way (test at least a somewhat interesting 
subset), please re-send the patch. 

Remember: be _careful_ with math. Overflow is nasty.

		Linus

