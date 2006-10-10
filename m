Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWJJOMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWJJOMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWJJOMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:12:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34218 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932126AbWJJOMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:12:05 -0400
Date: Tue, 10 Oct 2006 16:11:45 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Jones <davej@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com> <20061009225036.GC26728@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009225036.GC26728@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 09, 2006 at 02:59:25PM -0700, Badari Pulavarty wrote:
> 
>  > journal_dirty_data() would do submit_bh() ONLY if its part of the older
>  > transaction.
>  > 
>  > I need to take a closer look to understand the race.
>  > 
>  > BTW, is this 1k or 2k filesystem ?
> 
> (18:41:11:davej@gelk:~)$ sudo tune2fs -l /dev/md0  | grep size
> Block size:               1024
> Fragment size:            1024
> Inode size:               128
> (18:41:16:davej@gelk:~)$ 
> 
>  > How easy is to reproduce the problem ?
> 
> I can reproduce it within a few hours of stressing, but only
> on that one box.  I've not figured out exactly what's so
> special about it yet (though the 1k block thing may be it).
> I had been thinking it was a raid0 only thing, as none of
> my other boxes have that.
> 
> I'm not entirely sure how it got set up that way either.
> The Fedora installer being too smart for its own good perhaps.
  I think it's really the 1KB block size that makes it happen.
I've looked at journal_dirty_data() code and I think the following can
happen:
  sync() eventually ends up in journal_dirty_data(bh) as Eric writes.
There is finds dirty buffer attached to the comitting transaction. So it drops
all locks and calls sync_dirty_buffer(bh).
  Now in other process, file is truncated so that 'bh' gets just after EOF.
As we have 1kb buffers, it can happen that bh is in the partially
truncated page. Buffer is marked unmapped and clean. But in a moment the page
is marked dirty and msync() is called. That eventually calls
set_page_dirty() and all buffers in the page are marked dirty.
  The first process now wakes up, locks the buffer, clears the dirty bit
and does submit_bh() - Oops.

  This is essentially the same problem Badari found but in a different
place. There are two places that are arguably wrong...
  1) We mark buffer dirty after EOF. But actually that may be needed -
or what is the expected behaviour when we write into mmapped file after
EOF, then extend the file and do msync()?
  2) We submit a buffer after EOF for IO. This should be clearly avoided
but getting the needed info from bh is really ugly...

  What we could do is: Instead od calling sync_dirty_buffer() we do
something like:

lock_buffer(bh);
jbd_lock_bh_state(bh);
if (!buffer_jbd(bh) || jh != bh2jh(bh) || jh->b_transaction !=
  journal->j_committing_transaction) {
	jbd_unlock_bh_state(bh);
	unlock_buffer(bh);
}
jbd_unlock_bh_state(bh);
if (test_clear_buffer_dirty(bh)) {
	get_bh(bh);
	bh->b_end_io = end_buffer_write_sync;
	submit_bh(WRITE, bh);
	wait_on_buffer(bh);
}
else
	unlock_buffer(bh);

That should deal with the problem... Much more adventurous change would
be to remove the syncing code altogether - the new commit code makes
sure to write out each buffer just once so the livelock should not
happen now. But then we'd have to put running transaction in
j_next_transaction and refile data buffers instead of unfiling them.
That should actually give quite some performance improvement when
intensively rewriting files. But I guess that is JBD2 matter ;).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
