Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWEaPJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWEaPJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWEaPJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:09:15 -0400
Received: from gold.veritas.com ([143.127.12.110]:51869 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965048AbWEaPJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:09:15 -0400
X-IronPort-AV: i="4.05,193,1146466800"; 
   d="scan'208"; a="60055972:sNHT32738844"
Date: Wed, 31 May 2006 16:09:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447D9D9C.1030602@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605311602020.26969@blonde.wat.veritas.com>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org>
 <20060530090549.GF4199@suse.de> <447D9D9C.1030602@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 May 2006 15:09:14.0733 (UTC) FILETIME=[2E0761D0:01C684C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, Nick Piggin wrote:
> Jens Axboe wrote:
> > 
> > Maybe I'm being dense, but I don't see a problem there. You _should_
> > call the new mapping sync page if it has been migrated.
> 
> But can some other thread calling lock_page first find the old mapping,
> and then run its ->sync_page which finds the new mapping? While it may
> not matter for anyone in-tree, it does break the API so it would be
> better to either fix it or rip it out than be silently buggy.

Splicing a page from one mapping to another is rather worrying/exciting,
but it does look safely done to me.  remove_mapping checks page_count
while page lock and old mapping->tree_lock are held, and gives up if
anyone else has an interest in the page.  And we already know it's
unsafe to lock_page without holding a reference to the page, don't we?

Hugh
