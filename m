Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUAHWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUAHWvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:51:16 -0500
Received: from ozlabs.org ([203.10.76.45]:53419 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266349AbUAHWvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:51:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16381.57040.576175.977969@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jan 2004 09:50:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
In-Reply-To: <20040108051111.4ae36b58.pj@sgi.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:

> The key thing to recall first is that these masks, and the bitops of
> longer standing on which they rely, are very little endian.  On all
> architectures, masks are essentially as if an array of bytes, even
> though they have a size that is a multiple of sizeof(long).
> 
> To quote from include/asm-ppc64/bitops.h:
> 
>  * Bitops are odd when viewed on big-endian systems.  They were designed
>  * on little endian so the size of the bitset doesn't matter (low order bytes
>  * come first) as long as the bit in question is valid.

Hmmm, well, that comment is a bit misleading.  Bitmasks on ppc64 (and
other bigendian 64-bit architectures such as sparc64) are stored as an
array of unsigned longs, i.e. 64-bit values.  The layout is such that
bit N is set iff (p[N/64] && (1UL << (N%64))) != 0, where p is an
unsigned long *.  In other words, a bitmask with only bit 0 set looks
like this, as an array of bytes:

00 00 00 00 00 00 00 01 00...

>  ==> However, _within_ each word, I suspect that I have the bytes arse
> backwards on a big endian machine.  The underlying snprintf("%x") and
> strtoul() routines that I call will presume that the byte order of the
> referenced u32 binary word is native (big on big endian).  Not good.

Why do you have to reference them as u32?  Why can't you use unsigned
long instead?  That should Just Work.

> If this request proceeds as expected, I will follow up with a patch to
> lib/mask.c that will likely make use of the cpu_to_le32() and
> le32_to_cpu() macros in byteorder.h to swap bytes in the u32 words being
> displayed and parsed.

That would be the wrong approach IMHO.

Regards,
Paul.
