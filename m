Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281836AbRLCIv4>; Mon, 3 Dec 2001 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRLCIst>; Mon, 3 Dec 2001 03:48:49 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:24069 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S284797AbRLCFqh>; Mon, 3 Dec 2001 00:46:37 -0500
To: linux-kernel@vger.kernel.org
Cc: j-nomura@ce.jp.nec.com
Subject: [PATCH] 2.4.16 kernel/printk.c (per processor initialization check)
From: j-nomura@ce.jp.nec.com
X-Mailer: Mew version 1.94.2 on XEmacs 21.4 (Copyleft)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011203144615C.nomura@hpc.bs1.fc.nec.co.jp>
Date: Mon, 03 Dec 2001 14:46:15 +0900
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I experienced system hang on my SMP machine and it turned out to be due to
console write before mmu initialization completes.

To be more specific, even if secondary processors are not in status enough
to do actual console I/O (e.g. mmu is not initialized), call_console_drivers()
tries to do it.
This leads to unpredictable result. For me, for example, it cause machine
check abort and hang up system.

Attached is a patch for it.

--- kernel/printk.c	2001/11/27 04:41:49	1.1.1.8
+++ kernel/printk.c	2001/12/03 05:25:26
@@ -491,20 +491,22 @@
  */
 void release_console_sem(void)
 {
 	unsigned long flags;
 	unsigned long _con_start, _log_end;
 	unsigned long must_wake_klogd = 0;
 
 	for ( ; ; ) {
 		spin_lock_irqsave(&logbuf_lock, flags);
 		must_wake_klogd |= log_start - log_end;
+		if (!(cpu_online_map & 1UL << smp_processor_id()))
+			break;
 		if (con_start == log_end)
 			break;			/* Nothing to print */
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		call_console_drivers(_con_start, _log_end);
 	}
 	console_may_schedule = 0;
 	up(&console_sem);

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
HPC Operating System Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.
