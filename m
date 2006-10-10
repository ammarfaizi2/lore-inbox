Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWJJSnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWJJSnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWJJSnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:43:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030211AbWJJSnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:43:14 -0400
Date: Tue, 10 Oct 2006 11:42:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: Dave Jones <davej@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Eric Sandeen <sandeen@sandeen.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com
Subject: Re: 2.6.18 ext3 panic.
Message-Id: <20061010114253.3f76c428.akpm@osdl.org>
In-Reply-To: <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
References: <20061002194711.GA1815@redhat.com>
	<20061003052219.GA15563@redhat.com>
	<4521F865.6060400@sandeen.net>
	<20061002231945.f2711f99.akpm@osdl.org>
	<452AA716.7060701@sandeen.net>
	<1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>
	<20061009225036.GC26728@redhat.com>
	<20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 16:11:45 +0200
Jan Kara <jack@suse.cz> wrote:

> > On Mon, Oct 09, 2006 at 02:59:25PM -0700, Badari Pulavarty wrote:
> > 
> >  > journal_dirty_data() would do submit_bh() ONLY if its part of the older
> >  > transaction.
> >  > 
> >  > I need to take a closer look to understand the race.
> >  > 
> >  > BTW, is this 1k or 2k filesystem ?
> > 
> > (18:41:11:davej@gelk:~)$ sudo tune2fs -l /dev/md0  | grep size
> > Block size:               1024
> > Fragment size:            1024
> > Inode size:               128
> > (18:41:16:davej@gelk:~)$ 
> > 
> >  > How easy is to reproduce the problem ?
> > 
> > I can reproduce it within a few hours of stressing, but only
> > on that one box.  I've not figured out exactly what's so
> > special about it yet (though the 1k block thing may be it).
> > I had been thinking it was a raid0 only thing, as none of
> > my other boxes have that.
> > 
> > I'm not entirely sure how it got set up that way either.
> > The Fedora installer being too smart for its own good perhaps.
>   I think it's really the 1KB block size that makes it happen.
> I've looked at journal_dirty_data() code and I think the following can
> happen:
>   sync() eventually ends up in journal_dirty_data(bh) as Eric writes.
> There is finds dirty buffer attached to the comitting transaction. So it drops
> all locks and calls sync_dirty_buffer(bh).
>   Now in other process, file is truncated so that 'bh' gets just after EOF.
> As we have 1kb buffers, it can happen that bh is in the partially
> truncated page. Buffer is marked unmapped and clean. But in a moment the page
> is marked dirty and msync() is called. That eventually calls
> set_page_dirty() and all buffers in the page are marked dirty.
>   The first process now wakes up, locks the buffer, clears the dirty bit
> and does submit_bh() - Oops.
> 
>   This is essentially the same problem Badari found but in a different
> place. There are two places that are arguably wrong...
>   1) We mark buffer dirty after EOF. But actually that may be needed -
> or what is the expected behaviour when we write into mmapped file after
> EOF, then extend the file and do msync()?

yup.

>   2) We submit a buffer after EOF for IO. This should be clearly avoided
> but getting the needed info from bh is really ugly...

Things like __block_write_full_page() avoid this by checking the block's
offset against i_size.  (Not racy against truncate-down because the page is
locked, not racy against truncate-up because the bh is zero and
up-to-date).

But for jbd writeout we don't hold the page lock, so checking against
bh->b_page->host->i_size is a bit racy.

hm.  But we do lock the buffers in journal_invalidatepage(), so checking
i_size after locking the buffer in the writeout path might get us there.


