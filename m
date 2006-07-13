Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWGMW1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWGMW1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWGMW1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:27:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50918 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030437AbWGMW1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:27:40 -0400
Date: Thu, 13 Jul 2006 15:27:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org, nagar@watson.ibm.com,
       balbir@in.ibm.com, alokk@calsoftinc.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <1152818472.3024.75.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607131520340.30403@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra>  <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org>  <20060713072635.GA907@elte.hu> 
 <20060713004445.cf7d1d96.akpm@osdl.org>  <20060713124603.GB18936@elte.hu> 
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com> 
 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org> <1152818472.3024.75.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Arjan van de Ven wrote:

> there is a corner case in the slab code that I personally don't trust at
> all. In the NUMA case, if the memory is not originally from your own
> node, the cache_free_alien() function takes, while having your own local
> lock, the lock of the remote node as well. (at least on my reading of
> the code) to free the memory to that node. I have yet to see where in
> the code it safeguards against that remote node doing the exact same
> thing in the opposite direction concurrently, and causing a basic ABBA
> deadlock.

Hmmm.. This case is only followed during bootup when we do not have
alien caches yet. And its pretty rare to free memory on bootup. Once the
alien caches are present then we do not take the listlock anymore but
use the lock of the alien structure.

This could cause an ABBA deadlock if a free happens on another 
processor during bootup before all the slabs are established.

That then brings us to look if a slab free can happen before a slab is 
completely established via kmem_cache_create.

kmem_cache_create takes the cpu hotplug lock and the cache_chain_mutex.

One could argue that a subsystem must make sure that the slab cache it 
creates should not be used before kmem_cache_create is complete?

Alokk: Do we really need to check for alien caches not present there?


