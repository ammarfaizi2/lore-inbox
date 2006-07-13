Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWGMWvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWGMWvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWGMWvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:51:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54505 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161030AbWGMWvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:51:25 -0400
Date: Thu, 13 Jul 2006 15:51:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org, nagar@watson.ibm.com,
       balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <1152818472.3024.75.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
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

> [*] Note Note Note
> there is a corner case in the slab code that I personally don't trust at
> all. In the NUMA case, if the memory is not originally from your own
> node, the cache_free_alien() function takes, while having your own local
> lock, the lock of the remote node as well. (at least on my reading of
> the code) to free the memory to that node. I have yet to see where in
> the code it safeguards against that remote node doing the exact same
> thing in the opposite direction concurrently, and causing a basic ABBA
> deadlock.

Second look: I cannot find where we take our own local nodes list_lock.
We only take the lock from the remote node. Or is this related to the 
OFF_SLAB kfree issue?


We either have a alien cache structure established then:

We take a lock on the alien structure for node x from our own node 
(without holding our local list_lock!) and then we need take the remote 
list_lock for node x if the alien structure overflows and we then free
to the remote nodes list.

Or we do not have a alien cache structure established yet. Then:

We simply take the remote list_lock on node x and free directly to the 
foreign nodes list.



In an OFF_SLAB situation this may differ because then we call 
kmem_cache_free from slab_destroy. Ughhh... This looks extremely bad. 
Whew! We drop the list lock before calling slab_destroy.


