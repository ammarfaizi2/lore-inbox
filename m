Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268955AbRG3Pl7>; Mon, 30 Jul 2001 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268975AbRG3Plj>; Mon, 30 Jul 2001 11:41:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:61196 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268955AbRG3Ple>; Mon, 30 Jul 2001 11:41:34 -0400
Message-ID: <3B65818D.13AA5A1D@zip.com.au>
Date: Tue, 31 Jul 2001 01:47:25 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>,
        "Gryaznova E." <grev@namesys.botik.ru>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <272900000.996506656@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Mason wrote:
> 
> On Saturday, July 28, 2001 03:28:05 AM +1000 Andrew Morton
> <akpm@zip.com.au> wrote:
> 
> [ patch to trigger data writes before commit in reiserfs ]
> 
> >
> > There's no disruption to disk format - it just simulates
> > the user typing `sync' at the right time.  I think the
> > concept is sound, and I'm sure Chris can find a more efficient
> > way...
> 
> Well, its gets points for simplicity ;-)

Well, I tried system("/bin/sync"); but that didn't link.

> What I think we need is for commit_write to put new buffers a per super
> list of new buffers, and then the journal code can flush that list on
> commit.

whee.  Now there's an idea - If the fs keeps track of all its inodes
then you can traverse those and flush out the i_dirty_buffers ring
on each one.

writepage() output is a problem, but that never sits well with
journalling.  I guess one could do fdatasync/fdatawait against
the same list of inodes.

> Since all the filesystems already mark things BH_New, it seems a good
> choice to let commit_write look for BH_New buffers and put them on this new
> list.  But, the only place BH_New seems to get cleared right now is
> unmap_buffer, which only gets called from block_flushpage.
> 
> Is there any reason we can't just clear BH_New before writing the buffer
> out?  It looks like a bug to leave it set the way we do now.

I think it can be cleared as soon as the get_block() caller has looked at
it, actually.  test_and_clear_bit.  The lifecycle of the various buffer_head
fields is exhasperatingly fluffy.

I'd be reluctant to add another eight bytes to buffer_head though.
It's 96 now, which is a nice number.  b_inode can go - it's just
a boolean.  b_size and b_list can be crunched into a single byte..

How about just doing it via the inodes?

-
