Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVKPVJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVKPVJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVKPVJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:09:45 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:21153 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932607AbVKPVJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:09:44 -0500
Date: Wed, 16 Nov 2005 21:09:28 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Robin Holt <holt@sgi.com>
Cc: Russ Anderson <rja@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to handle a hugepage with bad physical memory?
In-Reply-To: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0511162103300.15891@skynet>
References: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Robin Holt wrote:

> Russ Anderson recently introduced a patch into ia64 that changes MCA
> behavior.  When the MCA is caused by a user reference to a users memory,
> we put an extra reference on the page and kill the user.  This leaves
> the working memory available for other jobs while causing a leak of the
> bad page.
>
> I don't know if Russ has done any testing with hugetlbfs pages.  I preface
> the remainder of my comments with a huge "I don't know anything"
> disclaimer.
>

Right now, I am not much of an improvement.

> With the new hugepages concept, would it be possible to only mark
> the default pagesize portion of a hugepage as bad and then return the
> remainder of the hugepage for normal use?

The process is dead so the mapping is not a concern. But that huge page is
gone and is no longer useful as a huge page. So, no, it cannot be used for
normal use.

What could be done is something like the following;

1. Go to the struct page that represents the start of the huge page
2. Clear all the flags and fields. Set the count to 1
3. Call __free_pages(smallpage, 0)

Do that for every struct page within the huge page except for the one that
the MCA flagged as bad. The side-effect will be that the buddy allocator
will merge them back to the largest possible blocks and place them on the
free lists. That will give you back all the small pages at least.

> What would we basically need
> to do to accomplish this?  Are there patches in the community which we
> should wait to see how they progress before we do any work on this front?
>

Not that I am aware of but that does not mean they do not exist.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
