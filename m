Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUAHNKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUAHNKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:10:00 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:733 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264444AbUAHNJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:09:52 -0500
Date: Thu, 8 Jan 2004 05:11:11 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040108051111.4ae36b58.pj@sgi.com>
In-Reply-To: <20040107113207.3aab64f5.akpm@osdl.org>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew asked:
> Just looking at this function, it seems to walking an array of longs using
> a u32*.  Could someone please convince me that this is correct on both
> little-endian and big-endian 64-bit hardware?  

Good question, Andrew.  Thanks.  I suspect I did indeed break something
here.

The key thing to recall first is that these masks, and the bitops of
longer standing on which they rely, are very little endian.  On all
architectures, masks are essentially as if an array of bytes, even
though they have a size that is a multiple of sizeof(long).

To quote from include/asm-ppc64/bitops.h:

 * Bitops are odd when viewed on big-endian systems.  They were designed
 * on little endian so the size of the bitset doesn't matter (low order bytes
 * come first) as long as the bit in question is valid.

>From one u32 word to the next, both my input and output routines in
lib/mask.c (mask_snprintf and mask_parse) respect this order, so that
part is correct, I believe.  For a mask beginning at address A, bytes
A[0..3] form the first u32 word, A[4..7] the second, and so forth. 
Good.

Whether the mask size is a multiple of u32 or u64 doesn't matter.

 ==> However, _within_ each word, I suspect that I have the bytes arse
backwards on a big endian machine.  The underlying snprintf("%x") and
strtoul() routines that I call will presume that the byte order of the
referenced u32 binary word is native (big on big endian).  Not good.

Anyone with a big-endian SMP machine should be able to see this, by
displaying /proc/irq/prof_cpu_mask or /proc/irq/<pid>/smp_affinity, and
determining if they see the expected low order bit(s) set, or instead
the output is byte reversed.

Given the good chance that I'm still confused, I will now broadcast
under a more enticing Subject a request for someone with a big endian
SMP to verify whether I've broken this as I suspect.

If this request proceeds as expected, I will follow up with a patch to
lib/mask.c that will likely make use of the cpu_to_le32() and
le32_to_cpu() macros in byteorder.h to swap bytes in the u32 words being
displayed and parsed.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
