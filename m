Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWGMNvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWGMNvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMNvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:51:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:55702 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751458AbWGMNvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:51:16 -0400
Subject: Re: Random panics seen in 2.6.18-rc1
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@asdl.org, akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060713071221.GA31349@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu>
Content-Type: text/plain
Organization: IBM
Date: Thu, 13 Jul 2006 06:51:12 -0700
Message-Id: <1152798672.18415.2.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 09:12 +0200, Ingo Molnar wrote:
> * Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> 
> > By adding one patch at a time to 2.6.17's mm/slab.c, I found that the
> > following patch is the cause of the panic.
> > --------------
> > [PATCH] lockdep: annotate SLAB code
> 
> great debugging!

Thanks. 
> 
> I have reviewed that patch, and there's only one chunk that could 
> possibly have a functional effect. The patch below undoes it - does that 
> fix the crashes you are seeing? [If you have lockdep enabled then this 
> patch will cause a lockdep false positive - ignore that one for now, it 
> shouldnt impact the crash scenario itself.]
> 

started the tests with this patch now. will report back in couple of
hours... earlier if it crashes again :), which i doubt.

Thanks & regards,

chandra
> 	Ingo
> 
> --------------------->
> Subject: revert slab.c locking change
> From: Ingo Molnar <mingo@elte.hu>
> 
> Chandra Seetharaman reported SLAB crashes caused by the slab.c
> lock annotation patch. There is only one chunk of that patch
> that has a material effect on the slab logic - this patch
> undoes that chunk.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  mm/slab.c |    9 ---------
>  1 file changed, 9 deletions(-)
> 
> Index: linux/mm/slab.c
> ===================================================================
> --- linux.orig/mm/slab.c
> +++ linux/mm/slab.c
> @@ -3100,16 +3100,7 @@ static void free_block(struct kmem_cache
>  		if (slabp->inuse == 0) {
>  			if (l3->free_objects > l3->free_limit) {
>  				l3->free_objects -= cachep->num;
> -				/*
> -				 * It is safe to drop the lock. The slab is
> -				 * no longer linked to the cache. cachep
> -				 * cannot disappear - we are using it and
> -				 * all destruction of caches must be
> -				 * serialized properly by the user.
> -				 */
> -				spin_unlock(&l3->list_lock);
>  				slab_destroy(cachep, slabp);
> -				spin_lock(&l3->list_lock);
>  			} else {
>  				list_add(&slabp->list, &l3->slabs_free);
>  			}
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


