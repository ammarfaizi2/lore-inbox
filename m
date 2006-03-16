Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWCPS51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWCPS51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWCPS51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:57:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17829 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964836AbWCPS50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:57:26 -0500
Date: Thu, 16 Mar 2006 10:57:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh. TestSetPackLocked works just opposite of spin_trylock. So add an !


Seems that we can call try_to_release_page with PagePrivate off and a 
valid mapping? This may cause all sorts of trouble for the 
filesystem *_releasepage() handlers. XFS bombs out in that case.
 
Lock the page before checking for page private.
 
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6/mm/swap.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/swap.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/mm/swap.c	2006-03-16 10:15:23.000000000 -0800
@@ -392,8 +392,9 @@ void pagevec_strip(struct pagevec *pvec)
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
-		if (PagePrivate(page) && !TestSetPageLocked(page)) {
-			try_to_release_page(page, 0);
+		if (!TestSetPageLocked(page)) {
+			if (PagePrivate(page))
+				try_to_release_page(page, 0);
 			unlock_page(page);
 		}
 	}
