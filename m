Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUAFQ0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUAFQ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:26:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:36572 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbUAFQ0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:26:49 -0500
Date: Tue, 6 Jan 2004 08:26:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Andrew Morton <akpm@osdl.org>, johnstultz@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <1073405053.2047.28.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0401060819000.2653@home.osdl.org>
References: <1073405053.2047.28.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, James Bottomley wrote:
>
>			 however, there is also no need to get
> the xtime sequence lock every time we do a jiffies_64 read, since the
> only unstable time is when we may be updating both halves of it
> non-atomically.  Thus, we only need the sequence lock when the bottom
> half is zero.  This should improve the fast path of get_jiffies_64() for
> all x86 arch's.

This is wrong. There is nothing that guarantees that the read has read the 
high bits first. 

It might have read the low bits first (and gotten 0xffffffff), and then on
another CPU the contents were updated, and now the high bits are one
bigger, and when you read the high bits, you get a value that is off by a
_lot_.

And it's not just 0 and 0xffffffff in the low bits that can be problematic 
either: if the CPU that does the "get_jiffies64()" gets an interrupt, the 
thing may be off by more than a count of one.

IF this optimization is really worth it, the code should be something like 
this:

	#define JIFFY_SLOP (3)

	u64 ret = jiffies_64;
	u32 low32 = ret;

	if ((low+JIFFY_SLOP) <= JIFFY_SLOP*2) {
		... do the seqlock thing ...
	}

instead.

Which still avoids the read-lock about 99.9999% of the time, so it may 
well be worth it. But somebody should double-check my logic.

				Linus
