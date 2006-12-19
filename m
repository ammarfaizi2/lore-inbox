Return-Path: <linux-kernel-owner+w=401wt.eu-S932762AbWLSKdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWLSKdb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLSKdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:33:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47259 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932762AbWLSKda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:33:30 -0500
Date: Tue, 19 Dec 2006 02:32:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061219023255.f5241bb0.akpm@osdl.org>
In-Reply-To: <4587B762.2030603@yahoo.com.au>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<45876C65.7010301@yahoo.com.au>
	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	<45878BE8.8010700@yahoo.com.au>
	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	<4587B762.2030603@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 20:56:50 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Linus Torvalds wrote:
> 
> > NOTICE? First you make a BIG DEAL about how dirty bits should never get 
> > lost, but THE VERY SAME FUNCTION actually very much on purpose DOES drop 
> > the dirty bit for when it's not in the page tables.
> 
> try_to_free_buffers is quite a special case, where we're transferring
> the page dirty metadata from the buffers to the page. I think Andrew
> would have a better grasp of it so he could correct me, but what it
> does is legitimate.

Well it used to be.  After 2.6.19 it can do the wrong thing for mapped
pages.  But it turns out that we don't feed it mapped pages, apart from
pagevec_strip() and possibly races against pagefaults.

> I think it could be very likely that indeed the bug is a latent one in
> a clear_page_dirty caller, rather than dirty-tracking itself.

The only callers are try_to_free_buffers(), truncate and a few scruffy
possibly-wrong-for-fsync filesytems which aren't being used here.


<spots a race in do_no_page()>

If a write-fault races with a read-fault and the write-fault loses, we forget
to mark the page dirty.

Something like this, but it's probably wrong - I didn't try very hard (am
feeling ill, and vaguely grumpy)


From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/memory.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff -puN mm/memory.c~a mm/memory.c
--- a/mm/memory.c~a
+++ a/mm/memory.c
@@ -2264,10 +2264,22 @@ retry:
 		}
 	} else {
 		/* One of our sibling threads was faster, back out. */
+		if (write_access) {
+			/*
+			 * We might have raced against a read-fault.  We still
+			 * need to dirty the page.
+			 */
+			dirty_page = vm_normal_page(vma, address, *page_table);
+			if (dirty_page) {
+				get_page(dirty_page);
+				goto dirty_it;
+			}
+		}
 		page_cache_release(new_page);
 		goto unlock;
 	}
 
+dirty_it:
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
_

