Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTF2VMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTF2VMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:12:39 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:45956 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264312AbTF2VMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:12:34 -0400
Date: Sun, 29 Jun 2003 22:26:51 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
In-Reply-To: <200306282306.59502.phillips@arcor.de>
Message-ID: <Pine.LNX.4.53.0306292214160.11946@skynet>
References: <200306250111.01498.phillips@arcor.de> <200306271800.53487.phillips@arcor.de>
 <Pine.LNX.4.53.0306291953490.20655@skynet> <200306282306.59502.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, Daniel Phillips wrote:

> There's no question that that's the case today.  However, there are good
> reasons for using a largish filesystem blocksize, 16K for example, once it
> becomes possible to do so.

Fair enough. I am not very familiar with filesystems or why it would be
desirable to have a blocksize greater than a page size. I'd be grateful if
you'd recommend a good book, paper or documentation set that would
enlighten me.

> > Because they are so common in comparison to other orders, I
> > think that putting order0 in slabs of size 2^MAX_ORDER will make
> > defragmentation *so* much easier, if not plain simple, because you can
> > shuffle around order0 pages in the slabs to free up one slab which frees
> > up one large 2^MAX_ORDER adjacent block of pages.
>
> But how will you shuffle those pages around?
>

Thats where your defragger would need to kick in. The defragger would scan
at most MAX_DEFRAG_SCAN slabs belonging to the order0 userspace cache
where MAX_DEFRAG_SCAN is related to how urgent the request is. Select the
slab with the least objects in them and either:

a) Reclaim the pages by swapping them out or whatever
b) Copy the pages to another slab and update the page tables via rmap

Once the pages are copied from the selected slab, destroy it and you have
a large block of free pages. The point which I am getting across, quite
badly, is that by having order0 pages in slab, you are guarenteed to be
able to quickly find a cluster of pages to move which will free up a
contiguous block of 2^MAX_ORDER pages, or at least 2^MAX_GFP_ORDER with
the current slab implementation.

For kernel pages, it would get a lot more complicated but at least the
kernel pages would be clustered together in the order0 cache for kernel
pages.

-- 
Mel Gorman
