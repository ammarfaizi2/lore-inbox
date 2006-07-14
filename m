Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWGNDf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWGNDf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWGNDfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:35:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43492 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161080AbWGNDfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:35:25 -0400
Date: Thu, 13 Jul 2006 20:35:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, alokk@calsoftinc.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <20060713200234.d30cf1b8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607132009520.32134@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
 <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu>
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org> <1152818472.3024.75.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
 <20060713161620.f61d2ac0.akpm@osdl.org> <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0607131944260.31824@schroedinger.engr.sgi.com>
 <20060713200234.d30cf1b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Andrew Morton wrote:

> > 2.6.17 code has also the dropping of the lock.
> 
> It doesn't.

Ahh... mm patch in the way. This gets even stranger.
 
> > This was no reversion. 
> > Maybe there is a problem but then I'd like to hear about it:
> 
> It's all in this thread - see Chandra's testing results.

Hmmm. Chandra's traces are all over the place.

Ok. I found a series of cases where free_block is used on the shared 
array where the shared array can become corrupted if we drop the lock
in free_block():

1. cache_reap() calling drain_array (which calls free_block) on the shared 
  array

2. drain_cpu_caches() calling drain_array on the shared array.

3. cpuup_callback() in case CPU_UP_CANCELLED calling free_block

4. alloc_kmemlist() calling free_block().

The fix by removing the dropping of the lock in free_block could cause 
retaking the list_lock that we already hold in the OFF_SLAB case (even in 
the non NUMA case). 

However, we have not noticed this so far. Maybe we were lucky?

In the RCU case we only need to take the list lock when RCU runs to free 
the management object. So that is safe. Guess we never use non-RCU 
OFF_SLAB.

Alokk? Can you confirm this reasoning.

