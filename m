Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWJ2HFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWJ2HFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 02:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWJ2HFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 02:05:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965100AbWJ2HFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 02:05:23 -0500
Date: Sun, 29 Oct 2006 00:05:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
Message-Id: <20061029000513.de5af713.akpm@osdl.org>
In-Reply-To: <454442DC.9050703@google.com>
References: <454442DC.9050703@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 22:57:48 -0700
"Martin J. Bligh" <mbligh@google.com> wrote:

> -git4 was fine. -git5 is broken (on PPC64 blade)
> 
> As -rc2-mm2 seemed fine on this box, I'm guessing it's something
> that didn't go via Andrew ;-( Looks like it might be something
> JFS or slab specific. Bigger PPC64 box with different config
> was OK though.
> 
> Full log is here: http://test.kernel.org/abat/59046/debug/console.log
> Good -git4 run: http://test.kernel.org/abat/58997/debug/console.log
> 
> kernel BUG in cache_grow at mm/slab.c:2705!

This?

--- a/mm/vmalloc.c~__vmalloc_area_node-fix
+++ a/mm/vmalloc.c
@@ -428,7 +428,8 @@ void *__vmalloc_area_node(struct vm_stru
 	area->nr_pages = nr_pages;
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
-		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
+		pages = __vmalloc_node(array_size, gfp_mask & ~__GFP_HIGHMEM,
+					PAGE_KERNEL, node);
 		area->flags |= VM_VPAGES;
 	} else {
 		pages = kmalloc_node(array_size,
_

