Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWIFR12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWIFR12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWIFR12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:27:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18876 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751768AbWIFR11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:27:27 -0400
Date: Wed, 6 Sep 2006 19:27:33 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-ID: <20060906172733.GC14345@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk> <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com> <20060901101801.7845bca2.akpm@osdl.org> <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com> <20060906124719.GA11868@atrey.karlin.mff.cuni.cz> <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com> <20060906153449.GC18281@atrey.karlin.mff.cuni.cz> <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com> <20060906162723.GA14345@atrey.karlin.mff.cuni.cz> <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2006-09-06 at 18:27 +0200, Jan Kara wrote:
> > > But my debug clearly shows that we are clearing the buffer, while
> > > we haven't actually submitted to ll_rw_block() code. (I added "track"
> > > flag to bh and set it in journal_commit_transaction() when we add
> > > them to wbuf[] and clear it in ll_rw_block() after submit. I checked
> > > for this flag in journal_unmap_buffer() while clearing the buffer).
> > > Here is what my debug shows:
> > > 
> > > buffer is tracked bh ffff8101686ea850 size 1024 
> > > 
> > > Call Trace:
> > >  [<ffffffff8020b395>] show_trace+0xb5/0x370
> > >  [<ffffffff8020b665>] dump_stack+0x15/0x20
> > >  [<ffffffff8030d474>] journal_invalidatepage+0x314/0x3b0
> >   I see just journal_invalidatepage() here. That is fine. It calls
> > journal_unmap_buffer() which should do nothing return 0. If it does
> > not it would be IMO bug.. If the buffer is really unmapped here, in what
> > state it is (i.e. which list is it on?).
> 
> Okay.. here is the path its taking according to my debug ..
> Remember, the issue is: after the buffer is cleaned - they are
> still (left) attached to the page (since a page can have 4
> buffer heads and we partially truncated the page). After
> we clean up the buffers any subsequent call to set_page_dirty()
> would end up marking *all* the buffers dirty. If ll_rw_block()
> happens after this, we will run into the assert. If no 
> set_page_dirty() happens before ll_rw_block() happens, things
> would be fine - as the buffer won't be dirty and be skipped.
  Yes, OK.

> journal_unmap_buffer() 
> {
> .....
> 	        } else {
>                 /* Good, the buffer belongs to the running transaction.
>                  * We are writing our own transaction's data, not any
>                  * previous one's, so it is safe to throw it away
>                  * (remember that we expect the filesystem to have set
>                  * i_size already for this truncate so recovery will not
>                  * expose the disk blocks we are discarding here.) */
>                 J_ASSERT_JH(jh, transaction == journal-
> >j_running_transaction);
>                 may_free = __dispose_buffer(jh, transaction);
>         }
> zap_buffer:
>         journal_put_journal_head(jh);
> zap_buffer_no_jh:
>         spin_unlock(&journal->j_list_lock);
>         jbd_unlock_bh_state(bh);
>         spin_unlock(&journal->j_state_lock);
> zap_buffer_unlocked:
>         clear_buffer_dirty(bh);
>         J_ASSERT_BH(bh, !buffer_jbddirty(bh));
>         clear_buffer_mapped(bh);
>         clear_buffer_req(bh);
>         clear_buffer_new(bh);
>         bh->b_bdev = NULL;
>         return may_free;
> }
  Ugh! Are you sure? For this path the buffer must be attached (only) to
the running transaction. But then how the commit code comes to it?
Somebody would have to even manage to refile the buffer from the
committing transaction to the running one while the buffer is in wbuf[].
Could you check whether someone does __journal_refile_buffer() on your
marked buffers, please? Or whether we move buffer to BJ_Locked list in
the write_out_data: loop? Thanks.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
