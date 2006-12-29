Return-Path: <linux-kernel-owner+w=401wt.eu-S1754222AbWL2OBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbWL2OBc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 09:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbWL2OBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 09:01:31 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:42239 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbWL2OBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 09:01:31 -0500
Date: Fri, 29 Dec 2006 15:01:07 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, 394392@bugs.debian.org,
       Jeff Licquia <licquia@debian.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: Alternative msync() fix for 2.6.18?
Message-ID: <20061229140107.GG2062@deprecation.cyrius.com>
References: <20061226123106.GA32708@deprecation.cyrius.com> <Pine.LNX.4.64.0612261305510.18364@blonde.wat.veritas.com> <20061226132547.GC6256@deprecation.cyrius.com> <Pine.LNX.4.64.0612261411580.20159@blonde.wat.veritas.com> <Pine.LNX.4.64.0612270104020.11930@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612270104020.11930@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CCing linux-kernel since Hugh's patch might be of interest to
non-Debian people too.  This message concerns a problem with msync()
in 2.6.17 and 2.6.18 that can be found with the LSB test suite.

* Hugh Dickins <hugh@veritas.com> [2006-12-27 01:04]:
> On Tue, 26 Dec 2006, Hugh Dickins wrote:
> > On Tue, 26 Dec 2006, Martin Michlmayr wrote:
> > > 
> > > The first message at http://bugs.debian.org/394392 contains some
> > > information about it, but I'm sure Jeff Licquia (CCed) can provide
> > > more information if necessary.
> > 
> > I've given that a quick look, and I'll bet it's something very
> > easily and safely fixed by a much simpler patch, to mm/msync.c alone,
> > than by all the dirty pages rework and attendant unresolved problems.
> 
> How quickly I forget!  It wasn't until I looked into the git history
> that I remembered how I'd discovered this already, just before 2.6.17
> went out; but thought myself likely to introduce a more serious bug
> if I tried to fix it in a hurry.  (Then forgot to send in a fix for
> 2.6.18, expecting Linus to put in Peter's more significant mods.)
> 
> So beware of the fix below, which I'll confess to not even having
> tested in practice: please review carefully, it's a confusing loop
> (rather like the mincore one which Linus has just cleaned up in
> 2.6.20-rc); and it took me a while to decide which of our many
> versions of that loop to start from in fixing it - chose to
> rely on what I'd worked out earlier when redoing it for 2.6.19.
> 
> Material for -stable?  Well, my judgement was, and is, not really:
> the 2.6.17/2.6.18 behaviour isn't quite right, but though it doesn't
> match the man page and that testsuite, what it does isn't actually
> harmful at all.  If this patch is more acceptable to Debian if it
> does appear in -stable, I can try sending it to Chris and Greg:
> but I won't be able to argue for it very forcefully.

I think it would make sense to have it in an -stable update because
it's a regression from 2.6.16 after all and it means that 2.6.17 and
2.6.18 are not LSB 3.1 compliant.  However, I don't have a strong
opinion about it and I'm not sure another update for 2.6.18 is
planned.

> Maybe better for you to consider it as just a subpatch of what went
> into 2.6.19, which I was wrong to have mixed in with Peter's work.
>
> I certainly think that this patch below (if it satisfies your review
> and testing) is much more suitable for Debian's 2.6.18 than Peter's
> suite of patches.  Not to put those down at all: the reverse, they're
> a significant contribution to 2.6.19, which just wouldn't be expected
> in any 2.6.18 kernel (and sadly, as you've found, are exposing still
> unexplained problems there).  Anyway, the patch and its comment...

Yes, I agree.  I'm CCing the linux-mm list in hope that someone can
review your patch.  In the meantime, I've asked the Debian LSB folks to
verify that your patch fixes the LSB problem.


From: Hugh Dickins <hugh@veritas.com>

Fix 2.6.18 (or 2.6.17) sys_msync to report -ENOMEM as before when an
unmapped area falls within its range, and not to overshoot: to satisfy
LSB 3.1 tests and to fix Debian Bug#394392.  Took the 2.6.19 sys_msync
as starting point (including its cleanup of repeated "current->mm"s),
reintroducing the msync_interval and balance_dirty_pages_ratelimited_nr
previously needed.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/msync.c |   66 +++++++++++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

--- 2.6.18/mm/msync.c	2006-09-20 04:42:06.000000000 +0100
+++ linux/mm/msync.c	2006-12-26 23:52:58.000000000 +0000
@@ -146,10 +146,10 @@ static int msync_interval(struct vm_area
 asmlinkage long sys_msync(unsigned long start, size_t len, int flags)
 {
 	unsigned long end;
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int unmapped_error = 0;
 	int error = -EINVAL;
-	int done = 0;

 	if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
 		goto out;
@@ -169,64 +169,58 @@ asmlinkage long sys_msync(unsigned long 
 	 * If the interval [start,end) covers some unmapped address ranges,
 	 * just ignore them, but return -ENOMEM at the end.
 	 */
-	down_read(&current->mm->mmap_sem);
-	vma = find_vma(current->mm, start);
-	if (!vma) {
-		error = -ENOMEM;
-		goto out_unlock;
-	}
-	do {
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, start);
+	for (;;) {
 		unsigned long nr_pages_dirtied = 0;
 		struct file *file;
 
+		/* Still start < end. */
+		error = -ENOMEM;
+		if (!vma)
+			goto out_unlock;
 		/* Here start < vma->vm_end. */
 		if (start < vma->vm_start) {
-			unmapped_error = -ENOMEM;
 			start = vma->vm_start;
-		}
-		/* Here vma->vm_start <= start < vma->vm_end. */
-		if (end <= vma->vm_end) {
-			if (start < end) {
-				error = msync_interval(vma, start, end, flags,
-							&nr_pages_dirtied);
-				if (error)
-					goto out_unlock;
-			}
-			error = unmapped_error;
-			done = 1;
-		} else {
-			/* Here vma->vm_start <= start < vma->vm_end < end. */
-			error = msync_interval(vma, start, vma->vm_end, flags,
-						&nr_pages_dirtied);
-			if (error)
+			if (start >= end)
 				goto out_unlock;
+			unmapped_error = -ENOMEM;
 		}
+		/* Here vma->vm_start <= start < vma->vm_end. */
+		error = msync_interval(vma, start, min(end, vma->vm_end),
+						flags, &nr_pages_dirtied);
+		if (error)
+			goto out_unlock;
 		file = vma->vm_file;
 		start = vma->vm_end;
 		if ((flags & MS_ASYNC) && file && nr_pages_dirtied) {
 			get_file(file);
-			up_read(&current->mm->mmap_sem);
+			up_read(&mm->mmap_sem);
 			balance_dirty_pages_ratelimited_nr(file->f_mapping,
 							nr_pages_dirtied);
 			fput(file);
-			down_read(&current->mm->mmap_sem);
-			vma = find_vma(current->mm, start);
+			if (start >= end)
+				goto out;
+			down_read(&mm->mmap_sem);
+			vma = find_vma(mm, start);
 		} else if ((flags & MS_SYNC) && file &&
 				(vma->vm_flags & VM_SHARED)) {
 			get_file(file);
-			up_read(&current->mm->mmap_sem);
+			up_read(&mm->mmap_sem);
 			error = do_fsync(file, 0);
 			fput(file);
-			down_read(&current->mm->mmap_sem);
-			if (error)
-				goto out_unlock;
-			vma = find_vma(current->mm, start);
+			if (error || start >= end)
+				goto out;
+			down_read(&mm->mmap_sem);
+			vma = find_vma(mm, start);
 		} else {
+			if (start >= end)
+				goto out_unlock;
 			vma = vma->vm_next;
 		}
-	} while (vma && !done);
+	}
 out_unlock:
-	up_read(&current->mm->mmap_sem);
+	up_read(&mm->mmap_sem);
 out:
-	return error;
+	return error ? : unmapped_error;
 }

-- 
Martin Michlmayr
http://www.cyrius.com/
