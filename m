Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270848AbRIARXn>; Sat, 1 Sep 2001 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270849AbRIARXd>; Sat, 1 Sep 2001 13:23:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:48408 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270848AbRIARXV>; Sat, 1 Sep 2001 13:23:21 -0400
Date: Sat, 1 Sep 2001 19:24:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "G. Hugh Song" <ghsong@norma.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre2aa2
Message-ID: <20010901192406.A30745@athlon.random>
In-Reply-To: <3B90C0D4.6010509@norma.kjist.ac.kr> <20010901161517.C927@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010901161517.C927@athlon.random>; from andrea@suse.de on Sat, Sep 01, 2001 at 04:15:17PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 04:15:17PM +0200, Andrea Arcangeli wrote:
> On Sat, Sep 01, 2001 at 08:04:52PM +0900, G. Hugh Song wrote:
> > Dear Andrea,
> > 
> > Since sometime around 2.4.7-*aa*, I never succeeded booting from your
> > patched kernel on UP2000 dual with SuSE-7.1 with 2GB memory.
> > 
> > Booting stops somewhere near the file system check.  The stopping place
> > is not always the same.  Today I compiled 2.4.10pre2aa2.  It stopped
> > while reading the /lib/modules/2.4.10pre2aa2.
> > 
> > I attached .config here.
> > 
> > Am I the only one having trouble with the recent *aa*-series kernel?
> > 
> > The last time I succeeded, I had 2.4.5pre2aa1.  I attached the xconfig
> > file also.
> 
> Can you try to backout those two patches in order before compiling?
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre2aa2/71_mmap-rb-6_other-archs-1
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre2aa2/70_mmap-rb-6
> 
> I also cannot boot 2.4.10pre2aa2 on my alpha box :(, I nailed it down
> due the mmap-rb vma lookup rewrite, however it is quite strange that it
> is generating problems because it's at 99% common code stuff. I will try
> to fix it ASAP. In the meantime make sure to backout those two patches
> when you run it on alpha (such two patches never generated a single
> problem on x86 yet AFIK).

Ok, found the silliness after a few hours of debugging. Can you try this
patch on top of 2.4.10pre2aa2?  My alpha now runs solid again with it
applied.

--- 2.4.10pre2aa3/mm/mmap.c.~1~	Sat Sep  1 19:07:24 2001
+++ 2.4.10pre2aa3/mm/mmap.c	Sat Sep  1 19:07:51 2001
@@ -360,7 +360,7 @@
 		spin_lock(lock);
 		prev->vm_end = end;
 		next = prev->vm_next;
-		if (prev->vm_end == next->vm_start && can_vma_merge(next, vm_flags)) {
+		if (next && prev->vm_end == next->vm_start && can_vma_merge(next, vm_flags)) {
 			prev->vm_end = next->vm_end;
 			__vma_unlink(mm, next, prev);
 			spin_unlock(lock);


It was not triggering for all programs because to trigger you'd need an
mmap or sbrk that would close an hole in the address space, and only 1
vma after the hole.

It couldn't trigger on x86 because on x86 we always have the stack at
the end of the address space so vm_next was always non null in practice.

However it would been possible to write a malicious application to
exploit this bug on x86 too, it wasn't a bug specific to alpha.
It will be fixed in the next -aa as well of course. In the meantime keep
the above patch applied.

Andrea
