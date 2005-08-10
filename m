Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVHJRuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVHJRuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVHJRuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:50:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22696 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965235AbVHJRub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:50:31 -0400
Subject: Re: How to reclaim inode pages on demand
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508101819340.11984@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
	 <20050808160844.04d1f7ac.akpm@osdl.org>
	 <Pine.LNX.4.58.0508101730441.11984@skynet>
	 <20050810101714.147e1333.akpm@osdl.org>
	 <Pine.LNX.4.58.0508101819340.11984@skynet>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 10:50:25 -0700
Message-Id: <1123696225.15970.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 18:27 +0100, Mel Gorman wrote:
> I later linearly scan the mem_map looking for pages that can be freed up
> (usually LRU pages). I was expecting any page with PG_inode set to have a
> page->mapping but not all of them do. It is the pages without a ->mapping
> that are confusing the hell out of me.

How about putting a check for PG_inode and a periodic dump_stack()
wherever page->mapping is cleared?  That should at least let you catch
the culprit who is clearing them. __remove_from_page_cache() is the only
real place I see this being done.

Are you remembering to clean PG_inode when a page is freed?  Perhaps
it's allocated for the page cache, reclaimed, returned to the allocator,
and reallocated as anonymous memory where you're seeing the null
->mapping.  Might want to check for PG_inode in free_pages_check().

-- Dave

