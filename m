Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbUKKPJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUKKPJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUKKPHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:07:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:63662 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262249AbUKKPEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:04:15 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tuning task-migration
Date: Thu, 11 Nov 2004 09:04:11 -0600
User-Agent: KMail/1.5
References: <200411110851.30819.habanero@us.ibm.com>
In-Reply-To: <200411110851.30819.habanero@us.ibm.com>
Cc: kenneth.w.chen@intel.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       mingo@elte.hu
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411110904.11955.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo Molnar wrote on Wednesday, October 06, 2004 1:05 PM
>
> > could you try the replacement patch below - what results does it give?
>
> By the way, I wonder why you chose to round down, but not up.
>
>
> arch cache_decay_nsec: 10000000
> migration cost matrix (cache_size: 9437184, cpu: 1500 MHz):
>         [00]  [01]  [02]  [03]
> [00]:    9.1   8.5   8.5   8.5
> [01]:    8.5   9.1   8.5   8.5
> [02]:    8.5   8.5   9.1   8.5
> [03]:    8.5   8.5   8.5   9.1
> min_delta: 8909202
> using cache_decay nsec: 8909202 (8 msec)

I tried this patch on power5.  This is a 2 node system, 2 chips (1 per node), 
2 cores per chip, 2 siblings per core.  Cores share and L2 & L3 cache.

Hard coding 1920KB for cache size (L2) I get:

migration cost matrix (cache_size: 1966080, cpu: 1656 MHz):
        [00]  [01]  [02]  [03]  [04]  [05]  [06]  [07]
[00]:    1.3   1.3   1.3   1.3   2.3   1.4   1.4   1.4
[01]:    1.3   1.4   1.3   1.3   1.4   1.4   1.4   1.4
[02]:    1.3   1.4   1.3   1.3   1.4   1.4   1.4   1.4
[03]:    1.4   1.4   1.4   1.3   1.4   1.4   1.4   1.4
[04]:    1.3   1.3   1.3   1.3   1.3   1.3   1.3   1.3
[05]:    1.3   1.4   1.3   1.3   1.3   1.4   1.4   1.3
[06]:    1.3   1.4   1.4   1.3   1.3   1.3   1.3   1.3
[07]:    1.3   1.3   1.3   1.3   1.3   1.4   1.3   1.3
min_delta: 1422824
using cache_decay nsec: 1422824 (1 msec)

I ran again for L3, but could not vmalloc the whole amount (cache is 36MB).  I 
tried 19200KB 
and got:

migration cost matrix (cache_size: 19660800, cpu: 1656 MHz):
        [00]  [01]  [02]  [03]  [04]  [05]  [06]  [07]
[00]:   16.9  16.8  16.0  16.0  16.7  16.9  16.7  16.9
[01]:   16.0  17.1  16.0  16.0  16.8  16.9  16.7  16.9
[02]:   17.0  17.1  17.0  16.0  16.7  16.9  16.7  16.9
[03]:   17.0  17.1  16.0  16.0  16.7  16.9  16.8  16.9
[04]:   16.0  16.0  16.0  16.9  17.2  17.1  17.2  17.2
[05]:   16.0  16.0  16.0  16.9  17.2  17.2  17.2  17.2
[06]:   16.0  16.0  16.0  16.9  17.2  17.1  17.2  17.2
[07]:   16.0  16.0  16.0  16.9  17.2  17.1  17.2  17.1
min_delta: 17492688
using cache_decay nsec: 17492688 (16 msec)

First, I am going to assume this test is not designed to show effects of 
shared cache.  For power5, since cores on a same chip share L2 & L3, I would 
conclude that cache_hot_time for level 0 (siblings in a core) and level 1 
(cores in a chip) domains should probably be "0".  For level 2 domains (all 
chips in a system), I guess it needs to be somewhere above 16ms.

We had someone run that online transaction DB workload with 10ms 
cache_hot_time on both level1 & 2 domains and performance regressed.  If we 
get a chance to run again, I will probably try level0: 0ms level1: 0ms 
level2: 10-20ms.

-Andrew Theurer
