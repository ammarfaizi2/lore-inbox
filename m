Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVBHOOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVBHOOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVBHOOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:14:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261533AbVBHOOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:14:52 -0500
Date: Tue, 8 Feb 2005 09:14:35 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1107431261.15236.29.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502080910370.31986-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Fruhwirth Clemens wrote:

> First attempt:
> 
> static inline int scatterwalk_needscratch(struct scatter_walk *walk, int
> nbytes) {
>        return ((nbytes) <= (walk)->len_this_page &&
>                (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) +
> (nbytes) <= PAGE_CACHE_SIZE);
> }
> 
> While trying to improve this unreadable monster I noticed, that 
> (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) is always equal
> to walk->offset. walk->data and walk->offset always grows together (see
> scatterwalk_copychunks), and when the bitwise AND-ing of walk->data with
> PAGE_CACHE_SIZE-1 would result walk->offset to be zero, in just that
> moment, walk->offset is set zero (see scatterwalk_pagedone). So, better:
> 
> static inline int scatterwalk_needscratch(struct scatter_walk *walk, int
> nbytes) 
> {
> 	return (nbytes <= walk->len_this_page &&
> 		(nbytes + walk->offset) <= PAGE_CACHE_SIZE);
> }
> 

This appears to be correct.  Adam (cc'd) did some work on this code, and
may have some further observations.

> Looks nicer, right? But in fact, it's redundant. walk->offset is never
> intended to grow bigger than PAGE_CACHE_SIZE, and further it's illegal
> to hand cryptoapi a scatterlist, where sg->offset is greater than
> PAGE_CACHE_SIZE (I presume this from the calculations in
> scatterwalk_start). Are these two conclusions correct, James? 

Yes, passing in an offset beyond the page size is wrong.

Also, I don't know why PAGE_CACHE_SIZE is being used here instead of
PAGE_SIZE.  Even though they're always the same now, I would suggest
changing all occurrences to PAGE_SIZE.


- James
-- 
James Morris
<jmorris@redhat.com>



