Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWFUAJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWFUAJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWFUAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:09:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30620 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932155AbWFUAI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:08:59 -0400
Date: Wed, 21 Jun 2006 02:09:16 +0200
From: Jan Kara <jack@suse.cz>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
Message-ID: <20060621000916.GA19013@atrey.karlin.mff.cuni.cz>
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz> <447F13B3.6050505@bull.net> <20060601162751.GH26933@atrey.karlin.mff.cuni.cz> <44801E16.3040300@bull.net> <20060602134923.GA1644@atrey.karlin.mff.cuni.cz> <44982344.2060507@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44982344.2060507@bull.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I have got some crashes due to:
> 
> Assertion failure in __journal_file_buffer():
>      "jh->b_transaction == transaction || jh->b_transaction == 0"
  Yes, I've seen your reports. Thanks for them and sorry for being a bit
unresponsive (I have a lot of other work...).

<snip>
> 
> --- Called from --- :
> 
> journal_submit_data_buffers+0x200/0x660 [jbd]
>      r32 : e0000001035ec100  journal
>      r33 : e00000010396a380  commit_transaction
> 
> As you can see, the current "jh" has been stolen for the new
> "->j_running_transaction" while we released temporarily "->j_list_lock"
> in the middle of "journal_submit_data_buffers()".
  Yes, this seems to be correct analysis.

> Therefore the test "jh->b_jlist != BJ_SyncData", i.e. if it is still
> on a (_any_) sync. list is not enough.
  Right.

> --- linux-2.6.16.20-orig/fs/jbd/commit.c	2006-06-20 
> 17:19:47.000000000 +0200
> +++ linux-2.6.16.20/fs/jbd/commit.c	2006-06-20 17:35:54.000000000 +0200
> @@ -219,15 +219,26 @@
> 				bufs = 0;
> 				lock_buffer(bh);
> 				spin_lock(&journal->j_list_lock);
> +				/* Stolen (e.g. for a new transaction) ? */
> +				if (jh != 
> commit_transaction->t_sync_datalist) {
> +					unlock_buffer(bh);
> +					JBUFFER_TRACE(jh, "stolen sync. 
> data");
> +					put_bh(bh);
> +					continue;
> +				}
  Yes, this is definitely safer check and should also catch the case
when jh was released from memory so buffer_jbd() is not needed any more.

> 				/* Someone already cleaned up the buffer? */
> -				if (!buffer_jbd(bh)
> -					|| jh->b_jlist != BJ_SyncData) {
> +
> +				// Can this happen???
> +
> +				if (!buffer_jbd(bh)) {
> 					unlock_buffer(bh);
> 					BUFFER_TRACE(bh, "already cleaned 
> 					up");
> 					put_bh(bh);
> 					continue;
> 				}
> 				put_bh(bh);
> +				J_ASSERT_JH(jh, jh->b_transaction ==
> +							commit_transaction);
> 			}
> 			if (test_clear_buffer_dirty(bh)) {
> 				BUFFER_TRACE(bh, "needs writeout, 
> 				submitting");
> 
> I am not really sure that the test "!buffer_jbd(bh)" is really useful.
> I left it alone for not introducing a new bug.
> If you can confirm that it is not necessary, I can take it away.
  BTW: I've also written another version of the patch using a bit
different approach. When I have some time I can benchmark them against
each other to see if there is some difference...

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
