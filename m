Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBEOjw>; Mon, 5 Feb 2001 09:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129937AbRBEOjm>; Mon, 5 Feb 2001 09:39:42 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:54801 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129245AbRBEOja>; Mon, 5 Feb 2001 09:39:30 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@caldera.de>, Andi Kleen <ak@suse.de>
Message-ID: <CA2569EA.00506354.00@d73mta03.au.ibm.com>
Date: Mon, 5 Feb 2001 20:01:45 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Hi,
>
>On Sun, Feb 04, 2001 at 06:54:58PM +0530, bsuparna@in.ibm.com wrote:
>>
>> Can't we define a kiobuf structure as just this ? A combination of a
>> frag_list and a page_list ?
>

>Then all code which needs to accept an arbitrary kiobuf needs to be
>able to parse both --- ugh.
>

Making this a little more explicit to help analyse tradeoffs:

/* Memory descriptor portion of a kiobuf - this is something that may get
passed around between layers and subsystems */
struct kio_mdesc {
     int nr_frags;
     struct frag *frag_list;
     int nr_pages;
     struct page **page_list;
     /* list follows */
};

For block i/o requiring #1 type descriptors, the list could have allocated
extra space for:
struct kio_type1_ext {
     struct frag frag;
     struct page *pages[NUM_STATIC_PAGES];
}

For n/w i/o or cases requiring  #2 type descriptors, the list could have
allocated extra space for:

struct kio_type2_ext {
     struct frag frags[NUM_STATIC_FRAGS];
     struct page *page[NUM_STATIC_FRAGS];
}


struct  kiobuf {
     int            status;
     wait_queue_head_t   waitq;
     struct kio_mdesc    mdesc;
     /* list follows - leaves room for allocation for mem descs, completion
sub structs etc */
}

Code that accepts an arbitrary kiobuf needs to do the following :
     process the fragments one by one
          - type #1 case, only one fragment would typically be there, but
processing it would involve crossing all pages in the page list
               So extra processing vs a kiobuf with single <offset, len>
pair, involves the following:
                    dereferencing the frag_list pointer
                    checking the nr_frags field
          - type #2 case, the number of fragments would be equal to or
greater than number of pages, so processing will typically go over each
fragments and thus cross each page in the list one by one
               So extra processing vs a kiobuf with per-page <offset, len>
pairs, involves
                    deferencing the page list entry (involves computing the
page-index in the page_list from the offset value)
                    check if offset+len doesn't fall outside the page


Boils down to approx one extra dereference and one comparison  per kiobuf
for the common cases (have I missed something critical ?)  vs the most
optimized choices of descriptors for those cases.

In terms of resource consumption (extra bytes taken up), two fields extra
per kiobuf chain (e.g. nr_frags and frag_list pointer when it comes to #1),
i.e. a total of 8 bytes, for the common cases vs the most optimized choice
of structures for those cases.

This seems to be more uniformly balanced across #1 and #2 cases, than an
<offset, len> for every page, as well as an overall <offset, len>. But,
then, come to think of it, since the need for lightweight structures is
greater in the case of #2, should the point of balance (if at all we want
to find one) be tilted towards #2 ?

On the other hand, since having a common structure does involve extra bytes
and cycles, if there are very few situations where we need both #1 and #2 -
conversion only at subsystem boundaries like i2o does may turn out to be
better.

Oh well ...


>> BTW, We could have a higher level io container that includes a <status>
>> field and a <wait_queue_head> to take care of i/o completion
>
>IO completion requirements are much more complex.  Think of disk
>readahead: we can create a single request struct for an IO of a
>hundred buffer heads, and as the device driver satisfies that request,
>it wakes up the buffer heads as it goes.  There is a separete
>completion notification for every single buffer head in the chain.
>
I understand the requirement of independent completion notifiers for higher
level buffers/other structures, since they are indeed independently usable
structures. That was one aspect that I thought I was being able to address
in the cev_wait design based on wait_queue wakeup functions.
The way it would work is that there would be multiple wakeup functions
registered on the container for the big request, each wakeup function being
responsible for waking up a higher level buffer. This way, the linkage
information is actually external to the buffer structures (which seems
reasonable, since it is only required while the i/o is happening, unless
there is another reason to keep a more lasting association)

>It's the very essence of readahead that we wake up the earlier buffers
>as soon as they become available, without waiting for the later ones
>to complete, so we _need_ this multiple completion concept.
>

I can understand this in principle, but when we have a single request going
down to the device that actually fills in multiple buffers, do we get
notified (interrupted) by the device before all the data in that request
got transferred ? I mean, how do we know that some buffers have become
available until the overall device request has completed (unless of course
the request actually gets broken up at this level and completed bit by
bit).


>Which is exactly why we have one kiobuf per higher-level buffer, and
>we chain together kiobufs when we need to for a long request, but we
>still get the independent completion notifiers.

As I mentioned above, the alternative is to have the i/o completion related
linkage information within the wakeup structures instead. That way, it
doesn't matter to the lower level driver what higher level structure we
have above (maybe buffer heads, may be page cache structures, may be
kiobufs). We only chain together memory descriptors for the buffers during
the io.

>
>Cheers,
> Stephen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
