Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSH1DDY>; Tue, 27 Aug 2002 23:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSH1DDX>; Tue, 27 Aug 2002 23:03:23 -0400
Received: from holomorphy.com ([66.224.33.161]:25256 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318638AbSH1DDU>;
	Tue, 27 Aug 2002 23:03:20 -0400
Date: Tue, 27 Aug 2002 20:05:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: softirq.c BUG's out
Message-ID: <20020828030517.GA4926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to run tiobench on 2.5.32 on my machine, and got this:

Program received signal SIGTRAP, Trace/breakpoint trap.
tasklet_hi_action (a=0xc032fd60) at softirq.c:230
230     softirq.c: No such file or directory.
        in softirq.c
(gdb) bt
#0  tasklet_hi_action (a=0xc032fd60) at softirq.c:230
#1  0xc011f3b2 in do_softirq () at softirq.c:89
#2  0xc0109bee in do_IRQ (regs=
      {ebx = -1070398784, ecx = -463010764, edx = -511893504, esi = -608242656,
edi = -768991232, ebp = -511885904, eax = -1026729084, xds = 104, xes = -5119015
92, orig_eax = -256, eip = -1072436501, xcs = 96, eflags = 582, esp = -144631436
, xss = -608242656}) at irq.c:392
#3  0xc0108224 in common_interrupt () at process.c:982
#4  0xc013e999 in blk_queue_bounce (q=0xf790501c, bio_orig=0xe17d3e2c)
    at /mnt/b/2.5.32/linux-2.5.32/include/asm/highmem.h:61
#5  0xc01db7f8 in __make_request (q=0xf790501c, bio=0xdbbef420)
    at ll_rw_blk.c:1481
#6  0xc01dbd2f in generic_make_request (bio=0xdbbef420) at ll_rw_blk.c:1714
#7  0xc01dbdac in submit_bio (rw=1, bio=0xdbbef420) at ll_rw_blk.c:1760
#8  0xc01605d1 in mpage_bio_submit (rw=1, bio=0xdbbef420) at mpage.c:83
#9  0xc0160f54 in mpage_writepages (mapping=0xf71c39fc, nr_to_write=0x0,
    get_block=0xc0173090 <ext2_get_block>) at mpage.c:434
#10 0xc01734f0 in ext2_writepages (mapping=0xf71c39fc, nr_to_write=0x0)
    at inode.c:636
#11 0xc014060a in do_writepages (mapping=0xf71c39fc, nr_to_write=0x0)
    at page-writeback.c:367
#12 0xc012f82a in filemap_fdatawrite (mapping=0xf71c39fc) at filemap.c:484
#13 0xc0144935 in sys_fsync (fd=52) at buffer.c:311
#14 0xc01078df in syscall_call () at process.c:982

Following some suggestions from akpm (save/restore flags and check the
bit before fiddling with the list below), and taking a small bit of
initiative of my own (removing the BUG check entirely and just assuming
someone else handled it -- AFAICT it's legitimate for this happen) I got
the following results instead of oopsing for the first time on 2.5 ever:


tiobench on disk 1:
Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256   20.79 283.4%    22.998   111635.79   0.16956  0.02403     7

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256   18.66 346.9%     0.620      137.95   0.00000  0.00000     5

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    3.76 52.42%    53.414   490850.36   0.17262  0.04263     7

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    0.07 15.58%   200.620    58083.14   3.67188  0.07812     0


tiobench on disk 2:
Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256   34.08 391.4%    14.576    74595.64   0.07753  0.02327     9

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    4.41 40.39%     0.272        6.19   0.00000  0.00000    11

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    3.24 39.10%    78.737   538753.18   0.08297  0.06924     8

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    0.15 24.27%    44.161     4504.39   1.01562  0.00000     1


tiobench on disk 3:
Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256   66.00 1023.%     9.294    25761.69   0.15011  0.01125     6

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    2.38 28.99%     0.655      477.21   0.00000  0.00000     8

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    3.67 58.33%     7.929    25735.00   0.08078  0.00038     6

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    0.09 14.44%    66.025    21296.61   1.38021  0.02604     1


tiobench on disk 4:
Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256   28.86 297.1%    18.640   104797.43   0.11721  0.02508    10

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256   77.29 1243.%     0.390       12.12   0.00000  0.00000     6

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    3.34 37.64%    82.880   518269.40   0.07524  0.06428     9

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.32-3                      4096  4096  256    0.09 23.59%    37.670     5785.26   0.44271  0.00000     0


Cheers,
Bill


--- linux-2.5.32-virgin/kernel/softirq.c	2002-08-27 12:26:37.000000000 -0700
+++ linux-2.5.32/kernel/softirq.c	2002-08-27 18:12:30.000000000 -0700
@@ -179,11 +179,12 @@
 static void tasklet_action(struct softirq_action *a)
 {
 	struct tasklet_struct *list;
+	unsigned long flags;
 
-	local_irq_disable();
+	local_irq_save(flags);
 	list = __get_cpu_var(tasklet_vec).list;
 	__get_cpu_var(tasklet_vec).list = NULL;
-	local_irq_enable();
+	local_irq_restore(flags);
 
 	while (list) {
 		struct tasklet_struct *t = list;
@@ -192,31 +193,34 @@
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
-				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
+				if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
+					t->func(t->data);
+					tasklet_unlock(t);
+					continue;
+				}
 			}
 			tasklet_unlock(t);
 		}
 
-		local_irq_disable();
-		t->next = __get_cpu_var(tasklet_vec).list;
-		__get_cpu_var(tasklet_vec).list = t;
-		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
-		local_irq_enable();
+		local_irq_save(flags);
+		if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+			t->next = __get_cpu_var(tasklet_vec).list;
+			__get_cpu_var(tasklet_vec).list = t;
+			__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
+		}
+		local_irq_restore(flags);
 	}
 }
 
 static void tasklet_hi_action(struct softirq_action *a)
 {
 	struct tasklet_struct *list;
+	unsigned long flags;
 
-	local_irq_disable();
+	local_irq_save(flags);
 	list = __get_cpu_var(tasklet_hi_vec).list;
 	__get_cpu_var(tasklet_hi_vec).list = NULL;
-	local_irq_enable();
+	local_irq_restore(flags);
 
 	while (list) {
 		struct tasklet_struct *t = list;
@@ -225,20 +229,23 @@
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
-				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
+				if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
+					
+					t->func(t->data);
+					tasklet_unlock(t);
+					continue;
+				}
 			}
 			tasklet_unlock(t);
 		}
 
-		local_irq_disable();
-		t->next = __get_cpu_var(tasklet_hi_vec).list;
-		__get_cpu_var(tasklet_hi_vec).list = t;
-		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
-		local_irq_enable();
+		local_irq_save(flags);
+		if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+			t->next = __get_cpu_var(tasklet_hi_vec).list;
+			__get_cpu_var(tasklet_hi_vec).list = t;
+			__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
+		}
+		local_irq_restore(flags);
 	}
 }
 
