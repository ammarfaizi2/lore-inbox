Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWJKKdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWJKKdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWJKKdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:33:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16599 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751174AbWJKKdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:33:41 -0400
Date: Wed, 11 Oct 2006 12:33:25 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Eric Sandeen <esandeen@redhat.com>,
       Jan Kara <jack@suse.cz>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061011103325.GC6865@atrey.karlin.mff.cuni.cz>
References: <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com> <20061009225036.GC26728@redhat.com> <20061010141145.GM23622@atrey.karlin.mff.cuni.cz> <452C18A6.3070607@redhat.com> <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com> <452C4C47.2000107@sandeen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452C4C47.2000107@sandeen.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Badari Pulavarty wrote:
> >On Tue, 2006-10-10 at 17:03 -0500, Eric Sandeen wrote:
> >>Jan Kara wrote:
> >>
> >>>  I think it's really the 1KB block size that makes it happen.
> >>>I've looked at journal_dirty_data() code and I think the following can
> >>>happen:
> >>>  sync() eventually ends up in journal_dirty_data(bh) as Eric writes.
> >>>There is finds dirty buffer attached to the comitting transaction. So it 
> >>>drops
> >>>all locks and calls sync_dirty_buffer(bh).
> >>>  Now in other process, file is truncated so that 'bh' gets just after 
> >>>  EOF.
> >>>As we have 1kb buffers, it can happen that bh is in the partially
> >>>truncated page. Buffer is marked unmapped and clean. But in a moment the 
> >>>page
> >>>is marked dirty and msync() is called. That eventually calls
> >>>set_page_dirty() and all buffers in the page are marked dirty.
> >>>  The first process now wakes up, locks the buffer, clears the dirty bit
> >>>and does submit_bh() - Oops.
> >>Hm, just FWIW I have a couple traces* of the buffer getting unmapped
> >>-before- journal_submit_data_buffers ever even finds it...
> >>
> >> journal_submit_data_buffers():[fs/jbd/commit.c:242] needs writeout,
> >>adding to array pid 1836
> >>     b_state:0x114025 b_jlist:BJ_SyncData cpu:0 b_count:2 b_blocknr:27130
> >>     b_jbd:1 b_frozen_data:0000000000000000
> >>b_committed_data:0000000000000000
> >>     b_transaction:1 b_next_transaction:0 b_cp_transaction:0
> >>b_trans_is_running:0
> >>     b_trans_is_comitting:1 b_jcount:0 pg_dirty:0
> >>
> >>so it's already unmapped at this point.  Could
> >>journal_submit_data_buffers benefit from some buffer_mapped checks?  Or
> >>is that just a bandaid too late...
> >
> >Hmm..
> >
> >b_state: 0x114025 
> >               ^
> >means BH_Mapped. Isn't it ?
> 
> Whoops, I pasted in the wrong one, I guess, from earlier in the trace.  
> Here are the ones I was looking at:
> 
>  journal_submit_data_buffers():[fs/jbd/commit.c:242] needs writeout, adding 
>  to array pid 1690
>      b_state:0x104005 b_jlist:BJ_SyncData cpu:0 b_count:2 b_blocknr:30045
>      b_jbd:1 b_frozen_data:0000000000000000 
>      b_committed_data:0000000000000000
>      b_transaction:1 b_next_transaction:0 b_cp_transaction:0 
>      b_trans_is_running:0
>      b_trans_is_comitting:1 b_jcount:0 pg_dirty:1
> 
> and
> 
>  journal_submit_data_buffers():[fs/jbd/commit.c:242] needs writeout, adding 
>  to array pid 1836
>      b_state:0x114005 b_jlist:BJ_SyncData cpu:1 b_count:2 b_blocknr:27130
>      b_jbd:1 b_frozen_data:0000000000000000 
>      b_committed_data:0000000000000000
>      b_transaction:1 b_next_transaction:0 b_cp_transaction:0 
>      b_trans_is_running:0
>      b_trans_is_comitting:1 b_jcount:0 pg_dirty:1
  Umm, but these two traces confuse me:
1) They are different traces that those you wrote about initially,
aren't they? Because here we would not call sync_dirty_buffer() from
journal_dirty_data().
  BTW: Does this buffer trace lead to that Oops in submit_bh()? I guess not
as the buffer is not dirty...
  Am I right that now there are no Oopses because of buffers submitted
from the commit code? Only those from journal_dirty_data()?

2) Those buffers have strange states - they are !mapped, !dirty (so this
is fine) but they are also JBD_Dirty and ion BJ_SyncData. This is really
strange! Either it is ordered data buffer and should not be JBD_Dirty or
it is not ordered data buffer and then it should not be in BJ_SyncData!
The second buffer even has JBD_JWrite set so it really was metadabuffer
under commit and later something took it from the committing transaction
(without clearing the JWrite bit) and filed it in the SyncData list...
Umm, this reminds me something... <looks into commit code> Oh no, who could
write that BJ_Forget list handling.. me? ;)

I think the problem is in my change to BJ_Forget list handling - if we
find out buffer has b_next_transaction set, we just refile it
(previously we BUGged). That it just fine, except when we are in the
ordered mode and the buffer is reallocated as data. Then we refile the
buffer to BJ_Metadata or BJ_Reserved list, instead of BJ_SyncData.  What
then happens is uncertain but probably something gets (rightfully so)
confused and JBD_Dirty buffer gets to BJ_SyncData list.  This bug does
not seem to cause those problems with unmapped buffers but still we
should fix it as it is asking for trouble.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
