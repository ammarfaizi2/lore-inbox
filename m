Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129354AbRBAQwL>; Thu, 1 Feb 2001 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129972AbRBAQvv>; Thu, 1 Feb 2001 11:51:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:18629 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129354AbRBAQvn>;
	Thu, 1 Feb 2001 11:51:43 -0500
Date: Thu, 1 Feb 2001 16:49:58 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steve Lord <lord@sgi.com>
Cc: hch@caldera.de, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201164958.U11607@redhat.com>
In-Reply-To: <hch@caldera.de> <200102011608.f11G8j007752@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102011608.f11G8j007752@jen.americas.sgi.com>; from lord@sgi.com on Thu, Feb 01, 2001 at 10:08:45AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 10:08:45AM -0600, Steve Lord wrote:
> Christoph Hellwig wrote:
> > On Thu, Feb 01, 2001 at 08:14:58PM +0530, bsuparna@in.ibm.com wrote:
> > > 
> > > That would require the vfs interfaces themselves (address space
> > > readpage/writepage ops) to take kiobufs as arguments, instead of struct
> > > page *  . That's not the case right now, is it ?
> > 
> > No, and with the current kiobufs it would not make sense, because they
> > are to heavy-weight.  With page,length,offsett iobufs this makes sense
> > and is IMHO the way to go.
> 
> Enquiring minds would like to know if you are working towards this 
> revamp of the kiobuf structure at the moment, you have been very quiet
> recently. 

I'm in the middle of some parts of it, and am actively soliciting
feedback on what cleanups are required.  

I've been merging all of the 2.2 fixes into a 2.4 kiobuf tree, and
have started doing some of the cleanups needed --- removing the
embedded page vector, and adding support for lightweight stacking of
kiobufs for completion callback chains.

However, filesystem IO is almost *always* page aligned: O_DIRECT IO
comes from VM pages, and internal filesystem IO comes from page cache
pages.  Buffer cache IOs are the only exception, and kiobufs only fail
for such IOs once you have multiple buffer_heads being merged into
single requests.

So, what are the benefits in the disk IO stack of adding length/offset
pairs to each page of the kiobuf?  Basically, the only advantage right
now is that it would allow us to merge requests together without
having to chain separate kiobufs.  However, chaining kiobufs in this
case is actually much better than merging them if the original IOs
came in as kiobufs: merging kiobufs requires us to reallocate a new,
longer (page/offset/len) vector, whereas chaining kiobufs is just a
list operation.

Having true scatter-gather lists in the kiobuf would let us represent
arbitrary lists of buffer_heads as a single kiobuf, though, and that
_is_ a big win if we can avoid using buffer_heads below the
ll_rw_block layer at all.  (It's not clear that this is really
possible, though, since we still need to propagate completion
information back up into each individual buffer head's status and wait
queue.)

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
