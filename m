Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277803AbRJWPrP>; Tue, 23 Oct 2001 11:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277806AbRJWPrG>; Tue, 23 Oct 2001 11:47:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37132 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277803AbRJWPqz>; Tue, 23 Oct 2001 11:46:55 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: How should we do a 64-bit jiffies?
Date: Tue, 23 Oct 2001 15:45:42 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9r43b6$1as$1@penguin.transmeta.com>
In-Reply-To: <1164.1003813848@ocs3.intra.ocs.com.au> <3BD52454.218387D9@mvista.com>
X-Trace: palladium.transmeta.com 1003852019 14605 127.0.0.1 (23 Oct 2001 15:46:59 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 23 Oct 2001 15:46:59 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BD52454.218387D9@mvista.com>,
george anzinger  <george@mvista.com> wrote:
>
>I am beginning to think that defining a u64 and casting, i.e.:
>
>#define jiffies (unsigned long volitial)jiffies_u64
>
>is the way to go.

..except for gcc being bad at even 64->32-bit casts like the above.  It
will usually still load the full 64-bit value, and then only use the low
bits. 

The efficient and sane way to do it is:

	/*
	 * The 64-bit value is not volatile - you MUST NOT read it
	 * without holding the spinlock
	 */
	u64 jiffies_64;

	/*
	 * Most people don't necessarily care about the full 64-bit
	 * value, so we can just get the "unstable" low bits without
	 * holding the lock. For historical reasons we also mark
	 * it volatile so that busy-waiting doesn't get optimized
	 * away in old drivers.
	 */
	#if defined(__LITTLE_ENDIAN) || (BITS_PER_LONG > 32)
	#define jiffies (((volatile unsigned long *)&jiffies_64)[0])
	#else
	#define jiffies (((volatile unsigned long *)&jiffies_64)[1])
	#endif
	
which looks ugly, but the ugliness is confined to that one place, and
none of the users will ever have to care..

		Linus
