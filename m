Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUAFSbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUAFSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:31:35 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:43172 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265078AbUAFSbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:31:03 -0500
Message-ID: <3FFAFE7A.7030404@grupopie.com>
Date: Tue, 06 Jan 2004 18:29:14 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, johnstultz@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
References: <1073405053.2047.28.camel@mulgrave> <Pine.LNX.4.58.0401060819000.2653@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> On Tue, 6 Jan 2004, James Bottomley wrote:
> 
>>			 however, there is also no need to get
>>the xtime sequence lock every time we do a jiffies_64 read, since the
>>only unstable time is when we may be updating both halves of it
>>non-atomically.  Thus, we only need the sequence lock when the bottom
>>half is zero.  This should improve the fast path of get_jiffies_64() for
>>all x86 arch's.
>>
> 
> This is wrong. There is nothing that guarantees that the read has read the 
> high bits first. 
> 


It seems to me that even if the the high bits get read first, the 64 value can 
go "backwards" in time, since it can read X from the high 32 bits, then the 
clock advance to X+1, and the low bits will read a value close to zero, 
resulting in ((X<<32)|0).


> It might have read the low bits first (and gotten 0xffffffff), and then on
> another CPU the contents were updated, and now the high bits are one
> bigger, and when you read the high bits, you get a value that is off by a
> _lot_.
> 
> And it's not just 0 and 0xffffffff in the low bits that can be problematic 
> either: if the CPU that does the "get_jiffies64()" gets an interrupt, the 
> thing may be off by more than a count of one.
> 
> IF this optimization is really worth it, the code should be something like 
> this:
> 
> 	#define JIFFY_SLOP (3)
> 
> 	u64 ret = jiffies_64;

> 	u32 low32 = ret;
> 
> 	if ((low+JIFFY_SLOP) <= JIFFY_SLOP*2) {
> 		... do the seqlock thing ...
> 	}
> 
> instead.
> 


What about this instead? I don't like very much this kind of construction, but 
it seems that it would prevent the lock altogether:


	u32 jiff_high1, jiff_high2, jiff_low

	do {
		jiff_high1 = ((volatile) jiffies_64) >> 32;
		jiff_low = ((volatile) jiffies_64);
		jiff_high2 = ((volatile) jiffies_64) >> 32;
	}
	while(jiff_high1 != jiff_high2);

	return (jiff_high1<<32) | jiff_low;

If there is anyway to avoid the volatiles there, it would be much cleaner.


Please don't beat me too hard if there is an obvious problem with this 
implementation.

This is an old trick that was used on a brain dead DOS API, where there were 2 
functions to read date and time, and there was hard to get a real timestamp :)


-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

