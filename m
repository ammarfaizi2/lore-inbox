Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262000AbTDBHjf>; Wed, 2 Apr 2003 02:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTDBHjf>; Wed, 2 Apr 2003 02:39:35 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:38130 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262000AbTDBHjd>; Wed, 2 Apr 2003 02:39:33 -0500
Date: Wed, 02 Apr 2003 16:50:44 +0900 (JST)
Message-Id: <20030402.165044.576024545.nomura@hpc.bs1.fc.nec.co.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: lru_list_lock contention in write_unlocked_buffers()
From: j-nomura@ce.jp.nec.com
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I run mkfs while doing other large file I/O in parallel,
the system response becomes terribly bad on 2.4.18 kernel.
(probably on other 2.4 kernels also)

I found there are hard contention on lru_list_lock, which is mostly held
by write_unlocked_buffers().
It happens only on large memory machine because lru_list can grow very long
and write_some_buffers() scans the long list from head on each call.

Lowlatency patch in aa tree did not help this situation.

The patch below is hasty workaround for it.
Any comments, or suggestions to better fix?


For example, on 8 CPUs and 16GB memory system, I've run:
  - 4 instance of 'dd if=/dev/zero of=somefile'
  - 1 instance of mke2fs
  - more than 5 top to keep other CPUs busy

Output of SGI lockstat for the test looked like:
SPINLOCKS         HOLD            WAIT
  UTIL    MEAN(  MAX )   MEAN(  MAX )     TOTAL   NAME
 93.6%    83us( 549ms)   56ms(1591ms)   5076092   lru_list_lock
 92.9%    45ms( 520ms)   26us(6703us)      9283     write_unlocked_buffers+0x30
 0.27%  1354us( 519ms)  4.2us(  16us)       888     wait_for_locked_buffers+0x30
 0.26%    58ms( 549ms)   20us(  25us)        20     invalidate_bdev+0x60

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
Enterprise Linux Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.


--- linux/fs/buffer.c
+++ linux/fs/buffer.c
@@ -120,6 +120,8 @@ union bdflush_param {
 /* These are the min and max parameter values that we will allow to be assigned */
 int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   0, 0, 0};
 int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,10000*HZ, 6000*HZ, 100, 0, 0};
+int max_nr_seek_lrulist = 1024;
+int lrulist_seek_delay  = 1;
 
 
 static int 
@@ -231,10 +233,19 @@ static int write_some_buffers(kdev_t dev
 	struct buffer_head *array[NRSYNC];
 	unsigned int count;
 	int nr;
+	int fast_exit = 0;
+	int pass = 0;
 
+repeat:
 	next = lru_list[BUF_DIRTY];
 	nr = nr_buffers_type[BUF_DIRTY];
 	count = 0;
+
+	if (dev && max_nr_seek_lrulist && max_nr_seek_lrulist < nr && !pass) {
+		nr = max_nr_seek_lrulist;
+		fast_exit = 1;
+	}
+
 	while (next && --nr >= 0) {
 		struct buffer_head * bh = next;
 		next = bh->b_next_free;
@@ -267,6 +278,17 @@ static int write_some_buffers(kdev_t dev
 
 	if (count)
 		write_locked_buffers(array, count);
+	if (fast_exit && next) {
+		if (lrulist_seek_delay) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(lrulist_seek_delay*HZ);
+			spin_lock(&lru_list_lock);
+			fast_exit = 0;
+			pass++;
+			goto repeat;
+		}
+		return -EAGAIN;
+	}
 	return 0;
 }
 
