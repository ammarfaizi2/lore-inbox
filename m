Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWG1ROd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWG1ROd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWG1ROd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:14:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161098AbWG1ROb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:14:31 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Arjan van de Ven <arjan@infradead.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, alokk@calsoftinc.com,
       tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060728171155.GA3739@localhost.localdomain>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <Pine.LNX.4.64.0607280744530.18198@schroedinger.engr.sgi.com>
	 <20060728171155.GA3739@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 28 Jul 2006 19:14:19 +0200
Message-Id: <1154106859.6416.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> cache_free_alien could get called, but there is no recursion here:
> 
> 1. reap_alien tries dropping remote objects freed by local node (A) to the 
> remote node (B) shared array cache (choosing a remote node as indicated by the 
> node rotor), to do this, it takes the local alien cache lock (A), and calls 
> __drain_alien_cache. The remote object comes from a slab cache X say.
> 
> 2. __drain_alien_cache. takes the remote node l3 lock (B), transfers as many
> objects as shared array cache of the remote node can hold, and calls
> free_block to free remaining objects that could not be dropped in into the
> shared array cache of remote node (B).  Now free_block is being called from
> (A) to free objects on (B). 
> 
> 3. free_block calls slab_destroy for the slab belonging to B. calls
> kmem_cache_free for the slab management, which calls __cache_free, and 
> hence cache_free_alien().  Now since this is being called from A for a local
> object of B, the check in cache_free_alien fails, and cache_free_alien
> *does* get executed.  Since slab management of a slab from B, local to B is
> freed from A, A tries to write to the local alien cache corresponding to B,
> which comes from a slab cache Y.  There is a recursion if X and Y are the
> same caches.   But that is not a possibility at all, as the off slab management
> for a slab cache cannot come from the same slab cache.  So this looks like a
> false positive from lockdep.  
actually lockdep doesn't see normal slabs and the slabs where off-slab
management comes from as the same lock, so it really shouldn't complain
about this specific case.


