Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUAGX5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUAGX5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:57:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:4792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265665AbUAGX5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:57:02 -0500
Date: Wed, 7 Jan 2004 15:57:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ornati <ornati@lycos.it>
Cc: linuxram@us.ibm.com, gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-Id: <20040107155729.7e737c36.akpm@osdl.org>
In-Reply-To: <200401072112.35334.ornati@lycos.it>
References: <200401021658.41384.ornati@lycos.it>
	<200401071559.16130.ornati@lycos.it>
	<1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
	<200401072112.35334.ornati@lycos.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati <ornati@lycos.it> wrote:
>
> I haven't done a lot of tests but it seems to me that the changes in 
> mm/filemap.c are the only things that influence the sequential read 
> performance on my disk.

The fact that this only happens when reading a blockdev (true?) is a big
hint.   Maybe it is because regular files implement ->readpages.

If the below patch makes read throughput worse on regular files too then
that would confirm the idea.

diff -puN mm/readahead.c~a mm/readahead.c
--- 25/mm/readahead.c~a	Wed Jan  7 15:56:32 2004
+++ 25-akpm/mm/readahead.c	Wed Jan  7 15:56:36 2004
@@ -103,11 +103,6 @@ static int read_pages(struct address_spa
 	struct pagevec lru_pvec;
 	int ret = 0;
 
-	if (mapping->a_ops->readpages) {
-		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
-		goto out;
-	}
-
 	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_to_page(pages);

_

