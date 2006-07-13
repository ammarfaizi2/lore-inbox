Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWGMXRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWGMXRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWGMXRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:17:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161043AbWGMXRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:17:03 -0400
Date: Thu, 13 Jul 2006 16:16:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-Id: <20060713161620.f61d2ac0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
	<20060713002803.cd206d91.akpm@osdl.org>
	<20060713072635.GA907@elte.hu>
	<20060713004445.cf7d1d96.akpm@osdl.org>
	<20060713124603.GB18936@elte.hu>
	<84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
	<Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
	<1152818472.3024.75.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 15:51:09 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 13 Jul 2006, Arjan van de Ven wrote:
> 
> > [*] Note Note Note
> > there is a corner case in the slab code that I personally don't trust at
> > all. In the NUMA case, if the memory is not originally from your own
> > node, the cache_free_alien() function takes, while having your own local
> > lock, the lock of the remote node as well. (at least on my reading of
> > the code) to free the memory to that node. I have yet to see where in
> > the code it safeguards against that remote node doing the exact same
> > thing in the opposite direction concurrently, and causing a basic ABBA
> > deadlock.
> 
> Second look: I cannot find where we take our own local nodes list_lock.
> We only take the lock from the remote node. Or is this related to the 
> OFF_SLAB kfree issue?
> 
> 
> We either have a alien cache structure established then:
> 
> We take a lock on the alien structure for node x from our own node 
> (without holding our local list_lock!) and then we need take the remote 
> list_lock for node x if the alien structure overflows and we then free
> to the remote nodes list.
> 
> Or we do not have a alien cache structure established yet. Then:
> 
> We simply take the remote list_lock on node x and free directly to the 
> foreign nodes list.
> 
> 
> 
> In an OFF_SLAB situation this may differ because then we call 
> kmem_cache_free from slab_destroy. Ughhh... This looks extremely bad. 

uh-oh.

> Whew! We drop the list lock before calling slab_destroy.

Well we did, up until about ten minutes ago.

free_block()'s droppage of l3->list_lock around the slab_destroy() call was
just reverted, due to Shailabh confirming that it caused corruption.
