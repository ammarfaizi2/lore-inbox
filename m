Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUEKUw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUEKUw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUEKUw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:52:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35257 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263629AbUEKUwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:52:14 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: alexeyk@mysql.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040510160740.5db8c62c.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
	 <1084218659.6140.459.camel@localhost.localdomain>
	 <20040510132151.238b8d0c.akpm@osdl.org>
	 <1084228767.6140.832.camel@localhost.localdomain>
	 <20040510160740.5db8c62c.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-mRCtkoTtez+HP1ZFy6bF"
Organization: 
Message-Id: <1084308706.25954.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2004 13:51:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mRCtkoTtez+HP1ZFy6bF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-05-10 at 16:07, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > I am nervous about this change. You are totally getting rid of
> > lazy-readahead and that was the optimization which gave the best
> > possible boost in performance. 
> 
> Because it disabled the large readahead outside the area which the app is
> reading.  But it's still reading too much.

> > Let me see how this patch does with a DSS benchmark.
> 
> That was not a real patch.  More work is surely needed to get that right.
> 
> > In the normal large random workload this extra page would have
> > compesated for all the wasted readaheads.
> 
> I disagree that 64k is "normal"!
> 
> >  However in the case of
> > sysbench with Andrew's ra-copy patch the readahead calculation is not
> > happening quiet right. Is it worth trying to get a marginal gain 
> > with sysbench at the cost of getting a big hit on DSS benchmarks,
> > aio-tests,iozone and probably others. Or am I making an unsubstantiated
> > claim? I will get back with results.
> 
> It shouldn't hurt at all - the app does a seek, we perform the
> correctly-sized read.

Looks like you are right on all counts! I did some modifications to your
patch and did a preliminary run with my user-level simulator. With these
changes I am able to get rid of that extra page. Also code looks much
simpler and adapts well to sequential and random patterns.

However I have to run this under some benchmarks and see how it fares.
Its a pre-alpha level patch.

Can you take a quick look at the changes and see if you like it? I am
sure you won't consider these changes a hack ;)

RP

--=-mRCtkoTtez+HP1ZFy6bF
Content-Disposition: attachment; filename=readahead_trim.patch
Content-Type: text/x-patch; name=readahead_trim.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.6/mm/readahead.c linux-2.6.6.new/mm/readahead.c
--- linux-2.6.6/mm/readahead.c	2004-05-09 19:32:00.000000000 -0700
+++ linux-2.6.6.new/mm/readahead.c	2004-05-11 20:26:51.288797696 -0700
@@ -353,7 +353,7 @@ page_cache_readahead(struct address_spac
 	unsigned orig_next_size;
 	unsigned actual;
 	int first_access=0;
-	unsigned long preoffset=0;
+	unsigned long average=0;
 
 	/*
 	 * Here we detect the case where the application is performing
@@ -394,10 +394,17 @@ page_cache_readahead(struct address_spac
 		if (ra->serial_cnt <= (max * 2))
 			ra->serial_cnt++;
 	} else {
-		ra->average = (ra->average + ra->serial_cnt) / 2;
+		/* to avoid rounding errors, ensure that 'average' 
+		 * tends towards the value of ra->serial_cnt.
+		 */
+                if(ra->average > ra->serial_cnt) {
+                        average = ra->average - 1; 
+                } else {
+                        average = ra->average + 1;
+                }
+		ra->average = (average + ra->serial_cnt) / 2;
 		ra->serial_cnt = 1;
 	}
-	preoffset = ra->prev_page;
 	ra->prev_page = offset;
 
 	if (offset >= ra->start && offset <= (ra->start + ra->size)) {
@@ -457,18 +464,14 @@ do_io:
 		 * ahead window and get some I/O underway for the new
 		 * current window.
 		 */
-		if (!first_access && preoffset >= ra->start &&
-				preoffset < (ra->start + ra->size)) {
-			 /* Heuristic:  If 'n' pages were
-			  * accessed in the current window, there
-			  * is a high probability that around 'n' pages
-			  * shall be used in the next current window.
-			  *
-			  * To minimize lazy-readahead triggered
-			  * in the next current window, read in
-			  * an extra page.
+		if (!first_access) {
+			 /* Heuristic: there is a high probability 
+			  * that around  ra->average number of
+			  * pages shall be accessed in the next
+			  * current window.
 			  */
-			ra->next_size = preoffset - ra->start + 2;
+			ra->next_size = (ra->average > max ?  
+				max : ra->average); 
 		}
 		ra->start = offset;
 		ra->size = ra->next_size;
@@ -492,21 +495,19 @@ do_io:
 		 */
 		if (ra->ahead_start == 0) {
 			/*
-			 * if the average io-size is less than maximum
+			 * If the average io-size is more than maximum
 			 * readahead size of the file the io pattern is
 			 * sequential. Hence  bring in the readahead window
-			 * immediately.
-			 * Else the i/o pattern is random. Bring
-			 * in the readahead window only if the last page of
-			 * the current window is accessed (lazy readahead).
+			 * immediately. 
+			 * If the average io-size is less than maximum
+			 * readahead size of the file the io pattern is
+			 * random. Hence don't bother to readahead.
 			 */
-			unsigned long average = ra->average;
-
+			average = ra->average;
 			if (ra->serial_cnt > average)
-				average = (ra->serial_cnt + ra->average) / 2;
+				average = (ra->serial_cnt + ra->average + 1) / 2;
 
-			if ((average >= max) || (offset == (ra->start +
-							ra->size - 1))) {
+			if (average > max) {
 				ra->ahead_start = ra->start + ra->size;
 				ra->ahead_size = ra->next_size;
 				actual = do_page_cache_readahead(mapping, filp,

--=-mRCtkoTtez+HP1ZFy6bF--

