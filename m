Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVACR32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVACR32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVACR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:27:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261518AbVACR0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:26:13 -0500
Date: Mon, 3 Jan 2005 12:25:53 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still untested, but posting the concept here anyway, since this
could explain a lot...

OOM kills have been observed with 70% of the pages in lowmem being
in the writeback state.  If we count those pages in sc->nr_scanned,
the VM should throttle and wait for IO completion, instead of OOM
killing.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.9/mm/vmscan.c.screclaim	2005-01-03 12:17:56.547148905 -0500
+++ linux-2.6.9/mm/vmscan.c	2005-01-03 12:18:16.855965416 -0500
@@ -376,10 +376,10 @@

  		BUG_ON(PageActive(page));

+		sc->nr_scanned++;
  		if (PageWriteback(page))
  			goto keep_locked;

-		sc->nr_scanned++;
  		/* Double the slab pressure for mapped and swapcache pages */
  		if (page_mapped(page) || PageSwapCache(page))
  			sc->nr_scanned++;
