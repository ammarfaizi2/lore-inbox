Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUEDGag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUEDGag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUEDGad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 02:30:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:8080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263574AbUEDGab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 02:30:31 -0400
Date: Mon, 3 May 2004 23:29:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040503232928.1b13037c.akpm@osdl.org>
In-Reply-To: <1083631804.4544.16.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
	<20040503110854.5abcdc7e.akpm@osdl.org>
	<1083615727.7949.40.camel@localhost.localdomain>
	<20040503135719.423ded06.akpm@osdl.org>
	<1083620245.23042.107.camel@abyss.local>
	<20040503145922.5a7dee73.akpm@osdl.org>
	<4096DC89.5020300@yahoo.com.au>
	<20040503171005.1e63a745.akpm@osdl.org>
	<4096E1A6.2010506@yahoo.com.au>
	<1083631804.4544.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> Sorry, If I am saying this again. I have checked the behaviour of the
>  readahead code using my user level simulator as well as running some
>  DSS benchmark and iozone benchmark. It generates a steady stream of
>  large i/o for large-random-reads and should not exhibit the bad behavior
>  that we are seeing.  I feel this bad behavior is because of interleaved
>  access by multiple thread. 

you're right - the benchmark has multiple threads issuing concurrent
pread()s against the same fd.  For some reason this mucks up the 2.6
readahead state more than 2.4's.

Putting a semaphore around do_generic_file_read() or maintaining the state
as below fixes it up.

I wonder if we should bother fixing this?  I guess as long as the app is
using pread() it is a legitimate thing to be doing, so I guess we should...



--- 25/mm/filemap.c~readahead-seralisation	2004-05-03 23:14:43.399947720 -0700
+++ 25-akpm/mm/filemap.c	2004-05-03 23:14:43.404946960 -0700
@@ -612,7 +612,7 @@ EXPORT_SYMBOL(grab_cache_page_nowait);
  * - note the struct file * is only passed for the use of readpage
  */
 void do_generic_mapping_read(struct address_space *mapping,
-			     struct file_ra_state *ra,
+			     struct file_ra_state *_ra,
 			     struct file * filp,
 			     loff_t *ppos,
 			     read_descriptor_t * desc,
@@ -622,6 +622,7 @@ void do_generic_mapping_read(struct addr
 	unsigned long index, offset;
 	struct page *cached_page;
 	int error;
+	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
@@ -644,13 +645,13 @@ void do_generic_mapping_read(struct addr
 		}
 
 		cond_resched();
-		page_cache_readahead(mapping, ra, filp, index);
+		page_cache_readahead(mapping, &ra, filp, index);
 
 		nr = nr - offset;
 find_page:
 		page = find_get_page(mapping, index);
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, ra, index);
+			handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
 		if (!PageUptodate(page))
@@ -752,6 +753,8 @@ no_cached_page:
 		goto readpage;
 	}
 
+	*_ra = ra;
+
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);

_

