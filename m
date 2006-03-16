Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWCPTtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWCPTtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCPTtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:49:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31145 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932691AbWCPTtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:49:06 -0500
Date: Thu, 16 Mar 2006 11:49:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0603161147590.2704@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Hugh Dickins wrote:

> But wouldn't you, on balance, be better off repeating the
> PagePrivate test within the lock?

Good idea. That avoid uselessly taking the pagelock.



Seems that we can call try_to_release_page with PagePrivate off and a
valid mapping because we check PagePrivate before taking the page lock.
This may cause all sorts of trouble for thefilesystem *_releasepage()
handlers. XFS bombs out in that case.

Check the PagePrivate again before calling try_to_release_page.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6/mm/swap.c
===================================================================
--- linux-2.6.16-rc6.orig/mm/swap.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/mm/swap.c	2006-03-16 11:46:54.000000000 -0800
@@ -393,7 +393,8 @@ void pagevec_strip(struct pagevec *pvec)
 		struct page *page = pvec->pages[i];
 
 		if (PagePrivate(page) && !TestSetPageLocked(page)) {
-			try_to_release_page(page, 0);
+			if (PagePrivate(page))
+				try_to_release_page(page, 0);
 			unlock_page(page);
 		}
 	}
