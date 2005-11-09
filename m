Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVKIQuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVKIQuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVKIQup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:50:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8393 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932097AbVKIQuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:50:44 -0500
Date: Wed, 9 Nov 2005 08:50:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andi Kleen <ak@suse.de>, Magnus Damm <magnus.damm@gmail.com>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 5/8] Direct Migration V2: upgrade MPOL_MF_MOVE and
 sys_migrate_pages()
In-Reply-To: <43717426.3050002@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0511090847270.3607@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
 <20051108210402.31330.19167.sendpatchset@schroedinger.engr.sgi.com>
 <43715266.5080900@jp.fujitsu.com> <Pine.LNX.4.62.0511081922260.582@schroedinger.engr.sgi.com>
 <43717426.3050002@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, KAMEZAWA Hiroyuki wrote:

> > We only allocate 256 pages which are on the newlist. If the newlist is empty
> > but there are still pages that could be migrated (!list_empty(pagelist))
> > then we need to allocate more pages and call migrate_pages() again.
> Ah, Okay.
> 
> confirmation:
> 1. Because mm->sem is held, there is no page-is-truncated/freed case.

The page is truncated/freed case is handled by migrate_pages(). The page 
is moved to the "moved" lists and then returned to the LRU. The functions 
putting a page back to the LRU will check the refcount and discard the 
page.

> 2. Because pages in pagelist are removed from zone's lru, kswapd and others
> will not
>    find and unmap them. There is no page-is-swapedout-by-others case.

Right.
 
> So if all target pages are successfuly remvoed from pagelist, newlist must be
> empty.
> Right ?

It could be empty but there could be new pages left over because some 
pages were freed before we could move them or we were unable to migrate a 
page and fell back to swap for a particular page. We need to free the 
leftover pages then.

