Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316439AbSETXnp>; Mon, 20 May 2002 19:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316440AbSETXno>; Mon, 20 May 2002 19:43:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60344 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316439AbSETXnn>;
	Mon, 20 May 2002 19:43:43 -0400
Message-ID: <3CE98A04.5040107@us.ibm.com>
Date: Mon, 20 May 2002 16:43:00 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c rewrite for better locking
In-Reply-To: <3CE01FC9.5000107@us.ibm.com> <20020513213638.F10287@parcelfarce.linux.theplanet.co.uk> <3CE9369D.50802@us.ibm.com> <20020520200807.A20755@parcelfarce.linux.theplanet.co.uk> <3CE967A6.9050107@us.ibm.com> <20020520223750.D20755@parcelfarce.linux.theplanet.co.uk> <3CE97C0D.7010500@us.ibm.com> <20020521000540.F20755@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm cc'ing LKML to see if anyone else has some input on this.

LKML folks,
   Matt and I are discussing moving fs/locks.c away from the BKL and 
to a better locking scheme.

Here's an overview of what is happening right now:

Current scheme, locks are always:
1. hanging off a per-inode list
AND
(
2. On the file_lock_list
OR
3. On the blocked_list
)

All operations on all of those lists are guarded using the BKL.

With the current layout of data structures, finely grained locking 
will be a pain.  There will continue to be a need for these locks:
1. 1 for each of the 2 global lists
2. a lock for each inode's lock list
3. a lock (or refcount) for every single lock, because it could be 
referenced from either the inode's list OR the global lists.
OR, a single global lock for everything (which I don't like)

   That's why I want to change the global lock list storage to use the 
already existing per-inode lists.  I want a file_lock_list to be a 
list of inodes that have locks outstanding on them.  This global list 
of inodes will need race protection as will the per-inode flock list. 
  The print_lock_info thing (whatever it's called) will look something 
like this:

read_lock( global_flock_list )
for each inode with locks {
	read_lock( inode->flock_list_lock )
	for each flock on inode {
		print stuff for this lock
	}
	read_unlock( inode->flock_list_lock )
}
read_unlock( global_flock_list )


>>inode_list fl_inode_list* head;
>>Is the use of blocked_list just an optimization?  Could 
>>posix_locks_deadlock theoretically go through all of the locks (from 
>>the global list) and ignore the ones that aren't posix and aren't 
>>blocking?
> 
> Theoretically, yes, because that's what the code used to do ;-)
> That was really ugly code, though.  Not to mention that it's an O(n^2)
> algorithm, which you really don't want to do while holding a global lock.
> It's still O(n^2), but at least I reduced the size of N to the number
> of tasks currently waiting for a lock.  (Actually, it used to be O(n^3)
> because it was written badly.  But we'll skip over that.)

Since this will only require a read lock, it should be significantly 
less costly than when the BKL was held.  Also, we're dealing with 
quite small numbers here, or we wouldn't be using linked lists.  If 
optimization is needed, perhaps the global-inodes-with-locks-on-them 
list can be supplemented with a 
global-inodes-with-locks-blocking-on-them list too.  However, I don't 
like the looks of it and I think that to do it cleanly, it will be 
necessary to add _another_ per-inode list for the blocked locks.  This 
approach is starting to sound way too complex.

>>2.4.17-something, one of our patch sets that we test.  There are some 
>>BKL changes that mimic the 2.5 behavior.
> 
> Ah, that might help... I was pounding on some SCSI discs trying to saturate
> them and got hung up on the io_request_lock.

You might want to check out our lse04 patch.  It has all of the stuff 
that we can't get into 2.4, including (I think) iorequest lock removal 
for the popular scsi drivers.  It is quite stable and tested 
thoroughly.  Look at the very bottom of our sourceforge files page:
http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=88803

-- 
Dave Hansen
haveblue@us.ibm.com

