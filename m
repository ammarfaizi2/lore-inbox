Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTLBHOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 02:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLBHOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 02:14:18 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.116]:34284 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261719AbTLBHOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 02:14:16 -0500
From: Michael Frank <mhf@linuxmail.org>
To: axboe@suse.de
Subject: Laptop mode and 2.4.23
Date: Tue, 2 Dec 2003 15:14:06 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312020741.05319.mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using laptop mode for the first time. Kernel is 2.4.23-Vanilla+kdb4.3 on a x86 notebook.

IDE Disk is ext3 mounted with rw,noatime

# cat /proc/sys/vm/laptop_mode
1
# cat /proc/sys/vm/bdflush
30      500     0       0       60000   60000   60      20      0

- Any disk write access spins up and writes as usual after 5 seconds by kjournald
- A disk spinup by kjournald does _not_ run bdflush and kupdated, so once they 
  elapse, the disk spins up again

This part of the laptop-mode patch is missing and the 5 second interval is still hardcoded:

diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.cWed May 14 11:29:52 2003
+++ b/fs/jbd/transaction.cWed May 14 11:29:52 2003
@@ -56,7 +56,11 @@
 transaction->t_journal = journal;
 transaction->t_state = T_RUNNING;
 transaction->t_tid = journal->j_transaction_sequence++;
-transaction->t_expires = jiffies + journal->j_commit_interval;
+/*
+ * have to do it here, otherwise changed age_buffers since boot
+ * wont have any effect
+ */
+transaction->t_expires = jiffies + get_buffer_flushtime();
 INIT_LIST_HEAD(&transaction->t_jcb);

IMHO, without this patch, laptop-mode is only half as useful ;)

Why was this part of the patch not used?

Regards
Michael

