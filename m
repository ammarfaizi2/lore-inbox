Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUHNNpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUHNNpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 09:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUHNNpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 09:45:52 -0400
Received: from [195.23.16.24] ([195.23.16.24]:54428 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262138AbUHNNpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 09:45:49 -0400
Message-ID: <411E1783.1030103@grupopie.com>
Date: Sat, 14 Aug 2004 14:45:39 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de> <20040813135109.GA20638@elte.hu> <411D9A2A.1000202@grupopie.com> <20040814124145.GA96097@muc.de>
In-Reply-To: <20040814124145.GA96097@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>The final algorithm pre-calculates markers on the compressed symbols so 
>>that the search time is almost divided by the number of markers.
> 
> 
> You could do that at compile time (in scripts/kallsyms.c) 

You're right! I'll see if I can come up with a patch.

If this is done in scripts/kallsyms.c, there is less code needed in the 
actual kernel, and there is no time penalty on the first lookup. This is 
a true win-win scenario :)

Thanks a lot for your suggestion.

>>There are still a few issues with this approach. The biggest issue is 
>>that this is clearly a speed/space trade-off, and maybe we don't want to 
>>waste the space on a code path that is not supposed to be "hot". If this 
>>is the case, I can make a smaller patch, that fixes just the name 
>>"decompression" strcpy's.
> 
> 
> I'm surprised that using 8 markers helps anything. There should 
> be many many more 0 stems than that in a not so big kernel.
> Did you actually measure the hit rate of the cache? I bet it is pretty low.

Well, I only left in the resulting source code the pieces that I 
actually measured to be a significant improvment.

The thing is, this is not exactly a cache.

The problem that the markers address is that the decompression must be 
done sequentially.

If I have 20000 symbols and already figured out from the binary search 
that I need symbol 11201 (for instance), I would have to go through 
11201 symbols to get to the symbol I need.

The algorithm I wrote keeps markers in the middle of the stream, so that 
when I try to fetch symbol 11201, I already know where symbol 10000 is 
because of the marker and only have to go through 1201 symbols.

With N markers you get N times the speed on the name search. (actually 
this is not exactly right for high values of N, because you can only use 
a marker that is a 0 stem, but for N<~32 this is a good approximation)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
