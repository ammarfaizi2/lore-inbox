Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289911AbSAORTH>; Tue, 15 Jan 2002 12:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSAORSr>; Tue, 15 Jan 2002 12:18:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47829 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289911AbSAORSb>;
	Tue, 15 Jan 2002 12:18:31 -0500
Message-ID: <011001c19de8$ec1d4800$1cdb0209@diz.watson.ibm.com>
Reply-To: "Hubertus Franke" <frankeh@watson.ibm.com>
From: "Hubertus Franke" <frankeh@watson.ibm.com>
To: "Manfred Spraul" <manfred@colorfullife.com>,
        <linux-kernel@vger.kernel.org>
Cc: <lse-tech@lists.sourceforge.net>
In-Reply-To: <002701c19638$400f15f0$010411ac@local>
Subject: Re: [Lse-tech] zerocopy pipe, new version
Date: Tue, 15 Jan 2002 12:20:25 -0500
Organization: IBM Research
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <linux-kernel@vger.kernel.org>
Cc: <lse-tech@lists.sourceforge.net>
Sent: Saturday, January 05, 2002 5:27 PM
Subject: [Lse-tech] zerocopy pipe, new version


> Attached is a new version of the zerocopy pipe code.
>
> A few months ago, Hubertus Franke found a severe performance problem with
my last
> version. Now I figured out how I can solve it:
> For good pipe performance, sys_read() must try to return as much data as
possible with
> one syscall, even if the writer writes small bits. The current code uses
> PIPE_WAITING_WRITERS, but that doesn't work with nonblocking IO and is not
that
> efficient.
>
> I added a sched_yield() into that path, and that fixed the performance
degradation:
> if pipe_read made progress and the user wants even more data, then call
sched_yield() and
> give the writers a chance to write additional data. After sched_yield()
returns, try again until
> there is either no more data, or the user request is completely
fullfilled. Then return to userspace.
>
> Now I got +50% on UP with pipeflex -c2 -r32 -w1 with 2.5.2-pre8+zerocopy,
SMP kernel
> over 2.4.2-UP.
>
> Unfortunately the patch has virtually no effect on 4 kB write-4 kB read,
and that's the most
> common case. (number of context switches cut in half, but a slight
performance loss on K6,
> probably due to cache trashing)
>
> The only solution I see for that problem are larger kernel buffers - more
data must be queued
> in kernel. Either on-demand (kmalloc() up to <sysctl-limit, around 512 kB>
if a request for
> <= 4096 bytes arrives and would block. If the allocation fails, then
block), or at pipe creation
> like in Hubertus' patch.
>
> --
>     Manfred
>

We can only echo Manfred's recent finding and improvements to
the zerocopy  patch he has submitted. Looks like a winner to us.
As you might recall we had worked from the other end namely
larger pipe buffers and a below we show that a combination of zero-copy
and large pipe can basically deal with all the performance issues.

We show the performance gain/loss for various benchmarks on
2-way, 1-way and UP systems.

For this test we added our new large pipe patch over Manfred Spraul's
Zero copy patch and all these test were ran on 2.4.17 kernel.

Here are our initial results which shows the performance improvement of
large pipe buffer + zero copy over 2.4.17 vanilla kernel. The pipe size
we used for this testing was 32K (ie. 8 pages).

Grep over 50mb file
-------------------

        2-way   1-way    UP
        -----   -----    --
%imp    206.76  8.02    -1.55


LMBench
-------
                %imp
TS      2-way   1-way      UP
--      -----   -----      --
2k     102.61   -5.22    -7.25
4k     136       4.01    -5.02
6k      95.98  -22.15   -26.67
8k      29.75  -31.84   -44.23
12k      5.99  -14.09   -23.41
16k      8.49  -13.21   -22.19
24k     -0.92   -3.11   -15.39
32k      3.11   -3.14   -14.75
64k     26.55    0.99    25.76
128k    22.69   55.72    -7.43

Pipeflex -c2 -t 20 -x 500 -y 0 -r #TS -w 1 -o 0 -m 0
--------
                %imp
TS      2-way   1-way    UP
--      -----   -----    --
2k      1.6     1.07     0.27
4k      0.14    0       -0.41
6k      21.08   0.29    -1.21
8k      15.01  -1.25    -3.07
12k     12.1   -3.81    -5.66
16k     27.02  -4.29    -5.8
24k     48.34  -4.86    -7.47
32k     27.89  -6.34    -8.24
64k     34.74  -6.67   -11.53
128k    58.23   2.09    -2.79


Here are the results of % improvement of Large Pipe(32k) + Zero copy over
Zero copy.


Grep over 50mb file
-------------------

        2-way   1-way   UP
        -----   -----   --

%imp    96.62   -3.77   -4.64


LMBench
-------

TS      2-way    1-way   UP
--      -----    -----   --
2k      26.3    -20.19   -8.54
4k      26.98   -20.56  -29.92
6k      11.69   -47.83  -58.35
8k      -5.26   -53.8   -65.39
12k    -22.11   -28.19  -32.76
16k    -22.62   -30.1   -34.15
24k    -18.88   -27.02  -29.29
32k    -20.44   -28.92  -29.95
64k     -1.38   -29.75    1.92
128k     7.3     -2.02  -18.49


Pipeflex -c2 -t 20 -x 500 -y 0 -r #TS -w 1 -o 0 -m 0
----------------------------------------------------

TS      2-way    1-way    UP
--      -----    -----    --
2k       1.33    0.27    -0.53
4k       6.1     0.14    -0.54
6k      15.38   -0.47    -1.66
8k      22.69   -1.4     -3
12k     24.1    -3.25    -4.98
16k     25.49   -3.88    -5.96
24k     41.48   -5.22    -8.19
32k     21.84   -5.52    -9.04
64k     35.35   -8.32   -14.06
128k    42.8    -8.78   -16.16

Here are the results which shows the % improvement (degradation)
of large pipe when added to the zero copy patch. For that
we set the pipe size to the default 4k.


Grep
----
                2-way   1-way   UP
                -----   -----   --
%overhead       -0.73   -0.97   0


LMBench
-------
           % overhead
TS      2-way    1-way   UP
--      -----    -----   --
2k      -9.59   13.51    1.75
4k       5.5    -1.22  -10.11
6k      -2.44    3.93   -2.92
8k      -1.61    0.51   -0.92
12k     -1.74    0.71   -0.85
16k     -0.04    0.44   -0.46
24k     -0.15    0.37    0.05
32k     -0.39   -0.02   -0.14
64k     -0.8    -1.05    1.52
128k     1.94   -7.46   -2.96


Pipeflex -c2 -t 20 -x 500 -y 0 -r #TS -w 1 -o 0 -m 0
--------

                % overhead
TS      2-way   1-way    UP
--      -----   ----     --
2k      -0.27    0.27   -0.26
4k       1.45    0      -0.14
6k       2.35   -0.09   -0.09
8k       7.96   -0.37   -0.14
12k     13.89    0.37    0.05
16k     17.66   -1.96    0
24k     12.41   -0.92   -0.66
32k     16.12   -0.11   -0.64
64k     32.97   -0.35   -0.64
128k    67.87   -0.25   -0.89


Conclusion
----------
Manfred Spraul's new zero copy patch showed a very good performance
improvement for pipeflex as well as grep on both 2-way and 1-way.
By adding our large pipe support, performance improvement up to
42% for pipeflex and 96% for grep benchmarks on 2-way systems.
No significant different has been observed for lmbench on 1-way systems.
The right way to configure the system than would be for UP and 1-way to
set the buffer size by default to 4K while for the SMP larger pipe buffers
should be encouraged.
Below is the large pipe patch which has to be applied over manfred's
latest zero copy patch.



diff -urbN linux-2.4.17-manfred-up/fs/pipe.c linux-2.4.17-pipe-up/fs/pipe.c
--- linux-2.4.17-manfred-up/fs/pipe.c   Mon Jan  7 15:54:00 2002
+++ linux-2.4.17-pipe-up/fs/pipe.c      Thu Jan 10 11:23:05 2002
@@ -28,6 +28,8 @@
  * -- Julian Bradfield 1999-06-07.
  */

+struct pipe_stat_t pipe_stat;
+
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode)
 {
@@ -158,7 +160,7 @@
                 * case. Write into the internal buffer before
                 * checking for signals/error conditions.
                 */
-               size_t j = min((size_t)PIPE_SIZE, pio->len);
+               size_t j = min((size_t)PIPE_SIZE(*inode), pio->len);
                if (PIPE_LEN(*inode)) BUG();
                if (PIPE_START(*inode)) BUG();
                if (!copy_from_user(PIPE_BASE(*inode), buf + i, j)) {
@@ -201,8 +203,8 @@
                        int offset = PIPE_START(*inode)%PIPE_BUF;
                        if (chars > count)
                                chars = count;
-                       if (chars > PIPE_SIZE-offset)
-                               chars = PIPE_SIZE-offset;
+                       if (chars > PIPE_SIZE(*inode)-offset)
+                               chars = PIPE_SIZE(*inode)-offset;
                        if (unlikely(copy_to_user(buf, pipebuf+offset,
chars))) {
                                if (!read)
                                        read = -EFAULT;
@@ -326,11 +328,11 @@
                if (PIPE_PIOLEN(*inode))
                        goto skip_int_buf;
                /* write to internal buffer - could be cyclic */
-               while(start = PIPE_LEN(*inode),chars = PIPE_SIZE - start,
chars >= min) {
+               while(start = PIPE_LEN(*inode),chars = PIPE_SIZE(*inode) -
start, chars >= min) {
                        start += PIPE_START(*inode);
-                       start %= PIPE_SIZE;
-                       if (chars > PIPE_BUF - start)
-                               chars = PIPE_BUF - start;
+                       start %= PIPE_SIZE(*inode);
+                       if (chars > PIPE_SIZE(*inode) - start)
+                               chars = PIPE_SIZE(*inode) - start;
                        if (chars > count)
                                chars = count;
                        if (unlikely(copy_from_user(PIPE_BASE(*inode)+start,
@@ -470,7 +472,7 @@
        if (!PIPE_READERS(*inode) && !PIPE_WRITERS(*inode)) {
                struct pipe_inode_info *info = inode->i_pipe;
                inode->i_pipe = NULL;
-               free_page((unsigned long) info->base);
+               free_pages((unsigned long) info->base, info->order);
                kfree(info);
        } else {
                wake_up_interruptible(PIPE_WAIT(*inode));
@@ -604,8 +606,12 @@
 struct inode* pipe_new(struct inode* inode)
 {
        unsigned long page;
+        int pipe_order = pipe_stat.pipe_size_order;
+
+        if (pipe_order > MAX_PIPE_ORDER)
+                pipe_order = MAX_PIPE_ORDER;

-       page = __get_free_page(GFP_USER);
+       page = __get_free_pages(GFP_USER, pipe_order);
        if (!page)
                return NULL;

@@ -619,10 +625,11 @@
        PIPE_START(*inode) = PIPE_LEN(*inode) = PIPE_PIOLEN(*inode) = 0;
        PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
        PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+       PIPE_ORDER(*inode) = pipe_order;

        return inode;
 fail_page:
-       free_page(page);
+       free_pages(page, pipe_order);
        return NULL;
 }

@@ -737,7 +744,7 @@
 close_f12_inode_i:
        put_unused_fd(i);
 close_f12_inode:
-       free_page((unsigned long) PIPE_BASE(*inode));
+       free_pages((unsigned long) PIPE_BASE(*inode), PIPE_ORDER(*inode));
        kfree(inode->i_pipe);
        inode->i_pipe = NULL;
        iput(inode);
diff -urbN linux-2.4.17-manfred-up/include/linux/pipe_fs_i.h
linux-2.4.17-pipe-up/include/linux/pipe_fs_i.h
--- linux-2.4.17-manfred-up/include/linux/pipe_fs_i.h   Mon Jan  7 15:54:00
2002
+++ linux-2.4.17-pipe-up/include/linux/pipe_fs_i.h      Tue Jan  8 13:42:18
2002
@@ -2,6 +2,7 @@
 #define _LINUX_PIPE_FS_I_H

 #define PIPEFS_MAGIC 0x50495045
+#define MAX_PIPE_ORDER 3
 struct pipe_inode_info {
        wait_queue_head_t wait;
        char *base;
@@ -13,12 +14,21 @@
        unsigned int writers;
        unsigned int r_counter;
        unsigned int w_counter;
+       unsigned int order;
 };

+struct pipe_stat_t{
+        int pipe_size_order;
+        int pipe_seg_order;
+};
+
+extern struct pipe_stat_t pipe_stat;
+
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
    memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
-#define PIPE_SIZE              PAGE_SIZE
+#define PIPE_SIZE(inode)       ((1 << PIPE_ORDER(inode)) * PAGE_SIZE)

+#define PIPE_ORDER(inode)      ((inode).i_pipe->order)
 #define PIPE_SEM(inode)                (&(inode).i_sem)
 #define PIPE_WAIT(inode)       (&(inode).i_pipe->wait)
 #define PIPE_BASE(inode)       ((inode).i_pipe->base)
@@ -31,8 +41,8 @@
 #define PIPE_RCOUNTER(inode)   ((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)   ((inode).i_pipe->w_counter)

-#define PIPE_FREE(inode)       (PIPE_SIZE - PIPE_LEN(inode))
-#define PIPE_END(inode)        ((PIPE_START(inode) + PIPE_LEN(inode)) &
(PIPE_SIZE-1))
+#define PIPE_FREE(inode)       (PIPE_SIZE(inode) - PIPE_LEN(inode))
+#define PIPE_END(inode)        ((PIPE_START(inode) + PIPE_LEN(inode)) &
(PIPE_SIZE(inode)-1))

 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode);
diff -urbN linux-2.4.17-manfred-up/include/linux/sysctl.h
linux-2.4.17-pipe-up/include/linux/sysctl.h
--- linux-2.4.17-manfred-up/include/linux/sysctl.h      Tue Jan  8 16:16:55
2002
+++ linux-2.4.17-pipe-up/include/linux/sysctl.h Tue Jan  8 16:04:01 2002
@@ -543,6 +543,7 @@
        FS_LEASES=13,   /* int: leases enabled */
        FS_DIR_NOTIFY=14,       /* int: directory notification enabled */
        FS_LEASE_TIME=15,       /* int: maximum time to wait for a lease
break */
+        FS_PIPE_SIZE=16,        /* int: number of pages allocated for PIPE
*/
 };

 /* CTL_DEBUG names: */
diff -urbN linux-2.4.17-manfred-up/kernel/sysctl.c
linux-2.4.17-pipe-up/kernel/sysctl.c
--- linux-2.4.17-manfred-up/kernel/sysctl.c     Fri Dec 21 12:42:04 2001
+++ linux-2.4.17-pipe-up/kernel/sysctl.c        Tue Jan  8 13:42:20 2002
@@ -307,6 +307,8 @@
         sizeof(int), 0644, NULL, &proc_dointvec},
        {FS_LEASE_TIME, "lease-break-time", &lease_break_time, sizeof(int),
         0644, NULL, &proc_dointvec},
+        {FS_PIPE_SIZE, "pipe-sz", &pipe_stat, 2*sizeof(int),
+         0644, NULL, &proc_dointvec},
        {0}
 };



