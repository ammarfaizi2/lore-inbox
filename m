Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUEFIni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUEFIni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 04:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUEFIni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 04:43:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:28867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261580AbUEFInf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 04:43:35 -0400
Date: Thu, 6 May 2004 01:43:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Kopytov <alexeyk@mysql.com>
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040506014307.1a97d23b.akpm@osdl.org>
In-Reply-To: <200405060204.51591.alexeyk@mysql.com>
References: <200405022357.59415.alexeyk@mysql.com>
	<200405050301.32355.alexeyk@mysql.com>
	<20040504162037.6deccda4.akpm@osdl.org>
	<200405060204.51591.alexeyk@mysql.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kopytov <alexeyk@mysql.com> wrote:
>
> Results with the deadline scheduler on my hardware:
> 
>  Time spent for test:  92.8340s

Now we're into unreproducible results, alas.  On a 256MB uniprocessor
machine:

ext3:

sysbench --num-threads=16 --test=fileio --file-total-size=2G --file-test-mode=rndrw run

2.6.6-rc3-mm2, deadline:

	Time spent for test:  66.7536s
	Time spent for test:  67.9000s
		0.04s user 6.41s system 4% cpu 2:14.74 total

2.6.6-rc2-mm2, as:

	Time spent for test:  66.7576s
		0.07s user 6.68s system 5% cpu 2:14.18 total
	Time spent for test:  66.3216s
		0.06s user 6.28s system 4% cpu 2:12.25 total

2.4.27-pre2:

	Time spent for test:  64.9766s
		0.09s user 11.57s system 8% cpu 2:17.43 total
	Time spent for test:  64.2852s
		0.11s user 11.18s system 8% cpu 2:14.63 total

so 2.6 is a shade slower.  2.6 has tons less system CPU time, probably due
to ext3 improvements.

The reason for the difference appears to be the thing which Ram added to
readahead which causes it to usually read one page too many.  With this
exciting patch:

--- 25/mm/readahead.c~a	2004-05-06 01:24:26.230330464 -0700
+++ 25-akpm/mm/readahead.c	2004-05-06 01:24:26.234329856 -0700
@@ -475,7 +475,7 @@ do_io:
 		ra->ahead_start = 0;		/* Invalidate these */
 		ra->ahead_size = 0;
 		actual = do_page_cache_readahead(mapping, filp, offset,
-						 ra->size);
+				ra->size == 5 ? 4 : ra->size);
 		if(!first_access) {
 			/*
 			 * do not adjust the readahead window size the first

_


I get:

	Time spent for test:  63.9435s
		0.07s user 6.69s system 5% cpu 2:11.02 total

which is a good result.

Ram, can you take a look at fixing that up please?  Something clean, not
more hacks ;) I'd also be interested in an explanation of what the extra
page is for.  The little comment in there doesn't really help.


One thing I note about this test is that it generates a huge number of
inode writes.  atime updates from the reads and mtime updates from the
writes.  Suppressing them doesn't actually make a lot of performance
difference, but that is with writeback caching enabled.  I expect that with
a writethrough cache these will really hurt.

The test uses 128 files, which seems excessive.  I assume that four or
eight files is a more likely real-life setup, and in theis case the
atime/mtime update volume will be proportionately less.

Alexey, I do not know why you're seeing such a disparity.  I assume that
IDE DMA is enabled - the difference seems too small for that to be an
explanation, but please check it.
