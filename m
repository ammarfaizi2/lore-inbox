Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVDDJiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDDJiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDDJiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:38:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20684 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261194AbVDDJiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:38:03 -0400
Date: Mon, 4 Apr 2005 11:38:02 +0200
From: Jan Kara <jack@suse.cz>
To: John Madden <weez@freelists.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11, nfsd, log_do_checkpoint()
Message-ID: <20050404093802.GC20219@atrey.karlin.mff.cuni.cz>
References: <200504011927.19030.weez@freelists.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <200504011927.19030.weez@freelists.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

> I woke up to a mostly-dead PE1850 this morning: 
> 
> Message from syslogd@storage at Fri Apr  1 06:19:14 2005 ...
> storage kernel: Assertion failure in log_do_checkpoint() at 
> fs/jbd/checkpoint.c:365: "drop_count != 0 || cleanup_ret != 0"
> 
> Message from syslogd@storage at Fri Apr  1 06:19:14 2005 ...
> storage kernel: invalid operand: 0000 [1] SMP 
> 
> Full error:
> 
> Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:365: 
> "drop_count != 0 || cleanup_ret != 0"
  Could you try running a kernel with the attached patch? Are you able to
reproduce the problem even with the patch?

> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at checkpoint:365
> invalid operand: 0000 [1] SMP
> CPU 1
> Modules linked in:
> Pid: 212, comm: nfsd Not tainted 2.6.11-rc5

<snip>

> nfsd was serving out a pretty heavily-used (2.5-million page web site) ext3 
> partition on the 1850's built-in LSI/MPT controller.  I'm able to duplicate 
> this somewhat consistently by putting nfsd under heavy load (say, by deleting 
> 20,000 files from a directory).
> 
> (Please Cc me on replies, I'm not subscribed.)

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-release-race.patch"

linux-2.6.11-ext3-release-race.patch:
 transaction.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- NEW FILE linux-2.6.11-ext3-release-race.patch ---
--- linux-2.6.9/fs/jbd/transaction.c.=K0002=.orig
+++ linux-2.6.9/fs/jbd/transaction.c
@@ -1812,10 +1812,10 @@ static int journal_unmap_buffer(journal_
 			JBUFFER_TRACE(jh, "checkpointed: add to BJ_Forget");
 			ret = __dispose_buffer(jh,
 					journal-&gt;j_running_transaction);
+			journal_put_journal_head(jh);
 			spin_unlock(&amp;journal-&gt;j_list_lock);
 			jbd_unlock_bh_state(bh);
 			spin_unlock(&amp;journal-&gt;j_state_lock);
-			journal_put_journal_head(jh);
 			return ret;
 		} else {
 			/* There is no currently-running transaction. So the
@@ -1826,10 +1826,10 @@ static int journal_unmap_buffer(journal_
 				JBUFFER_TRACE(jh, "give to committing trans");
 				ret = __dispose_buffer(jh,
 					journal-&gt;j_committing_transaction);
+				journal_put_journal_head(jh);
 				spin_unlock(&amp;journal-&gt;j_list_lock);
 				jbd_unlock_bh_state(bh);
 				spin_unlock(&amp;journal-&gt;j_state_lock);
-				journal_put_journal_head(jh);
 				return ret;
 			} else {
 				/* The orphan record's transaction has
@@ -1850,10 +1850,10 @@ static int journal_unmap_buffer(journal_
 					journal-&gt;j_running_transaction);
 			jh-&gt;b_next_transaction = NULL;
 		}
+		journal_put_journal_head(jh);
 		spin_unlock(&amp;journal-&gt;j_list_lock);
 		jbd_unlock_bh_state(bh);
 		spin_unlock(&amp;journal-&gt;j_state_lock);
-		journal_put_journal_head(jh);
 		return 0;
 	} else {
 		/* Good, the buffer belongs to the running transaction.

--h31gzZEtNLTqOjlF--
