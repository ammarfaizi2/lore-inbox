Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUAJRbw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAJR3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:29:48 -0500
Received: from rat-4.inet.it ([213.92.5.94]:9950 "EHLO rat-4.inet.it")
	by vger.kernel.org with ESMTP id S265269AbUAJR3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:29:23 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sat, 10 Jan 2004 18:29:17 +0100
User-Agent: KMail/1.5.2
Cc: Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <40002196.4030506@wmich.edu> <400025FF.1030508@wmich.edu>
In-Reply-To: <400025FF.1030508@wmich.edu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401101827.47754.ornati@lycos.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 17:19, Ed Sweetman wrote:
>
> debian unstable's dd may also be seeing that it's writing to /dev/null
> and just not doing anything. I know extents are fast and make certain
> manipulations on them extremely faster than plain ext3 but 256MB/sec is
> really really too fast. So in either case it looks like this test is not
> usable to me.

yes... 256MB/s is a bit too high!
Can you try with "fadvice" installed?
Anyway I think your theroy is right... and so intalling "fadvice" you will 
NOT see any big difference.

>
>
> I dont know why you dont also try 8192 for readahead, measuring

beacuse readahead setted to 8192 gives me BAD performance!

> performance by the duration or intensity of the hdd is led is not very
> sound. i actually copy large files to and from parts of the same ext3
> partition at over 20MB/sec sustained hdparm shows it's highest numbers
> under it. For me it doesn't get any faster than that.  So what's this
> all say, maybe all these performance numbers are just as much based on
> your readahead value as they are on the position of the moon and the
> rest of the system and it's hardware. btw, what is the value of your HZ
> environment variable, debian still sets it to 100, i set it to 1024, not
> really sure if it made any difference.
>
> i'm using the via ide driver, so are you, i'm not seeing the type of
> regression that you are, my dd doesn't do what your dd does. our hdds
> are different.  The regression in the kernels could just as easily be
> due to a regression in the schedular and nothing to do with the ide
> drivers.  Have you tried just using 2.6.0 (whatever version you see
> changes with your readahead values) then the same kernel with the new
> ide code from the kernel you dont see any changes so you're running
> everything else the same but only ide has been "upgraded" and see if you
> see the same regression.  I dont think you will. the readahead effects

Yes, the correct way to work is as you say....
BUT read the whole story:

1) using "hdparm -t /dev/hda" I found IDE performace regression (in 
sequential reads) upgrading from 2.6.0 to 2.6.1-rc1

2) someone tell me to try to revert this patch:
"readahead: multiple performance fixes"

Reverting it in 2.6.1-rc1 kernel gives me the same ide performaces that 
2.6.0 has.

3) Since 2.6.0 and 2.6.1-rc1(with "readahead: multiple performance fixes" 
reverted) kernels give me the same results for any IDE performance test I 
do --> I treat them as they are the same thing ;-) 


The part of the patch that gives me all these problem is already found and 
is quite small:

diff -Nru a/mm/filemap.c b/mm/filemap.c

--- a/mm/filemap.c	Sat Jan  3 02:29:08 2004
+++ b/mm/filemap.c	Sat Jan  3 02:29:08 2004
@@ -587,13 +587,22 @@
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, offset;
+	unsigned long index, offset, last;
 	struct page *cached_page;
 	int error;
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
+	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
+
+	/*
+	 * Let the readahead logic know upfront about all
+	 * the pages we'll need to satisfy this request
+	 */
+	for (; index < last; index++)
+		page_cache_readahead(mapping, ra, filp, index);
+	index = *ppos >> PAGE_CACHE_SHIFT;
 
 	for (;;) {
 		struct page *page;
@@ -612,7 +621,6 @@
 		}
 
 		cond_resched();
-		page_cache_readahead(mapping, ra, filp, index);
 
 		nr = nr - offset;
 find_page:


-- 
	Paolo Ornati
	Linux v2.4.24


