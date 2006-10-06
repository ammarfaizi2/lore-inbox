Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422994AbWJFWQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbWJFWQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWJFWQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:16:48 -0400
Received: from mx2.netapp.com ([216.240.18.37]:16936 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1422994AbWJFWQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:16:47 -0400
X-IronPort-AV: i="4.09,273,1157353200"; 
   d="scan'208"; a="415723073:sNHT16908944"
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Steve Dickson <SteveD@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4526CF6F.9040006@RedHat.com>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	 <4526CF6F.9040006@RedHat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Fri, 06 Oct 2006 18:16:30 -0400
Message-Id: <1160172990.12253.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 06 Oct 2006 22:16:45.0878 (UTC) FILETIME=[1C2D7D60:01C6E995]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 17:49 -0400, Steve Dickson wrote:
> Trond Myklebust wrote:
> > If try_to_release_page() is called with a zero gfp mask, then the
> > filesystem is effectively denied the possibility of sleeping while
> > attempting to release the page. There doesn't appear to be any valid
> > reason why this should be banned, given that we're not calling this from
> > a memory allocation context.
> >  
> > For this reason, change the gfp_mask argument of the call to GFP_KERNEL.
> >     
> > Note: I am less sure of what the callers of invalidate_complete_page()
> > require, and so this patch does not touch that mask.
> > 
> > Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> > ---
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index f4edbc1..49c1ffd 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -302,7 +302,7 @@ invalidate_complete_page2(struct address
> >  	if (page->mapping != mapping)
> >  		return 0;
> >  
> > -	if (PagePrivate(page) && !try_to_release_page(page, 0))
> > +	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
> >  		return 0;
> >  
> >  	write_lock_irq(&mapping->tree_lock);
> Well I was using mapping_gfp_mask(mapping) as the argument to
> try_to_release_page() which also worked... but isn't this
> just plugging one of many holes?

Yeah using mapping_gfp_mask(mapping) sounds like a better option.

...and yes, there are other callers that need to be audited. I'm
particularly curious about the effect of the call in
block_invalidatepage() on XFS, which has a similar test to ours.

The call in fallback_migrate_page() should probably be using
mapping_gfp_mask() too.

> Meaning try_to_release_page is called
> from a number of places with a zero gfp_mask so shouldn't those
> also be fixed as well OR removed the gfp_mask as an argument as the
> comment at the top of try_to_release_page() alludes to?

Nope. In order to make it work correctly with NFS and XFS, all calls to
try_to_release_page() would have to be allowed to be blocking. The
problem is that shrink_page_list() still wants to call
try_to_release_page() from a memory allocation context.

Cheers,
  Trond
