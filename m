Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWAQWXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWAQWXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWAQWXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:23:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25801 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964867AbWAQWXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:23:54 -0500
Date: Tue, 17 Jan 2006 23:23:53 +0100
From: Jan Kara <jack@suse.cz>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: unmount oops in log_do_checkpoint
Message-ID: <20060117222353.GA26770@atrey.karlin.mff.cuni.cz>
References: <20060116160420.GA21064@wotan.suse.de> <20060116212250.GD12159@atrey.karlin.mff.cuni.cz> <20060117113727.GB24083@wotan.suse.de> <20060117034601.6556322a.akpm@osdl.org> <20060117115945.GC24083@wotan.suse.de> <20060117140929.GA23497@wotan.suse.de> <20060117163235.GA18895@atrey.karlin.mff.cuni.cz> <20060117163622.GA20740@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20060117163622.GA20740@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Tue, Jan 17, 2006 at 05:32:35PM +0100, Jan Kara wrote:
> > > On Tue, Jan 17, 2006 at 12:59:45PM +0100, Nick Piggin wrote:
> > > 
> > > Maybe it is because people haven't been turning on their debugging options,
> > > tsk tsk ;) It only oopses when DEBUG_SLAB and DEBUG_PAGEALLOC are both
> > > enabled. And only then when the jbd patch is not reverted. Weird.
> >   Hmm, that's really strange, maybe we have some use-after-free
> > problem or so... I'll see what I can do :).
> > 
> 
> Are you able to reproduce? If not I can test patches...
  Hmm, I was not able to reproduce the problem even with those debug
options set :(. As I'm looking into the code it seems that somebody
managed to free the transaction but did not clear the
j_checkpoint_transactions pointer. It's even stranger that it's during
umount time when there should not be much processes playing with the JBD
structures on that filesystem.
  Attached is the patch that fixes two minor possible problems I've
found. Neither of them should be causing your oops but one never knows
:). Also turn on the JBD debugging in config. Maybe it spits something
useful. If you still see the same oops, I'll create some debugging
patch.
  BTW: the oops during umount is after some activity on the filesystem
or you just mount & umount?

						Thanks for testing
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.16-rc1-checkpointfix.diff"

diff -rupX /home/jack/.kerndiffexclude linux-2.6.16-rc1/fs/jbd/checkpoint.c linux-2.6.16-rc1-1-checkpoint-fix/fs/jbd/checkpoint.c
--- linux-2.6.16-rc1/fs/jbd/checkpoint.c	2006-01-17 21:44:02.000000000 +0100
+++ linux-2.6.16-rc1-1-checkpoint-fix/fs/jbd/checkpoint.c	2006-01-17 23:35:49.000000000 +0100
@@ -338,7 +338,7 @@ restart:
 	 * done (maybe it's a new transaction, but it fell at the same
 	 * address).
 	 */
- 	if (journal->j_checkpoint_transactions == transaction ||
+ 	if (journal->j_checkpoint_transactions == transaction &&
 			transaction->t_tid == this_tid) {
 		int batch_count = 0;
 		struct buffer_head *bhs[NR_BATCH];
diff -rupX /home/jack/.kerndiffexclude linux-2.6.16-rc1/fs/jbd/commit.c linux-2.6.16-rc1-1-checkpoint-fix/fs/jbd/commit.c
--- linux-2.6.16-rc1/fs/jbd/commit.c	2006-01-15 00:20:12.000000000 +0100
+++ linux-2.6.16-rc1-1-checkpoint-fix/fs/jbd/commit.c	2006-01-17 23:35:19.000000000 +0100
@@ -829,7 +829,8 @@ restart_loop:
 	journal->j_committing_transaction = NULL;
 	spin_unlock(&journal->j_state_lock);
 
-	if (commit_transaction->t_checkpoint_list == NULL) {
+	if (commit_transaction->t_checkpoint_list == NULL &&
+	    commit_transaction->t_checkpoint_io_list == NULL) {
 		__journal_drop_transaction(journal, commit_transaction);
 	} else {
 		if (journal->j_checkpoint_transactions == NULL) {

--gKMricLos+KVdGMg--
