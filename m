Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318419AbSHEMfc>; Mon, 5 Aug 2002 08:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318420AbSHEMfc>; Mon, 5 Aug 2002 08:35:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13983 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318419AbSHEMfa>; Mon, 5 Aug 2002 08:35:30 -0400
Date: Mon, 5 Aug 2002 18:08:48 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@zip.com.au
Subject: Re: [PATCH] Bio Traversal Changes
Message-ID: <20020805180848.A2223@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <suparna@in.ibm.com> <200208021348.g72Dm7q03058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208021348.g72Dm7q03058@localhost.localdomain>; from James.Bottomley@steeleye.com on Fri, Aug 02, 2002 at 08:48:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 08:48:06AM -0500, James Bottomley wrote:
> The SCSI changes (small that they are) look reasonable.
> 
> This does look like it exposes an existing problem in the tag/barrier 
> approach, though.
> 
> The bio can be split by making multiple requests over segements of the bio, 
> correct?  If this is a BIO_RW_BARRIER, then each of these requests will be a 

It doesn't quite go as far as multiple requests in the full sense
of what a struct request represents.

All it allows at the moment is the ability for a driver to setup 
a command that involves multiple sequential transfers to complete 
a single request where each transfer covers a chunk of data for 
a portion of the request. Variations like:

	setup command
	process_that_request_first - chunk 1
	[interrupt, status check]
	end_that_request_first	- chunk1
	process_that_request_first - chunk 2
	[interrupt, status check]
	end_that_request_first - chunk 2

or

	setup command
	process_that_request_first - chunk 1
	process_that_request_first - chunk 2
	process_that_request_first - chunk 3
	..
	end_that_request_first - chunk 1 + 2 + 3

There is only one call to ->request_fn for the entire request, and
the drivers manages things underneath. The chunks are expected to
complete sequentially. In the situation where the request is
restarted in the event of an error (say), the submission pointers
are rolled back to the last (successfully) completed point
before issuing the request again.

Right now I do not know what kind of use there could be for this
in the context of SCSI in general (in IDE, as I had mentioned 
before, PIO commands, especially multi-count writes follow such
a pattern). You would probably be in a better position to
do so, and suggestions to improve this in that regard are very
welcome indeed. Which is why it is harder for me to decide if the 
situation you suggest could arise with SCSI, since its not clear
whether such pieces/sub-requests are generated in that case.

</ramble>
I must say that I initially did think that this could be 
extended to the more generic case which you probably are 
referring to and that such an approach could take away the need 
to split bios in certain cases (i.e. when the i/o is destined for 
a single queue). Later it appeared that trying to cover 
the case where each of these pieces gets queued up and might 
complete out of order (requiring a tag to correlate things on 
completion), would most likely boil down to trying to maintain 
all the state that struct request does today. 

You might recall the discussion with Niels at the kernel 
summit about the alternate possibility of having two request 
structs pointing to the same bio, now that we track submission 
state separately. In this case, though, as completion state is 
still indicated in the bio, it could get a little inelegant 
to handle in the context of remembering partial completion 
state for two requests simultaneously. Whether partial 
completion at a granularity of less than one bio makes sense, 
however, is another question that discussions with 
Barthlomiej has brought up.

At the same time, if we can afford to allocate a fresh
request struct, then probably allocating a bio (possibly from 
a pool associated with the queue) may not sound all that bad.
</ramble>


> REQ_BARRIER.  However, in the SCSI paradigm where we translate REQ_BARRIER to 
> ordered tag, each of the requests will get a new ordered tag as it comes back 
> around through end_that_request_first, potentially allowing other tags to be 
> inserted in between these, which would be incorrect, since other bios would be 
> inserted in between the segments of this one, thus violating the barrier.
> 
> Is the above correct?  If it is, I may have finally found a use for linked 
> scsi tasks (gives you the ability to have one tag cover multiple commands).

Would be nice (for me) to understand this in more detail. 
There might be some possibilities.
Any pointers that I can look up to get a clearer idea ?

Does completion notification happen only when all the commands 
covered by a single tag complete ? Otherwise, what is the ordering 
amongst the multiple commands in question (do they complete in 
serial order as well) ?

Regards
Suparna

> 
> James
> 
> 
