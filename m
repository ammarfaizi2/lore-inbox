Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWFRKLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWFRKLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWFRKLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:11:45 -0400
Received: from ns1.suse.de ([195.135.220.2]:40681 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750894AbWFRKLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:11:45 -0400
Date: Sun, 18 Jun 2006 12:11:43 +0200
From: Nick Piggin <npiggin@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>, Jens Axboe <axboe@suse.de>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [patch] rfc: fix splice mapping race?
Message-ID: <20060618101143.GE14452@wotan.suse.de>
References: <20060618094157.GD14452@wotan.suse.de> <1150624965.28517.55.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150624965.28517.55.camel@lappy>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 12:02:45PM +0200, Peter Zijlstra wrote:
> > In page migration, detect the missing mapping early and bail out if
> > that is the case: the page is not going to get un-truncated, so
> > retrying is just a waste of time.
> > 
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Looks sane, except the change in migrate (comment there). I like the
> remove_mapping() pre-conditions.

Thanks.

> > --- linux-2.6.orig/mm/migrate.c
> > +++ linux-2.6/mm/migrate.c
> > @@ -136,9 +136,13 @@ static int swap_page(struct page *page)
> >  {
> >  	struct address_space *mapping = page_mapping(page);
> >  
> > -	if (page_mapped(page) && mapping)
> > +	if (!mapping)
> > +		return -EINVAL; /* page truncated. signal permanent failure */
> 
> Here, I think you need to unlock the page too.

Bah, yes thanks... I'll post an updated patch after others have
had time to comment.

Nick
