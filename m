Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267339AbUHDRUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267339AbUHDRUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUHDRUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:20:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20103 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267339AbUHDRTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:19:55 -0400
Subject: Re: [PATCH] fix readahead breakage for sequential after random
	reads
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, shrybman@aei.ca
In-Reply-To: <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com>
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	 <20040726162950.7f4a3cf4.akpm@osdl.org>
	 <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
	 <20040726170843.3fe5615c.akpm@osdl.org>
	 <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-SSiwVza9CpMQKh0Uy+WR"
Organization: 
Message-Id: <1091641117.15334.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Aug 2004 10:38:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SSiwVza9CpMQKh0Uy+WR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-07-26 at 21:18, Ram Pai wrote:
> On Mon, 2004-07-26 at 17:08, Andrew Morton wrote:
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > >
> > > Andrew,
> > > 	Yes the patch fixes a valid bug.
> > > 
> > 
> > Please don't top-post :(
> > > RP
> > > 
> > > On Mon, 2004-07-26 at 16:29, Andrew Morton wrote:
> > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > Current readahead logic is broken when a random read pattern is
> > > > >  followed by a long sequential read.  The cause is that on a window
> > > > >  miss ra->next_size is set to ra->average, but ra->average is only
> > > > >  updated at the end of a sequence, so window size will remain 1 until
> > > > >  the end of the sequential read.
> > > > > 
> > > > >  This patch fixes this by taking the current sequence length into
> > > > >  account (code taken from towards end of page_cache_readahead()), and
> > > > >  also setting ra->average to a decent value in handle_ra_miss() when
> > > > >  sequential access is detected.
> > > > 
> > > > Thanks.   Do you have any performance testing results from this patch?
> > > > 
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > >
> > > Andrew,
> > > 	Yes the patch fixes a valid bug.
> > 
> > Fine, but the readahead code is performance-sensitive, and it takes quite
> > some time for any regressions to be discovered.  So I'm going to need to
> > either sit on this patch for a very long time, or extensively test it
> > myself, or await convincing test results from someone else.
> > 
> > Can you help with that?
> 
> yes I will run all my standard testsuites before we take this patch.
> (DSS workload, iozone, sysbench). I will get back with some results
> sooon. Probably by the end of this week.

Ok I have enclosed the results. The summary is: there is no significant
improvement or decrease in performance of (DSS workload, iozone,
sysbench) The increase or decrease is in the margin of errors.

I have also enclosed a patch that partially backs off Miklos's fix. 
Shane Shrybman correctly pointed out that the real fix is to set
ra->average value to max/2 when we move from readahead-off mode to
readahead-on mode. The other part of Miklos's fix becomes irrelevent.

 
Sorry it took some time to get back on this. Its almost automated so
turnaround time should be quick now-on-wards.

RP

--=-SSiwVza9CpMQKh0Uy+WR
Content-Disposition: attachment; filename=miklos_partial_backoff.patch
Content-Type: text/plain; name=miklos_partial_backoff.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.8-rc3/mm/readahead.c	2004-08-03 14:26:46.000000000 -0700
+++ mypatchdir/mm/readahead.c	2004-08-04 17:08:47.665196424 -0700
@@ -468,11 +468,7 @@ do_io:
 			  * pages shall be accessed in the next
 			  * current window.
 			  */
-			average = ra->average;
-			if (ra->serial_cnt > average)
-				average = (ra->serial_cnt + ra->average + 1) / 2;
-
-			ra->next_size = min(average , (unsigned long)max);
+			ra->next_size = min(ra->average , (unsigned long)max);
 		}
 		ra->start = offset;
 		ra->size = ra->next_size;

--=-SSiwVza9CpMQKh0Uy+WR
Content-Disposition: attachment; filename=report
Content-Type: text/plain; name=report; charset=UTF-8
Content-Transfer-Encoding: 7bit

			DSS WORKLOAD
			----------------

---------------------------------------------------------------------
|   2.6.8-rc2	|	miklos_patch	|	miklos_mod_patch     |
|               |                       |                            |
----------------------------------------------------------------------
|               |                       |                            |
|     X		|	0.9001% increase|	0.73649% increase    |
|		| 	w.r.t 	X	|  	w.r.t	X	     |
|               |                       |                            |
---------------------------------------------------------------------


			iozone 
			-------
		iozone -c -t1 -s 4096m -r 128k -w
--------------------------------------------------------------------
|	      |	2.6.8-rc2	| miklos_patch	|miklos_mod_patch  | 
---------------------------------------------------------------------
|	      |                 |               |                  |
|Sequential   | 29773.95KB/sec  | 29777.38KB/sec|  29968.74KB/sec  |
|	      |                 |               |                  |
|reverse read | 17905.65KB/sec  | 17897.85KB/sec|  17726.55KB/sec  |
|	      |                 |               |                  |
|stride read  | 19927.43KB/sec  | 19778.90KB/sec|  19625.75KB/sec  |
|	      |                 |               |                  |
|random read  | 18454.49KB/sec  | 18384.28KB/sec|  18666.47KB/sec  |
|	      |                 |               |                  |
|random mix   | 19434.58KB/sec  | 19480.43KB/sec|  18755.05KB/sec  |
|	      |                 |               |                  |
|pread	      | 29763.56KB/sec  | 29780.05KB/sec|  29961.16KB/sec  |
|	      |                 |               |                  |
--------------------------------------------------------------------



			iozone NFS
			-------
		iozone -c -t1 -s 4096m -r 128k -w

---------------------------------------------------------------------------
|		| 2.6.8-rc2	|	miklos_patch	| miklos_mod_patch|
|---------------|---------------|-----------------------|-----------------|
|               |               |                       |           	  |
|Sequential	| 2272.77KB/sec |	2266.45KB/sec 	|   2269.98KB/sec |
|               |               |                       |           	  |
|reverse read	| 3078.14KB/sec |	3066.73KB/sec 	|   3079.87KB/sec |
|               |               |                       |           	  |
|stride read	| 3253.49KB/sec |	3220.70KB/sec 	|   3264.41KB/sec |
|               |               |                       |           	  |
|random read	| 5225.44KB/sec |	5231.68KB/sec 	|   5274.32KB/sec |
|               |               |                       |           	  |
|random mix	| 8389.64KB/sec |	8458.40KB/sec 	|   7722.72KB/sec |
|               |               |                       |           	  |
|pread		| 2264.64KB/sec |	2264.35KB/sec 	|   2256.15KB/sec |
--------------------------------------------------------------------------




			sysbench
			--------

sysbench --num-threads=256 --test=fileio --file-total-size=2800M --file-test-mode=rndrw run

-------------------------------------------------------------------------
|		|	2.6.8-rc2 	| miklos_patch	|miklos_mod_patch|
-------------------------------------------------------------------------
|               |                       |               |                |
| Throughput	|	2.745MB/sec     | 2.721MB/sec	| 2.607MB/sec    |
|---------------|-----------------------|---------------|----------------|
|               |                       |               |                |
|               |                       |               |                |
|Requests/sec	|	175.99		| 174.40MB/sec	| 167.08MB/sec   |
|---------------|-----------------------|---------------|----------------|
|               |                       |               |                |
|               |                       |               |                |
|Execution time	|	56.8213s	| 57.3400s	| 59.8498s       |
--------------------------------------------------------------------------

--=-SSiwVza9CpMQKh0Uy+WR--

