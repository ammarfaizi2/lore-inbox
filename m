Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVJXTjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVJXTjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVJXTjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:39:17 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:1753 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751235AbVJXTjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:39:16 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 24 Oct 2005 20:38:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Hugh Dickins <hugh@veritas.com>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Carsten Otte <cotte@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
 broken
In-Reply-To: <Pine.LNX.4.61.0510241648170.4338@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0510242012120.24138@hermes-1.csi.cam.ac.uk>
References: <1130167005.19518.35.camel@imp.csi.cam.ac.uk> 
 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> 
 <7872.1130167591@warthog.cambridge.redhat.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
 <Pine.LNX.4.61.0510241648170.4338@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Hugh Dickins wrote:
> On Mon, 24 Oct 2005, Anton Altaparmakov wrote:
> > I don't really mind either way.  I am stuck with ntfs at the moment at
> > the point where I am either going to use my own ->nopage handler to
> > allocate on-disk clusters or have a ->page_mkwrite handler do it.  The
> > former is not nice as it means we allocate space even when only reading
> > whilst the later is very nice as it only triggers when someone actually
> > does an mmapped write.
> 
> A complication to beware of there (and I may be misunderstanding, but
> the point is worth making).  

Now you got me completely confused.  Just when I thought I was 
understanding things.  (-;  Let me repeat what you say with some questions 
thrown in...  Please bear with me and help me beat some clue into my 
head...  (-:

> If you have already mmaped readonly zero pages into some mms, you'll 

When you say "zero pages" you mean just normal page cache pages that are 
fully zero because they are in a sparse region of a file?

Or do you mean ZERO_PAGE(address) stuff like in xip_file_nopage()?

And when you say "mapped readonly zero pages into some mms" you mean that 
there are several processes which have done mmap(PROT_READ, MAP_SHARED) on 
the same file, right?

Or do you mean mmap(PROT_READ|PROT_WRITE, MAP_SHARED)?

Or something else?

> need to update those mms with the new shared writable pages once they 
> are allocated.

If your answer above is that the pages are normal page cache pages, then:

Is it to reflect the fact that the pages are now marked writable?

Or is it to reflect the fact that the pages are now allocated on disk 
(i.e. update the page buffers)?

Or am I barking up the wrong tree and the reasons are altogether 
different?

If your answer above was ZERO_PAGE(), then:

Is it to get rid of the zero page and replace it with the _real_, now 
allocated and writable page?

> That put me off using page_mkwrite in tmpfs, but Carsten has solved the 
> problem (though not going so far as to use page_mkwrite) with his 
> xip_file_nopage in mm/filemap_xip.c - has to go down the vma_prio_tree 
> like rmap.
>  
> (That code is a little different in -mm, partly because of my page
> table locking changes, partly because of Nick's ZERO_PAGE changes.)
> 
> Hmm, strictly speaking, it should be substituting the new page
> when VM_LOCKED: whether that's worth the effort of implementing....

I have now read filemap_xip.c as it is in Linus kernel and see the 
ZERO_PAGE().  I guess that that is what you were talking about above all 
along and not normal page cache pages that happen to be zero.  Correct?

In which case am I correct in saying that as long as I use 
filemap_nopage() and filemap_populate(), I can ignore your comment about 
updating mms as ZERO_PAGE() will _never_ be mapped and in fact just 
normal page cache pages containing zeroes will be mapped?

If that is correct then great.  Otherwise I have missed the plot and would 
be very grateful if you were to impart some clue upon me.  (-:

Thanks a lot for your help!  Much appreciated!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
