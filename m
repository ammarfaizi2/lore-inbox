Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319078AbSHFMO1>; Tue, 6 Aug 2002 08:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319079AbSHFMO1>; Tue, 6 Aug 2002 08:14:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37097 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319078AbSHFMOZ>;
	Tue, 6 Aug 2002 08:14:25 -0400
Date: Tue, 6 Aug 2002 17:47:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@zip.com.au
Subject: Re: [PATCH] Bio Traversal Changes
Message-ID: <20020806174725.A2901@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <suparna@in.ibm.com> <200208051547.g75FldT11138@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208051547.g75FldT11138@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Aug 05, 2002 at 10:47:39AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 10:47:39AM -0500, James Bottomley wrote:
> suparna@in.ibm.com said:
> > There is only one call to ->request_fn for the entire request, and the
> > drivers manages things underneath. The chunks are expected to complete
> > sequentially. In the situation where the request is restarted in the
> > event of an error (say), the submission pointers are rolled back to
> > the last (successfully) completed point before issuing the request
> > again. 
> 
> Yes, that's the way I thought it would operate.
> 
> suparna@in.ibm.com said:
> > I must say that I initially did think that this could be  extended to
> > the more generic case which you probably are  referring to and that
> > such an approach could take away the need  to split bios in certain
> > cases (i.e. when the i/o is destined for  a single queue). Later it
> > appeared that trying to cover  the case where each of these pieces
> > gets queued up and might  complete out of order (requiring a tag to
> > correlate things on  completion), would most likely boil down to
> > trying to maintain  all the state that struct request does today.  
> 
> For this more generic case, most of our problems seem to be because the 
> barrier has width:  It actually belongs to an I/O request.  If the barrier had 
> zero width (i.e. it was simply a barrier in the stream with no I/O attached) 
> then it would be much easier to preserve it correctly across this (or any 
> other) type of bio splitting.  It would also make it much more obvious to the 
> implementing driver where the barrier was supposed to be in the I/O stream, 
> and would allow more efficient "wait for completion" barrier implementations 
> for drivers that couldn't enforce it any other way.
> 
> > Would be nice (for me) to understand this in more detail.  There might
> > be some possibilities. Any pointers that I can look up to get a
> > clearer idea ? 
> 
> The SCSI standards (www.t10.org) are the only real authoritative source (with 
> even some explanation).  However, I'll do my best to summarise.
> 
> In SCSI, commands are allowed to disconnect, that is suspend temporarily while 
> the device does other things.  When the device implements tag command 
> queueing, it is allowed to disconnect one command and subsequently reconnect 
> (restart) a different one.  In theory, this means that we can have multiple 
> active I/Os at once.  The way you signal to the scsi device that you want a 
> barrier is to label one or more of the tags as "ordered" which means that the 
> device must complete all I/O of tags prior to the ordered one before it and 
> may not begin I/O of subsequent tags until the ordered tag has completed.
> 
> looping a single request over a big bio means that the SCSI device sees the 
> I/O as a discrete stream of tags.  However, we lose throughput if we stall the 
> queue waiting for this single bio to complete and we can't work out what the 
> next tag is until the prior tag completes.  In the non barrier case, 
> everything will still be OK as long as the queue isn't stalled because we'll 
> be getting throughput from other bios coming down.
> 
> I think basically, I'd like to translate as much of the bio as I can into SCSI 
> tags to improve throughput and each tag currently requires a struct request.

I didn't think of the possibility of serializing the chunks
of a single request, while letting other requests on the queue through
in the no barrier situation. That's a thought, though it might result 
in non-optimal scans ... and in that sense affect the throughput.
But, now I see why the barrier case was the one you were mainly worried
about.

> 
> > Does completion notification happen only when all the commands
> > covered by a single tag complete ? Otherwise, what is the ordering
> > amongst the multiple commands in question (do they complete in  serial
> > order as well) ? 
> 
> Yes and no.  You get a special completion code (INTERMEDIATE_TASK_COMPLETE) 
> which says "I've finished this bit, give me the next part".  You don't get a 
> real SCSI completion until the last part of the linked task set completes.  
> The task is linked sequentially, so it does complete in serial order.

Thanks for the explanation. I think I get the gist.

> 
> However, Don't worry about the linked task stuff, it's a rather esoteric area 
> of the SCSI standard (that allows a single tag to be used across multiple I/Os 
> in very much the same way the bio splitting works) which, on mature 
> reflection, probably isn't such a good idea to use since I'd be doubtful about 
> how well it's implemented in the devices we have to deal with.

OK. 

Regards
Suparna

> 
> James
> 
> 
