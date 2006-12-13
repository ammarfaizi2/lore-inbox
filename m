Return-Path: <linux-kernel-owner+w=401wt.eu-S1751612AbWLMWBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWLMWBP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWLMWBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:01:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47512 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbWLMWBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:01:15 -0500
Date: Wed, 13 Dec 2006 14:00:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
Subject: Re: [patch 03/13] io-accounting: write accounting
Message-Id: <20061213140058.be5f7445.akpm@osdl.org>
In-Reply-To: <20061213110701.37300a1e.akpm@osdl.org>
References: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
	<457FBDBE.10102@FreeBSD.org>
	<20061213005954.e2d32446.akpm@osdl.org>
	<457FD777.9040703@FreeBSD.org>
	<457FDDCE.7010303@FreeBSD.org>
	<20061213110701.37300a1e.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 11:07:01 -0800
Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 13 Dec 2006 03:02:38 -0800
> Suleiman Souhlal <ssouhlal@FreeBSD.org> wrote:
> 
> > The only I/O non-shared VMAs might cause is from swapping, and I'm not
> > sure if the io accounting patches actually care about that.
> 
> Yes, the patches do attempt to correctly account for swap IO.  swapin is
> accounted in submit_bio() and swapout is, err, not accounted at all.  Drat,
> I forgot to retest that.
> 

hey, this is hard.

The obvious "fix" is to do:

--- a/mm/page-writeback.c~a
+++ a/mm/page-writeback.c
@@ -816,8 +816,10 @@ int fastcall set_page_dirty(struct page 
 		return (*spd)(page);
 	}
 	if (!PageDirty(page)) {
-		if (!TestSetPageDirty(page))
+		if (!TestSetPageDirty(page)) {
+			task_io_account_write(PAGE_SIZE);
 			return 1;
+		}
 	}
 	return 0;
 }
_


but that means that memset(malloc(1000000)) will accuse the task of having
done 1MB of writing, which is daft.

What would be appropriate here is to account the task with the write when
someone moves a dirty anon page into swapcache.  That means that some
random task needs to locate the task which "owns" this anon page.  So in
shrink_page_list()->add_to_swap() we need to hunt down the appropriate
locks, do the rmap walk, find the vma, find the mm, then wonder how the
heck we find the right task_struct based on the mm_struct.

I think I'll back slowly away from this problem and mark it as "known
shortcoming".

Which perhaps means that we should not account for swapin either.
