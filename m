Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVB1UeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVB1UeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVB1UeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:34:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:25757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbVB1UdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:33:25 -0500
Date: Mon, 28 Feb 2005 12:33:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>, Darren Hart <dvhltc@us.ibm.com>,
       akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
Message-ID: <20050228203307.GL15867@shell0.pdx.osdl.net>
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net> <20050225220543.GC15867@shell0.pdx.osdl.net> <Pine.LNX.4.61.0502261626330.20871@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502261626330.20871@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> On Fri, 25 Feb 2005, Chris Wright wrote:
> > 
> > Actually I think it winds up being fine since we don't do merging with
> > mlock.  But why not?  Patch below remedies that.
> 
> > Successive mlock/munlock calls can leave fragmented vmas because they can
> > be split but not merged.  Give mlock et. al. full vma merging support.
> 
> Phew, you followed mprotect, saving me from having to think too deeply
> about the correctness of this (I'm assuming mprotect is perfect ;))

Heh, same assumption here ;-)

> Some remarks then on the three places where you departed from mprotect.
> 
> > ===== mm/mlock.c 1.19 vs edited =====
> > --- 1.19/mm/mlock.c	2005-02-11 11:07:35 -08:00
> > +++ edited/mm/mlock.c	2005-02-24 23:53:10 -08:00
> > @@ -7,18 +7,32 @@
> >  
> >  #include <linux/mman.h>
> >  #include <linux/mm.h>
> > +#include <linux/mempolicy.h>
> >  #include <linux/syscalls.h>
> >  
> >  
> > -static int mlock_fixup(struct vm_area_struct * vma, 
> > +static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
> >  	unsigned long start, unsigned long end, unsigned int newflags)
> >  {
> >  	struct mm_struct * mm = vma->vm_mm;
> > +	pgoff_t pgoff;
> >  	int pages;
> >  	int ret = 0;
> >  
> > -	if (newflags == vma->vm_flags)
> > +	if (newflags == vma->vm_flags) {
> > +		*prev = vma;
> >  		goto out;
> > +	}
> > +
> > +	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > +	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
> > +			  vma->vm_file, pgoff, vma_policy(vma));
> > +	if (*prev) {
> > +		vma = *prev;
> > +		goto success;
> > +	}
> > +
> > +	*prev = vma;
> 
> You've raised that line higher (so do_mlockall's "Ignore errors" works):
> that's an improvement because it saves special casing errors, I'd like
> you to make the same adjustment to mprotect_fixup, even though it's not
> required there (and delete "Unless it returns an error, " from comment).
> Let's keep the two in step.

Sure, makes sense.

> >  	if (start != vma->vm_start) {
> >  		ret = split_vma(mm, vma, start, 1);
> > @@ -32,6 +46,7 @@ static int mlock_fixup(struct vm_area_st
> >  			goto out;
> >  	}
> >  
> > +success:
> >  	/*
> >  	 * vm_flags is protected by the mmap_sem held in write mode.
> >  	 * It's okay if try_to_unmap_one unmaps a page just after we
> > @@ -59,7 +74,7 @@ out:
> >  static int do_mlock(unsigned long start, size_t len, int on)
> >  {
> >  	unsigned long nstart, end, tmp;
> > -	struct vm_area_struct * vma, * next;
> > +	struct vm_area_struct * vma, * prev;
> >  	int error;
> >  
> >  	len = PAGE_ALIGN(len);
> > @@ -68,7 +83,7 @@ static int do_mlock(unsigned long start,
> >  		return -EINVAL;
> >  	if (end == start)
> >  		return 0;
> > -	vma = find_vma(current->mm, start);
> > +	vma = find_vma_prev(current->mm, start, &prev);
> >  	if (!vma || vma->vm_start > start)
> >  		return -ENOMEM;
> 
> But here sys_mprotect also says:
> 
> 	if (start > vma->vm_start)
> 		prev = vma;
> 
> Perhaps you've worked your way through vma_merge and convinced yourself
> this is never necessary, that's quite possible; but I'd still be happier
> if you were to add it into your do_mlock: it limits the cases vma_merge
> has to worry about.  Or if you feel strongly about it, explain why I'm
> just being silly, and delete it from mprotect too.

No, I think you're right, and it measurably improves (~5%) the worst
case benchmark I was doing, thanks.

> > @@ -81,18 +96,19 @@ static int do_mlock(unsigned long start,
> >  		if (!on)
> >  			newflags &= ~VM_LOCKED;
> >  
> > -		if (vma->vm_end >= end) {
> > -			error = mlock_fixup(vma, nstart, end, newflags);
> > -			break;
> > -		}
> > -
> >  		tmp = vma->vm_end;
> > -		next = vma->vm_next;
> > -		error = mlock_fixup(vma, nstart, tmp, newflags);
> > +		if (tmp > end)
> > +			tmp = end;
> > +		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
> >  		if (error)
> >  			break;
> >  		nstart = tmp;
> > -		vma = next;
> > +		if (nstart < prev->vm_end)
> > +			nstart = prev->vm_end;
> > +		if (nstart >= end)
> > +			break;
> > +
> > +		vma = prev->vm_next;
> >  		if (!vma || vma->vm_start != nstart) {
> >  			error = -ENOMEM;
> >  			break;
> > @@ -141,7 +157,7 @@ asmlinkage long sys_munlock(unsigned lon
> >  
> >  static int do_mlockall(int flags)
> >  {
> > -	struct vm_area_struct * vma;
> > +	struct vm_area_struct * vma, * prev;
> >  	unsigned int def_flags = 0;
> >  
> >  	if (flags & MCL_FUTURE)
> > @@ -150,7 +166,7 @@ static int do_mlockall(int flags)
> >  	if (flags == MCL_FUTURE)
> >  		goto out;
> >  
> > -	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
> > +	for (prev = vma = current->mm->mmap; vma ; vma = vma->vm_next) {
> 
> Here prev should be initialized to NULL, rather than the first vma.
> Again, you've probably worked out that it's safe as you've written it,
> but vma_merge does expect prev NULL at the beginning.

No, it was a bug.

> >  		unsigned int newflags;
> >  
> >  		newflags = vma->vm_flags | VM_LOCKED;
> > @@ -158,7 +174,8 @@ static int do_mlockall(int flags)
> >  			newflags &= ~VM_LOCKED;
> >  
> >  		/* Ignore errors */
> > -		mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
> > +		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
> > +		vma = prev;
> 
> Scrap that "vma = prev;" line, just say "vma = prev->vm_next" in the loop?

Yup, thanks for reviewing.  Updated patch below.

thanks,
-chris
-- 

Successive mlock/munlock calls can leave fragmented vmas because they can
be split but not merged.  Give mlock et. al. full vma merging support.
While we're at it, move *pprev assignment above first split_vma in
mprotect_fixup to keep it in step with mlock_fixup (which for mlockall
ignores errors yet still needs a valid prev pointer).

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== mm/mlock.c 1.19 vs edited =====
--- 1.19/mm/mlock.c	2005-02-11 11:07:35 -08:00
+++ edited/mm/mlock.c	2005-02-28 11:08:23 -08:00
@@ -7,18 +7,32 @@
 
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 
 
-static int mlock_fixup(struct vm_area_struct * vma, 
+static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
 	struct mm_struct * mm = vma->vm_mm;
+	pgoff_t pgoff;
 	int pages;
 	int ret = 0;
 
-	if (newflags == vma->vm_flags)
+	if (newflags == vma->vm_flags) {
+		*prev = vma;
 		goto out;
+	}
+
+	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
+			  vma->vm_file, pgoff, vma_policy(vma));
+	if (*prev) {
+		vma = *prev;
+		goto success;
+	}
+
+	*prev = vma;
 
 	if (start != vma->vm_start) {
 		ret = split_vma(mm, vma, start, 1);
@@ -32,6 +46,7 @@ static int mlock_fixup(struct vm_area_st
 			goto out;
 	}
 
+success:
 	/*
 	 * vm_flags is protected by the mmap_sem held in write mode.
 	 * It's okay if try_to_unmap_one unmaps a page just after we
@@ -59,7 +74,7 @@ out:
 static int do_mlock(unsigned long start, size_t len, int on)
 {
 	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * next;
+	struct vm_area_struct * vma, * prev;
 	int error;
 
 	len = PAGE_ALIGN(len);
@@ -68,10 +83,13 @@ static int do_mlock(unsigned long start,
 		return -EINVAL;
 	if (end == start)
 		return 0;
-	vma = find_vma(current->mm, start);
+	vma = find_vma_prev(current->mm, start, &prev);
 	if (!vma || vma->vm_start > start)
 		return -ENOMEM;
 
+	if (start > vma->vm_start)
+		prev = vma;
+
 	for (nstart = start ; ; ) {
 		unsigned int newflags;
 
@@ -81,18 +99,19 @@ static int do_mlock(unsigned long start,
 		if (!on)
 			newflags &= ~VM_LOCKED;
 
-		if (vma->vm_end >= end) {
-			error = mlock_fixup(vma, nstart, end, newflags);
-			break;
-		}
-
 		tmp = vma->vm_end;
-		next = vma->vm_next;
-		error = mlock_fixup(vma, nstart, tmp, newflags);
+		if (tmp > end)
+			tmp = end;
+		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 		nstart = tmp;
-		vma = next;
+		if (nstart < prev->vm_end)
+			nstart = prev->vm_end;
+		if (nstart >= end)
+			break;
+
+		vma = prev->vm_next;
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
 			break;
@@ -141,7 +160,7 @@ asmlinkage long sys_munlock(unsigned lon
 
 static int do_mlockall(int flags)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev = NULL;
 	unsigned int def_flags = 0;
 
 	if (flags & MCL_FUTURE)
@@ -150,7 +169,7 @@ static int do_mlockall(int flags)
 	if (flags == MCL_FUTURE)
 		goto out;
 
-	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
+	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
 		unsigned int newflags;
 
 		newflags = vma->vm_flags | VM_LOCKED;
@@ -158,7 +177,7 @@ static int do_mlockall(int flags)
 			newflags &= ~VM_LOCKED;
 
 		/* Ignore errors */
-		mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
+		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
 	}
 out:
 	return 0;
===== mm/mprotect.c 1.40 vs edited =====
--- 1.40/mm/mprotect.c	2004-12-22 01:31:46 -08:00
+++ edited/mm/mprotect.c	2005-02-28 11:09:39 -08:00
@@ -185,16 +185,13 @@ mprotect_fixup(struct vm_area_struct *vm
 		goto success;
 	}
 
+	*pprev = vma;
+
 	if (start != vma->vm_start) {
 		error = split_vma(mm, vma, start, 1);
 		if (error)
 			goto fail;
 	}
-	/*
-	 * Unless it returns an error, this function always sets *pprev to
-	 * the first vma for which vma->vm_end >= end.
-	 */
-	*pprev = vma;
 
 	if (end != vma->vm_end) {
 		error = split_vma(mm, vma, end, 0);
