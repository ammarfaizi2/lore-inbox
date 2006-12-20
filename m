Return-Path: <linux-kernel-owner+w=401wt.eu-S1030368AbWLTVz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWLTVz4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWLTVz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:55:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:48091 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030368AbWLTVzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:55:55 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 15:55:35 -0600
Message-Id: <1166651735.10211.9.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 11:50 -0800, Linus Torvalds wrote:

> NOTE NOTE NOTE! I _only_ did enough to make things compile for my
> particular configuration. That means that right now the following
> filesystems are broken with this patch (because they use the totally
> broken old crap):
> 
> 	CIFS, FUSE, JFS, ReiserFS, XFS
> 
> and I don't know exactly what they need to be fixed. But most likely their
> usage was insane and pointless anyway (looking at the ReiserFS case, for
> example, that was DEFINITELY the case. I can't even imagine what the heck
> it thinks it is doing).

Here's a patch to get rid of clear_page_dirty() from jfs.  I'm not
convinced it was totally broken, but I'm not convinced it wasn't.
Either way, I don't think that bit of code was particularly beneficial.

Feel free to apply this patch independent of your patch if you really
think that jfs's use of clear_page_dirty is crap, or I can push it
through -mm first.

This patch removes some questionable code that attempted to make a
no-longer-used page easier to reclaim.

Calling metapage_writepage against such a page will not result in any
I/O being performed, so removing this code shouldn't be a big deal.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff -Nurp linux-orig/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux-orig/fs/jfs/jfs_metapage.c	2006-12-07 17:12:58.000000000 -0600
+++ linux/fs/jfs/jfs_metapage.c	2006-12-20 15:19:48.000000000 -0600
@@ -764,22 +764,9 @@ void release_metapage(struct metapage * 
 	} else if (mp->lsn)	/* discard_metapage doesn't remove it */
 		remove_from_logsync(mp);
 
-#if MPS_PER_PAGE == 1
-	/*
-	 * If we know this is the only thing in the page, we can throw
-	 * the page out of the page cache.  If pages are larger, we
-	 * don't want to do this.
-	 */
-
-	/* Retest mp->count since we may have released page lock */
-	if (test_bit(META_discard, &mp->flag) && !mp->count) {
-		clear_page_dirty(page);
-		ClearPageUptodate(page);
-	}
-#else
 	/* Try to keep metapages from using up too much memory */
 	drop_metapage(page, mp);
-#endif
+
 	unlock_page(page);
 	page_cache_release(page);
 }


