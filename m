Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWAZF21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWAZF21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAZF21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:28:27 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:48354 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751320AbWAZF20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:28:26 -0500
Message-ID: <43D85DF4.9020703@cosmosbay.com>
Date: Thu, 26 Jan 2006 06:28:20 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Bernd Eckenfels <be-news06@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Red zones
References: <E1F1sSY-0004yP-00@calista.inka.de>
In-Reply-To: <E1F1sSY-0004yP-00@calista.inka.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Thu, 26 Jan 2006 06:28:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> We can use a red zone big enough to hold the whole per_cpu data.
> 
> I am trying to learn a bit here: why is it required to have a speciel red
> zone for this case? Wouldnt it make more sence to have a single red zone
> which can be used by all locations in the kernel for unused structures? That
> would reduce the number of wasted segements in the page table, or?
>

On x86_64, available virtual space is huge, so having different red zones can 
spot the fault more easily : If the target of the fault is in the PER_CPU 
redzone given range, we can instantly knows there is still a per_cpu() user 
accessing a non possible cpu area. As the red zone is not mapped at all, no 
page table is setup.


On 32 bits platforms, this is completely different : space is scarse (typical 
User/Kernel split of 3GB/1GB), so we should avoid to reserve even a 32 KB 
redzone. We could do it in DEBUG mode for example. Current interim patch in 
2.6.16-rc1-mm3 is using NULL pointer but this is not a perfect solution since 
the underlying current user process can perfectly map something in this 'zone'.

Eric


