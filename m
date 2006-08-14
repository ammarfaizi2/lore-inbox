Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWHNCD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWHNCD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 22:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWHNCD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 22:03:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:14237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751794AbWHNCD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 22:03:26 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 14 Aug 2006 12:03:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17631.55785.167985.711845@cse.unsw.edu.au>
Cc: Willy Tarreau <w@1wt.eu>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
In-Reply-To: message from Peter Zijlstra on Friday August 11
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
	<20060810045711.GI8776@1wt.eu>
	<17627.53340.43470.60811@cse.unsw.edu.au>
	<1155286110.5696.64.camel@twins>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 11, a.p.zijlstra@chello.nl wrote:
> On Fri, 2006-08-11 at 10:33 +1000, Neil Brown wrote:
> > On Thursday August 10, w@1wt.eu wrote:
> > > 
> > > > Can someone help me and give me a brief description on OOM issue?
> > > 
> > > I don't know about any OOM issue related to NFS. At most it might happen
> > > on the client (eg: stating firefox from an NFS root) which might not have
> > > enough memory for new network buffers, but I don't even know if it's
> > > possible at all.
> > 
> > We've had reports of OOM problems with NFS at SuSE.
> > The common factors seem to be lots of memory (6G+) and very large
> > files. 
> > Tuning down  /proc/sys/vm/dirty_*ratio seems to avoid the problem,
> > but I'm not very close to understanding what the real problem is.
> 
> Would it not be related to mmap'ed files, where the client will not
> properly
> track the dirty pages? This will make the reclaim code go crap itself
> because
> suddenly not a single page is easily freeable anymore, all pages are
> then
> found to be dirty and require writeback, which takes more memory - ie.
> allocate
> network packets, and wait for proper answer.

I don't think mmap is being used, but I've asked for confirmation just
to be sure - thanks for the tip.

I have a reconstructed "/proc/meminfo" collected out of a crash-dump.
(note that this is from a 2.6.5 based kernel, though the same symptom
has been reported on a 2.6.16 based kernel).
It is below, plus the 'Unstable' number (which 2.6.5 doesn't show
normally).

It seems that 10Gig of the 16Gig is in 'writeback'.
It is my understanding that pages shouldn't stay in 'writeback for
very long.  They should get written and then (for nfs) moved to
Unstable.
The fact that 'Dirty' is zero suggests that there weren't any malloc
failures in starting writeback so I don't think the system is actually
OOM at this point (MemFree is 17Meg which is 1/1000th of total ram,
but some thousands of pages).  But the machine has nevertheless seized
up.

I'm thinking that the very large number of 'writeback pages on the
inactive list is slowing down shink_list and associated functions
and nothing is progressing very fast.  But I wonder why
'writeback' was allowed to get so high, and why it stays to high.

Looking at balance_dirty_pages again, I see that it only really
worries about the number of dirty pages. i.e. once enough pages have
been written, it breaks out of the loop, even if there are 
heaps and heaps of writeback pages....

So on this 16Gig machine with dirty_ratio at the default of '40',
We happily let 6.4Gig get dirty and then start writing it out in
balance_dirty_pages.  It will then flush out 6Meg for every 4 Meg
that is written.  While nr_writeback stays high balance_dirty will keep
flushing until nr_dirty hits zero. then it will just flush out all
dirty pages every time it is called, thus keeping nr_writeback high.
They should be a 100msec pause each time balance_dirty_pages
is called at this stage.  It is called for every 4Meg of data,
which would take a lot longer than 100msec to go out via NFS....

Hmmm.. maybe balance_dirty_pages should wait for nr_writeback to
drop sometimes.  Currently it has to write at least
sync_writeback_pages().  If it cannot find that many to write, it
stops.
Maybe if it cannot find that many, it should wait for nr_writeback to
drop by the corresponding number.  That would mean that if 
nr_pagewriteback got out-of-hand, writes would be throttled until it
came back in line.

But there is more to the story... (I hope you don't mind me rambling
on like this.  It helps to have someone to explain the problem to).
When Writeback is really high, nfs doesn't make (much) progress in
getting it down again.  Apparently rpciod is using lots of CPU time
and not sending many packets on the network...

The crash dump shows rpciod and lots of other processes as Runnable,
with very simply stack-tops (I don't have full details on hand) so
they are probably all trying to get some free memory and so going very
slowly (because the inactive list is so long with very little usable
on it).  rpciod calls rpc_malloc which uses a mempool to avoid
starvation, but that doesn't avoid incredible slowness.

So here is my understanding of the problem that I am seeing:

 1/ balance_dirty_pages will allow nr_writeback to grow
    without bound.  While it does work to decrease the number of 
    ditry pages, it does nothing about decreasing the number
    of writeback pages.  It should (in some situations) wait for
    the number to decrease (blk_congestion_wait isn't strong enough by
    itself).

 2/ When there is a very large number of Writeback pages on the
    inactive list, memory reclaim can go very slowly.  Maybe Writeback
    pages shouldn't be on the inactive list?  Either that or we
    need a strong limit on the number of Writeback pages.


Comments/corrections very welcome.  I'll see if I can find a way to
verify any of this with the customer...

Thanks for listening,
NeilBrown



MemTotal:     16154060 kB
MemFree:         17760 kB
Buffers:         16104 kB
Cached:       12956032 kB
SwapCached:       1224 kB
Active:             52 kB
Inactive:     12972740 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:     16154060 kB
LowFree:         17760 kB
SwapTotal:    25173844 kB
SwapFree:     25119512 kB
Dirty:               0 kB
Writeback:    10999176 kB
Mapped:           4316 kB
Slab:          3135240 kB
Committed_AS:   112984 kB
PageTables:       1436 kB
VmallocTotal: 536870911 kB
VmallocUsed:     12828 kB
VmallocChunk: 536858083 kB

Unstable       1326884 kB

