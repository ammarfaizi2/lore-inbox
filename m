Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274739AbRIZAHW>; Tue, 25 Sep 2001 20:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274742AbRIZAHN>; Tue, 25 Sep 2001 20:07:13 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:21491 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274739AbRIZAHC>; Tue, 25 Sep 2001 20:07:02 -0400
Date: Tue, 25 Sep 2001 20:07:28 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>, torvalds@transmeta.com
Cc: Rik van Riel <riel@conectiva.com.br>,
        Olivier Sessink <olivier@lx.student.wau.nl>,
        linux-kernel@vger.kernel.org
Subject: [patch] Re: weird memory related problems, negative memory usage or fake memory usage?
Message-ID: <20010925200728.A30860@redhat.com>
In-Reply-To: <20010926003626.L8350@athlon.random> <Pine.LNX.4.33L.0109251952330.26091-100000@duckman.distro.conectiva> <20010926011116.X8350@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010926011116.X8350@athlon.random>; from andrea@suse.de on Wed, Sep 26, 2001 at 01:11:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 01:11:16AM +0200, Andrea Arcangeli wrote:
> possibly yes but maybe not, dunno right now or I would be just sending
> the fix inline in this email :).  As said I never seen it before Ben's
> tlb shootdown was merged into mainline, but again I repeat it can
> _really_ be just an unlucky coincidence. But I guess because of this
> coincidence the tlb shootdown will be the first things I will audit
> tomorrow.

This should fix it.

		-ben

... v2.4.10-rss.diff ...
diff -urN v2.4.10/mm/memory.c foo/mm/memory.c
--- v2.4.10/mm/memory.c	Mon Sep 24 02:16:05 2001
+++ foo/mm/memory.c	Tue Sep 25 20:03:04 2001
@@ -319,7 +319,9 @@
 		if (pte_none(pte))
 			continue;
 		if (pte_present(pte)) {
-			freed ++;
+			struct page *page = pte_page(pte);
+			if (!PageReserved(page) && VALID_PAGE(page))
+				freed ++;
 			/* This will eventually call __free_pte on the pte. */
 			tlb_remove_page(tlb, ptep, address + offset);
 		} else {
