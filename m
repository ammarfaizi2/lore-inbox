Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130857AbRBAXIM>; Thu, 1 Feb 2001 18:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbRBAXIC>; Thu, 1 Feb 2001 18:08:02 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:52787 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130857AbRBAXHy>; Thu, 1 Feb 2001 18:07:54 -0500
Date: Thu, 1 Feb 2001 15:04:48 -0500 (EST)
From: Chaitanya Tumuluri <chait@getafix.engr.sgi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010201174120.A11607@redhat.com>
Message-ID: <Pine.LNX.4.21.0102011243330.13626-100000@getafix.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Feb 01, 2001 at 06:05:15PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 01, 2001 at 04:16:15PM +0000, Stephen C. Tweedie wrote:
> > > > 
> > > > No, and with the current kiobufs it would not make sense, because they
> > > > are to heavy-weight.
> > > 
> > > Really?  In what way?  
> > 
> > We can't allocate a huge kiobuf structure just for requesting one page of
> > IO.  It might get better with VM-level IO clustering though.
> 
> A kiobuf is *much* smaller than, say, a buffer_head, and we currently
> allocate a buffer_head per block for all IO.
> 
> A kiobuf contains enough embedded page vector space for 16 pages by
> default, but I'm happy enough to remove that if people want.  However,
> note that that memory is not initialised, so there is no memory access
> cost at all for that empty space.  Remove that space and instead of
> one memory allocation per kiobuf, you get two, so the cost goes *UP*
> for small IOs.
> 
> > > > With page,length,offsett iobufs this makes sense
> > > > and is IMHO the way to go.
> > > 
> > > What, you mean adding *extra* stuff to the heavyweight kiobuf makes it
> > > lean enough to do the job??
> > 
> > No.  I was speaking abou the light-weight kiobuf Linux & Me discussed on
> > lkml some time ago (though I'd much more like to call it kiovec analogous
> > to BSD iovecs).
> 
> What is so heavyweight in the current kiobuf (other than the embedded
> vector, which I've already noted I'm willing to cut)?


Hi,

It'd seem that "array_len", "locked", "bounced", "io_count" and "errno" 
are the fields that need to go away (apart from the "maplist").

The field "nr_pages" would reincarnate in the kiovec struct (which is
is not a plain array anymore) as the field "nbufs". See below.

Based on what I've seen fly by on the lists here's my understanding of 
the proposed new kiobuf/kiovec structures:

===========================================================================
/*
 * a simple page,offset,length tuple like Linus wants it
 */
struct kiobuf {
	struct page *   page;   /* The page itself               */
	u_16       	offset; /* Offset to start of valid data */
	u_16       	length; /* Number of valid bytes of data */
};

struct kiovec {
	int             nbufs;          /* Kiobufs actually referenced */
	struct kiobuf * bufs;
}

/*
 * the name is just plain stupid, but that shouldn't matter
 */
struct vfs_kiovec {
        struct kiovec * iov;

        /* private data, mostly for the callback */
        void * private;

        /* completion callback */
        void (*end_io)  (struct vfs_kiovec *);
        wait_queue_head_t wait_queue;
};
===========================================================================

Is this correct? 

If so, I have a few questions/clarifications:

	- The [ll_rw_blk, scsi/ide request-functions, scsi/ide 
	  I/O completion handling] functions would be handed the 
	  "X_kiovec" struct, correct?

	- So, the soft-RAID / LVM layers need to construct their 
	  own "lvm_kiovec" structs to handle request splits and
	  the partial completions, correct? 

	- Then, what are the semantics of request-merges containing 
	  the "X_kiovec" structs in the block I/O queueing layers?
	  Do we add "X_kiovec->next", "X_kiovec->prev" etc. fields?

	  It will also require a re-allocation of a new and longer
	  kiovec->bufs array, correct?
	  
	- How are I/O error codes to be propagated back to the 
	  higher (calling) layers? I think that needs to be added
	  into the "X_kiovec" struct, no?

	- How is bouncing to be handled with this setup? (some state 
	  is needed to (a) determine that bouncing occurred, (b) find 
	  out which pages have been bounced and, (c) find out the 
	  bounce-page for each of these bounced pages).

Cheers,
-Chait.






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
