Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUAOU4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUAOU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:56:29 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:15744 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261595AbUAOUy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:54:56 -0500
Subject: Re: Slowwwwwwwwwwww NFS read performance....
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1074197762.1232.1.camel@nidelv.trondhjem.org>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
	 <1074025508.1987.10.camel@lumiere>
	 <1074026758.4524.65.camel@nidelv.trondhjem.org>
	 <bu4pd6$anf$1@news.cistron.nl>
	 <1074134135.1522.52.camel@nidelv.trondhjem.org>
	 <1074193256.2148.55.camel@nidelv.trondhjem.org>
	 <1074196422.2907.35.camel@dyn319250.beaverton.ibm.com>
	 <1074197762.1232.1.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074200089.1232.6.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 15:54:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 15/01/2004 klokka 15:16, skreiv Trond Myklebust:
> På to , 15/01/2004 klokka 14:53, skreiv Ram Pai:
> > Yes this problem has been reported earlier. Attaching Andrew's patch
> > that reverts a change. This should work. Please confirm.
> 
> Sorry to disappoint you, but that change appears already in 2.6.1-mm3,
> and does not suffice to fix the problem.

The following reversion is what fixes my regression. That puts the
sequential read numbers back to the 2.6.0 values of ~140MB/sec (from the
current 2.6.1 values of 14MB/second)...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.6.1-mm3/mm/readahead.c linux-2.6.1-fixed/mm/readahead.c
--- linux-2.6.1-mm3/mm/readahead.c	2004-01-09 01:59:07.000000000 -0500
+++ linux-2.6.1-fixed/mm/readahead.c	2004-01-15 15:41:35.118000000 -0500
@@ -474,13 +474,9 @@
 		/*
 		 * This read request is within the current window.  It is time
 		 * to submit I/O for the ahead window while the application is
-		 * about to step into the ahead window.
-		 * Heuristic: Defer reading the ahead window till we hit
-		 * the last page in the current window. (lazy readahead)
-		 * If we read in earlier we run the risk of wasting
-		 * the ahead window.
+		 * crunching through the current window.
 		 */
-		if (ra->ahead_start == 0 && offset == (ra->start + ra->size -1)) {
+		if (ra->ahead_start == 0) {
 			ra->ahead_start = ra->start + ra->size;
 			ra->ahead_size = ra->next_size;
 			actual = do_page_cache_readahead(mapping, filp,

