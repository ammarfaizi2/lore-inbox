Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUKGDno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUKGDno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 22:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUKGDnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 22:43:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:48025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbUKGDnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 22:43:41 -0500
Date: Sat, 6 Nov 2004 19:43:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
cc: linux-aio@kvack.org, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Oops in aio_free_ring on 2.6.9
In-Reply-To: <1099683260.12365.348.camel@bluebox>
Message-ID: <Pine.LNX.4.58.0411061938150.2223@ppc970.osdl.org>
References: <1099683260.12365.348.camel@bluebox>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Nov 2004, Darrick J. Wong wrote:
> 
> Next, the aio_setup_ring function tries to mmap a bunch of pages and
> fails, because in step 1 we used up all the address space. 
> aio_setup_ring then calls aio_free_ring to tear all of this down.
> (fs/aio.c:143)
> 
> aio_free_ring sees the block of struct page pointers and calls free_page
> (fs/aio.c:88) on the pointers without checking that they're not NULL. 
> Unfortunately, they _are_ NULL and *oops*!  My patch amends the function
> to include a null pointer check.

I don't disagree with the bug, but I disagree with the fix. 

In my opinion, the problem is that "info->nr_pages" is _wrong_. It's wrong 
because it has been initialized to a bogus value. 

I'd much prefer this alternate appended patch. Can you verify that it also 
fixes the problem (we can drop the bogus info->nr_pages initialization, 
because the context - including the info part - has been cleared when it 
was allocated, so nr_pages should already have the _correct_ value of zero 
at this point).

		Linus

-----
===== fs/aio.c 1.60 vs edited =====
--- 1.60/fs/aio.c	2004-10-20 01:12:10 -07:00
+++ edited/fs/aio.c	2004-11-06 19:41:45 -08:00
@@ -118,8 +118,6 @@
 	if (nr_pages < 0)
 		return -EINVAL;
 
-	info->nr_pages = nr_pages;
-
 	nr_events = (PAGE_SIZE * nr_pages - sizeof(struct aio_ring)) / sizeof(struct io_event);
 
 	info->nr = 0;
