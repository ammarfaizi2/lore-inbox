Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSEBUfo>; Thu, 2 May 2002 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEBUfn>; Thu, 2 May 2002 16:35:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7439 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315410AbSEBUfi>;
	Thu, 2 May 2002 16:35:38 -0400
Message-ID: <3CD1A2E2.A240823C@zip.com.au>
Date: Thu, 02 May 2002 13:34:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <3CD191C5.AC09B1F4@zip.com.au> <Pine.GSO.4.21.0205021530010.16530-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 2 May 2002, Andrew Morton wrote:
> > A few things..
> >
> [snip]
> 
> Andrew, judging by the filenames he'd mentioned, I suspect that he runs
> innd.  I.e. one of the very few programs heavily using truncate().  And
> no, it doesn't promise anything good - last time we had crap in truncate/mmap
> interaction it was a hell to fix.
> 
> I suspect that you had screwed the truncate exclusion warranties up.  If
> _any_ IO happens in the area currently manipulated by ->truncate() - you
> are screwed and results would look pretty much like the things mentioned
> in bug report.

OK, thanks.  That's something to go on.

The only change which comes to mind is discard_buffer() - it's
no longer clearing BH_Uptodate.  Because for the partial page
at the end of the mapping, buffers outside i_size were zeroed
in truncate_partial_page().  But with (presumed) 4k blocksize,
it can't be that.

ext3_writepage() can hold a reference against the buffers
after the page has come unlocked, so a try_to_free in the
right window will fail, which will leave the page floating
about on the page LRU, not mapped into any address_space,
clean, not uptodate, but with uptodate buffers.  Nobody
but the VM should ever find that page, but it does make more
sense to mark that buffer not uptodate.  This would only
happen on super-heavy SMP loads.

So hmm.

There's a small SMP-only race in truncate_list_pages:
the test for PageWriteback happens against an unlocked
page.  There's a three-instruction window where writeback
could start up.  That won't be it, but I'll fix that.

-
