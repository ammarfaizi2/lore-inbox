Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757068AbWKWRMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbWKWRMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757435AbWKWRMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:12:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757068AbWKWRMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:12:33 -0500
Date: Thu, 23 Nov 2006 09:11:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mel Gorman <mel@skynet.ie>
cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <20061123163613.GA25818@skynet.ie>
Message-ID: <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2006, Mel Gorman wrote:
>
> There are a suprising number of GFP_HIGHUSER users. I've included an
> untested patch below to give an idea of what the reworked patch would
> look like.

Thanks. Seeing the patch actually was useful, because I think this isa 
good idea quite regardless of anything else: it adds a certain amount of 
"inherent documentation" when you see a line like

	page = alloc_page(GFP_HIGHUNMOVABLE);

because it makes it very obvious that something is going on.

At the same time, I do get the feelign that maybe we should simply go the 
other way: talk about allocating MOVABLE pages instead of talking about 
allocating pages that are NOT movable.

Because usually it's really that way you think about it: when you allocate 
a _movable_ page, you need to add support for moving it some way (ie you 
need to put it on the proper page-cache lists etc), while a page that you 
don't think about is generally _not_ movable.

So: I think this is the right direction, but I would actually prefer to 
see

	page = alloc_page(GFP_[HIGH_]MOVABLE);

instead, and then just teach the routines that create movable pages 
(whether they are movable because they are in the page cache, or for some 
other reason) to use that flag instead of GFP_[HIGH]USER.

And the assumption would be that if it's MOVABLE, then it's obviously a 
USER allocation (it it can fail much more eagerly - that's really what the 
whole USER bit ends up meaning internally).

			Linus
