Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbTCNRRB>; Fri, 14 Mar 2003 12:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263394AbTCNRRB>; Fri, 14 Mar 2003 12:17:01 -0500
Received: from mail-1.tiscali.it ([195.130.225.147]:65511 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263384AbTCNRQ4>;
	Fri, 14 Mar 2003 12:16:56 -0500
Date: Fri, 14 Mar 2003 18:27:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Message-ID: <20030314172745.GE1375@dualathlon.random>
References: <20030314090825.GB1375@dualathlon.random> <20030314045029.2f05eeb5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314045029.2f05eeb5.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 04:50:29AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Only in 2.4.21pre5aa1: 00_clean-inode-fix-1
> > 
> > 	Reset r_dev.
> 
> oops.  What problem was this observed to cause btw?

some apps complains that the file in ocfs is a raw device while it's
really a regular file.

> 
> > Only in 2.4.21pre5aa1: 00_smp-timers-not-deadlocking-1
> > 
> > 	Corrected varsion of the smp timers that can deadlock in 2.5
> > 	and in all kernels that were used to incorporate this patch,
> > 	including jam.
> 
> OK, I'll take a look at that thanks.

thanks

> 
> > 	This is fixed so that a timer reinserting
> > 	itself to run immediate, won't loop forever deadlocking
> > 	a CPU spinning in a tight loop. This bug was present in
> > 	ancient 2.4 kernels too and this is been fixed after bugreports
> > 	in both 2.2 and again in 2.4 because we forgotten to forward
> > 	port it to 2.4, these fixes must be forward ported today
> > 	to 2.5 too. Fixed also run_all_timers to correctly convert
> > 	the logical to physical cpu id (doesn't matter on x86, but
> > 	run_all_timers doesn't matter either on x86, other archs
> > 	may need this fix to avoid crashing too). This patch
> > 	was originally written from Ingo Molnar, David Miller with the help of
> > 	Alexey Kuznetsov, for more details see the timer.c added credit lines.
> 
> This code is buggy.  See
> 
> http://linux.bkbits.net:8080/linux-2.5/user=akpm/cset@1.786.202.5?nav=!-|index.html|stats|!+|index.html|ChangeSet@-6M

yet another kernel crashing bug in the smptimers :(, I'll backport the
fix thanks!

> 
> 
> > Only in 2.4.21pre5aa1: 9999_fsync-msync-async-errors-1
> > 
> > 	Allow userspace to always be notified about async write failures
> > 	when calling msync and fsync even if they happened long before
> > 	the systemcall run.
> 
> The code in shrink_cache() has a couple of problems.
> 
> a) If someone else is truncating the file at the same time,
>    block_write_full_page() will see the page is outside i_size and will
>    return -EIO.  That will be propagated into the address_space and
>    userspace will see a bogus I/O error.
> 
>    Fix: just return zero from writepage-outside-i_size.  There are several
>    instances.

sorry but this is a bug in writepage if something not a bug in
9999_fsync-msync-async-errors-1, msync just checks the writepage retval
today, but it only checks it for the synchronous writepages that it
submits, not the async one from the vm.

> b) Can't touch `mapping' after calling writepage().  The page can now be

more precisely can't touch the mapping on a unlocked page (unless we
reference the mapping through the inode and not though the page),
agreed, it can race.

>    unlocked, truncated off the inode and the inode could be freed up.
> 
>    No, I don't have a testcase ;)
> 
>    The fix is to lock the page again, see if it still has a ->mapping,
>    then set mapping->error.

so the problem is in vmscan.c:

 			if ((gfp_mask & __GFP_FS) && writepage) {
+				int err;
+
 				ClearPageDirty(page);
 				SetPageLaunder(page);
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
 
-				writepage(page);
+				err = writepage(page);
+				if (unlikely(err))
+					mapping->error = err;
+
 				page_cache_release(page);

locking the page again is very ugly, and there's a worse problem with
your proposed fix that makes it not an option: we risk to get the lock
on the page and to set the error _after_ msync/fsync returned no errors
to usersapce. So this could invalidate the feature despite it would make
the kernel stable again.

The only fix I can see is to change all writepage to set error by
themself before unlocking the page, then the above vmscan diff can go
away. And well, the prepare write should do the same too, the patch
takes care of the data failures in the prepare-write case in the I/O
completion handler, but not of the metadata failure. And even for the
prepare write data failures, it is broken because the write_io_error
information is passed over only during bh collection, not at msync or
fsync time. I think I'll drop this patch completely since it's useless
in its current form and the above bug will crash the kernel.

Thank you very much for the helpful review!

Andrea
