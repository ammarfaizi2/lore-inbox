Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272164AbTHRQBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272165AbTHRQBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:01:21 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:46093 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272164AbTHRQBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:01:12 -0400
Message-ID: <3F40FC02.3000506@techsource.com>
Date: Mon, 18 Aug 2003 12:17:06 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Forrest <forrest@lmcg.wisc.edu>
CC: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <D069C7355C6E314B85CF36761C40F9A42E20BB@mailse02.se.axis.com> <20030816034129.A6301@rda07.lmcg.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Forrest wrote:
> On Sat, Aug 16, 2003 at 10:15:14AM +0200, Peter Kjellerstedt wrote:


> Shouldn't this be:
> 
> 		while (tmp & (sizeof(long) - 1)) {
> 
> 
>>			*tmp++ = '\0';
>>			count--;
>>		}

Oh, yeah!  That's right.  We need to check the address.  Also need to 
cast tmp to (int) or something (doesn't matter what it's cast to, 
because we only care about the lower 2 or 3 bits).

Peter, please see if this makes any speed difference.  But it definately 
needs this fix.


Frankly, I'm surprised it works.  In fact, it might not, but it's hard 
to tell from the tests just benchmarks.


Also, if you're doing dense addressing on Alpha, and you do byte 
accesses the addresses for char are byte addresses, but the code does 
read-modify-write to memory for byte accesses, because in that mode, you 
can only do 32-bit and 64-bit accesses.  The performance increase could 
be even greater for Alpha than for x86.


For Sparc, we might be able to do something with VIS instructions, 
although I don't know what the setup overhead is.  Sun's memcpy and 
memset only use VIS when the size is greater than 512, because 
otherwise, it's not worth it.


I don't know enough about PowerPC other than the proper use of the 
"eieio" instruction. :)

