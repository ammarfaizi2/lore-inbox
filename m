Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278924AbRJ2ArP>; Sun, 28 Oct 2001 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278926AbRJ2ArF>; Sun, 28 Oct 2001 19:47:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278924AbRJ2Aqr>; Sun, 28 Oct 2001 19:46:47 -0500
Date: Mon, 29 Oct 2001 01:47:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)
Message-ID: <20011029014715.J1396@athlon.random>
In-Reply-To: <20011028120721.A286@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011028120721.A286@earthlink.net>; from rwhron@earthlink.net on Sun, Oct 28, 2001 at 12:07:21PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 12:07:21PM -0500, rwhron@earthlink.net wrote:
> 
> Summary:	2.4.14pre3aa2 gave oom errors not seen in 2.4.14pre3aa1.
> 
> Test:	Usual scripts to execute mtest01 and mmap001.  
> 	Listen to long mp3 with mp3blaster.
> 
> mtest01 -p 80 -w
> ================
> 
> 2.4.14pre3aa1
> 
> Averages for 10 mtest01 runs
> bytes allocated:                    1246232576
> User time (seconds):                2.105
> System time (seconds):              2.773
> Elapsed (wall clock) time:          59.503
> Percent of CPU this job got:        7.80
> Major (requiring I/O) page faults:  132.8
> Minor (reclaiming a frame) faults:  305043.1
> 
> 2.4.14pre3aa2
> 
> Averages for 10 mtest01 runs
> bytes allocated:                    1254201753
> User time (seconds):                2.211
> System time (seconds):              2.794
> Elapsed (wall clock) time:          65.176
> Percent of CPU this job got:        7.20
> Major (requiring I/O) page faults:  129.7
> Minor (reclaiming a frame) faults:  306988.9

I'm looking into optimizing this test. While it probably doesn't affect
the above numbers given the bytes allocated are quite similar, the
benchmark is not reliable, if you want to use it as benchmark you should
apply this patch first to make sure to compare apples to apples (not to
oranges). For example, without those fixes it allocates only 20mbytese
of ram here so it cannot swapout despite I use -p 80, because it
considers only the freeswap and freememory but on any real load all the
free memory will be allocated in cache most of the time.

the bench in short measure how fast we can push stuff to disk (just the
swapout, no the swapins).

Index: mtest01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/mem/mtest01/mtest01.c,v
retrieving revision 1.1
diff -u -r1.1 mtest01.c
--- mtest01.c	2001/08/27 22:15:12	1.1
+++ mtest01.c	2001/10/29 00:32:08
@@ -69,24 +69,9 @@
   }
 
   if(maxpercent) {
-    unsigned long int D, C;
     sysinfo(&sstats);
-    maxbytes = ((float)maxpercent/100)*(sstats.totalram+sstats.totalswap) - ((sstats.totalram+sstats.totalswap)-(sstats.freeram+sstats.freeswap));
-    /* Total memory needed to reach maxpercent */
-    D = ((float)maxpercent/100)*(sstats.totalram+sstats.totalswap);
-
-    /* Total memory already used */
-    C = (sstats.totalram+sstats.totalswap)-(sstats.freeram+sstats.freeswap);
-
-    /* Are we already using more than maxpercent? */
-    if(C>D) {
-      printf("More memory than the maximum amount you specified is already being used\n");
-      exit(1);
-    }
-
-    /* set maxbytes to the extra amount we want to allocate */
-    maxbytes = D-C;
-    printf("Filling up %d%%  of ram which is %lud bytes\n",maxpercent,maxbytes);
+    maxbytes = ((float)maxpercent/100)*(sstats.totalram+sstats.totalswap);
+    printf("Filling up %d of ram which is %lu bytes\n",maxpercent,maxbytes);
   }
 
   bytecount=chunksize;


For the mmap001 failures, they're due the max_mapped logic (the one that
was supposed to improve the swapout), I break the loop but I don't
consider I didn't scanned all the nr_inactive/vm_scan_ratio. they
triggers only with mmap001 because with mmap001 the lru gets filled by
mapped pages.

thanks for the feedback,

Andrea
