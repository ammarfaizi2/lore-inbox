Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUECLOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUECLOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUECLOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:14:54 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:2151 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263640AbUECLOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:14:49 -0400
Message-ID: <409629A5.8070201@yahoo.com.au>
Date: Mon, 03 May 2004 21:14:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Kopytov <alexeyk@mysql.com>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Random file I/O regressions in 2.6
References: <200405022357.59415.alexeyk@mysql.com>
In-Reply-To: <200405022357.59415.alexeyk@mysql.com>
Content-Type: multipart/mixed;
 boundary="------------050507080204080205020004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507080204080205020004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alexey Kopytov wrote:
> Hello!
> 
> I tried to compare random file I/O performance in 2.4 and 2.6 kernels and 
> found some regressions that I failed to explain. I tested 2.4.25, 2.6.5-bk2 
> and 2.6.6-rc3 with my own utility SysBench which was written to generate 
> workloads similar to a database under intensive load. 
> 
> For 2.6.x kernels anticipatory, deadline, CFQ and noop I/O schedulers were
> tested with AS giving the best results for this workload, but it's still about 
> 1.5 times worse than the results for 2.4.25 kernel.
> 
> The SysBench 'fileio' test was configured to generate the following workload:
> 16 worker threads are created, each running random read/write file requests in
> blocks of 16 KB with a read/write ratio of 1.5. All I/O operations are evenly
> distributed over 128 files with a total size of 3 GB. Each 100 requests, an
> fsync() operations is performed sequentially on each file. The total number of
> requests is limited by 10000.
> 
> The FS used for the test was ext3 with data=ordered.
> 

I am able to reproduce this here. 2.6 isn't improved by increasing
nr_requests, relaxing IO scheduler deadlines, or turning off readahead.
It looks like 2.6 is submitting a lot of the IO in 4KB sized requests...

Hmm, oh dear. It looks like the readahead logic shat itself and/or
do_generic_mapping_read doesn't know how to handle multipage reads
properly.

What ends up happening is that readahead gets turned off, then the
16K read ends up being done in 4 synchronous 4K chunks. Because they
are synchronous, they have no chance of being merged with one another
either.

I have attached a proof of concept hack... I think what should really
happen is that page_cache_readahead should be taught about the size
of the requested read, and ensures that a decent amount of reading is
done while within the read request window, even if
beyond-request-window-readahead has been previously unsuccessful.

Numbers with an IDE disk, 256MB ram
2.4.24:		 81s
2.6.6-rc3-mm1:  126s
rc3-mm1+patch:   87s

The small remaining regression might be explained by 2.6's smaller
nr_requests, IDE driver, io scheduler tuning, etc.

> Here are the results (values are number of seconds to complete the test):
> 
> 2.4.25: 77.5377
> 
> 2.6.5-bk2(noop): 165.3393
> 2.6.5-bk2(anticipatory): 118.7450
> 2.6.5-bk2(deadline): 130.3254
> 2.6.5-bk2(CFQ): 146.4286
> 
> 2.6.6-rc3(noop): 164.9486
> 2.6.6-rc3(anticipatory): 125.1776
> 2.6.6-rc3(deadline): 131.8903
> 2.6.6-rc3(CFQ): 152.9280
> 
> I have published the results as well as the hardware and kernel setups at the
> SysBench home page: http://sysbench.sourceforge.net/results/fileio/
> 
> Any comments or suggestions would be highly appreciated.
> 

 From your website:
"Another interesting fact is that AS gives the best results for this
workload, though it's believed to give worse results for this kind of
workloads as compared to other I/O schedulers available in 2.6.x
kernels."

The anticipatory scheduler is actually in a fairly good state of tune,
and can often beat deadline even for random read/write/fsync tests. The
infamous database regression problem is when this sort of workload is
combined with TCQ disk drives.

Nick

--------------050507080204080205020004
Content-Type: text/x-patch;
 name="read-populate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="read-populate.patch"

 include/linux/mm.h             |    0 
 linux-2.6-npiggin/mm/filemap.c |    5 ++++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff -puN mm/readahead.c~read-populate mm/readahead.c
diff -puN mm/filemap.c~read-populate mm/filemap.c
--- linux-2.6/mm/filemap.c~read-populate	2004-05-03 19:56:00.000000000 +1000
+++ linux-2.6-npiggin/mm/filemap.c	2004-05-03 20:51:37.000000000 +1000
@@ -627,6 +627,9 @@ void do_generic_mapping_read(struct addr
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
+	force_page_cache_readahead(mapping, filp, index,
+			max_sane_readahead(desc->count >> PAGE_CACHE_SHIFT));
+
 	for (;;) {
 		struct page *page;
 		unsigned long end_index, nr, ret;
@@ -644,7 +647,7 @@ void do_generic_mapping_read(struct addr
 		}
 
 		cond_resched();
-		page_cache_readahead(mapping, ra, filp, index);
+		page_cache_readahead(mapping, ra, filp, index + desc->count);
 
 		nr = nr - offset;
 find_page:
diff -puN include/linux/mm.h~read-populate include/linux/mm.h

_

--------------050507080204080205020004--
