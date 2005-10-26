Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVJZQpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVJZQpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVJZQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:45:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25810 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964808AbVJZQpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:45:41 -0400
Date: Wed, 26 Oct 2005 09:44:58 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Peter Zijlstra <peter@programming.kicks-ass.net>
cc: akpm@osdl.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Swap Migration V4: LRU operations
In-Reply-To: <1130319083.17653.37.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0510260943330.12433@schroedinger.engr.sgi.com>
References: <20051025193023.6828.89649.sendpatchset@schroedinger.engr.sgi.com>
  <20051025193028.6828.27929.sendpatchset@schroedinger.engr.sgi.com>
 <1130319083.17653.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Peter Zijlstra wrote:

> On Tue, 2005-10-25 at 12:30 -0700, Christoph Lameter wrote:
> 
> > +		if (rc == -1) {  /* Not possible to isolate */
> > +			list_del(&page->lru);
> > +			list_add(&page->lru, src);
> >  		}
> 
> Would the usage of list_move() not be simpler?

Hmmm. yes the whole section is a bit weird there (sorry Magnus). How 
about this additional patch:

Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-10-25 08:09:52.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-10-26 09:42:34.000000000 -0700
@@ -590,22 +590,22 @@ static int isolate_lru_pages(struct zone
 {
 	struct page *page;
 	int scanned = 0;
-	int rc;
 
 	while (scanned++ < nr_to_scan && !list_empty(src)) {
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		rc = __isolate_lru_page(zone, page);
-
-		BUG_ON(rc == 0); /* PageLRU(page) must be true */
-
-		if (rc == 1)     /* Succeeded to isolate page */
+		switch (__isolate_lru_page(zone, page)) {
+		case 1:
+			/* Succeeded to isolate page */
 			list_add(&page->lru, dst);
-
-		if (rc == -1) {  /* Not possible to isolate */
-			list_del(&page->lru);
-			list_add(&page->lru, src);
+			break;
+		case -1:
+			/* Not possible to isolate */
+			list_move(&page->lru, src);
+			break;
+		default:
+			BUG();
 		}
 	}
 
