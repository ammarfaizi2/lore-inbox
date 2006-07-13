Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWGMH2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWGMH2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWGMH2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:28:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750999AbWGMH2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:28:18 -0400
Date: Thu, 13 Jul 2006 00:28:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: sekharan@us.ibm.com, torvalds@asdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: Random panics seen in 2.6.18-rc1
Message-Id: <20060713002803.cd206d91.akpm@osdl.org>
In-Reply-To: <20060713071221.GA31349@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 09:12:21 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> Chandra Seetharaman reported SLAB crashes caused by the slab.c
> lock annotation patch. There is only one chunk of that patch
> that has a material effect on the slab logic - this patch
> undoes that chunk.
> 

yup.

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

But what was that change _for_?  Presumably, to plug some lockdep problem. 
Which now will come back.

And the additional arg to __cache_free() was rather a step backwards - this
is fastpath.  With a bit more effort that could have been avoided (please).
