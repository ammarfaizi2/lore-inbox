Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUEQRdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUEQRdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUEQRdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:33:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64172 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261984AbUEQRat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:30:49 -0400
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: alexeyk@mysql.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
	 <1084218659.6140.459.camel@localhost.localdomain>
	 <20040510132151.238b8d0c.akpm@osdl.org>
	 <1084228767.6140.832.camel@localhost.localdomain>
	 <20040510160740.5db8c62c.akpm@osdl.org>
	 <1084308706.25954.28.camel@localhost.localdomain>
	 <20040511141717.719f3ac8.akpm@osdl.org>
	 <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-QIj1AfrFBUkHiHxIko4a"
Organization: 
Message-Id: <1084815010.13559.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 May 2004 10:30:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QIj1AfrFBUkHiHxIko4a
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-05-13 at 13:41, Ram Pai wrote:
> On Tue, 2004-05-11 at 14:17, Andrew Morton wrote:
> > Ram Pai <linuxram@us.ibm.com> wrote:
>  
> I am yet to get my machine fully set up to run a DSS benchmark. But
> thought I will update you on the following comment.

Attached the cleaned up patch and the performance results of the patch.

Overall Observation:
        1.Small improvement with iozone with the patch, and overall
                        much better performance than 2.4
        2.Small/neglegible improvement with DSS workload.
        3.Negligible impact with sysbench, but results worser than
                        2.4 kernels

RP


--=-QIj1AfrFBUkHiHxIko4a
Content-Disposition: attachment; filename=seeky-readahead-speedups.patch
Content-Type: text/plain; name=seeky-readahead-speedups.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


	Results of iozone,sysbench and DSS workload with the 
		seeky-readahead-speedups.patch
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Overall Observation: 
	1.Small improvement with iozone with the patch, and overall
			much better performance than 2.4
	2.Small/neglegible improvement with DSS workload.
	3.Negligible impact with sysbench, but results worser than
			2.4 kernels

	The cleaned-up patch is included towards the end of this report.

Details:

**********************************************************************
			IOZONE 

	run on a nfs mounted filesystem:
	client machine 2proc, 733MHz, 2GB memory
	server machine 8proc, 700Mhz, 8GB memory

./iozone -c -t1 -s 4096m -r 128k


---------------------------------------------------------
|		| throughput |	throughput | throughput |
|		| KB/sec     |	KB/sec     | KB/sec     |
|		| 266	     |	266+patch  | 2.4.20     |
---------------------------------------------------------
|sequential read| 11697.55   |	11700.98   | 10846.87   |
| 		|	     |             |            |
|re-read	| 11698.39   |	11691.84   | 10865.39   |
|		|	     |             |            |
|reverse read	| 20002.71   |	20099.86   | 10340.34   |
|               |            |             |            |
|stride read	| 13813.01   |	13850.28   | 10193.87   |
|		|	     |             |            |
|random read	| 19705.06   |	19978.00   | 10839.57   |
|               |            |             |            |
|random mix	| 28465.68   |	29964.38   | 10779.17   |
|		|	     |             |            |
|pread		| 11692.95   |	11697.29   | 10863.56   |
---------------------------------------------------------


**************************************************************

			SYSBENCH

	run on machine 2proc, 733MHz, 256MB memory


---------------------------------------------------------
|		| 266	     |	266+patch  | 2.4.21     |
---------------------------------------------------------
|time spent     | 79.6253    |	79.8176    | 73.2605sec |
| 		|	     |             |            |
|Mb/sec		| 1.959Mb.sec|	1.954Mb/sec| 2.129Mb/sec|
|		|	     |             |            |
|requests/sec 	| 125.59     |	125.29     | 136.54	|
|               |            |             |            |
|no of Reads 	| 6001       |	6001	   | 6008	|
|		|	     |             |            |
|no of Writes 	| 3999	     |	3999       | 3995	|
|               |            |             |            |
---------------------------------------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
266 sysbench output:

Operations performed:  6001 Read, 3999 Write, 12800 Other = 22800 Total
Read 93Mb  Written 62Mb  Total Transferred 156Mb
   1.959Mb/sec  Transferred
  125.59 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  79.6253s

Per Request statistics:
Min:   0.0000s  Avg:   0.0467s  Max:   0.9802s    Events tracked: 10000
Total time taken by event execution: 467.1493s
Threads fairness: 87.41/94.20  distribution,  88.68/94.45 execution
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
266+patch sysbench output:

Operations performed:  6001 Read, 3999 Write, 12800 Other = 22800 Total
Read 93Mb  Written 62Mb  Total Transferred 156Mb
   1.954Mb/sec  Transferred
  125.29 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  79.8176s

Per Request statistics:
Min:   0.0000s  Avg:   0.0482s  Max:   0.8481s    Events tracked: 10000
Total time taken by event execution: 481.7572s
Threads fairness: 85.27/93.25  distribution,  85.15/94.91 execution

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2.4.21 sysbench output:

Operations performed:  6008 Read, 3995 Write, 12800 Other = 22803 Total
Read 93Mb  Written 62Mb  Total Transferred 156Mb
   2.129Mb/sec  Transferred
  136.54 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  73.2605s

Per Request statistics:
Min:   0.0000s  Avg:   0.0380s  Max:   0.3712s    Events tracked: 10003
Total time taken by event execution: 380.4081s
Threads fairness: 79.04/91.95  distribution,  82.52/92.44 execution
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




**************************************************************

DSS WORKLOAD

	Got 1% improvement with the patch

**************************************************************




diff -urNp linux-2.6.6/mm/readahead.c linux-2.6.6.new/mm/readahead.c
--- linux-2.6.6/mm/readahead.c	2004-05-11 20:41:28.000000000 -0700
+++ linux-2.6.6.new/mm/readahead.c	2004-05-17 17:33:51.145040472 -0700
@@ -353,7 +353,7 @@ page_cache_readahead(struct address_spac
 	unsigned orig_next_size;
 	unsigned actual;
 	int first_access=0;
-	unsigned long preoffset=0;
+	unsigned long average;
 
 	/*
 	 * Here we detect the case where the application is performing
@@ -394,10 +394,17 @@ page_cache_readahead(struct address_spac
 		if (ra->serial_cnt <= (max * 2))
 			ra->serial_cnt++;
 	} else {
-		ra->average = (ra->average + ra->serial_cnt) / 2;
+		/* 
+		 * to avoid rounding errors, ensure that 'average' 
+		 * tends towards the value of ra->serial_cnt.
+		 */
+		average = ra->average;
+		if (average < ra->serial_cnt) {
+			average++;
+		}
+		ra->average = (average + ra->serial_cnt) / 2;
 		ra->serial_cnt = 1;
 	}
-	preoffset = ra->prev_page;
 	ra->prev_page = offset;
 
 	if (offset >= ra->start && offset <= (ra->start + ra->size)) {
@@ -457,18 +464,13 @@ do_io:
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
+			ra->next_size = min(ra->average , (unsigned long)max);
 		}
 		ra->start = offset;
 		ra->size = ra->next_size;
@@ -492,21 +494,19 @@ do_io:
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

--=-QIj1AfrFBUkHiHxIko4a--

