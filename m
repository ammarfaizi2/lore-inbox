Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMCT7>; Sun, 12 Nov 2000 21:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKMCTu>; Sun, 12 Nov 2000 21:19:50 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:17163 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129103AbQKMCTq>; Sun, 12 Nov 2000 21:19:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Ying Chen/Almaden/IBM" <ying@almaden.ibm.com>
Date: Mon, 13 Nov 2000 13:19:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14863.20391.109936.97487@notabene.cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] nfsd optimizations for test10 (recoded to use list_head)
In-Reply-To: message from Ying Chen/Almaden/IBM on Sunday November 12
In-Reply-To: <OFEBB493A2.95975790-ON88256996.0006B37E@LocalDomain>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 12, ying@almaden.ibm.com wrote:
> 
> Hi,
> 
> This is the recoded racache that uses list_head for several lists, e.g.,
> lru and free lists. I have tested it under SPEC SFS runs, and several other
> NFS loads myself.

Ok, I have taken a closer look at this code:

1/ Why did you change nfsd_busy into an atomic_t?  It is only ever
   used or updated inside the Big-Kernel-Lock, so it doesn't need
   to be atomic.

2/ Your new nfsd_racache_init always allocates a new cache, were as
   the current one checks first to see if it has already been
   allocated.
   This is important because it is quite legal to run "rpc.nfsd"
   multiple times.  Subsequent invocations serve to change the number
   of nfsd threads running.

3/ You currently allocate a single slab of memory for all of the
   "struct raparms".  Admittedly this is what the old code did, but I
   don't think that it is really necessary, and calling kmalloc
   multiple times would work just a well and would (arguably) be
   clearer.

4/ small point:  you added a hash table as the comment suggests might
   be needed, but you didn't change the comment accordingly:-)

5/ the calls to spin_lock/spin_unlock in nfsd_racache_init seem
   pointless. At this point, nothing else could possibly be accessing
   the racache, and if it was you would have even bigger problems.
   ditto for nfsd_racache_shutdown
  
6/ The lru list is now a list.h list, but the hash lists aren't.  Why
   is that?

7/ The old code kept a 'use' count for each cache entry to make sure 
   that an entry was not reused while it was in use.  You have dropped
   this.  Now because of the lru ordering, and because each thread can
   use at most one entry, you wont have a problem if there are more
   cache entries than threads, and you currently have 2048 entries
   configured which is greater than NFSD_MAXSERVS.  However I think it
   would be best if this dependancy were made explicit.
   Maybe the call to nfsd_racache_init should tell the racache how
   many threads are being started, and nfsd_racache_init should record
   how many cache entries have been alloced, and it could alloc some
   more if needed.

8/ I would like the stats collected to tell me a bit more about what
   was going on.  If find simple hit/miss numbers nearly useless, as
   you expect many lookups to be misses anyway (first time a file is
   accessed) but you don't know what percentage.
   As a first approximation, I would like to only count a miss if the
   seek address was > 0.
   What would be really nice would be to get stats on how long entries
   stayed in the cache between last use and re-use.  If we stored a
   'last-use' time in each entry, and on reuse, kept count of which
   range the age was is:
 
             0-62 msec
             63-125 msec
             125-250 msec
             250-500 msec
             500-1000 msec
              1-2     sec
              2-4     sec
              4-8     sec
              8-16    sec
              16-32   sec

   This obviously isn't critical, but it would be nice to be able
   to see how the cache was working.


9/ Actually, you don't need the spinlock at all, and nfsd is currently
   all under the BigKernelLock, but it doesn't hurt to have it around
   the nfsd_get_raparms function because we hopefully will get rid of
   the BKL one day.

NeilBrown



  
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
