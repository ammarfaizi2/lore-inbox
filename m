Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVAEX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVAEX2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVAEX2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:28:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:61572 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262663AbVAEX0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:26:46 -0500
Date: Wed, 5 Jan 2005 15:26:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105152625.0b479838.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> OOM kills have been observed with 70% of the pages in lowmem being
>  in the writeback state.  If we count those pages in sc->nr_scanned,
>  the VM should throttle and wait for IO completion, instead of OOM
>  killing.

I'll queue this up:



From: Rik van Riel <riel@redhat.com>

OOM kills have been observed with 70% of the pages in lowmem being in the
writeback state.  If we count those pages in sc->nr_scanned, the VM should
throttle and wait for IO completion, instead of OOM killing.

(akpm: this is how the code was designed to work - we broke it six months
ago).

Signed-off-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/vmscan.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~vmscan-count-writeback-pages-in-nr_scanned mm/vmscan.c
--- 25/mm/vmscan.c~vmscan-count-writeback-pages-in-nr_scanned	2005-01-05 15:24:53.730874336 -0800
+++ 25-akpm/mm/vmscan.c	2005-01-05 15:25:48.286580608 -0800
@@ -369,14 +369,14 @@ static int shrink_list(struct list_head 
 
 		BUG_ON(PageActive(page));
 
-		if (PageWriteback(page))
-			goto keep_locked;
-
 		sc->nr_scanned++;
 		/* Double the slab pressure for mapped and swapcache pages */
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
 
+		if (PageWriteback(page))
+			goto keep_locked;
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
_

