Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTARA4p>; Fri, 17 Jan 2003 19:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTARA4o>; Fri, 17 Jan 2003 19:56:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:50307 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261854AbTARA4n>;
	Fri, 17 Jan 2003 19:56:43 -0500
Date: Fri, 17 Jan 2003 17:05:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch 2.4] Fix ext3 scheduling storm and lockup
Message-Id: <20030117170516.2e184b82.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 01:05:36.0437 (UTC) FILETIME=[B57D9E50:01C2BE8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes an inefficiency and potential system lockup in the 2.4
kernel's ext3 filesystem.  The problem has been present since 2.4.20-pre5. 
This patch is applicable to 2.4.20.  A copy is at

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.20/ext3-scheduling-storm.patch

Anyone who is using tasks which have realtime scheduling policy on ext3
systems should apply this change.


Details:

At the start of do_get_write_access() we have this logic:

	repeat:
		lock_buffer(jh->bh);
		...
		unlock_buffer(jh->bh);
		...
		if (jh->j_list == BJ_Shadow) {
			sleep_on_buffer(jh->bh);
			goto repeat;
		}

The problem is that the unlock_buffer() will wake up anyone who is sleeping
in the sleep_on_buffer().

So if task A is asleep in sleep_on_buffer() and task B now runs
do_get_write_access(), task B will wake task A by accident.  Task B will then
sleep on the buffer and task A will loop, will run unlock_buffer() and then
wake task B.

Net effect: the system does 100,000 context switches/sec until I/O completes
against the buffer and kjournald changes the value of jh->j_list.

Unless task A and task B happen to both have realtime scheduling policy - if
they do then kjournald will never run.  The state is never cleared and your
box locks up.


The fix is to not do the `goto repeat;' until the buffer has been taken off
the shadow list.  So we don't go and wake up the other waiter(s) until they
can actually proceed to use the buffer.



diff -puN fs/jbd/transaction.c~ext3-scheduling-storm fs/jbd/transaction.c
--- 24/fs/jbd/transaction.c~ext3-scheduling-storm	2003-01-16 02:45:19.000000000 -0800
+++ 24-akpm/fs/jbd/transaction.c	2003-01-16 02:45:19.000000000 -0800
@@ -669,7 +669,8 @@ repeat:
 			spin_unlock(&journal_datalist_lock);
 			unlock_journal(journal);
 			/* commit wakes up all shadow buffers after IO */
-			sleep_on(&jh2bh(jh)->b_wait);
+			wait_event(jh2bh(jh)->b_wait,
+						jh->b_jlist != BJ_Shadow);
 			lock_journal(journal);
 			goto repeat;
 		}

_

