Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUAOTyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUAOTyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:54:33 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:20169 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261406AbUAOTya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:54:30 -0500
Subject: Re: Slowwwwwwwwwwww NFS read performance....
From: Ram Pai <linuxram@us.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1074193256.2148.55.camel@nidelv.trondhjem.org>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
	 <1074025508.1987.10.camel@lumiere>
	 <1074026758.4524.65.camel@nidelv.trondhjem.org>
	 <bu4pd6$anf$1@news.cistron.nl>
	 <1074134135.1522.52.camel@nidelv.trondhjem.org>
	 <1074193256.2148.55.camel@nidelv.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-SyvHKQca+KbDc0zgPiys"
Organization: 
Message-Id: <1074196422.2907.35.camel@dyn319250.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jan 2004 11:53:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SyvHKQca+KbDc0zgPiys
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 2004-01-15 at 11:00, Trond Myklebust wrote:
> På on , 14/01/2004 klokka 21:35, skreiv Trond Myklebust:
> 
> > Err.. no...
> > 
> > I didn't have a 2.6.1-mm3 machine ready to go in our GigE testbed (I'm
> > busy compiling one up right now). However I did run a quick test on
> > 2.6.0-test11. Iozone rather than bonnie, but the results should be
> > comparable:
> 
> Hah.... They turned out not to be...
> 
> The changeset with key 
> 
> akpm@osdl.org[torvalds]|ChangeSet|20031230234945|63435
> 
> # ChangeSet
> #   2003/12/30 15:49:45-08:00 akpm@osdl.org
> #   [PATCH] readahead: multiple performance fixes
> #
> #   From: Ram Pai <linuxram@us.ibm.com>
> 
Yes this problem has been reported earlier. Attaching Andrew's patch
that reverts a change. This should work. Please confirm.

Thanks,
RP



--=-SyvHKQca+KbDc0zgPiys
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -puN mm/filemap.c~readahead-partial-backout mm/filemap.c
--- 25/mm/filemap.c~readahead-partial-backout	2004-01-09 17:41:14.000000000 -0800
+++ 25-akpm/mm/filemap.c	2004-01-09 17:41:14.000000000 -0800
@@ -587,22 +587,13 @@ void do_generic_mapping_read(struct addr
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, offset, last;
+	unsigned long index, offset;
 	struct page *cached_page;
 	int error;
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
-	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
-
-	/*
-	 * Let the readahead logic know upfront about all
-	 * the pages we'll need to satisfy this request
-	 */
-	for (; index < last; index++)
-		page_cache_readahead(mapping, ra, filp, index);
-	index = *ppos >> PAGE_CACHE_SHIFT;
 
 	for (;;) {
 		struct page *page;
@@ -621,6 +612,7 @@ void do_generic_mapping_read(struct addr
 		}
 
 		cond_resched();
+		page_cache_readahead(mapping, ra, filp, index);
 
 		nr = nr - offset;
 find_page:

_

--=-SyvHKQca+KbDc0zgPiys--

