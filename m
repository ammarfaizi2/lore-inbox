Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272367AbTHECL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272370AbTHECL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:11:26 -0400
Received: from dyn-ctb-210-9-244-254.webone.com.au ([210.9.244.254]:49927 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272367AbTHECLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:11:21 -0400
Message-ID: <3F2F1236.6050900@cyberone.com.au>
Date: Tue, 05 Aug 2003 12:11:02 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org>
In-Reply-To: <200308050207.18096.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>Changes:
>
>Reverted the child penalty to 95 as new changes help this from hurting
>
>Changed the logic behind loss of interactive credits to those that burn off 
>all their sleep_avg
>
>Now all tasks get proportionately more sleep as their relative bonus drops 
>off. This has the effect of detecting a change from a cpu burner to an 
>interactive task more rapidly as in O10. 
>
>The _major_ change in this patch is that tasks on uninterruptible sleep do not 
>earn any sleep avg during that sleep; it is not voluntary sleep so they should 
>not get it. This has the effect of stopping cpu hogs from gaining dynamic 
>priority during periods of heavy I/O. Very good for the jerks you may 
>see in X or audio skips when you start a whole swag of disk intensive cpu hogs 
>(eg make -j large number). I've simply dropped all their sleep_avg, but 
>weighting it may be more appropriate. This has the side effect that pure
>disk tasks (eg cp) have relatively low priority which is why weighting may
>be better. We shall see.
>

I don't think this is a good idea. Uninterruptible does not mean its
not a voluntary sleep. Its more to do with how a syscall is implemented.
I don't think it should be treated any differently to any other type of
sleep.

Any task which calls schedule in kernel context is sleeping volintarily
- if implicity due to having called a blocking syscall.

>
>Please test this one extensively. It should _not_ affect I/O throughput per 
>se, but I'd like to see some of the I/O benchmarks on this. I do not want to 
>have detrimental effects elsewhere.
>

Well the reason it can affect IO thoughput is for example when there is
an IO bound process and a CPU hog on the same processor: the longer the
IO process has to wait (after being woken) before being run, the more
chance the disk will fall idle for a longer period. And of course the
CPU uncontended case is somewhat uninteresting when it comes to a CPU
scheduler.



