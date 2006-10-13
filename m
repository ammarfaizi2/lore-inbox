Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWJMVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWJMVbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJMVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:31:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932083AbWJMVbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:31:11 -0400
Date: Fri, 13 Oct 2006 14:31:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: corbet@lwn.net (Jonathan Corbet)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] Add __GFP_ZERO to GFP_LEVEL_MASK
Message-Id: <20061013143107.1e8fcb00.akpm@osdl.org>
In-Reply-To: <30805.1160773222@lwn.net>
References: <20061013134635.a983e4d7.akpm@osdl.org>
	<30805.1160773222@lwn.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 15:00:22 -0600
corbet@lwn.net (Jonathan Corbet) wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > It would be a bit odd to pass __GFP_ZERO into the slab allocator.  Slab
> > doesn't need that hint: it has its own ways of initialising the memory.
> > 
> > What is the callsite?
> 
> It's vmalloc_user(), which does this:
> 
>   ret = __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
> 

oic, yes, that was a recent change.

I guess this will do the trick?


diff -puN mm/vmalloc.c~vmalloc-dont-pass-__gfp_zero-to-slab mm/vmalloc.c
--- a/mm/vmalloc.c~vmalloc-dont-pass-__gfp_zero-to-slab
+++ a/mm/vmalloc.c
@@ -428,8 +428,11 @@ void *__vmalloc_area_node(struct vm_stru
 	if (array_size > PAGE_SIZE) {
 		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
 		area->flags |= VM_VPAGES;
-	} else
-		pages = kmalloc_node(array_size, (gfp_mask & ~__GFP_HIGHMEM), node);
+	} else {
+		pages = kmalloc_node(array_size,
+				(gfp_mask & ~(__GFP_HIGHMEM | __GFP_ZERO)),
+				node);
+	}
 	area->pages = pages;
 	if (!area->pages) {
 		remove_vm_area(area->addr);
_



(hmm, __vmalloc_area_node and __vmalloc_node are mutually recursive. ick.)
