Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUKFB1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUKFB1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUKFB1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:27:06 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:42701 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261269AbUKFB1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:27:03 -0500
Message-ID: <418C2861.6030501@cyberone.com.au>
Date: Sat, 06 Nov 2004 12:26:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random>
In-Reply-To: <20041106012018.GT8229@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Fri, Nov 05, 2004 at 03:32:50PM -0800, Jesse Barnes wrote:
>
>>On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
>>
>>>In my opinion the correct approach is to trigger the OOM killer
>>>when kswapd is unable to free pages. Once that is done, the number
>>>of tasks inside page reclaim is irrelevant.
>>>
>>That makes sense.
>>
>
>I don't like it, kswapd may fail balancing because there's a GFP_DMA
>allocation that eat the last dma page, but we should not kill tasks if
>we fail to balance in kswapd, we should kill tasks only when no fail
>path exists (i.e. only during page faults, everything else in the kernel
>has a fail path and it should never trigger oom).
>
>If you move it in kswapd there's no way to prevent oom-killing from a
>syscall allocation (I guess even right now it would go wrong in this
>sense, but at least right now it's more fixable). I want to move the oom
>kill outside the alloc_page paths. The oom killing is all about the page
>faults not having a fail path, and in turn the oom killing should be
>moved in the page fault code, not in the allocator. Everything else
>should keep returning -ENOMEM to the caller.
>
>

Probably a good idea. OTOH, some kernel allocations might really
need to be performed and have no failure path. For example __GFP_REPEAT.

I think maybe __GFP_REPEAT allocations at least should be able to
cause an OOM. Not sure though.

>So to me moving the oom killer into kswapd looks a regression.
>
>
>

Also, I think it would do the wrong thing on NUMA machines because
that has a per-node kswapd.

