Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWDRSI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWDRSI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWDRSI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:08:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7568 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932245AbWDRSI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:08:26 -0400
Date: Tue, 18 Apr 2006 11:07:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       anton@samba.org, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: BUG: spinlock lockup/wrong CPU/recursion -- when reading numa_maps
 on 2.6.17-rc1
In-Reply-To: <20060417211633.5ddfa0df.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604181106590.7720@schroedinger.engr.sgi.com>
References: <20060418000042.GA7376@kevlar.burdell.org> <20060417211633.5ddfa0df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Andrew Morton wrote:

> Yes, that's a bug and that cond_resched() needs to go.



Remove cond_resched in gather_stats()

gather_stats() is called with a spinlock held from check_pte_range. We
cannot reschedule with a lock held.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm3/mm/mempolicy.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/mm/mempolicy.c	2006-04-18 10:58:33.000000000 -0700
+++ linux-2.6.17-rc1-mm3/mm/mempolicy.c	2006-04-18 10:59:56.000000000 -0700
@@ -1761,7 +1761,6 @@ static void gather_stats(struct page *pa
 		md->mapcount_max = count;
 
 	md->node[page_to_nid(page)]++;
-	cond_resched();
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
