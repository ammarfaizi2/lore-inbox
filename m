Return-Path: <linux-kernel-owner+w=401wt.eu-S932769AbWLSKxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbWLSKxd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWLSKxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:53:33 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:12467 "EHLO
	amsfep18-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932769AbWLSKxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:53:32 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061219023255.f5241bb0.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	 <4587B762.2030603@yahoo.com.au>  <20061219023255.f5241bb0.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 11:52:15 +0100
Message-Id: <1166525535.10372.138.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 02:32 -0800, Andrew Morton wrote:
> On Tue, 19 Dec 2006 20:56:50 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Linus Torvalds wrote:
> > 
> > > NOTICE? First you make a BIG DEAL about how dirty bits should never get 
> > > lost, but THE VERY SAME FUNCTION actually very much on purpose DOES drop 
> > > the dirty bit for when it's not in the page tables.
> > 
> > try_to_free_buffers is quite a special case, where we're transferring
> > the page dirty metadata from the buffers to the page. I think Andrew
> > would have a better grasp of it so he could correct me, but what it
> > does is legitimate.
> 
> Well it used to be.  After 2.6.19 it can do the wrong thing for mapped
> pages.  But it turns out that we don't feed it mapped pages, apart from
> pagevec_strip() and possibly races against pagefaults.

So how about this:

Index: linux-2.6-git/mm/page-writeback.c
===================================================================
--- linux-2.6-git.orig/mm/page-writeback.c	2006-12-19 08:24:48.000000000 +0100
+++ linux-2.6-git/mm/page-writeback.c	2006-12-19 11:43:31.000000000 +0100
@@ -859,6 +859,9 @@ int test_clear_page_dirty(struct page *p
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
 
+	if (page_mapped(page))
+		return 0;
+
 	if (!mapping)
 		return TestClearPageDirty(page);
 


