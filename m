Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281038AbRKCU40>; Sat, 3 Nov 2001 15:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKCU4R>; Sat, 3 Nov 2001 15:56:17 -0500
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:46729 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S281038AbRKCU4D>; Sat, 3 Nov 2001 15:56:03 -0500
Message-ID: <20011103205601.2170.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Sat, 3 Nov 2001 21:56:01 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Google's mm problems
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Oct 31, 2001 at 12:07:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 12:07:17AM +0100, Daniel Phillips wrote:
> Hi, I've been taking a look on a mm problem that Ben Smith of Google posted 
> a couple of weeks ago.  As it stands, Google can't use 2.4 yet because all
> known flavors of 2.4 mm fall down in one way or another.  This is not good.

Andrea suggested that this might be a mlock bug and someone else
pointed out that madvise instead of mlock exhibits similar behaviour.
So I looked at this code and this patch looks obviously correct:

--- mlock.c.old Sat Nov  3 19:53:43 2001
+++ mlock.c     Sat Nov  3 19:55:18 2001
@@ -90,7 +90,6 @@
        left->vm_end = start;
        right->vm_start = end;
        right->vm_pgoff += (right->vm_start - left->vm_start) >> PAGE_SHIFT;
-       vma->vm_flags = newflags;
        left->vm_raend = 0;
        right->vm_raend = 0;
        if (vma->vm_file)

This assignment is redundant and it is not protected by any locks.
As far as I can see vma->vm_mm->page_table_lock is supposed to protect
modifications of vma->vm_flags. If this is true we probably need this
as well:

--- filemap.c.old       Sat Nov  3 21:44:12 2001
+++ filemap.c   Sat Nov  3 21:46:36 2001
@@ -2178,7 +2178,9 @@

        if (start == vma->vm_start) {
                if (end == vma->vm_end) {
+                       spin_lock(&vma->vm_mm->page_table_lock);
                        setup_read_behavior(vma, behavior);
+                       spin_unlock(&vma->vm_mm->page_table_lock);
                        vma->vm_raend = 0;
                } else
                        error = madvise_fixup_start(vma, end, behavior);

I doubt that this is the reason for the google memory problems, but
who knows?

    regards  Christian

-- 
THAT'S ALL FOLKS!
