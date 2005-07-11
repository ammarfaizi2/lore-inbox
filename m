Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVGKVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVGKVYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVGKVWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:22:14 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:26297 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262716AbVGKVTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:19:55 -0400
Date: Mon, 11 Jul 2005 14:19:26 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sct@redhat.com
Subject: [PATCH] kjournald() missing JFS_UNMOUNT check
Message-ID: <20050711211926.GC14505@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Can we please merge this patch? I sent it to ext2-devel for comments
last week and haven't hear anything back. It seems trivially correct and is
testing fine - famous last words, I know :)

My original mail follows:

	It seems that kjournald() may be missing a check of the JFS_UNMOUNT
flag before calling schedule(). This showed up in testing of OCFS2 recovery
where our recovery thread would hang in journal_kill_thread() called from  
journal_destroy() because kjournald never got a chance to read the flag to 
shut down before the schedule().

Zach pointed out the missing check which led me to hack up this trivial
patch. It's been tested many times now and I have yet to reproduce the 
hang, which was happening very regularly before.

<mild rant>
I'm guessing that we could really use some wait_event() calls with helper
functions in, well, most of jbd these days which would make a ton of the 
wait code there vastly cleaner.
</mild rant>

As for why this doesn't happen in ext3 (or OCFS2 during normal mount/unmount
of the local nodes journal), I think it may that the specific timing of
events in the ocfs2 recovery thread exposes a race there. Because
ocfs2_replay_journal() is only interested in playing back the journal,
initialization and shutdown happen very quicky with no other metadata put
into that specific journal.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

--- ../linux-2.6.13-rc1-ro/fs/jbd/journal.c	2005-06-28 22:57:29.000000000 -0700
+++ linux-2.6.13-rc1/fs/jbd/journal.c	2005-07-07 12:01:44.280714000 -0700
@@ -193,6 +193,8 @@
 		if (transaction && time_after_eq(jiffies,
 						transaction->t_expires))
 			should_sleep = 0;
+		if (journal->j_flags & JFS_UNMOUNT)
+ 			should_sleep = 0;
 		if (should_sleep) {
 			spin_unlock(&journal->j_state_lock);
 			schedule();
