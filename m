Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315752AbSETEds>; Mon, 20 May 2002 00:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315756AbSETEdr>; Mon, 20 May 2002 00:33:47 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29227 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315752AbSETEdp>; Mon, 20 May 2002 00:33:45 -0400
Date: Mon, 20 May 2002 06:30:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <20020520043040.GA21806@dualathlon.random>
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 12:33:23PM -0700, Andrew Morton wrote:
> Martin Schwidefsky wrote:
> > 
> > Hi,
> > we managed to hang the kernel with a db/2 stress test on s/390. The test
> > was done on 2.4.7 but the problem is present on all recent 2.4.x and 2.5.x
> > kernels (all architectures). In short a schedule is done while holding
> > the shm_lock of a shared memory segment. The system call that caused
> > this has been sys_ipc with IPC_RMID and from there the call chain is
> > as follows: sys_shmctl, shm_destroy, fput, dput, iput, truncate_inode_pages,
> > truncate_list_pages, schedule. The scheduler picked a process that called
> > sys_shmat. It tries to get the lock and hangs.
> 
> There's no way the kernel can successfully hold a spinlock
> across that call chain.

Yep, that's a blocking operations (even truncate_inode_pages can block
for reasons not related to the expired timeslice).

> 
> > One way to fix this is to remove the schedule call from truncate_list_pages:
> > 
> > --- linux-2.5/mm/filemap.c~   Tue May 14 17:04:14 2002
> > +++ linux-2.5/mm/filemap.c    Tue May 14 17:04:33 2002
> > @@ -237,11 +237,6 @@
> > 
> >                   page_cache_release(page);
> > 
> > -                 if (need_resched()) {
> > -                       __set_current_state(TASK_RUNNING);
> > -                       schedule();
> > -                 }
> > -
> >                   write_lock(&mapping->page_lock);
> >                   goto restart;
> >             }
> > 
> > Another way is to free the lock before calling fput in shm_destroy but the
> > comment says that this functions has to be called with shp and shm_ids.sem
> > locked. Comments?
> 
> Maybe ipc_ids.ary should become a semaphore?

the shmid spinlock is not needed across the fput so we don't need to
switch to a semaphore, btw, there seems some bit of superflous locking
in such file (usually harmless, but not in this case). NOTE: apparently
only shm_rmid seems to need the shmid lock in such function (please
double check).

This should fix it:

--- 2.4.19pre8aa3/ipc/shm.c.~1~	Wed May 15 22:37:20 2002
+++ 2.4.19pre8aa3/ipc/shm.c	Mon May 20 06:18:11 2002
@@ -117,12 +117,15 @@ static void shm_open (struct vm_area_str
  *
  * @shp: struct to free
  *
- * It has to be called with shp and shm_ids.sem locked
+ * It has to be called with the id locked and the shm_ids.sem
+ * held. Before returning it unlocks the id internally. fput()
+ * is a blocking operation.
  */
-static void shm_destroy (struct shmid_kernel *shp)
+static void shm_destroy (struct shmid_kernel *shp, int id)
 {
-	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
+	shm_unlock(id);
+	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	kfree (shp);
@@ -149,9 +152,9 @@ static void shm_close (struct vm_area_st
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_flags & SHM_DEST)
-		shm_destroy (shp);
-
-	shm_unlock(id);
+		shm_destroy (shp, id);
+	else
+		shm_unlock(id);
 	up (&shm_ids.sem);
 }
 
@@ -512,11 +515,11 @@ asmlinkage long sys_shmctl (int shmid, i
 			shp->shm_flags |= SHM_DEST;
 			/* Do not find it any more */
 			shp->shm_perm.key = IPC_PRIVATE;
+			shm_unlock(shmid);
 		} else
-			shm_destroy (shp);
+			shm_destroy (shp, shmid);
 
 		/* Unlock */
-		shm_unlock(shmid);
 		up(&shm_ids.sem);
 		return err;
 	}
@@ -653,8 +656,9 @@ invalid:
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_flags & SHM_DEST)
-		shm_destroy (shp);
-	shm_unlock(shmid);
+		shm_destroy (shp, shmid);
+	else
+		shm_unlock(shmid);
 	up (&shm_ids.sem);
 
 	*raddr = (unsigned long) user_addr;

As next thing I'll go ahead on the inode/highmem imbalance repored by
Alexey in the weekend.  Then the only pending thing before next -aa is
the integration of the 2.5 scheduler like in 2.4-ac. I will also soon
automate the porting of all the not-yet merged stuff into 2.5, so we
don't risk to forget anything. I mostly care about mainline but I would
also suggest Alan to merge in -ac the very same VM of -aa (so we also
increase the testing before it gets merged in mainline as it is
happening bit by bit overtime).  Alan, I'm looking at it a bit and what
you're shipping is an hybrid between the old 2.4 vm and the current one,
plus using the rmap design for unmapping pagetables. The issue is not
the rmap design, the issue is that the hybrid gratuitously reintroduces
various bugs like kswapd infinite loop and it misses all the recent
fixes (problems like kswapd infinite loop are reproducible after months
the machine are up, other things like unfreed bh with shortage in the
normal zone fixed in recent -aa are reproducible only with big irons,
numa/discontigmem stuff, definitive fix for google etc..etc..). The rmap
design (not the rmap patch, the rmap patch in -ac does a whole lots more
than just switching shrink_cache to use a reverse lookup chain instead
of triggering swap_out, it basically returns to the old 2.4 vm lru
logic) as well cannot make nearly any positive difference during paging,
the system CPU usage during a DBMS workload swapping 1.2G and with 1G of
shm in RAM is not significant, swap_out linear complexity is not showing
up heavily on the profiling yet (on smaller machines with less total
virtual memory it's a no brainer), and it instead hurts scalability of
most fast paths like page faults and fork.  The aging changes also
doesn't look significant either, infact aging the accessed bits in round
robin is more fair then aging it using vm-lru order. All numbers I seen
so far agrees but I'll be very interested to know if you reproduced any
different pratical results in your lab doing -ac vs -aa vm comparisons.

About rmap design I would very much appreciate if Rik could make a
version of his patch that implements rmap on top of current -aa (it
wouldn't be a rewrite, just a porting of the strict rmap feature), so we
can compare apples to apples and benchmark the effect of the rmap patch,
not the rmap + the hybrid, most of the slowdown during paging is most
probably due the hybrid, not because of the rmap design, the rmap design
if something should make things a bit faster during swapout infact, by
being a bit slower in the more important fast paths. It is definitely
possible to put a strict rmap on top of -aa without the huge "hybrid"
thing attached to the rmap code, so without impacting at all the rest of
the vm. It's just a matter of adding the try_to_unmap in shrink_cache
and deleting the swap_out call (it's almost as easy as shipping a
version of Windows without a web browser installed by default).

Andrea
