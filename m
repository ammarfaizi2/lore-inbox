Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVDKLg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVDKLg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVDKLg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:36:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62882 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261779AbVDKLgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:36:15 -0400
Date: Mon, 11 Apr 2005 13:36:14 +0200
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jeffm@suse.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problem in log_do_checkpoint()?
Message-ID: <20050411113614.GF1195@atrey.karlin.mff.cuni.cz>
References: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz> <1112969175.1975.96.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1112969175.1975.96.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> On Mon, 2005-04-04 at 10:04, Jan Kara wrote:
> 
> >   In log_do_checkpoint() we go through the t_checkpoint_list of a
> > transaction and call __flush_buffer() on each buffer. Suppose there is
> > just one buffer on the list and it is dirty. __flush_buffer() sees it and
> > puts it to an array of buffers for flushing. Then the loop finishes,
> > retry=0, drop_count=0, batch_count=1. So __flush_batch() is called - we
> > drop all locks and sleep. While we are sleeping somebody else comes and
> > makes the buffer dirty again (OK, that is not probable, but I think it
> > could be possible). 
> 
> Yes, there's no reason why not at that point.
> 
> > Now we wake up and call __cleanup_transaction().
> > It's not able to do anything and returns 0.
> 
> I think the _right_ answer here is to have two separate checkpoint
> lists: the current one, plus one for which the checkpoint write has
> already been submitted.  That way, we can wait for IO completion on
> submitted writes without (a) getting conned into doing multiple rewrites
> if there's somebody else dirtying the buffer; or (b) getting confused
> about how much progress we're making.  Buffers on the pre-write list get
> written; buffers on the post-write list get waited for; and both count
> as progress (eliminating the false assert-failure when we failed to
> detect progress).
  Yes, this seems to be a better long-term solution. A hotfix (retrying
after __flush_batch()) is attached if somebody is interested - it should
be safe and is lightly tested.

> The prevention of multiple writes in this case should also improve
> performance a little.
> 
> That ought to be pretty straightforward, I think.  The existing cases
> where we remove buffers from a checkpoint shouldn't have to care about
> which list_head we're removing from; those cases already handle buffers
> in both states.  It's only when doing the flush/wait that we have to
> distinguish the two.
  Yes, AFAICS the changes should remain local to the checkpointing code
(plus __unlink_buffer()). Should I write the patch or will you?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-rc2-checkpoint.diff"

Fix possible false assertion failure in JBD checkpointing code.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc2/fs/jbd/checkpoint.c linux-2.6.12-rc2-checkpoint/fs/jbd/checkpoint.c
--- linux-2.6.12-rc2/fs/jbd/checkpoint.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.12-rc2-checkpoint/fs/jbd/checkpoint.c	2005-04-05 13:26:42.000000000 +0200
@@ -339,8 +339,10 @@ int log_do_checkpoint(journal_t *journal
 			}
 		} while (jh != last_jh && !retry);
 
-		if (batch_count)
+		if (batch_count) {
 			__flush_batch(journal, bhs, &batch_count);
+			retry = 1;
+		}
 
 		/*
 		 * If someone cleaned up this transaction while we slept, we're

--lrZ03NoBR/3+SXJZ--
