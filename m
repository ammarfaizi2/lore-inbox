Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUAJBmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 20:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUAJBmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 20:42:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:25495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264591AbUAJBmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 20:42:46 -0500
Date: Fri, 9 Jan 2004 17:42:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 sendfile regression
Message-Id: <20040109174258.61932d46.akpm@osdl.org>
In-Reply-To: <1073695921.14637.284.camel@dyn319250.beaverton.ibm.com>
References: <20040110000128.GA301@codeblau.de>
	<20040109162149.1e88a643.akpm@osdl.org>
	<1073695921.14637.284.camel@dyn319250.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> There is a small mistake in Andrew's patch.  The call to
>  page_cache_readahead() is missing.
> 
>  Try this one.

Third time lucky.

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

