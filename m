Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbRENNMC>; Mon, 14 May 2001 09:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261251AbRENNLw>; Mon, 14 May 2001 09:11:52 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:43019 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261238AbRENNLm>; Mon, 14 May 2001 09:11:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Getting FS access events
Date: Mon, 14 May 2001 15:04:31 +0200
X-Mailer: KMail [version 1.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200105140224.f4E2OiE08257@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105132139590.21224-100000@penguin.transmeta.com> <200105140515.f4E5FwP10245@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200105140515.f4E5FwP10245@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Message-Id: <01051415043103.02742@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 07:15, Richard Gooch wrote:
> Linus Torvalds writes:
> > But sure, you can use bmap if you want. It would be interesting to
> > hear whether it makes much of a difference..
>
> I doubt bmap() would make any difference if there is a way of
> controlling when the I/O starts.
>
> However, this still doesn't address the issue of indirect blocks. If
> the indirect block has a higher bnum than the data blocks it points
> to, you've got a costly seek. This is why I'm still attracted to the
> idea of doing this at the block device layer. It's easy to capture
> *all* accesses and then warm the buffer cache.
>
> So, why can't the page cache check if a block is in the buffer cache?

That's not quite what you want, if only because there won't be anything 
in the buffer cache pretty soon.  What we really want is a block cache, 
tightly integrated with the page cache.  Readahead with a block cache 
would be more effective than our current file-based readahead.  For 
example, it handles the case where blocks of two files are interleaved.

Since we know that the page cache maps each block at most once, the 
optimal thing to do would be to just move a pointer from the block 
cache to the page cache whenever we can.  Unfortunately the layering in 
the VFS as it stands isn't friendly to this: typically we allocate a 
page in generic_file_read long before we ask the filesystem to map it.  
To test this zero-copy idea we'd need to replace generic_file_read and 
for mmap, filemap_nopage.

But we don't need anything so fancy to try out your idea, we just need 
a lvm-like device that can:

  - Maintain a block cache
  - Remap logical to physical blocks
  - Record the block accesses
  - Physically reorder the blocks according to the recorded order
  - Load a given region of disk into the block cache on command

None of this has to be particularly general to get to the benchmarking 
stage.  E.g, the 'block cache' only needs to cache one physical region.

The central idea here is that you obviously can't do any better than to 
have all the blocks you want to read at boot physically together on 
disk.

The advantage of using this lvm-style remapping is, it will work for 
any filesystem.  The disadvantage is that the ordering is then cast in 
stone - after the system is up it might not like the ordering you chose 
for the boot, and the elevator will be completely confused ;-)  But the 
thing is, everything you need to measure the boot performance is 
together in one place, just one device driver to write.  Then once you 
know what the perfect result is you have a yardstick to measure the 
effectivenns of other, less intrusive approaches.

I took a look at the lvm and md code to see if there's a quick way to 
press them into service for this test, and there probably is, but the 
complexity there is daunting.  I think starting with a clean sheet and 
writing a new driver would be easier.

--
Daniel
