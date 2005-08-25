Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVHYVku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVHYVku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVHYVku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:40:50 -0400
Received: from science.horizon.com ([192.35.100.1]:38205 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964855AbVHYVkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:40:42 -0400
Date: 25 Aug 2005 17:40:29 -0400
Message-ID: <20050825214029.21209.qmail@science.horizon.com>
From: linux@horizon.com
To: alex.williamson@hp.com
Subject: Re: Need better is_better_time_interpolator() algorithm
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (frequency) * (1/drift) * (1/latency) * (1/(jitter_factor * cpus))

(Note that 1/cpus, being a constant for all evaluations of this
expression, has no effect on the final ranking.)
The usual way it's done is with some fiddle factors:

quality_a^a * quality_b^b * quality_c^c

Or, equivalently:

a * log(quality_a) + b * log(quality_b) + c * log(quality_c)

Then you use the a, b and c factors to weight the relative importance
of them.  Your suggestion is equivalent to setting all the exponents to 1.

But you can also say that "a is twice as important as b" in a
consistent manner.

Note that computing a few bits of log_2 is not hard to do in integer
math if you're not too anxious about efficiency:

unsigned log2(unsigned x)
{
	unsigned result = 31;
	unsigned i;

	assert(x);
	while (!x & (1u<<31)) {
		x <<= 1;
		result--;
	}
	/* Think of x as a 1.31-bit fixed-point number, 1 <= x < 2 */
	for (i = 0; i < NUM_FRACTION_BITS; i++) {
		unsigned long long y = x;
		/* Square x and compare to 2. */
		y *= x;
		result <<= 1;
		if (y & (1ull<<63)) {
			result++;
			x = (unsigned)(y >> 32);
		} else {
			x = (unsigned)(y >> 31);
		}
	}
	return result;
}

Setting NUM_FRACTION_BITS to 16 or so would give enough room for
reasonable-sized weights and not have the total overflow 32 bits.
