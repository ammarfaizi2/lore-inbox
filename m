Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSBKMlw>; Mon, 11 Feb 2002 07:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSBKMln>; Mon, 11 Feb 2002 07:41:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18311 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288952AbSBKMlb>;
	Mon, 11 Feb 2002 07:41:31 -0500
Date: Mon, 11 Feb 2002 23:41:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020211234127.B8661@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020208025313.A11893@redhat.com> <20020208151009.A1810@in.ibm.com> <20020208170257.A12788@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020208170257.A12788@redhat.com>; from bcrl@redhat.com on Fri, Feb 08, 2002 at 05:02:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 05:02:57PM -0500, Benjamin LaHaise wrote:
> On Fri, Feb 08, 2002 at 03:10:09PM +0530, Suparna Bhattacharya wrote:
> > You chose to add a kvec_cb field to the bio structure rather than use
> > bi_private ?
> 
> Yup.  I'm lazy.  Also, the cb struct actually needs 2 pointers, so just 
> bi_private isn't enough.
> 
> > For the raw path, you are OK since you never have to copy data out of 
> > the kvecs after i/o completion, and unmap_kvec only looks at veclet pages. 
> > So the fact block can change the offset and len fields in the veclets 
> > doesn't affect you, but thought I'd mention it as a point of caution
> > anyhow ...
> 
> Ugh.  That sounds like something bio should not be doing.  If someone 
> wants to fix it, such a patch would be much appreciated, otherwise it'll 
> wait until I'm back in Canada.

I had posted a suggestion on lkml earlier about this problem and one way 
to fix this - at that time I was thinking of bio->bi_voffset field (the
thought was that it could even be useful for cloning/splitting), and
was waiting for a decision from Jens about it. 
(Your kvec_dst is another way :))

However I'm now wondering if the rq->hard_cur_sectors can be used to 
achieve a similar effect (won't help with splitting, but might suffice
for the request transfer, without requiring new bio fields). 


> 
> 		-ben

------------------------------------------



>From suparna@in.ibm.com Fri Dec 28 15:50:06 2001
Date: Fri, 28 Dec 2001 15:50:06 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: bio_io_vec and kvecs integration
Message-ID: <20011228155006.A1519@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Status: RO
Content-Length: 1831
Lines: 36

Since bio, aio and zero-copy networking code all make use of a similar 
representation of a memory vector or i/o currency, I was looking at
what it would take at bio level to make sure that these descriptors can
be passed down as is to the block layer (without having to translate or
copy descriptors). 

Ben has already posted some patches to change bio and skbuff fragments to
his kveclet representation. Once all these subsystems share the same
representation, the next step is to be able to pass the vectors around as
is.

Some of the changes towards this sort of a thing went in during one of
the early updates to bio. The bio structure was modified to maintain a 
pointer to the vector list, so it can point to a vector list sent down
to it by the calling subsystem. Well, this change was also needed for
bio cloning (for lvm etc) and that's all its been used for so far since 
we don't have kvecs in the kernel yet.

I think just a little more work is needed to get bio layer to take in
a vector directly. This is because currently the block layer could modify
the bv_offset and bv_len fields in the vector directly (as part of
end_that_request_first processing) in case the whole segment/veclet/bvec 
doesn't get transfered/completed in one shot. This could result in 
unexpected effects for the higher layer if it tried to interpret the
vector or say copy data from it after the i/o completes.

So, should we add a bi_voffset field, which can be used in conjunction with
bi_vidx to locate exactly where to start the next i/o transfer from/to, and 
try to leave bv_offset and bv_len fields untouched during request processing ?
Or is there some other way to do this ?

One of these days we're going to have to sort out the kiobuf/kvec decision
for 2.5, but that's probably a discussion for a little later.

Regards
Suparna

