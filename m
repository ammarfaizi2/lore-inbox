Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbTFSTzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTFSTzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:55:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46572 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265909AbTFSTze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:55:34 -0400
Date: Thu, 19 Jun 2003 13:10:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 umount hangs
Message-Id: <20030619131034.5be8232b.akpm@digeo.com>
In-Reply-To: <3EF20E86.3030102@austin.ibm.com>
References: <3EF1EC73.4070305@austin.ibm.com>
	<20030619105817.51613df2.akpm@digeo.com>
	<3EF20E86.3030102@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 20:09:33.0874 (UTC) FILETIME=[B3615920:01C3369E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> Here is the trace of the hung process:
> 
>  umount        D 00000001 290213268 18747  18746                     (NOTLB)
>  Call Trace:
>   [<c01a1ae8>] journal_kill_thread+0xa8/0xe0

whoops.  I bet you're seeing this when using some script which does the
unmount.

Might this help?


diff -puN fs/jbd/journal.c~kjournald-shutdown-fix fs/jbd/journal.c
--- 25/fs/jbd/journal.c~kjournald-shutdown-fix	2003-06-19 12:58:43.000000000 -0700
+++ 25-akpm/fs/jbd/journal.c	2003-06-19 12:58:43.000000000 -0700
@@ -161,7 +161,7 @@ loop:
 		del_timer_sync(journal->j_commit_timer);
 		journal_commit_transaction(journal);
 		spin_lock(&journal->j_state_lock);
-		goto loop;
+		goto end_loop;
 	}
 
 	wake_up(&journal->j_wait_done_commit);
@@ -210,7 +210,7 @@ loop:
 		journal->j_commit_request = transaction->t_tid;
 		jbd_debug(1, "woke because of timeout\n");
 	}
-
+end_loop:
 	if (!(journal->j_flags & JFS_UNMOUNT))
 		goto loop;
 
@@ -230,12 +230,16 @@ static void journal_start_thread(journal
 
 static void journal_kill_thread(journal_t *journal)
 {
+	spin_lock(&journal->j_state_lock);
 	journal->j_flags |= JFS_UNMOUNT;
 
 	while (journal->j_task) {
 		wake_up(&journal->j_wait_commit);
+		spin_unlock(&journal->j_state_lock);
 		wait_event(journal->j_wait_done_commit, journal->j_task == 0);
+		spin_lock(&journal->j_state_lock);
 	}
+	spin_unlock(&journal->j_state_lock);
 }
 
 /*

_

