Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUFHVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUFHVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbUFHVIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:08:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:45718 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265317AbUFHVIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:08:34 -0400
Date: Tue, 8 Jun 2004 14:11:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: arjanv@redhat.com, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop page_state stack waste
Message-Id: <20040608141106.3c7c3c10.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0406082144070.9094-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0406082144070.9094-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Replace get_page_state (which memset most of full page_state to 0) by
> get_main_page_state, which just sets the small structure needed.  This
> helps 4k stacks not to overflow: cuts 224 bytes off try_to_free_pages
> and wakeup_bdflush (and sync_inodes_sb) stack usages: wakeup_bdflush
> doesn't do much, but is called by try_to_free_pages and mempool_alloc.

Yeah, I was looking at that.  I simply did:



The ____cacheline_aligned in there is a leftover from before the existence of
the percpu infrastructure.  It bloats struct page_state and structures which
contain it enormously, and we use these things on the stack deep in page
reclaim.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/page-flags.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/page-flags.h~unalign-page_state include/linux/page-flags.h
--- 25/include/linux/page-flags.h~unalign-page_state	2004-06-08 03:08:02.766976760 -0700
+++ 25-akpm/include/linux/page-flags.h	2004-06-08 03:08:02.769976304 -0700
@@ -133,7 +133,7 @@ struct page_state {
 	unsigned long allocstall;	/* direct reclaim calls */
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
-} ____cacheline_aligned;
+};
 
 DECLARE_PER_CPU(struct page_state, page_states);
 
_

