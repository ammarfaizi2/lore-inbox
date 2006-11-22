Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755961AbWKVRJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbWKVRJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbWKVRJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:09:10 -0500
Received: from cantor2.suse.de ([195.135.220.15]:56716 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755961AbWKVRJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:09:09 -0500
Date: Wed, 22 Nov 2006 18:08:53 +0100
From: Andi Kleen <ak@suse.de>
To: Andre Noll <maan@systemlinux.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>, Mel Gorman <mel@skynet.ie>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061122170852.GA4982@bingen.suse.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de> <20061122160549.GD27761@skl-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122160549.GD27761@skl-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 05:05:49PM +0100, Andre Noll wrote:
> Unfortunately, yes. I tried rc6, current git, and currrent git + David
> Rientjes' patch. They all show the same behaviour.

I must have missed that patch.
> 
> > It's probably another bug in the memmap parsing rewrite (Mel cc'ed) 
> > but the debugging information in the standard kernel unfortunately
> > doesn't give enough output to find out where it happens.
> 
> Feel free to send me a debugging patch..

Here's one. Please send output (unless Mel finds the problem first..)

-Andi

Index: linux-2.6.19-rc6-hack/mm/page_alloc.c
===================================================================
--- linux-2.6.19-rc6-hack/mm/page_alloc.c
+++ linux-2.6.19-rc6-hack/mm/page_alloc.c
@@ -188,6 +188,10 @@ static inline int bad_range(struct zone 
 
 static void bad_page(struct page *page)
 {
+	static int warned; 
+	if (!warned) { 
+	warned = 1;
+	printk(KERN_EMERG "page address %lx\n", page_address(page));
 	printk(KERN_EMERG "Bad page state in process '%s'\n"
 		KERN_EMERG "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
 		KERN_EMERG "Trying to fix it up, but a reboot is needed\n"
@@ -196,6 +200,7 @@ static void bad_page(struct page *page)
 		(unsigned long)page->flags, page->mapping,
 		page_mapcount(page), page_count(page));
 	dump_stack();
+	}
 	page->flags &= ~(1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|

