Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUCPGIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 01:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCPGIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 01:08:16 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:5808 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262900AbUCPGIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 01:08:11 -0500
Message-ID: <405699C1.7010906@cyberone.com.au>
Date: Tue, 16 Mar 2004 17:08:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] RSS limit enforcement for 2.6
References: <Pine.LNX.4.44.0403151816350.12895-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0403151816350.12895-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:

>Hi,
>
>Hugh Dickins found a bug in the 2.4-rmap RSS limit enforcing
>code that may well explain why the previous port of the code
>to 2.6 resulted in bad performance.  The split active lists
>in 2.4-rmap probably masked the largest damages, but in 2.6
>it was very much visible.
>
>

Hi Rik,
What was the problem by the way?

>The patch below should work.  Pavel, Nick, still interested
>in testing the performance ? ;)
>

I could do that.

>@@ -593,6 +594,7 @@
> 	long mapped_ratio;
> 	long distress;
> 	long swap_tendency;
>+	int over_rsslimit;
> 
> 	lru_add_drain();
> 	pgmoved = 0;
>@@ -657,7 +659,7 @@
> 				continue;
> 			}
> 			pte_chain_lock(page);
>-			if (page_referenced(page)) {
>+			if (page_referenced(page, &over_rsslimit) && !over_rsslimit) {
> 				pte_chain_unlock(page);
> 				list_add(&page->lru, &l_active);
> 				continue;
>

This still has a problem that !reclaim_mapped scans will not
shrink a runaway process before putting a lot of pressure on
the rest of the pagecache.

You could do a page_gather_pte_info type thing that doesn't
actually clear all the referenced bits (would probably
SetPageReferenced). Unfortunately this has the downside that
you also need to walk the pte chains for all mapped pages even
in the !reclaim_mapped case.

But it is a good start. We advertise the functionality, so we
should be trying to do something with rss limits.

