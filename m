Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVCQXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVCQXZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVCQXZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:25:17 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:61320 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261360AbVCQXZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:25:07 -0500
Date: Thu, 17 Mar 2005 15:24:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050317151151.47fd6e5f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503171518030.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
 <20050317151151.47fd6e5f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Andrew Morton wrote:

> OK, so we're splitting each zone's buddy structure into two: one for zeroed
> pages and one for not-zeroed pages, yes?

Right.

> It's not obvious what the page->private of freed pages are being used for.
> Please comment that.

Ok.

> What's all this (zero << 10) stuff?
>
> +	page->private = order + (zero << 10);
> +           (page_zorder(page) == order + (zero << 10)) &&
>
> Doesn't this explode if we already have order-1024 pages in there?  I guess
> that's a reasonable restriction, but where did the "10" come from?
> Non-obvious, needs commenting.

Yes it will fail if we have pages of the size of 2^1036.

> And given that we have separate buddy structures for zeroed and not-zeroed
> pages, why is this tagging needed at all?

Because the buddy pointers may point to a page of the different kind. Then
a merge is not possible.

> These are all design decisions which have been made, but they're not
> communicated either in the patch description or in code comments.  It's to
> everyone's advantage to fix that, no?

Of course. Try to do this ASAP. Testing a patch that defines the
following:

Index: linux-2.6.11/include/linux/gfp.h
===================================================================
--- linux-2.6.11.orig/include/linux/gfp.h       2005-03-01
23:37:50.000000000 -0800
+++ linux-2.6.11/include/linux/gfp.h    2005-03-17 14:59:06.000000000
-0800
@@ -125,6 +125,8 @@ extern void FASTCALL(__free_pages(struct
 extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
 extern void FASTCALL(free_hot_page(struct page *page));
 extern void FASTCALL(free_cold_page(struct page *page));
+extern void FASTCALL(free_hot_zeroed_page(struct page *page));
+extern void FASTCALL(free_cold_zeroed_page(struct page *page));

 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr),0)

This is what you want right?

