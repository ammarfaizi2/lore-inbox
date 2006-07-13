Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWGMTVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWGMTVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWGMTVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:21:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21982 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030296AbWGMTVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:21:23 -0400
Subject: Re: [patch] lockdep: annotate mm/slab.c
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com
In-Reply-To: <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org>
	 <20060713072635.GA907@elte.hu>  <20060713004445.cf7d1d96.akpm@osdl.org>
	 <20060713124603.GB18936@elte.hu>
	 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
	 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 21:21:12 +0200
Message-Id: <1152818472.3024.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 11:56 -0700, Linus Torvalds wrote:
> 
> On Thu, 13 Jul 2006, Pekka Enberg wrote:
> > 
> > What's "nested lock" btw? If I understood from the other patch, you're
> > talking about ac->lock. Surely you can't take the same lock twice but
> > it's perfectly legal to take lock as long as the ac instance is
> > different...
> 
> Normally, no. You can't take another lock just because the instance is 
> different. That causes ABBA deadlocks unless you have some underlying 
> _ordering_ of the different lock instances.

and that is the case here fwiw;
the OFF_SLAB metadata thing is tricky when freeing stuff:

for kfree() you take the lock for your own slab, do some management and
then do effectively do a kfree() on your off-slab metadata. Which then
takes the lock for the kmalloc slab of the size of your metadata.
This is a natural order, you assume (and pray) that this kmalloc slab is
not in itself a slab with off-slab metadata, so that there can't be a BA
of the ABBA deadlock. [*]

This is what needed the lockdep annotation; lockdep by default thinks
all slabs are equal (by virtue of sharing the spin_lock_init()
location). And because of the slab-internal knowledge of off-slab versus
not-off-slab they're not equal.

Now there are two choices for annotation: tell the spin lock aquisition
that there is a natural hierarchy (eg spin_lock_depends) and this is
what Ingo tried at first. Except that it got horribly complex, messy and
just outright gross.

The second option is telling lockdep that kmalloc slabs without off-slab
metadata are really different in terms of locking rules (eg they have a
separate identity than the other slabs); and that is why my patch does
(or at least tries to; it works for my machines but the slab
initialization code is horribly complex wrt hotplug and numa so I may
have missed a corner case initialization). 

The downside of this 'separate identity' is that you basically split the
lock history, meaning that the graph of past history is not built up as
fast as it could have been. Slab is used so much that that isn't a big
deal; for other more exotic cases that's more of a quality issue.

Greetings,
   Arjan van de Ven


[*] Note Note Note
there is a corner case in the slab code that I personally don't trust at
all. In the NUMA case, if the memory is not originally from your own
node, the cache_free_alien() function takes, while having your own local
lock, the lock of the remote node as well. (at least on my reading of
the code) to free the memory to that node. I have yet to see where in
the code it safeguards against that remote node doing the exact same
thing in the opposite direction concurrently, and causing a basic ABBA
deadlock.

