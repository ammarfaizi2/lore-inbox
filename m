Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278441AbRJSPxZ>; Fri, 19 Oct 2001 11:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278524AbRJSPxS>; Fri, 19 Oct 2001 11:53:18 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:45096 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S278441AbRJSPxE>; Fri, 19 Oct 2001 11:53:04 -0400
Date: Fri, 19 Oct 2001 09:52:51 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Patch and Performance of larger pipes
Message-ID: <20011019095251.A10087@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
In-Reply-To: <3BCF1A74.AE96F241@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3BCF1A74.AE96F241@colorfullife.com>; from Manfred Spraul on Thu, Oct 18, 2001 at 08:07:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well we did for all the 3 benchmarks....

* Manfred Spraul <manfred@colorfullife.com> [20011018 14;07]:"
> Could you test the attached singlecopy patches?
> 
> with bw_pipe,
> * on UP, up to +100%.
> * on SMP with busy cpus, up to +100%
> * on SMP with idle cpus a performance drop due to increased cache
> trashing. Probably the scheduler should keep both bw_pipe processes on
> the same cpu.
> 
> I've sent patch-pgw to Linus for inclusion, since it's needed to fix the
> elf coredump deadlock.
> 
> patch-kiopipe must wait until 2.5, because it changes the behaviour of
> pipe_write with partial reads.
> 
> --
> 	Manfred

>    <<< Manfred's patch cout out >>>



Ok, at the request by Manfred Spraul we also ran his <single-copy>
patch. Manfred patch has applied over 2.4.13-pre13 and the results are compared 
over its base vanilla kernel. Our numbers still are %-improvements numbers
of patched 2.4.9 kernel vs. 2.4.9 vanilla.
Manfred's numbers are added as an additional column.

<< Bottom-line >>

Our patch does better for <Grep> and <Pipeflex> benchmark and
<LMBench> on low transfer sizes for large Pipe-Buffers. 
This is only relevant for SMP systems as we have enabled the patch
only for SMP.

Manfred's patch does better for <LMBench> and beats our patch across
configurations. But it lacks even vanilla for more realistic apps.
The same observation holds for UP.

We have not measured CPU utilization etc. 
As stated in my earlier message, bw_pipe doesn't have a lot of real
applicability, but I am willing to be re-educated here.

-- Hubertus

                         PIPE: Buffer Expansion
                         ----------------------

In this we will report on some experimentation to improve Linux pipe
performance. There are two basic parameters that govern the Linux pipe 
implementation. 
(a) PIPE_SIZE is the size of the pipe buffer. 
(b) PIPE_BUF is the maximum number of bytes an application 
    can write atomically to the pipe.

In the current implementation size of pipe buffer is PAGE_SIZE (most
architectures that is 4kB, and the PIPE_BUF is fixed to 4kB (and for
ARM=PAGE_SIZE).

We wanted to experiment with larger pipe buffer support and higher
concurrency of read and writes. Therefore we experimented with the
following items:

(A) expanding the pipe buffer size from 1 page to 2,4,8 pages.

(B) improving the pipe's concurrency of read and write by introducing 
   intermittent activation of pending readers/writers rather than at 
   the end of a pipe transaction (read/write). The PIPE_BUF 
   atomicity constraint is still observed. We therefore introduce 
   the term of a PIPE_SEG which is a multiple of the PAGE_SIZE and
   determines when to wake up pending readers and writers.

   Consider the pipe buffer size to be 32k. The space available to 
   write on the pipe is 32k and the data which is coming to be 
   written onto the pipe is also 32k. By keeping the segment size 
   as 4k, write the first 4k of the total 32k data instead of 
   writing the entire 32k data, and inform the reader process that 
   some data is there to be read, and the writer process proceeds 
   with the next 4k. By that time reader process starts reading 
   the available data. Intuitively this should create 
   more concurrency. 

Throughout this experimentation, we kept the PIPE_BUF (atomicity
guarantee) constant at 4kB.

Benchmarks
----------

The benchmarks we ran for measuring the performance of pipes are
LMBench, Grep, and Pipeflex. The description of these are below.
While LMBench is a widely used OS-Benchmark, we found that Grep and
Pipeflex model more real applications. All are descripted in more
detail below. All applications use different data transfer sizes
aka chunk sizes shown as TS. We report on the two aspects of our
implementation, i.e. larger pipes and intermittent activations
(PIPE_SEG) which is always 4k. All results are shown as % improvement
over the baseline kernel (2.4.9) and all these benchmarks are run on a
2-way Pentium II, 333Mhz machine.

                          Results Summary:
                          ================

UP + 1-way SMP:
---------------
Neither (A) nor (A)+(B) showed any improvements. Instead degradations 
of up to 30% are observed. Obviously our approach/patch does not 
make any sense on the 1-way systems.

N-way SMP:
----------

1. Increasing the pipe buffer size (A) increasingly improves the 
   performance of the Grep benchmark by upto 165% for size 32kB. 
   However, Grep does not show any added benefit nor
   degradation utilizing (A)+(B), i.e, expanding the pipe buffer
   size AND introducing the segment size=4kB.

2. For LMBench, (A) alone shows some improvements for small transfer
   sizes (TS<PIPE_SIZE). For TS>>PIPE_SIZE we observe degradation.
   Introducing (A)+(B) shows even better improvements for small TS
   with very small degradations for larger TS.

3. For pipeflex (A) provides increasing benefits with upto 358% 
   improvements, without any loss at the low end. When introducing 
   (A)+(B), the benefits drops but are still substantial.

Based on the results it is clear that expansion of PIPE_SIZE AND
PIPE_SEG introduction gives better performance for some scenarios. 


Grep
----

This benchmark measures the time taken to grep for some unexisting
pattern on a 50mb file.  ie. cat 50mbfile | grep "$$$$". We assume a
warm file cache.

LMBench
-------

LMBench provides a tool to measure the bandwidth of the pipe
(bw_pipe).  bw_pipe creates pipes between two processes and moves 10MB
through the pipe in 64KB chunks. We altered that code by providing the
chunk size as a variable input parameter.  ie. bw_pipe [2,4,...,32]

Pipeflex
--------

As LMBench does continuous read and write over the pipe in a
synchronous manner (which is not the case in real life), we studied
some test cases which uses pipes(grep, wc, sort, gunzip, ..), and
based on that we have written this pipeflex benchmark.

Here a write process writes smaller chunks continuously and the reader
process generates a number between [0.5*r .. 1.5*r] microseconds, and
spends that time for computation after each pipe reads.

A parent process clones 'c' child processes and 'c/2' pipes such that 
2 processes shares one pipe.
ie. pipeflex -c 2 -t 20 -r 500 -s 4

c : number of children/threads to launch (should be EVEN)
t : time for which each run of the test should be performed.
r : microseconds spend in computation after each pipe reads.
s : data to transfer over pipe in Kilo bytes.


Dynamically assigning values for PIPE_SIZE and PIPE_SEG
-------------------------------------------------------

In our current implementation, the size of PIPE_SIZE and PIPE_SEG can
be changed dynamically by writing the values into the newly created
/proc/sys/fs/pipe-sz file through a string having the following
format:

Po So

where Po is the Pipe size order
and So is the Segment size order.

Pipe size will be calculated as PIPE_SIZE = (1 << Po) * PAGE_SIZE.
Segment size will be calculated as (PIPE_SIZE >> So).

Similarly 'Po' and 'So' can be read through the same proc file.

* The notation we use in tables for PIPE_SIZE and PIPE_SEG are PS and
SS respectively and TS is the Transfer Size over pipe.

                2-way (% improvement) Results
                =============================

Grep
----

PS         (A)               (A)+(B)            Manfred
--         ---               -------            -------
4k        -0.87               -0.95              39.9
8k        50.84               50.12  
16k      107.97              115.86  
32k      165.25              164.14  


LMBench
-------
                (A)                             (A)+(B)                         
                ---                             -------                         

                PS                                PS                            
TS      4k      8k      16k     32k       4k      8k      16k     32k   Manfred
--      --      --      ---     ---       --      --      ---     ---   -------
2k     -0.3     3.26    4.25    3.83     -0.3     2.98    4.25    4.04  54.1
4k     -2.18   18.97   18.59   18.59     -2.18   18.59   18.59   18.59  21.0
6k      0.34   13.08   32.7    49.57      0.3    35.63   39.76   55.94  69.2
8k      0.14    3.02     0     -0.82     13.87   31.59   50.82   75.27  63.2
12k     0.34  -24.09  -18.74  -12.57      0.34    4.4   -14.86    8.23  38.3
16k     1.47   -8.88  -14.16  -16.03      1.4    14.42    9.48   13.86  37.5
24k     1.17  -13.9     1.65  -23.59      1.17    1.65   -2.72    1.2   31.2
32k     0.66  -14.77  -19.83  -25.63      0.66   -3.2    -6.59   -2.92  27.2
64k     x     x       x       x           x      x       x       x      22.84
128k    x     x       x       x           x      x       x       x      29.7


Pipeflex
--------

                (A)                             (A)+(B)
                ---                             -------

                PS                                 PS 
TS      4k      8k      16k     32k        4k      8k      16k     32k  Manfred
--      --      --      ---     ---        --      --      ---     ---
2k      0.00    0.00   -0.27   -0.27      0.00    -0.27   -0.27   -0.27 -24.1
4k      0.00    0.00    0.00    0.00      0.00     0.00    0.00    0.00 -42.0
6k      1.61   -1.82   11.46   10.28      1.61    -9.53    9.53    6.75 -10.86
8k     -2.00   46.20   46.31   46.31     -2.00   -11.08    7.17   23.73 -15.9
12k    -2.93   54.13   64.58   93.31     -2.93    51.62   46.08   84.22 -14.9
16k    -3.34   49.95  163.09  162.67     -3.34    51.82   45.57   85.92 -14.4
24k    -3.56   50.37  135.50  183.46     -3.56    49.95  134.97  144.40 -15.9
32k    -1.40   54.99  143.29  358.75     -1.40    55.75  142.32  147.37 -17.7
64k     x     x       x       x           x      x       x       x      -15.01
128k    x     x       x       x           x      x       x       x      -15.14


                1-way (% improvement) Results
                =============================

Grep     
----

PS         (A)               (A)+(B)    Manfred
--         ---               -------    -------
4k       -0.47               -0.47      -49.78
8k        1.9                -2.73  
16k      -2.73               -2.73  
32k       1.9                -2.73  



LMBench
-------
                (A)                             (A)+(B)
                ---                             -------

                PS                                PS  
TS      4k      8k      16k     32k       4k      8k      16k     32k   Manfred
--      --      --      ---     ---       --      --      ---     ---   -------
2k     0.49     4.42    -3.88  -10.13    0.49    11.02   -7.68  -12.06  5.91
4k    -0.5     -1.08   -22.17   -8.6    -0.5     -0.95  -18.65   -4.86  24.28
6k     3.73   -19.03   -24.23  -18.56    3.73   -15.85  -24.68  -12.44  55.17
8k     0.82   -33.43   -31.92  -30.19    0.82   -34.38  -25.41  -12.81  35.34
12k    1.39   -24.06   -30.67  -27.88    1.39   -24.43  -29.79  -27     20.39
16k   -0.87   -29.16   -31.27  -29.73   -0.87   -28.53  -31.97  -28.97  24.8
24k    0.16   -28.79   -31.87  -28.37    0.16   -28.16  -31.61  -28.66  32.72
32k    0.35   -28.91   -30.73  -27.23    0.35   -28.77  -31.6   -28.77  34.89
64k     x     x       x       x           x      x       x       x      38.7
128k    x     x       x       x           x      x       x       x      41.6

Pipeflex
--------

                (A)                             (A)+(B)
                ---                             -------

                PS                                 PS 
TS      4k      8k      16k     32k        4k      8k      16k     32k  Manfred
--      --      --      ---     ---        --      --      ---     ---  -------
2k    0.00   -0.54   -0.80   -1.07         0.00   -0.54   -0.80   -1.07 -23.66
4k   -0.14   -0.69   -1.80   -2.21        -0.14   -1.10   -1.80   -2.49 -41.97
6k   -0.19   -0.19   -2.41   -2.02        -0.19   -0.19   -2.12   -1.16 -22.09
8k   -0.30   -1.86   -6.41   -6.41        -0.30   -1.19   -3.80   -2.61 -39.97
12k  -0.33   -1.43   -4.56   -4.01        -0.33   -1.43   -3.84   -3.51 -55.71
16k  -0.18   -1.77   -4.47   -4.56        -0.18   -1.15   -4.78   -3.85 -64.37
24k  -0.37   -2.21   -6.94   -5.26        -0.37   -1.51   -6.07   -4.89 -72.98
32k  -0.42   -2.98   -7.12   -5.18        -0.42   -1.75   -7.06   -5.77 -77.19
64k     x     x       x       x           x      x       x       x      -82.57
128k    x     x       x       x           x      x       x       x      -84.91

                UP (% improvement) Results
                ==========================

Grep     
----

PS         (A)               (A)+(B)    Manfred
--         ---               -------    -------                         
4k        -0.53               1.61      -53.49
8k        -2.58              -1.56
16k       -4.55              -4.06
32k       -3.08              -4.06


LMBench
-------
                (A)                             (A)+(B)
                ---                             -------

                PS                                 PS 
TS      4k      8k      16k     32k        4k      8k      16k     32k  Manfred
--      --      --      ---     ---        --      --      ---     ---  -------
2k      7.38     1.17  -15.28  -18.07     4.18   -0.36  -14.32  -20.55  16.35
4k     -1.73    -0.5   -31.7   -26.94    -1.21    5.61  -21.75  -5.17   20.58
6k     -0.3    -22.33  -26.78  -23.36    -0.9   -17.31  -29.61  -19.5   73.06
8k      7.8    -35     -33.75  -30.65     1.71  -37.11  -29.45  -18.03  30.43
12k    -1.09   -25.99  -36.7   -35.77     0.13  -27.76  -35.56  -34.21  13.78
16k     0.08   -31.39  -35.37  -34.28     1.2   -30.93  -36.18  -34.18  17.47
24k     0.42   -32.06  -36.15  -34.65     0.63  -32.28  -36.82  -34.98  22.03
32k     0.82   -31.52  -35.71  -33.41     1.8   -32.11  -36.49  -34.52  24.87
64k     x     x       x       x           x      x       x       x      26.66
128k    x     x       x       x           x      x       x       x      41.27
    

Pipeflex
--------

                (A)                             (A)+(B)
                ---                             -------

                PS                                 PS 
TS      4k      8k      16k     32k        4k      8k      16k     32k  Manfred
--      --      --      ---     ---        --      --      ---     ---  -------
2k    -0.27   -0.27   -0.80   -1.06      -0.27   -0.27   -0.80   -1.06  -24.4
4k    -0.27   -0.68   -1.77   -2.31      -0.14   -0.54   -1.63   -2.18  -42.3
6k    -0.66   -0.94   -3.85   -3.94      -0.47   -0.66   -2.63   -1.97  -22.9
8k    -0.58   -1.96   -6.88   -6.88      -0.58   -1.30   -4.49   -3.48  -40.5
12k   -1.00   -2.16   -5.59   -5.59      -0.84   -1.79   -4.75   -4.54  -56.7
16k   -1.22   -2.40   -6.02   -6.18      -1.14   -2.10   -6.06   -5.34  -65.4
24k   -1.50   -3.41   -8.68   -7.23      -1.72   -2.76   -7.89   -7.11  -74.3
32k   -1.92   -4.44   -9.27   -7.94      -1.79   -3.43   -9.45   -8.41  -78.5
64k     x     x       x       x           x      x       x       x      -85.16
128k    x     x       x       x           x      x       x	 x	-87.66



diff -urN linux-2.4.9-v/fs/pipe.c linux-2.4.9-pipe-new/fs/pipe.c
--- linux-2.4.9-v/fs/pipe.c	Sun Aug 12 21:58:52 2001
+++ linux-2.4.9-pipe-new/fs/pipe.c	Tue Oct  9 10:48:15 2001
@@ -23,6 +23,14 @@
  * -- Julian Bradfield 1999-06-07.
  */
 
+#ifdef CONFIG_SMP 
+#define IS_SMP (1)
+#else 
+#define IS_SMP (0)
+#endif
+
+struct pipe_stat_t pipe_stat;
+
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode)
 {
@@ -85,30 +93,40 @@
 
 	/* Read what data is available.  */
 	ret = -EFAULT;
-	while (count > 0 && (size = PIPE_LEN(*inode))) {
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
-		ssize_t chars = PIPE_MAX_RCHUNK(*inode);
-
-		if (chars > count)
-			chars = count;
-		if (chars > size)
-			chars = size;
-
-		if (copy_to_user(buf, pipebuf, chars))
-			goto out;
+	if (count > 0 && (size = PIPE_LEN(*inode))) {
+		do {
+			char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
+			ssize_t chars = PIPE_MAX_RCHUNK(*inode);
+			
+			if (chars > count)
+				chars = count;
+			if (chars > size)
+				chars = size;
+			if (IS_SMP && PIPE_ORDER(*inode) && (chars > PIPE_SEG(*inode))) 
+				chars = PIPE_SEG(*inode);
+			
+			if (copy_to_user(buf, pipebuf, chars))
+				goto out;
 
-		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
-		count -= chars;
-		buf += chars;
+			read += chars;
+			PIPE_START(*inode) += chars;
+			PIPE_START(*inode) &= (PIPE_SIZE(*inode) - 1);
+			PIPE_LEN(*inode) -= chars;
+			count -= chars;
+			buf += chars;
+               		if ((count <= 0) || (!(size = PIPE_LEN(*inode))))
+	                       	break;
+        	      	if (IS_SMP && PIPE_ORDER(*inode) && PIPE_WAITING_WRITERS(*inode) && 
+			    !(filp->f_flags & O_NONBLOCK)) 
+                       		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			
+            	} while(1);
 	}
 
 	/* Cache behaviour optimization */
 	if (!PIPE_LEN(*inode))
 		PIPE_START(*inode) = 0;
-
+	
 	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
 		/*
 		 * We know that we are going to sleep: signal
@@ -187,10 +205,15 @@
 		ssize_t chars = PIPE_MAX_WCHUNK(*inode);
 
 		if ((space = PIPE_FREE(*inode)) != 0) {
+			pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
+			chars = PIPE_MAX_WCHUNK(*inode);
+
 			if (chars > count)
 				chars = count;
 			if (chars > space)
 				chars = space;
+			if (IS_SMP && PIPE_ORDER(*inode) && (chars > PIPE_SEG(*inode)))
+				chars = PIPE_SEG(*inode);
 
 			if (copy_from_user(pipebuf, buf, chars))
 				goto out;
@@ -200,6 +223,9 @@
 			count -= chars;
 			buf += chars;
 			space = PIPE_FREE(*inode);
+   			if (IS_SMP && PIPE_ORDER(*inode) && (count > 0) && space &&
+			    PIPE_WAITING_READERS(*inode) && !(filp->f_flags & O_NONBLOCK))
+                                wake_up_interruptible_sync(PIPE_WAIT(*inode));
 			continue;
 		}
 
@@ -231,14 +257,14 @@
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 
-out:
+ out:
 	up(PIPE_SEM(*inode));
-out_nolock:
+ out_nolock:
 	if (written)
 		ret = written;
 	return ret;
 
-sigpipe:
+ sigpipe:
 	if (written)
 		goto out;
 	up(PIPE_SEM(*inode));
@@ -309,7 +335,7 @@
 	if (!PIPE_READERS(*inode) && !PIPE_WRITERS(*inode)) {
 		struct pipe_inode_info *info = inode->i_pipe;
 		inode->i_pipe = NULL;
-		free_page((unsigned long) info->base);
+		free_pages((unsigned long) info->base, info->order);
 		kfree(info);
 	} else {
 		wake_up_interruptible(PIPE_WAIT(*inode));
@@ -443,8 +469,12 @@
 struct inode* pipe_new(struct inode* inode)
 {
 	unsigned long page;
+	int pipe_order = pipe_stat.pipe_size_order;
+
+	if (pipe_order > MAX_PIPE_ORDER)
+		pipe_order = MAX_PIPE_ORDER;
 
-	page = __get_free_page(GFP_USER);
+	page = __get_free_pages(GFP_USER, pipe_order);
 	if (!page)
 		return NULL;
 
@@ -458,10 +488,11 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+	PIPE_ORDER(*inode) = pipe_order;
 
 	return inode;
-fail_page:
-	free_page(page);
+ fail_page:
+	free_pages(page, pipe_order);
 	return NULL;
 }
 
@@ -477,12 +508,12 @@
 static struct inode * get_pipe_inode(void)
 {
 	struct inode *inode = get_empty_inode();
-
 	if (!inode)
 		goto fail_inode;
 
 	if(!pipe_new(inode))
 		goto fail_iput;
+
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 1;
 	inode->i_fop = &rdwr_pipe_fops;
 	inode->i_sb = pipe_mnt->mnt_sb;
@@ -501,9 +532,9 @@
 	inode->i_blksize = PAGE_SIZE;
 	return inode;
 
-fail_iput:
+ fail_iput:
 	iput(inode);
-fail_inode:
+ fail_inode:
 	return NULL;
 }
 
@@ -572,20 +603,20 @@
 	fd[1] = j;
 	return 0;
 
-close_f12_inode_i_j:
+ close_f12_inode_i_j:
 	put_unused_fd(j);
-close_f12_inode_i:
+ close_f12_inode_i:
 	put_unused_fd(i);
-close_f12_inode:
-	free_page((unsigned long) PIPE_BASE(*inode));
+ close_f12_inode:
+	free_pages((unsigned long) PIPE_BASE(*inode), PIPE_ORDER(*inode));
 	kfree(inode->i_pipe);
 	inode->i_pipe = NULL;
 	iput(inode);
-close_f12:
+ close_f12:
 	put_filp(f2);
-close_f1:
+ close_f1:
 	put_filp(f1);
-no_files:
+ no_files:
 	return error;	
 }
 
@@ -631,7 +662,7 @@
 }
 
 static DECLARE_FSTYPE(pipe_fs_type, "pipefs", pipefs_read_super,
-	FS_NOMOUNT|FS_SINGLE);
+		      FS_NOMOUNT|FS_SINGLE);
 
 static int __init init_pipe_fs(void)
 {
diff -urN linux-2.4.9-v/include/linux/pipe_fs_i.h linux-2.4.9-pipe-new/include/linux/pipe_fs_i.h
--- linux-2.4.9-v/include/linux/pipe_fs_i.h	Wed Apr 25 17:18:23 2001
+++ linux-2.4.9-pipe-new/include/linux/pipe_fs_i.h	Tue Oct  9 09:35:35 2001
@@ -2,6 +2,8 @@
 #define _LINUX_PIPE_FS_I_H
 
 #define PIPEFS_MAGIC 0x50495045
+#define MAX_PIPE_ORDER	3
+
 struct pipe_inode_info {
 	wait_queue_head_t wait;
 	char *base;
@@ -13,12 +15,20 @@
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
+	unsigned int order;
+};
+
+struct pipe_stat_t{
+	int pipe_size_order;
+	int pipe_seg_order;
 };
+extern struct pipe_stat_t pipe_stat;
 
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
    memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
-#define PIPE_SIZE		PAGE_SIZE
+#define PIPE_SIZE(inode)	((1 << PIPE_ORDER(inode)) * PAGE_SIZE)
 
+#define PIPE_ORDER(inode)	((inode).i_pipe->order)
 #define PIPE_SEM(inode)		(&(inode).i_sem)
 #define PIPE_WAIT(inode)	(&(inode).i_pipe->wait)
 #define PIPE_BASE(inode)	((inode).i_pipe->base)
@@ -32,12 +42,13 @@
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
 
 #define PIPE_EMPTY(inode)	(PIPE_LEN(inode) == 0)
-#define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)
-#define PIPE_FREE(inode)	(PIPE_SIZE - PIPE_LEN(inode))
-#define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & (PIPE_SIZE-1))
-#define PIPE_MAX_RCHUNK(inode)	(PIPE_SIZE - PIPE_START(inode))
-#define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE - PIPE_END(inode))
-
+#define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE(inode))
+#define PIPE_FREE(inode)	(PIPE_SIZE(inode) - PIPE_LEN(inode))
+#define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & (PIPE_SIZE(inode)-1))
+#define PIPE_MAX_RCHUNK(inode)	(PIPE_SIZE(inode) - PIPE_START(inode))
+#define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE(inode) - PIPE_END(inode))
+#define PIPE_SEG(inode)		((PIPE_ORDER(inode) > pipe_stat.pipe_seg_order) ? \
+				(PIPE_SIZE(inode) >> pipe_stat.pipe_seg_order): PAGE_SIZE)
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode);
 
diff -urN linux-2.4.9-v/include/linux/sysctl.h linux-2.4.9-pipe-new/include/linux/sysctl.h
--- linux-2.4.9-v/include/linux/sysctl.h	Wed Aug 15 17:21:21 2001
+++ linux-2.4.9-pipe-new/include/linux/sysctl.h	Tue Oct  9 10:12:48 2001
@@ -533,6 +533,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
+	FS_PIPE_SIZE=16,	/* int: current number of allocated pages for PIPE */
 };
 
 /* CTL_DEBUG names: */
diff -urN linux-2.4.9-v/kernel/sysctl.c linux-2.4.9-pipe-new/kernel/sysctl.c
--- linux-2.4.9-v/kernel/sysctl.c	Thu Aug  9 19:41:36 2001
+++ linux-2.4.9-pipe-new/kernel/sysctl.c	Mon Oct  8 13:19:46 2001
@@ -304,6 +304,8 @@
 	 sizeof(int), 0644, NULL, &proc_dointvec},
 	{FS_LEASE_TIME, "lease-break-time", &lease_break_time, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{FS_PIPE_SIZE, "pipe-sz", &pipe_stat, 2*sizeof(int),
+	 0644, NULL, &proc_dointvec},
 	{0}
 };
 
