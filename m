Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWJKRzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWJKRzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWJKRzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:55:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22463 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161164AbWJKRzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:55:05 -0400
Subject: Re: 2.6.18 ext3 panic.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <esandeen@redhat.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061011142205.GB24508@atrey.karlin.mff.cuni.cz>
References: <20061002231945.f2711f99.akpm@osdl.org>
	 <452AA716.7060701@sandeen.net>
	 <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>
	 <20061009225036.GC26728@redhat.com>
	 <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
	 <452C18A6.3070607@redhat.com>
	 <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>
	 <452C4C47.2000107@sandeen.net>
	 <20061011103325.GC6865@atrey.karlin.mff.cuni.cz>
	 <452CF523.5090708@sandeen.net>
	 <20061011142205.GB24508@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 10:54:44 -0700
Message-Id: <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 16:22 +0200, Jan Kara wrote:
> > Jan Kara wrote:
> > 
> > >  Umm, but these two traces confuse me:
> > >1) They are different traces that those you wrote about initially,
> > >aren't they? Because here we would not call sync_dirty_buffer() from
> > >journal_dirty_data().
> > >  BTW: Does this buffer trace lead to that Oops in submit_bh()? I guess not
> > >as the buffer is not dirty...
> > 
> > They do wind up at the same oops, from the same "testcase" (i.e. beat the 
> > tar out of the filesystem with multiple fsx's and fsstress...)
> > 
> > The buffer is not dirty at that tracepoint because it has just done
> >                 if (locked && test_clear_buffer_dirty(bh)) {
> > prior to the tracepoint...
>   Oh, I see. OK.
> 
> > 
> > See the whole traces at
> > 
> > http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
> > http://people.redhat.com/esandeen/traces/eric_ext3_oops2.txt
>   Hmm, those traces look really useful. I just have to digest them ;).
> 
> > As an aside, when we do journal_unmap_buffer... should it stay on 
> > t_sync_datalist?
>   Yes, it should and it seems it really was removed from it at some
> point. Only later journal_dirty_data() came and filed it back to the
> BJ_SyncData list. And the buffer remained unmapped till the commit time
> and then *bang*... It may even be a race in ext3 itself that it called
> journal_dirty_data() on an unmapped buffer but I have to read some more
> code.
> 

Yes. calling journal_dirty_data() on unmapped buffer can definitely
happen. (only thing i am not sure is - why doesn't happen with a
simple testcase like dirtying only a part of a page in 1k filesystem.
I am not sure why we need journal_unmap_buffer() in the sequence).


Here is what I think is happening..

journal_unmap_buffer() - cleaned the buffer, since its outside EOF, but
its a part of the same page. So it remained on the page->buffers
list. (at this time its not part of any transaction).

Then, ordererd_commit_write() called journal_dirty_data() and we added
all these buffers to BJ_SyncData list. (at this time buffer is clean -
not dirty).

Now msync() called __set_page_dirty_buffers() and dirtied *all* the
buffers attached to this page.

journal_submit_data_buffers() got around to this buffer and tried to
submit the buffer...

Andrew is right - only option for us to check the filesize in the
write out path and skip the buffers beyond EOF.

Thanks,
Badari

