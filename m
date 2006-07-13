Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWGMHSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWGMHSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGMHSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:18:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41089 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750750AbWGMHSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:18:09 -0400
Date: Thu, 13 Jul 2006 09:12:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: torvalds@asdl.org, akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Random panics seen in 2.6.18-rc1
Message-ID: <20060713071221.GA31349@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152763195.11343.16.camel@linuxchandra>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chandra Seetharaman <sekharan@us.ibm.com> wrote:

> By adding one patch at a time to 2.6.17's mm/slab.c, I found that the
> following patch is the cause of the panic.
> --------------
> [PATCH] lockdep: annotate SLAB code

great debugging!

I have reviewed that patch, and there's only one chunk that could 
possibly have a functional effect. The patch below undoes it - does that 
fix the crashes you are seeing? [If you have lockdep enabled then this 
patch will cause a lockdep false positive - ignore that one for now, it 
shouldnt impact the crash scenario itself.]

	Ingo

--------------------->
Subject: revert slab.c locking change
From: Ingo Molnar <mingo@elte.hu>

Chandra Seetharaman reported SLAB crashes caused by the slab.c
lock annotation patch. There is only one chunk of that patch
that has a material effect on the slab logic - this patch
undoes that chunk.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 mm/slab.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -3100,16 +3100,7 @@ static void free_block(struct kmem_cache
 		if (slabp->inuse == 0) {
 			if (l3->free_objects > l3->free_limit) {
 				l3->free_objects -= cachep->num;
-				/*
-				 * It is safe to drop the lock. The slab is
-				 * no longer linked to the cache. cachep
-				 * cannot disappear - we are using it and
-				 * all destruction of caches must be
-				 * serialized properly by the user.
-				 */
-				spin_unlock(&l3->list_lock);
 				slab_destroy(cachep, slabp);
-				spin_lock(&l3->list_lock);
 			} else {
 				list_add(&slabp->list, &l3->slabs_free);
 			}
