Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUCQXOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCQXOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:14:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:13750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262143AbUCQXJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:09:07 -0500
Date: Wed, 17 Mar 2004 15:09:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040317150909.7fd121bd.akpm@osdl.org>
In-Reply-To: <1079563568.4185.1947.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	<1079474312.4186.927.camel@watt.suse.com>
	<20040316152106.22053934.akpm@osdl.org>
	<20040316152843.667a623d.akpm@osdl.org>
	<20040316153900.1e845ba2.akpm@osdl.org>
	<1079485055.4181.1115.camel@watt.suse.com>
	<1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	<20040316180043.441e8150.akpm@osdl.org>
	<1079554288.4183.1938.camel@watt.suse.com>
	<20040317123324.46411197.akpm@osdl.org>
	<1079563568.4185.1947.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> wait_on_page_writeback_range() does a pagevec_lookup_tag on 
>  min(end - index + 1, (pgoff_t)PAGEVEC_SIZE)
> 
>  Which translates to: (unsigned long)-1 - 0 + 1, which is 0.

I made a mental note to test that code.

How's this look?

--- 25/mm/filemap.c~stop-using-locked-pages-fix-2	2004-03-17 15:01:47.466260848 -0800
+++ 25-akpm/mm/filemap.c	2004-03-17 15:04:10.730481376 -0800
@@ -186,8 +186,8 @@ static int wait_on_page_writeback_range(
 	pagevec_init(&pvec, 0);
 	index = start;
 	while ((nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-				PAGECACHE_TAG_WRITEBACK,
-				min(end - index + 1, (pgoff_t)PAGEVEC_SIZE)))) {
+			PAGECACHE_TAG_WRITEBACK,
+			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;
 
 		for (i = 0; i < nr_pages; i++) {

_

>  It doesn't look like anyone is using the range feature of this function,
>  can we make it just wait on all the writeback pages?

We could, but there are the dreaded "future plans".  In several places
we're syncing the whole file unnecessarily.  Most notably, O_SYNC writes. 
I'd like to get us to the stage where an O_SYNC write writes and waits upon
just the pages which are within the range of the caller's write(), without
holding i_sem.

