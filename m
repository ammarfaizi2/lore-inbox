Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287894AbSAUTNc>; Mon, 21 Jan 2002 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSAUTNO>; Mon, 21 Jan 2002 14:13:14 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:33031
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S287894AbSAUTNF>; Mon, 21 Jan 2002 14:13:05 -0500
Subject: Re: Possible Idea with filesystem buffering.
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0201202100340.455-100000@coredump.sh0n.net>
In-Reply-To: <Pine.LNX.4.40.0201202100340.455-100000@coredump.sh0n.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 21 Jan 2002 14:15:48 -0500
Message-Id: <1011640576.21632.0.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody wants to comment on this? :(

Shawn.

On Sun, 2002-01-20 at 21:29, Shawn Starr wrote:
> 
> On Mon, 21 Jan 2002, Anton Altaparmakov wrote:
> 
> > [snip]
> > At 00:57 21/01/02, Hans Reiser wrote:
> > [snip]
> >  > Would be best if VM told us if we really must write that page.
> >
> > In theory the VM should never call writepage unless the page must be writen
> > out...
> >
> > But I agree with you that it would be good to be able to distinguish the
> > two cases. I have been thinking about this a bit in the context of NTFS TNG
> > but I think that it would be better to have a generic solution rather than
> > every fs does their own copy of the same thing. I envisage that there is a
> > flush daemon which just walks around writing pages to disk in the
> > background (there could be one per fs, or a generic one which fs register
> > with, at their option they could have their own of course) in order to keep
> > the number of dirty pages low and in order to minimize data loss on the
> > event of system/power failure.
> >
> > This demon requires several interfaces though, with regards to journalling
> > fs. The daemon should have an interface where the fs can say "commit pages
> > in this list NOW and do not return before done", also a barrier operation
> > would be required in journalling context. A transactions interface would be
> > ideal, where the fs can submit whole transactions consisting of writing out
> > a list of pages and optional write barriers; e.g. write journal pages x, y,
> > z, barrier, write metadata, perhaps barrier, finally write data pages a, b,
> > c. Simple file systems could just not bother at all and rely on the flush
> > daemon calling the fs to write the pages.
> >
> > Obviously when this daemon writes pages the pages will continue being
> > there. OTOH, if the VM calls write page because it needs to free memory
> > then writepage must write and clean the page.
> >
> 
> if they are dirty and written immediately to the disk they can be cleaned
> from the queue. It would be nice if there was some way to have a checksum
> verify the data was written back then wipe it from the queue.
> 
> As an example: 5 operations requested, 2 already in queue.
> 
> In queue) DIRTY write to disk (this task has been in the queue for a
> while)
> 
> In queue) not 'old' memory but must be written to disk
> 
> pending queue:
> 
> 1) read operation
> 2) read operation
> 3) Write operation
> 4) write operation
> 
> The daemon should resort the priority write dirty pages to disk then write
> nay other pages that are left on queue, then get to read pages.
> 
> 
> Notes:
> 
> If there is only one operation in the queue (say write) and nothing else
> comes along, then the daemon should force-write the data back to disk
> after a period of timeout (the memory in the slot becomes dirty)
> 
> If there's too many tasks in the queue and another one requires more
> memory then whats left in the buffer/cache the daemon could request to
> store the request in swap memory and put it in the queue, if the request
> is a write request it would have more priority then any read requests
> still and get completed quickly allowing for remaining queue events to
> complete.
> 
> Example:
> 
> ReiserFS:
>    Operation A.  Write (10K)
>    Operation B.  Read  (200K)
>    Operation C.  Write (160K)
> 
> 
> XFS:
>    Operation A.  Read (63K)
>    Operation B.  Read (3k)
>    Operation C.  Write (10K)
> 
> 
> EXT3:
>    Operation A.  Write (290K)
>    Operation B.  Write (90K)
>    Operation C.  Read  (3k)
> 
> the kpagebuf (or whatever name). Would get all these requests and sort out
> what needs to be done first as long as there's buffer/cache memory free
> the write operations would be done as fast as possible, verified by some
> checksum and purged from the queue, If there's no cache/buffer memory
> free then all write queues reguardless of being in swap or cache/buffer need to be
> written to disk.
> 
> So:
> kpagebuf queue (total available buffer/cache memory is say 512K)
> 
>      EXT3  Write (290K)
>  ReiserFS  Write (160K)
>  ReiserFS  Write (10K)
>       XFS  Write (10K)
>      EXT3  Write (90K)  - Goes in swap because total > 512K (Dirty x2 state)
>  ReiserFS  Read  (200K) - Swap (dirty x2)
>       XFS  Read  (63K)  - Swap (dirty x2)
>       XFS  Read  (3K)   - Swap (dirty x2)
>      EXT3  Read  (3K)   - Swap (dirty x2)
> 
> * The daemon would check in order of filesystem registeration for whos
> should be in the read queue first.
> 
> * The daemon should maximize amount of memory stored in bufeer/cache to
> try to prevent write requests having to go into swap.
> 
> In the above queue, we have a lot of read operations and one write
> operation in swap. Clean out the write operations since they are now dirty
> (because there's no room for more operations in the buffer/cache). Move
> the swapped write operation to the top of the queue and get rid of it.
> Move the read operations from swap to queue since there is room again. **
> NOTE ** because those read requests are now dirty they MUST be delt with
> or they'll get stuck in the queue with more write requests overtaking
> them.
> 
> Maybe I've lost it but that's how I see it ;)
> 
> Shawn.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


