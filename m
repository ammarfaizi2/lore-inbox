Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCXUup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUCXUup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:50:45 -0500
Received: from hera.kernel.org ([63.209.29.2]:10130 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261326AbUCXUun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:50:43 -0500
Date: Wed, 24 Mar 2004 18:51:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: matthias.andree@gmx.de, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 SMP - BUG at page_alloc.c:105
Message-ID: <20040324215112.GA6931@logos.cnet>
References: <20040324205811.GB6572@logos.cnet> <20040324122806.4015d3d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324122806.4015d3d6.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 24, 2004 at 12:28:06PM -0800, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > 
> > The backtrace is odd to me. 
> > 
> > set_page_dirty() does not call __free_pages_ok() directly or indirectly.
> > 
> 
> I'd suspect that's just gunk on the stack and that zap_pte_range() freed an
> anonymous page which had a non-null ->mapping.  It could be a hardware bug.
> Without seeing the actual value of page->mapping it's hard to know.
> 
> It would be good to backport the bad_page() debug code so we get a bit more
> info when this sort of thing happens.

This should work. Matthias, please apply and try to reproduce.

--- mm/page_alloc.c.orig	2004-03-24 18:42:53.693251224 -0300
+++ mm/page_alloc.c	2004-03-24 18:47:52.484828000 -0300
@@ -81,6 +81,20 @@
  * -- wli
  */
 
+static void bad_page(const char *function, struct page *page)
+{
+        printk("Bad page state at %s\n", function);
+        printk("flags:0x%08lx mapping:%p buffers:%p count:%d\n",
+                page->flags, page->mapping,
+		page->buffers, page_count(page));
+        printk("Backtrace:\n");
+        dump_stack();
+	printk("bad_page: Trying to fix it up.\n");
+        set_page_count(page, 0);
+        page->mapping = NULL;
+}
+
+
 static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
@@ -101,8 +115,8 @@
 
 	if (page->buffers)
 		BUG();
-	if (page->mapping)
-		BUG();
+	if (page->mapping) 
+		bad_page(page);
 	if (!VALID_PAGE(page))
 		BUG();
 	if (PageLocked(page))
