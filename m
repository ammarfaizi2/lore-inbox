Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVCJRrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVCJRrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCJRmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:42:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:9909 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262729AbVCJRiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:38:03 -0500
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9)
	+ prezeroing (Version 4)
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503101421260.2105@skynet>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>
	 <1110239966.6446.66.camel@localhost>
	 <Pine.LNX.4.58.0503101421260.2105@skynet>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 09:37:47 -0800
Message-Id: <1110476267.16432.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 14:31 +0000, Mel Gorman wrote: 
> > > There are 2 kinds of sections: user and kernel.  The traditional
> > > ZONE_HIGHMEM is full of user sections (except for vmalloc).
> 
> And PTEs if configured to be allocated from high memory. I have not double
> checked but I don't think they can be trivially reclaimed.

We've run into a couple of these pieces of highmem that can't be
reclaimed.  The latest one are pages for the new pipe buffers.  We could
code these up with a flag something like __GFP_HIGHMEM_NORCLM, that is
__GFP_HIGHMEM in the normal case, but 0 in the hotplug case (at least
for now).

> > > Any
> > > section which has slab pages or any kernel caller to alloc_pages() is
> > > a kernel section.
> 
> Slab pages could be moved to the user section as long as the cache owner
> was able to reclaim the slabs on demand.

At least for the large consumers of slab (dentry/inode caches), they
can't quite reclaim on demand.  I was picking Dipankar's brain about
this one day, and there are going to be particularly troublesome
dentries, like "/", that are going to need some serious rethinking to be
able to forcefully free.  

-- Dave

