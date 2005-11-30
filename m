Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVK3QmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVK3QmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVK3QmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:42:14 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:58306 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751446AbVK3QmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:42:14 -0500
Date: Wed, 30 Nov 2005 08:41:35 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Cliff Wickman <cpw@sgi.com>
Subject: Re: [Lhms-devel] [PATCH 4/7] Direct Migration V5: migrate_pages()
 extension
In-Reply-To: <438D6427.8060003@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0511300834010.19142@schroedinger.engr.sgi.com>
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
 <20051128204304.10037.81195.sendpatchset@schroedinger.engr.sgi.com>
 <438D6427.8060003@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005, KAMEZAWA Hiroyuki wrote:

> I found a problem around the shmem,

The current page migration functions in mempolicy.c do not migrate shmem 
vmas to be safe. In the future we surely would like to support migration 
of shmem. I'd be glad if you could make sure that this works.

> Problem is:
> 1. a page of shmem(tmpfs)'s generic file is in page-cache. assume page is
> diry.
> 2. When it passed to migrate_page(), it reaches pageout() in the middle of
> migrate_page().
> 3. pageout calls shmem_writepage(), and the page turns to be swap-cache page.
>    At this point, page->mapping becomes NULL (see move_to_swapcache())

A swapcache page would have page->mapping pointing to swapper space. 
move_to_swap_cache does not set page->mapping == NULL.

> 7. Because spwapper_space's  a_ops->migratepage is not NULL,
>    "Avoid write back hook" in patch 7/7 is used.
> +		if (mapping->a_ops->migratepage) {
> +			rc = mapping->a_ops->migratepage(newpage, page);
> +			goto unlock_both;
> +                }
>    a_ops->migrate_page points to migrate_page() in mm/vmscan.c
> 8. migrate_page() try to replace radix tree entry in swapper_space.
> 9. Becasue page->mapping is NULL(becasue of 3),
> migrate_page_remove_references() fails.

If page->mapping would be NULL then migrate_page() could not 
have been called. The mapping is used to obtain the address of the 
function to call,
