Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289661AbSAJUpV>; Thu, 10 Jan 2002 15:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289667AbSAJUpC>; Thu, 10 Jan 2002 15:45:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:29707 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289669AbSAJUot>; Thu, 10 Jan 2002 15:44:49 -0500
Message-ID: <3C3DFBEF.BA050536@zip.com.au>
Date: Thu, 10 Jan 2002 12:39:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagecache lock ordering
In-Reply-To: <3C3CE5D6.2204BD27@zip.com.au> <Pine.LNX.4.21.0201101332560.1121-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Wed, 9 Jan 2002, Andrew Morton wrote:
> > Hugh Dickins wrote:
> > >
> > > There's two places, do_buffer_fdatasync
> >
> > generic_buffer_fdatasync() and hence do_buffer_fdatasync()
> > are completely unused.  It may be simpler to just trash
> > them.
> 
> Oh, nice observation.  writeout_one_page could be trashed at
> the same time (but not waitfor_one_page, still in use elsewhere).

I'm struggling to see a use for generic_buffer_fdatasync().  Maybe
for a filesystem which doesn't implement ->writepage()?  Dunno.

The only places where waitfor_one_page() is used are in the
directory-in-pagecache filesystems, for synchronous directories.
And the usage there seems completely incorrect.

They call ->commit_write(), which leaves the buffers dirty
and unlocked, then they call waitfor_one_page(), which does nothing
at all because the buffers are unlocked.  I/O was never started,
we didn't sync the blocks.

I feel I'm missing somethng here, because I checked that code
a few months back.  hmmm..

> But what's the chance that an out-of-tree filesystem might
> be using generic_buffer_fdatasync, which is still prototyped
> and exported?  Remove from 2.5 but leave in 2.4?  I'd like to
> see them go completely - revenge for being misled by them -
> but Marcelo may decide otherwise.

This code is untested, and there is no way for us to test it.
And now we think it may be deadlocky.  It has to go.

But the withdrawal of an exported API from 2.4.x is a policy
decision for Marcelo to make.

> ...
> 
> > I get the feeling that a lot of this would be cleaned up
> > if presence on an LRU contributed to page->count.  It
> > seems strange, kludgy and probably racy that this is not
> > the case.
> 
> That makes a lot of sense: but I feel much safer in agreeing
> with you than in making the corresponding changes!
> 

Heh.  I'll do the death-to-generic_buffer_fdatasync patch, and
I'll check whether we need to convert the dir-in-pagecache
filesytems over to writepage/wait_on_page.

-
