Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVJXVTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVJXVTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVJXVTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:19:10 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:6613 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751303AbVJXVTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:19:09 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 24 Oct 2005 22:18:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Hugh Dickins <hugh@veritas.com>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Carsten Otte <cotte@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
 broken
In-Reply-To: <Pine.LNX.4.61.0510242107580.6860@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0510242154560.24138@hermes-1.csi.cam.ac.uk>
References: <1130167005.19518.35.camel@imp.csi.cam.ac.uk> 
 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> 
 <7872.1130167591@warthog.cambridge.redhat.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
 <Pine.LNX.4.61.0510241648170.4338@goblin.wat.veritas.com>
 <Pine.LNX.4.64.0510242012120.24138@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.61.0510242107580.6860@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Hugh Dickins wrote:
> On Mon, 24 Oct 2005, Anton Altaparmakov wrote:
> > On Mon, 24 Oct 2005, Hugh Dickins wrote:
> > 
> > Now you got me completely confused.  Just when I thought I was 
> > understanding things.  (-;  Let me repeat what you say with some questions 
> > thrown in...  Please bear with me and help me beat some clue into my 
> > head...  (-:
> 
> Sorry for confusing you.  I can't answer many of your questions, because
> I don't know what you're doing or intending to do.  But you expressed an
> aversion to allocating pages unnecessarily.  Probably that made me think
> of memory allocation where you meant disk allocation.
> 
> Cutting a lot of questions...
> 
> > If your answer above is that the pages are normal page cache pages, then:
> 
> Nothing special needs doing if you choose to use normal page cache pages
> even for the holes.

Great!  I have no intention of using ZERO_PAGE().  Just normal page cache 
pages that are memset() to zero when sparse.  Phew.  /me relaxes (((-:

> Sorry for the confusion: I was just trying to warn you of some difficulties
> and their solution, if you were intending to pursue an alternative path.

No need to apologize!

If I had wanted to use the ZERO_PAGE() then you would be right and I would 
have missed all those things you said, but I never even knew about 
ZERO_PAGE().  (-:  I could well see that as a nice optimization at some 
point but for now I want it to work, not conserve memory.  (-:

Thank you very much for your comments!

In case you are curious, ntfs allows logical blocks of between 512 bytes 
and many hundreds of kiB in size (but always power of 2).  So to write to 
a mmap()ed sparse file using a PAGE_CACHE_SIZE page into the middle of a 
large, sparse logical block, I need to allocate the whole block on disk 
and cause all page cache pages to be zeroed and marked dirty.  To do this 
from writepage() is not possible due to deadlocks.  1) because the page is 
locked already and I would need to lock all the other pages in that 
logical block so we get into deadlock city with out of order page locking 
(I now only lock in ascending page index order and this requires no page 
with a higher index to be locked and dropping page lock in writepage is 
royal pain in the backside) and 2) because I am not meant to go allocating 
memory for more pages when the system is low on memory and running 
writepage exactly so it can reclaim some memory...

How I want to use page_mkdirty is that when it is run for a sparse logical 
block of size > PAGE_CACHE_SIZE, I allocate the logical block and get hold 
of all the pages (locked) that lie in that block and bring them uptodate 
(by zeroing if not uptodate already) and then mark them all dirty and 
release them again so the zeroes will make it to disk later.  Not sure 
whether to do the allocations even for logical blocks <= PAGE_CACHE_SIZE 
or just leave those to writepage...

In fact before allocating the block I plan to simply do a page cache read 
(via read_cache_page() which will give me uptodate, cleared pages) then do 
the allocation, then mark the pages dirty and that's it.  Writepage will 
later cause the buffers in the pages to be mapped to the new on-disk 
location and will write the dirty pages to disk.  (I may map the buffers 
in the pages there an then as an optimization given I have the pages and I 
know the on-disk location but I am not sure I will do that, at least 
probably not initially as it only makes the code more complex for very 
little gain.)

There is another ntfs complication and this is initialized size.  This is 
an evil beast that say that anything between initialized size and the real 
file size (inode->i_size), no matter whether it is allocated on disk or is 
a sparse hole or a mixture of the two, is to be read as zeroes.  The 
annoying thing here is that if you have a 1TiB file that is fully 
allocated on disk but has an initialized size of 0, and you write 1 byte 
somewhere towards the end of the file (or even at the end), you need to 
write to disk zeroes between file offset = initialized size (0 in this 
example) and the position of the write, in this case 1TiB.  Doing that 
from writepage could never fly.  But from page_mkdirty() it should work, 
again in same way as above for the sparse holes, I will read_cache_page() 
followed by set_page_dirty() for all pages between initialized size and 
the offset of the write.  It just means that the first write to such an 
mmaped file would take a _very_ long time in the specific example above...

Note for the above I plan to leverage 
fs/ntfs/file.c::ntfs_attr_extend_initialized() or at least an adapted form 
of it.  This function does the above described but for the file write(2) 
case where a user opens a file and writes somewhere beyond the initialized 
size...

I hope that explains what and why I am doing and I also hope that if you 
were not interested you didn't bother reading it all and hence never see 
this sentence.  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
