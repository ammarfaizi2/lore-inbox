Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSLZPTh>; Thu, 26 Dec 2002 10:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSLZPTh>; Thu, 26 Dec 2002 10:19:37 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:32721 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262324AbSLZPTf>; Thu, 26 Dec 2002 10:19:35 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa1
Date: Thu, 26 Dec 2002 16:26:41 +0100
User-Agent: KMail/1.4.3
Cc: "J.A. =?iso-8859-1?q?Magall=F3n?=" <jamagallon@able.es>
References: <20021226010605.GA4223@dualathlon.random> <20021226151358.GA1607@werewolf.able.es>
In-Reply-To: <20021226151358.GA1607@werewolf.able.es>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H8GQ4THXIFZYC5VGP3XA"
Message-Id: <200212261626.41204.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H8GQ4THXIFZYC5VGP3XA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 26 December 2002 16:13, J.A. Magall=F3n wrote:

Hi J.A.

> > =09I never noticed this problem before because I rarely use 3d (and u=
sually
> > =09I had mesasoft setup anyways). It's not specific to a certain grap=
hics
> > card, so it looks more like an agp generic problem or something, I ca=
n
> > reproduce myself on my laptop i830 graphics card and i830 agp, on my
> > desktop g450 with amd agp, and on my test box on a ati radeon 7500 an=
d
> > intel agp, so it doesn't look like a lowlevel driver problem, and it =
only
> > hurts while using the agp and/or drm somehow. Many thanks to Srihari
> > Vijayaraghavan who found the offending patch in the whole kit origina=
lly
> > some time ago.
> I saw it also using nVidia drivers, that do not touch drm. So I would v=
ote
> for agpgart.
try this please.

ciao, Marc
--------------Boundary-00=_H8GQ4THXIFZYC5VGP3XA
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="281_use-after-free-mremap-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="281_use-after-free-mremap-fix.patch"

 mm/mremap.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

--- 24/mm/mremap.c~move_vma-use-after-free	Thu Dec 19 01:29:52 2002
+++ 24-akpm/mm/mremap.c	Thu Dec 19 01:31:43 2002
@@ -134,14 +134,16 @@ static inline unsigned long move_vma(str
 	next = find_vma_prev(mm, new_addr, &prev);
 	if (next) {
 		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+				can_vma_merge(prev, vma->vm_flags) &&
+				!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			prev->vm_end = new_addr + new_len;
 			spin_unlock(&mm->page_table_lock);
 			new_vma = prev;
 			if (next != prev->vm_next)
 				BUG();
-			if (prev->vm_end == next->vm_start && can_vma_merge(next, prev->vm_flags)) {
+			if (prev->vm_end == next->vm_start &&
+					can_vma_merge(next, prev->vm_flags)) {
 				spin_lock(&mm->page_table_lock);
 				prev->vm_end = next->vm_end;
 				__vma_unlink(mm, next, prev);
@@ -151,7 +153,8 @@ static inline unsigned long move_vma(str
 				kmem_cache_free(vm_area_cachep, next);
 			}
 		} else if (next->vm_start == new_addr + new_len &&
-			   can_vma_merge(next, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+					can_vma_merge(next, vma->vm_flags) &&
+					!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			next->vm_start = new_addr;
 			spin_unlock(&mm->page_table_lock);
@@ -160,7 +163,8 @@ static inline unsigned long move_vma(str
 	} else {
 		prev = find_vma(mm, new_addr-1);
 		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+				can_vma_merge(prev, vma->vm_flags) &&
+				!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			prev->vm_end = new_addr + new_len;
 			spin_unlock(&mm->page_table_lock);
@@ -177,11 +181,15 @@ static inline unsigned long move_vma(str
 	}
 
 	if (!move_page_tables(vma, new_addr, addr, old_len)) {
+		unsigned long must_fault_in;
+		unsigned long fault_in_start;
+		unsigned long fault_in_end;
+
 		if (allocated_vma) {
 			*new_vma = *vma;
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
-			new_vma->vm_pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
+			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
 			new_vma->vm_raend = 0;
 			if (new_vma->vm_file)
 				get_file(new_vma->vm_file);
@@ -189,12 +197,19 @@ static inline unsigned long move_vma(str
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
+
+		must_fault_in = new_vma->vm_flags & VM_LOCKED;
+		fault_in_start = new_vma->vm_start;
+		fault_in_end = new_vma->vm_end;
+
 		do_munmap(current->mm, addr, old_len);
+
+		/* new_vma could have been invalidated by do_munmap */
+
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
-		if (new_vma->vm_flags & VM_LOCKED) {
+		if (must_fault_in) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
-			make_pages_present(new_vma->vm_start,
-					   new_vma->vm_end);
+			make_pages_present(fault_in_start, fault_in_end);
 		}
 		return new_addr;
 	}

--------------Boundary-00=_H8GQ4THXIFZYC5VGP3XA--

