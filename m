Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWBBUpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWBBUpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBBUpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:45:40 -0500
Received: from gold.veritas.com ([143.127.12.110]:11320 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932225AbWBBUpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:45:39 -0500
Date: Thu, 2 Feb 2006 20:46:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-rc-mm4 reiser4 calls try_to_unmap() with 1 arg
 -- now takes 2
In-Reply-To: <1138911375.5204.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602022040020.10639@goblin.wat.veritas.com>
References: <1138911375.5204.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Feb 2006 20:45:35.0919 (UTC) FILETIME=[9E357BF0:01C62839]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Lee Schermerhorn wrote:

> Apparent race between reiser4 and direct migration patches in 16-rc1-
> mm4.
> Direct migration added arg to rmap.c:try_to_unmap()--int ignore_refs--
> and
> fixed up existing refs.  reiser4 adds new call with single arg. 
> 
> One doesn't see this when building mm4 w/ reiser4 because the ref under
> an
> "#if REISER4_COPY_ON_CAPTURE" that is apparently not enabled.  I  just
> noticed
> it while looking at direct migration patches.  So, this patch is
> essentially
> UNTESTED.  Supplied simply to illustrate the location of the single arg

That's worrying code to find down in a filesystem.  But never mind,
it refers to pte_chain_lock(), which hasn't existed since 2.6.5.  So
REISER4_COPY_ON_CAPTURE is long untested and should just be deleted.

Hugh

> 
> Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
> 
> Index: linux-2.6.16-rc1-mm4/fs/reiser4/txnmgr.c
> ===================================================================
> --- linux-2.6.16-rc1-mm4.orig/fs/reiser4/txnmgr.c	2006-01-31
> 16:51:39.000000000 -0500
> +++ linux-2.6.16-rc1-mm4/fs/reiser4/txnmgr.c	2006-02-02
> 14:43:01.659744418 -0500
> @@ -3693,7 +3693,7 @@ static int create_copy_and_replace(jnode
>  		pte_chain_lock(page);
>  
>  		if (page_mapped(page)) {
> -			result = try_to_unmap(page);
> +			result = try_to_unmap(page, 0);
>  			if (result == SWAP_AGAIN) {
>  				result = RETERR(-E_REPEAT);
