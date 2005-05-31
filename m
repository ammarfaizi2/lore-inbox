Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVEaGfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVEaGfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVEaGfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:35:53 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:39096 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261271AbVEaGfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:35:46 -0400
References: <1117291619.9665.6.camel@localhost>
            <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
            <84144f0205052911202863ecd5@mail.gmail.com>
            <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
            <1117399764.9619.12.camel@localhost>
            <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
            <1117466611.9323.6.camel@localhost>
            <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Machine Freezes while Running Crossover Office
Date: Tue, 31 May 2005 09:35:45 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 10:31 -0700, Linus Torvalds wrote:
> Also, pipes are a bit special from a scheduling standpoint because they 
> use the magic "synchronous wakeup" thing, and it might be worthwhile 
> trying to just change the two calls to "wake_up_interruptible_sync()" in 
> fs/pipe.c to the non-sync version (ie just remove the "_sync" part).

Btw, I was looking at this yesterday but noticed there are no 
__wake_up_sync() calls in the oprofile report. So I don't think we're 
hitting the sync wakeup paths at all. 

I also read Crossover sources a bit and I think the setup is something like 
this: 

wineserver: 

 - Polls a 'reply' pipe to see if there's something to read.
 - If the pipe has something for us, read it.
 - Do something and the write results to another pipe. 

wine-preloader: 

 - Write to the 'reply' pipe.
 - Read from the another pipe. 

Looks if the processes keep on waking up each other and thus eat up all CPU 
time. (Even more so if Crossover uses RT priority, have to check that.) 

P.S. I can also verify that it is indeed the 64 KB change that breaks 
Crossover. I changed PIPE_BUFFERS to 1 and could not reproduce the hang. 
Increasing it to 8 makes the problem come up again. 

                  Pekka 

