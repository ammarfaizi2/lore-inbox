Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWE3Qje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWE3Qje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWE3Qje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:39:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56029 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932276AbWE3Qje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:39:34 -0400
Date: Tue, 30 May 2006 18:40:53 +0200
From: Jan Kara <jack@suse.cz>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
Message-ID: <20060530164053.GA4679@atrey.karlin.mff.cuni.cz>
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz> <1148051208.5156.31.camel@sisko.sctweedie.blueyonder.co.uk> <20060524173314.GB28568@atrey.karlin.mff.cuni.cz> <447C666D.5030003@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447C666D.5030003@bull.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I have got a concern about this code fragment:
> 
> >+		if (buffer_dirty(bh)) {
> >+			if (test_set_buffer_locked(bh)) {
> >+				...
> >+				get_bh(bh);
> >+				spin_unlock(&journal->j_list_lock);
> >+				/* Submit all accumulated buffers to prevent
> >+				 * possible deadlocks */
> >+				submit_buffers(bufs, wbuf);
> >+				bufs = 0;
> >+				lock_buffer(bh);
> >+				spin_lock(&journal->j_list_lock);
> >+				/* Someone already cleaned up the buffer? */
> >+				if (!buffer_jbd(bh)
> >+					|| jh->b_jlist != BJ_SyncData) {
> >+					unlock_buffer(bh);
> >+					BUFFER_TRACE(bh, "already cleaned 
> >up");
> >+					put_bh(bh);
> >+					continue;
> >+				}
> >+				put_bh(bh);
> >+			}
> >+			if (test_clear_buffer_dirty(bh)) {
> >+				BUFFER_TRACE(bh, "needs writeout, 
> >submitting");
> >+				get_bh(bh);
> >+				wbuf[bufs++] = bh;
> >+				if (bufs == journal->j_wbufsize) {
> >+					spin_unlock(&journal->j_list_lock);
> >+					/* Writeout will be done at the
> >+					 * beginning of the loop */
> >+					goto write_out_data;
> >+				}
> >+			}
> 
> We lock up to "->j_wbufsize" buffers, one after the others.
> 
> Originally, we toke a buffer, we did something to it, and we released it.
> When we wanted two of them and the second one was not available, we
> released the first one, too, in order to avoid dead-locks.
> 
> Keeping a couple of buffer locked for an unpredictably long time...
> (Here you keep N-1 buffer locked while you are waiting for the Nth one.)
> And not imposing / respecting any locking order...
  You are not right here. This is exactly why we do submit_buffers()
before we do lock_buffer. So either we get the lock without waiting via
test_set_buffer_locked() or we send all buffers for IO (and hence they
will get unlocked eventually).

> The original code did not lock the buffers while it was composing the
> list of buffers. "ll_rw_block()" locked one by one the buffers
> and submitted them to the BIO. These buffers got eventually unlocked,
> possibly before the some last buffers got locked by "ll_rw_block()".
> 
> This change implies an important difference in locking behavior.
  I agree the locking behaviour has changed a bit. But not as much as you
thought.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
