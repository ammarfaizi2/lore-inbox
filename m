Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWH0IVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWH0IVb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWH0IVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:21:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:30350 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751688AbWH0IVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:21:30 -0400
From: Neil Brown <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Sun, 27 Aug 2006 18:21:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17649.22021.437134.578510@cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>, David Chinner <dgc@sgi.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow 
	writeback.
In-Reply-To: message from Trond Myklebust on Friday August 25
References: <20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
	<20060818070314.GE798@suse.de>
	<p73hd0998is.fsf@verdi.suse.de>
	<17640.65491.458305.525471@cse.unsw.edu.au>
	<20060821031505.GQ51703024@melbourne.sgi.com>
	<17641.24478.496091.79901@cse.unsw.edu.au>
	<20060821135132.GG4290@suse.de>
	<17646.32332.572865.919526@cse.unsw.edu.au>
	<1156511810.5575.33.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 25, trond.myklebust@fys.uio.no wrote:
> On Fri, 2006-08-25 at 14:36 +1000, Neil Brown wrote:
> > The 'bugs' I am currently aware of are:
> >  - nfs doesn't put a limit on the request queue
> >  - the ext3 journal often writes out dirty data without clearing
> >    the Dirty flag on the page - so the nr_dirty count ends up wrong.
> >    ext3 writes the buffers out and marks them clean.  So when
> >    the VM tried to flush a page, it finds all the buffers are clean
> >    and so marks the page clean, so the nr_dirty count eventually
> >    gets correct again, but I think this can cause write throttling to
> >    be very unfair at times.
> > 
> > I think we need a queue limit on NFS requests.....
> 
> That is simply not happening until someone can give a cogent argument
> for _why_ it is necessary. Such a cogent argument must, among other
> things, allow us to determine what would be a sensible queue limit. It
> should also point out _why_ the filesystem should be doing this instead
> of the VM.

Well, I'm game.... let's see how I do ... (Hmmm. 290 lines.  Maybe I
did too well :-).

Firstly - what would be a sensible queue limit?
 To a large extent the size isn't very important.
 It needs to be big enough that you can have a reasonable number
 of concurrent in-flight requests - this is something that only
 the NFS client can determine.
 It needs to be small enough to not be able to use up too much
 memory.  This is something that the VM should impose, but doesn't
 yet.  Something like a few percent of memory would probably be
 the right ball park.  I agree this is something the VM should be
 responsible for, but isn't yet.  However I don't think it is a big
 part of the picture.

So: why is it necessary?
 How about "Because that's how the Linux VM works".  I can see that is
 not very satisfactory, and it isn't the whole answer, but I think it
 is worth saying.  There are probably several ways to do effective
 write throttling.  The Linux VM (currently) uses push-back from the
 writeout queue to achieve write throttling, so we really need all
 writeout mechanisms to provide some pushback.  Maybe the VM could be
 changed, but I think it would be a big change and not something to do
 lightly - partly because I think the current system works (for the
 most part) very well.

So: how does it work, why is it so clever, and how does it depend on
push-back?
It is actually quite subtle...

Write throttling needs to slow down the generation of dirty pages. (It
also could speed up the cleaning of dirty pages, but there is a limit
to how fast cleaning can happen, so the majority of the control
imposed is the slowing of generation of dirt).

It needs to do this in a way that is 'fair' in some (fairly coarse)
sense.  Possibly the best understanding of fairness is that - for any
process - the delay imposed is proportional to the cost generated.
i.e. generating more dirty pages imposes more delay.  Generating dirty
pages on slower devices imposes more delay.

When the fraction of dirty pages is below some threshold (40% by
default) no throttling is imposed.
When we cross that threshold we switch on write throttling.
The simplest approach might be to block all writers and push out pages
until we are below the threshold again.  This isn't fair in the above
sense as all dirtying processes are stopped for the same period of
time, independent of how much dirty that have created.

An 'obvious' response to that problem is to do lots of 'bean
counting'.  i.e. count how many pages are generated by each process
per unit time, and count how many pages are dirty for each writeout
queue, and impose delays accordingly.  However bean counting can hurt
performance, even when they aren't needed (not the effort that is
taken to minimise the performance impact of counting 'Dirty' and
'Writeback' pages etc.  We don't really want lots of fine grained
counting). 

Another 'obvious' response might be 'if you have dirtied N pages, then
wait until 'N' pages have become clean.  However that isn't easy to do
because if multiple processes are waiting for N pages to be cleaned,
you would need to credit each page as it becomes clean to some
process, and that is just more bean counting.

So what we actually do is notice that there are two sorts of dirty
pages.  Those marked 'Dirty' and those marked 'Writeback'.
Further we know there is some upper limit to the number if Writeback
pages (this is where the queue limit comes in).
So the penalty imposed on a process that has dirtied N pages is "You
must transition 1.5*N pages from 'Dirty' to 'Writeback'.  It is only
required to do that on the writeout queue that it is using so a
process writing to a fast device shouldn't be slowed down by the
presence of a slow device.

The first few processes might not find this to be much penalty as they
will just be filling up the writeout queue.  But soon the queues will
be full and write throttling will have its intended effect.

So in the steady state, for every N pages that are dirtied, a process
needs to wait for 1.5*N pages to become clean on the same device,
which sound reasonably fair.  Naturally this will push the number of
dirty pages steadily down until we are below the threshold, and then
it will be free-reign again.  Thus under heavy write load, the system
can expect to oscillate between just above and just below the
threshold.

So you can imagine - if some writeout queue does not put a bound on
its size (or has a size that is a substantial fraction of memory) then
the above will simply not work.  Transitioning pages from Dirty to
Writeback will not impose a delay so the number of Writeback pages
will continue to grow.

Could the VM impose this limit itself?  Probably yes.  But the
writeout queue driver is in a perfect position to keep track of the
number of outstanding requests, so it may as well impose the limit.
The current (unstated) internal API for Linux says that the writeout
queue must impose the limit, so NFS should do so too.

Is that cogent enough?  I hope so.
I haven't forgotten about 'unstable'.  I'll get to that a little
further down, but while that description is fresh in your mind....

So, if this is such a glaring problem with NFS, why aren't more people
having problems?  This is a very good question and one I only just
found an answer to - quite an interesting answer I think.

We have had quite a few customers report problems.  They all seem to
be using very big machines (8Gig plus).  However I couldn't come close
to duplicating the problem on the biggest machine I have easy access
to which has 6Gig.  I now think the memory size is only part of the
issue.  The other side of the issue is the NFS server.

I had always been writing to a Linux NFS server.  And, I'm sorry to
admit, the Linux NFS server isn't ideal. In particular:
 In NFSv3 the response to a WRITE request (and other requests) contain
 post-op attributes and (optionally) pre-op attributes.
 The pre-op attributes are only allowed if the server can guarantee
 that the WRITE operation was the only operation to be performed on
 the file between the moment when 'pre-op' were valid, and the moment
 when 'post-op' were valid.
 The idea is that the Client sends a WRITE request, gets a reply and
 if the pre-op attributes are present and match the client's cache,
 then no-one else has touched the file, the post-op attributes are now
 valid, and the clients cache is otherwise certain to be up-to-date.

 The Linux NFS server doesn't send pre-op attributes (because it
 cannot hold a lock on the file while doing a write ... probably a
 fixable problem with leases or something).  So when the client writes
 to the NFS server it always gets a response that says effectively
 "Someone else might have written to that file recently".
 In nfs_file_write there is (or was until very recently) a call to 
 nfs_revalidate_mapping which will flush out all changed pages if
 there is some doubt about the contents of the cache.

So on a Linux client (2.6.17 or prior) writing to a Linux server, you
will find the writer process almost always in invalidate_inode_pages
due to this call.  I.e. it is flushing out data quite independent of
write throttling.  (Write throttling triggers the first write, that
causes the caches to be doubtful, and then the next write will flush
the cache).

Writing to a different NFS server (e.g. a NetApp filer I expect - I
don't have complete server details on all my bug reports), the pre-op
attributes could be present, and you get a blow-out in the size of the
Writeback list.

Having noticed the recent change in nfs_file_write, I tried on
2.6.17-rc4-mm2 in a qemu instance and the Writeout count steadily grew
while the 'Dirty' count went down to zero.  Then writeout dropped back
to around 40% while Dirty stayed at zero (as balance_dirty_pages has a
fall back - if you cannot write out 1.5*N, then wait until the number
of dirty pages is below the threshold).  On a small memory machine
this doesn't cause much of a problem.  On a large machine which
millions of Writeback pages all on the inactive list, things slow to a
crawl.

[I'm curious about why the invalidate_inode_pages call was removed
from nfs_file_write... presumably the cache inconsistency is still
potentially there, so clean pages should be purged.  Whether dirty
pages should be purged is a different question....]

Despite having said that the current approach is quite clever, I think
there is room for improvement.  It is mostly tuning around the edges.

- I think that when there is a high write load, the system should stay
  in 'over-threshold' mode rather than oscillating back and forth.
  e.g. once we go over the threshold we set 'dirty_exceeded' and 
   leave it set until below (say) 90% of the threshold.
   While dirty_exceed is true:
    if over the threshold, the 'write_chunk' (number of pages to be
    transitioned from Dirty to Writeback) should be 1.5*N.
    if under, then just 1.0*N.
  This would mean a fairly predictable steady-state behaviour which
  would be more likely to be fair.

- We shouldn't fall back to 'wait until below the threshold' when 
  we fail to write out 1.5*N pages.  Rather we should realise this
  means there are no dirty blocks on this device, and just let the
  process continue - obviously it has done it's work.  However that
  fall-back is the only thing currently saving NFS from using up all
  available pages in its writeout queue, so that change cannot happen
  until NFS joins the party.

- When 'dirty_exceed' is true, balance_dirty_pages gets called for
  every 8 pages that are written, but 'write_chunk' is still set to
  3/64 of memory (or 6Meg, which ever is smaller) (that assumes a 1
  CPU system).  This seems terribly unfair, but should be trivial to
  fix.

There is one more issue that I feel I should talk about in order to
give the full picture on write-throttling.
The above treatment only considers the fact that the throttled
processes are causing transitions from Dirty to Writeback, and it
tries to require an appropriate number of transitions from each.
But in fact other processes might be causing that transition and so be
using up spots on the writeout queue, thus imposing more throttling.

bdflush also causes writeback on Dirty pages.  This will only write
out old pages.  I suspect (no measuring attempted) this will either
have no effect at all when write-throttling is happening, (as no pages
will be old enough) or will mean that the slowest device will see more
writeout than faster devices (as the oldest pages should belong to the
slowest device).  This means that writers to the slowest device will
have to wait longer than they might expect (because the slots in the
writeout queue that they could have taken, were taken by bdflush).
This should generally push down the number of dirty pages used by the
slowest device, which is possibly a good thing.

Another process that causes writeback on Dirty pages is the ext3
journald.  It actually writes out the buffers so that when the VM
tries to write the page, it finds it is actually clean already.
However the journald is still 'stealing' slots in the request queue
that the write-throttled processes cannot get.  I'm not sure what the
net effect of this will be.  In my experimenting I did have a scenario
where it had a pronounced effect, but I have changed enough code that
I don't think it was in any way representative on what the mainline
kernel would do..

Anyway, to your other issue...

> 
> Furthermore, I'd like to point out that NFS has a "third" state for
> pages: following an UNSTABLE write the data on them is marked as
> 'uncommitted'. Such pages are tracked using the NR_UNSTABLE_NFS counter.
> The question is: if we want to set limits on the write queue, what does
> that imply for the uncommitted writes?

Excellent question.
In some ways, Unstable pages are like Dirty pages. i.e. there is some
operation that needs to be done on them.  Either WRITE or COMMIT.
This similarity is supported by the fact that the two numbers are
added together into 'nr_reclaimable' in balance_dirty_pages.

A first guess might be that the write throttling should transition 
1.5*N "dirty or unstable" pages to Writeback  (What state are Unstable
pages when the commit is happening?  Let's pretend for the moment
they are Writeback again, it isn't important for this discussion).

However that wouldn't work.  For every page that is dirtied, one dirty
page needs to be written and one unstable page needs to be committed.
So maybe nfs_writepages (which does the final writing I think) should
effectively double nr_to_write, as WRITEing is only half of the
required work.

But the won't work either.  Because sometimes a WRITE can return
DATA_STABLE and no commit is needed.  So requiring twice as many
WRITEs or COMMITs isn't right.

I think that nfs_writepages needs to try to write nr_to_write, and try
to commit nr_to_write pages, and should decrease nr_to_write by the
maximum of the number of pages written and the number of pages
committed. (I note that nfs currently doesn't commit individual pages
but instead commits the whole file. Obviously if you end up committing
more pages than nr_to_write, you wouldn't decrease nr_to_write so much
that it goes negative).
However this thought hasn't been thoroughly considered.  It might have
problems and there might be a better way.  The important thing is to
generate some requests and to decrease nr_to_write in proportion to
the mount of useful work that has been done.


> If you go back and look at the 2.4 NFS client, we actually had an
> arbitrary queue limit. That limit covered the sum of writes+uncommitted
> pages. Performance sucked, 'cos we were not able to use server side
> caching efficiently. The number of COMMIT requests (causes the server to
> fsync() the client's data to disk) on the wire kept going through the
> roof as we tried to free up pages in order to satisfy the hard limit.

Pages that are UNSTABLE shouldn't use slots in the request queue
(which you seem to be implying was the case in 2.4).
So while we are below the threshold for throttling, commits would only
be forced by sync or bdflush (how does that work?  The first bdflush
passes triggers a WRITE, the next one triggers the COMMIT?).

But once we get above the threshold, we really want to be calling
COMMIT quite a lot to get the number of "dirty or writeback or
unstable" pages down.  So calling COMMIT on every nfs_write_pages that
came from balance_dirty_pages would seem fairly appropriate.

> For those reasons and others, the filesystem queue limit was removed for
> 2.6 in favour of allowing the VM to control the limits based on its
> extra knowledge of the state of global resources.

Unfortunately the VM still needs a little help from the writeout
queue.

(I think I'm going to write a Documentation file on how writeback -
but would anyone read it....)

NeilBrown
