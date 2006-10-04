Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWJDUkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWJDUkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWJDUkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:40:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751101AbWJDUkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:40:04 -0400
Date: Wed, 4 Oct 2006 16:39:35 -0400
From: Dave Jones <davej@redhat.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andre Noll <maan@systemlinux.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       riel@redhat.com
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061004203935.GB32161@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andre Noll <maan@systemlinux.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, andrea@suse.de, riel@redhat.com
References: <20061004104018.GB22487@skl-net.de> <4523BE45.5050205@yahoo.com.au> <20061004154227.GD22487@skl-net.de> <1159976940.27331.0.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159976940.27331.0.camel@twins>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 05:49:00PM +0200, Peter Zijlstra wrote:

 > > > It is also nice if we can work out where the page actually came from. The
 > > > following attached patch should help out a bit with that, if you could
 > > > run with it?
 > > Okay. I'll reboot with your patch and let you know if it crashes again.
 > enable CONFIG_DEBUG_VM to get that.

Given this warnings still pops up from time to time, I question whether
putting that check under DEBUG_VM was such a good idea.  It's not as
if it's a major performance impact.  This has potential for us to lose
valuable debugging info for a few nanoseconds performance increase in
an already costly path.

This patch brings it back unconditionally, and moves the BUG()
into the if arm.

Signed-off-by: Dave Jones <davej@redhat.com>

--- local-git/mm/rmap.c~	2006-10-04 16:38:06.000000000 -0400
+++ local-git/mm/rmap.c	2006-10-04 16:38:24.000000000 -0400
@@ -576,15 +576,14 @@ void page_add_file_rmap(struct page *pag
 void page_remove_rmap(struct page *page)
 {
 	if (atomic_add_negative(-1, &page->_mapcount)) {
-#ifdef CONFIG_DEBUG_VM
 		if (unlikely(page_mapcount(page) < 0)) {
 			printk (KERN_EMERG "Eeek! page_mapcount(page) went negative! (%d)\n", page_mapcount(page));
 			printk (KERN_EMERG "  page->flags = %lx\n", page->flags);
 			printk (KERN_EMERG "  page->count = %x\n", page_count(page));
 			printk (KERN_EMERG "  page->mapping = %p\n", page->mapping);
+			BUG();
 		}
-#endif
-		BUG_ON(page_mapcount(page) < 0);
+
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
-- 
http://www.codemonkey.org.uk
