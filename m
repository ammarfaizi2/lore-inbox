Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbULAOlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbULAOlY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULAOlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:41:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:5862 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261265AbULAOlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:41:06 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@redhat.com
Subject: Re: [dm-devel] Re: [2.6 patch] dm: remove unused functions (fwd)
Date: Wed, 1 Dec 2004 08:41:06 -0600
User-Agent: KMail/1.7.1
Cc: Alasdair G Kergon <agk@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041129022940.GQ4390@stusta.de> <20041130230525.GC24233@agk.surrey.redhat.com>
In-Reply-To: <20041130230525.GC24233@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412010841.06954.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 5:05 pm, Alasdair G Kergon wrote:
> On Mon, Nov 29, 2004 at 03:29:40AM +0100, Adrian Bunk wrote:
> > Please apply or comment on it.
>
> Please check *why* the functions aren't used first.
>
> e.g. An alloc function with a corresponding free that
> never gets called suggests a leak to me...

That one isn't a leak (referring to "kmem_cache_t *exception_cache" in 
dm-snap.c). Items are allocated from this cache using alloc_exception(). This 
can happen either when an existing snapshot is activated and it's exception 
table is read from disk into an in-memory hash-table, or when a copy-on-write 
completes and a new exception is added to this hash-table. As long as the 
snapshot is active, this hash-table remains in memory and items cannot be 
removed from it. When the snapshot is deactivated, we call 
exit_exception_table() and pass it a pointer to this hash-table and 
exception_cache. This routine calls kmem_cache_free() directly instead of 
using the free_exception() routine. The reason it doesn't use 
free_exception() is that exit_exception_table() is used to tear down two 
different but somewhat similar hash-tables, each of which uses a different 
kmem_cache_t.

So, it may be nice to keep the symmetric routines defined (alloc_exception() 
and free_exception()), but Adrian is correct in that the later is not being 
used, and it really can't be used without some more significant code changes.

As for bs_bio_init(), it can be safely removed. It was just a duplicate of 
bio_init() from fs/bio.c. The use of that call in dm-io.c was changed to use 
bio_init(), but apparently the routine itself was never removed.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
