Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTHYQyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbTHYQyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:54:19 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:531 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261815AbTHYQyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:54:17 -0400
Message-ID: <3F4A4362.4020601@techsource.com>
Date: Mon, 25 Aug 2003 13:12:02 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
CC: linux-kernel@vger.kernel.org, Frank.Cornelis@elis.ugent.be
Subject: Re: [PATCH] sched: CPU_THRESHOLD
References: <20030823195740.7133874d.rnsanchez@terra.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ricardo Nabinger Sanchez wrote:
> hello Frank,
> 
> 
>>-	*imbalance = (max_load - nr_running) / 2;
>>+	*imbalance = (max_load - nr_running) >> 1;
> 
> 
> I think it is a good coding practice to keep things human-readable. 
> In this code snippet, the division by 2 is quickly understood by most
> readers (specially those who didn't write it).  The right shift may
> obfuscate the real meaning of this operation, which is a single
> division by 2, not a bit-oriented expression.
> 
> Assuming that sched.c will be compiled with optimizations enabled, the
> compiler will change the human-readable division by a fast machine
> right shift operation, whenever possible (gcc surely will).
> 
> Thus, we keep the kernel code more readable, and sometimes let the
> compiler apply newer (and hopefully faster) optimizations than some
> tricks we have known as fastest available.
> 
> Regards, and please let me know what do you think about it.
> 

Note that right-shift rounds towards negative infinity, while divide 
rounds towards zero.

If the operands are unsigned, then rsh and divide will yield the same 
instructions (on x86).  OTOH, if they are signed, then you get different 
results.  For this rsh, obviously, you get a shift, but for divide, you 
get something like this:

; divide edx by 2
mov ecx,edx
lsr ecx,31
asr edx,1
add edx,ecx


