Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWIFRNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWIFRNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWIFRNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:13:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63908 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751728AbWIFRNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:13:37 -0400
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>
	 <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>
	 <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com>
	 <20060901101801.7845bca2.akpm@osdl.org>
	 <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906124719.GA11868@atrey.karlin.mff.cuni.cz>
	 <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
	 <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 10:16:56 -0700
Message-Id: <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 18:27 +0200, Jan Kara wrote:
> > On Wed, 2006-09-06 at 17:34 +0200, Jan Kara wrote:
> > > > On Wed, 2006-09-06 at 14:47 +0200, Jan Kara wrote:
> > > > 
> > > > > > Andrew, what should we do ? Do you suggest handling this in jbd
> > > > > > itself (like this patch) ?
> > > > >   Actually that part of commit code needs rewrite anyway (and after that
> > > > > rewrite you get rid of ll_rw_block()) because of other problems - the
> > > > > code assumes that whenever buffer is locked, it is being written to disk
> > > > > which is not true... I have some preliminary patches for that but they
> > > > > are not very nice and so far I didn't have enough time to find a nice
> > > > > solution.
> > > > 
> > > > Are you okay with current not-so-elegant fix ? 
> > >   Actually I don't quite understand how it can happen what you describe
> > > (so probably I missed something). How it can happen that some buffers
> > > are unmapped while we are committing them?  journal_unmap_buffers()
> > > checks whether we are not committing truncated buffers and if so, it
> > > does not do anything to such buffers...
> > > 							Bye
> > > 								Honza
> > 
> > Yep. I spent lot of time trying to understand - why they are not
> > getting skipped :(
> > 
> > But my debug clearly shows that we are clearing the buffer, while
> > we haven't actually submitted to ll_rw_block() code. (I added "track"
> > flag to bh and set it in journal_commit_transaction() when we add
> > them to wbuf[] and clear it in ll_rw_block() after submit. I checked
> > for this flag in journal_unmap_buffer() while clearing the buffer).
> > Here is what my debug shows:
> > 
> > buffer is tracked bh ffff8101686ea850 size 1024 
> > 
> > Call Trace:
> >  [<ffffffff8020b395>] show_trace+0xb5/0x370
> >  [<ffffffff8020b665>] dump_stack+0x15/0x20
> >  [<ffffffff8030d474>] journal_invalidatepage+0x314/0x3b0
>   I see just journal_invalidatepage() here. That is fine. It calls
> journal_unmap_buffer() which should do nothing return 0. If it does
> not it would be IMO bug.. If the buffer is really unmapped here, in what
> state it is (i.e. which list is it on?).

Okay.. here is the path its taking according to my debug ..
Remember, the issue is: after the buffer is cleaned - they are
still (left) attached to the page (since a page can have 4
buffer heads and we partially truncated the page). After
we clean up the buffers any subsequent call to set_page_dirty()
would end up marking *all* the buffers dirty. If ll_rw_block()
happens after this, we will run into the assert. If no 
set_page_dirty() happens before ll_rw_block() happens, things
would be fine - as the buffer won't be dirty and be skipped.


journal_unmap_buffer() 
{
.....
	        } else {
                /* Good, the buffer belongs to the running transaction.
                 * We are writing our own transaction's data, not any
                 * previous one's, so it is safe to throw it away
                 * (remember that we expect the filesystem to have set
                 * i_size already for this truncate so recovery will not
                 * expose the disk blocks we are discarding here.) */
                J_ASSERT_JH(jh, transaction == journal-
>j_running_transaction);
                may_free = __dispose_buffer(jh, transaction);
        }
zap_buffer:
        journal_put_journal_head(jh);
zap_buffer_no_jh:
        spin_unlock(&journal->j_list_lock);
        jbd_unlock_bh_state(bh);
        spin_unlock(&journal->j_state_lock);
zap_buffer_unlocked:
        clear_buffer_dirty(bh);
        J_ASSERT_BH(bh, !buffer_jbddirty(bh));
        clear_buffer_mapped(bh);
        clear_buffer_req(bh);
        clear_buffer_new(bh);
        bh->b_bdev = NULL;
        return may_free;
}



