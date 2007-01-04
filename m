Return-Path: <linux-kernel-owner+w=401wt.eu-S932117AbXADS5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXADS5m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbXADS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:57:41 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:17919 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXADS5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:57:40 -0500
X-AuditID: d80ac21c-9d537bb00000021a-51-459d4e23825f 
Date: Thu, 4 Jan 2007 18:57:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
In-Reply-To: <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701041840360.23501@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
 <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 18:57:39.0277 (UTC) FILETIME=[34A057D0:01C73032]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Pekka Enberg wrote:

> Hi Hugh,
> 
> [Sorry, no access to kernel tree right now, so can't send a patch.]
> 
> On 1/4/07, Hugh Dickins <hugh@veritas.com> wrote:
> > @@ -3310,7 +3310,7 @@ retry:
> >                                         */
> >                                         goto retry;
> >                         } else {
> > -                               kmem_freepages(cache, obj);
> > +                               /* cache_grow already freed obj */
> >                                 obj = NULL;
> 
> So, how about we rename the current cache_grow() to __cache_grow() and
> move the kmem_freepages() to a higher level function like this:
> 
> static int cache_grow(struct kmem_cache *cache,
>                                gfp_t flags, int nodeid)
> {
>        void *objp;
>        int ret;
> 
>        if (flags & __GFP_NO_GROW)
>                return 0;
> 
>        objp = kmem_getpages(cachep, flags, nodeid);
>        if (!objp)
>                return 0;
> 
>        ret = __cache_grow(cache, flags, nodeid, objp);
>        if (!ret)
>                kmem_freepages(cachep, objp);
> 
>        return ret;
> }
> 
> And use the non-allocating __cache_grow version() in fallback_alloc() instead?

That does indeed look more tasteful.  But there appears to be a fair
bit more refactoring one would want to do, if aiming for good taste
there: the kmem_flagcheck, the conditional local_irq_dis/enable...
I think I'll leave that to you and Christoph to fight over later!

Hugh
