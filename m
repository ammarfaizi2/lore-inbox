Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282322AbRKXB0y>; Fri, 23 Nov 2001 20:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282327AbRKXB0o>; Fri, 23 Nov 2001 20:26:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11272 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282322AbRKXB03>; Fri, 23 Nov 2001 20:26:29 -0500
Message-ID: <3BFEF71A.F32176FE@zip.com.au>
Date: Fri, 23 Nov 2001 17:25:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <Pine.LNX.4.40.0111231859510.4162-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> My laptop drive seems to be waking up more often today and I suspect it's
> somehow ext3/kjournald that's to blame. Does it obey the timings in
> /proc/sys/vm/bdflush or does it have its own flush timer?

It has its own flush timer.  This is something we need to crunch
on and think about.

There's an untested patch here which may suffice.

> There's a more general problem with VM on laptops which is that the system
> doesn't have any notion of spun-down disks. Flush intervals should be
> short when the disk is running and long when it isn't and decisions about
> which pages to discard or swap might be improvable. Pre-emptive swap when
> the disk is spun down is a loss..

Yup.  The current VM is a bit too swap-happy, IMO.  In try_to_free_pages(),
replace `priority = DEF_PRIORITY' with `priority = DEF_PRIORITY + 2'.

Also, if we had appropriate hooks into the request layer, we could detect
when the disk was being spun up for a read, and opporunistically flush
out any pending writes.

Tell me if this is joyful:

--- linux-2.4.15/fs/buffer.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/buffer.c	Fri Nov 23 17:21:04 2001
@@ -119,6 +119,12 @@ union bdflush_param {
 int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   0, 0, 0};
 int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,10000*HZ, 6000*HZ, 100, 0, 0};
 
+int dirty_buffer_flush_interval(void)
+{
+	return bdf_prm.b_un.interval;
+}
+EXPORT_SYMBOL(dirty_buffer_flush_interval);
+
 void unlock_buffer(struct buffer_head *bh)
 {
 	clear_bit(BH_Wait_IO, &bh->b_state);
--- linux-2.4.15/fs/jbd/transaction.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/fs/jbd/transaction.c	Fri Nov 23 17:21:37 2001
@@ -43,6 +43,8 @@ extern spinlock_t journal_datalist_lock;
  *	processes trying to touch the journal while it is in transition.
  */
 
+extern int dirty_buffer_flush_interval(void);
+
 static transaction_t * get_transaction (journal_t * journal, int is_try)
 {
 	transaction_t * transaction;
@@ -56,7 +58,7 @@ static transaction_t * get_transaction (
 	transaction->t_journal = journal;
 	transaction->t_state = T_RUNNING;
 	transaction->t_tid = journal->j_transaction_sequence++;
-	transaction->t_expires = jiffies + journal->j_commit_interval;
+	transaction->t_expires = jiffies + dirty_buffer_flush_interval();
 
 	/* Set up the commit timer for the new transaction. */
 	J_ASSERT (!journal->j_commit_timer_active);
