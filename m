Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWC2NbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWC2NbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWC2NbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:31:16 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:27513 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751114AbWC2NbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:31:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=JUezxgcrrUQMh7qXN1yG4PhTqNE8Leop1WWo2En16ZWqeCtDxyt0KTg5968QtbnPaG8yQJgZVmqqM3PYfy/PAVGGQCQ4Trqgpf0FDjLmjjWJ8x0AVsihbk9ACGlTiSF5clhjmTKRZHRJ36cmlU4hLMv0AAoD4lYBr3Jbyl2lAfo=
Message-ID: <bc56f2f0603290531v2680a403tb30ad1bf94cc1d68@mail.gmail.com>
Date: Wed, 29 Mar 2006 08:31:08 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH 2.6.16] mm: POSIX Memory Lock
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_491_15230155.1143639068678"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_491_15230155.1143639068678
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Currently, Linux's mlock series memory locks/unlocks may fail with
part of their jobs done, thus may confuse the programmers of which
part of memory is locked, which is not.

While a better implementation is transaction-like POSIX memory lock.

POSIX mlock/munlock :

http://www.opengroup.org/onlinepubs/009695399/functions/mlock.html

RETURN VALUE

   Upon successful completion, the mlock() and munlock() functions
shall return a value of zero. Otherwise, no change is made to any
locks in the address space of the process, and the function shall
return a value of -1 and set errno to indicate the error.

POSIX mlockall/munlockall :

http://www.opengroup.org/onlinepubs/009695399/functions/mlockall.html

RETURN VALUE

   Upon successful completion, the mlockall() function shall return a
value of zero.  Otherwise, no additional memory shall be locked, and
the function shall return a value of -1 and set errno to indicate the
error. The effect of failure of mlockall() on previously existing
locks in the address space is unspecified.

   If it is supported by the implementation, the munlockall() function
shall always return a value of zero. Otherwise, the function shall
return a value of -1 and set errno to indicate the error.


The patch try to fix this, tests proved it works.

Nick Piggin suggested that the patch submited alone, as well as using 1 bit=
 of
vm_flags instead of adding 1 member to vm_area_struct. Special thanks to hi=
m.
Besides, the patch is largely rewritten to make it clearer.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

-----

 include/linux/mm.h |    1
 mm/mlock.c         |  283 ++++++++++++++++++++++++++++++++++++------------=
-----
 2 files changed, 196 insertions(+), 88 deletions(-)


diff -urNp linux-2.6.16/include/linux/mm.h
linux-2.6.16-release/include/linux/mm.h
--- linux-2.6.16/include/linux/mm.h=092006-03-28 02:38:07.000000000 -0500
+++ linux-2.6.16-posixmlock/include/linux/mm.h=092006-03-29
05:40:55.000000000 -0500
@@ -166,6 +166,7 @@ extern unsigned int kobjsize(const void
 #define VM_NONLINEAR=090x00800000=09/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY=090x01000000=09/* T if mapped copy of data (nommu m=
map) */
 #define VM_INSERTPAGE=090x02000000=09/* The vma has had
"vm_insert_page()" done on it */
+#define VM_CHANGELOCK=090x04000000=09/* The vma just has VM_LOCKED bit cha=
nged */

 #ifndef VM_STACK_DEFAULT_FLAGS=09=09/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -urNp linux-2.6.16/mm/mlock.c linux-2.6.16-release/mm/mlock.c
--- linux-2.6.16/mm/mlock.c=092006-03-28 02:38:07.000000000 -0500
+++ linux-2.6.16-posixmlock/mm/mlock.c=092006-03-29 05:38:59.000000000 -050=
0
@@ -3,6 +3,7 @@
  *
  *  (C) Copyright 1995 Linus Torvalds
  *  (C) Copyright 2002 Christoph Hellwig
+ *  (C) Copyright 2006 Peter Wang
  */

 #include <linux/capability.h>
@@ -11,72 +12,120 @@
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>

-
-static int mlock_fixup(struct vm_area_struct *vma, struct
vm_area_struct **prev,
-=09unsigned long start, unsigned long end, unsigned int newflags)
+static int do_mlock(unsigned long start, size_t len,unsigned int jump_hole=
)
 {
-=09struct mm_struct * mm =3D vma->vm_mm;
-=09pgoff_t pgoff;
-=09int pages;
+=09unsigned long  end =3D 0, vmoff =3D 0;
+=09unsigned long  pages =3D 0;
+=09struct mm_struct *mm =3D current->mm;
+=09struct vm_area_struct * vma, *prev, **pprev,*next;
 =09int ret =3D 0;

-=09if (newflags =3D=3D vma->vm_flags) {
-=09=09*prev =3D vma;
-=09=09goto out;
-=09}
+=09len =3D PAGE_ALIGN(len);
+=09end =3D start + len;
+=09if (end < start)
+=09=09return -EINVAL;
+=09if (end =3D=3D start)
+=09=09return 0;

-=09pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-=09*prev =3D vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-=09=09=09  vma->vm_file, pgoff, vma_policy(vma));
-=09if (*prev) {
-=09=09vma =3D *prev;
-=09=09goto success;
-=09}
+=09vma =3D find_vma_prev(current->mm, start, &prev);
+=09if (!vma || vma->vm_start > start)
+=09=09return -ENOMEM;

-=09*prev =3D vma;
+=09while (vma->vm_start < end) {
+=09=09if (vma->vm_flags & VM_LOCKED) {
+=09=09=09if (vma->vm_end < end)
+=09=09=09=09goto next;
+=09=09=09else
+=09=09=09=09break;
+=09=09} else {
+=09=09=09if (vma->vm_start < start) {
+=09=09=09=09prev =3D vma;
+=09=09=09=09ret =3D split_vma(mm, prev, start, 0);
+=09=09=09=09if (!ret) {
+=09=09=09=09=09vma =3D prev->vm_next;
+=09=09=09=09=09vmoff =3D vma->vm_end;
+=09=09=09=09}
+=09=09=09=09else=09=09
+=09=09=09=09=09break;
+=09=09=09}
+=09=09=09if (vma->vm_end > end) {
+=09=09=09=09ret =3D split_vma(mm, vma, end, 0);
+   =09=09=09=09if (!ret)
+=09=09=09=09=09vmoff =3D vma->vm_end;
+=09=09=09=09else
+=09=09=09=09=09break;
+=09=09=09}
+=09=09}

-=09if (start !=3D vma->vm_start) {
-=09=09ret =3D split_vma(mm, vma, start, 1);
-=09=09if (ret)
-=09=09=09goto out;
-=09}
+=09=09pages +=3D (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;

-=09if (end !=3D vma->vm_end) {
-=09=09ret =3D split_vma(mm, vma, end, 0);
-=09=09if (ret)
-=09=09=09goto out;
+=09=09vma->vm_flags |=3D VM_LOCKED;
+=09=09vma->vm_flags |=3D VM_CHANGELOCK;
+=09=09vmoff =3D vma->vm_end;
+=09=09if (!(vma->vm_flags & VM_IO)) {
+   =09=09=09ret =3D make_pages_present(vma->vm_start, vma->vm_end);
+=09=09=09if (ret)
+=09=09=09=09break;
+=09=09}
+next:
+=09=09if (vma->vm_end =3D=3D end)
+=09=09=09break;
+=09=09prev =3D vma;
+=09=09vma =3D vma->vm_next;
+=09=09
+=09=09/* If called from do_mlockall,
+=09=09 * we may jump over holes.
+=09=09 */
+=09=09if (jump_hole) {
+=09=09=09if (vma)
+=09=09=09=09continue;
+=09=09=09else
+=09=09=09=09break;
+=09=09}
+=09=09else if (!vma || vma->vm_start !=3D prev->vm_end) {
+=09=09=09ret =3D -ENOMEM;
+=09=09=09break;
+=09=09}
 =09}

-success:
-=09/*
-=09 * vm_flags is protected by the mmap_sem held in write mode.
-=09 * It's okay if try_to_unmap_one unmaps a page just after we
-=09 * set VM_LOCKED, make_pages_present below will bring it back.
-=09 */
-=09vma->vm_flags =3D newflags;
+=09pprev =3D &prev;
+=09vma =3D find_vma_prev(mm, start, pprev);

-=09/*
-=09 * Keep track of amount of locked VM.
+=09/*
+=09 * Try to merge the vmas.
+=09 * If error happened, rollback vmas to original status.
 =09 */
-=09pages =3D (end - start) >> PAGE_SHIFT;
-=09if (newflags & VM_LOCKED) {
-=09=09pages =3D -pages;
-=09=09if (!(newflags & VM_IO))
-=09=09=09ret =3D make_pages_present(start, end);
+=09while (vma && vma->vm_end <=3D vmoff ) {
+=09=09if (vma->vm_flags & VM_CHANGELOCK) {
+=09=09=09vma->vm_flags &=3D ~VM_CHANGELOCK;
+=09=09=09if (ret)
+=09=09=09=09vma->vm_flags &=3D ~VM_LOCKED;
+=09=09}
+=09=09next =3D vma->vm_next;
+=09=09if (next && (next->vm_flags & VM_CHANGELOCK)) {
+=09=09=09next->vm_flags &=3D ~VM_CHANGELOCK;
+=09=09=09if (ret)
+=09=09=09=09next->vm_flags &=3D ~VM_LOCKED;
+=09=09}
+=09=09*pprev =3D vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm=
_flags,
+=09=09=09=09=09vma->anon_vma,vma->vm_file, vma->vm_pgoff, vma_policy(vma))=
;
+=09=09if (*pprev)
+=09=09=09vma =3D *pprev;
+=09=09vma =3D vma->vm_next;
 =09}

-=09vma->vm_mm->locked_vm -=3D pages;
-out:
-=09if (ret =3D=3D -ENOMEM)
-=09=09ret =3D -EAGAIN;
+=09if (!ret)
+=09=09mm->locked_vm +=3D pages;
 =09return ret;
 }

-static int do_mlock(unsigned long start, size_t len, int on)
+static int do_munlock(unsigned long start, size_t len, unsigned int jump_h=
ole)
 {
-=09unsigned long nstart, end, tmp;
-=09struct vm_area_struct * vma, * prev;
-=09int error;
+=09unsigned long  end =3D 0,vmoff =3D 0;
+=09unsigned long  pages =3D 0;
+=09struct mm_struct *mm=3Dcurrent->mm;
+=09struct vm_area_struct * vma, *prev, **pprev, *next;
+=09int ret =3D 0;

 =09len =3D PAGE_ALIGN(len);
 =09end =3D start + len;
@@ -88,37 +137,86 @@ static int do_mlock(unsigned long start,
 =09if (!vma || vma->vm_start > start)
 =09=09return -ENOMEM;

-=09if (start > vma->vm_start)
-=09=09prev =3D vma;
-
-=09for (nstart =3D start ; ; ) {
-=09=09unsigned int newflags;
+=09while (vma->vm_start < end) {
+=09=09if (!(vma->vm_flags & VM_LOCKED)) {
+=09=09=09if(vma->vm_end < end)
+=09=09=09=09goto next;
+=09=09=09else
+=09=09=09=09break;
+=09=09} else {
+=09=09=09if (vma->vm_start < start) {
+=09=09=09=09prev =3D vma;
+=09=09=09=09ret =3D split_vma(mm, prev, start, 0);
+=09=09=09=09if (!ret) {
+=09=09=09=09=09vma =3D prev->vm_next;
+=09=09=09=09=09vmoff =3D vma->vm_end;
+=09=09=09=09}
+=09=09=09=09else
+=09=09=09=09=09break;
+=09=09=09}
+=09=09=09if (vma->vm_end > end) {
+=09=09=09=09ret =3D split_vma(mm, vma, end, 0);
+=09=09=09=09if (!ret)
+=09=09=09=09=09vmoff =3D vma->vm_end;
+=09=09=09=09else
+=09=09=09=09=09break;
+=09=09=09}
+=09=09}

-=09=09/* Here we know that  vma->vm_start <=3D nstart < vma->vm_end. */
+=09=09/* Delay clearing VM_LOCKED bit here,
+=09=09 * thus make the possibly rollback easy.
+=09=09 */
+=09=09vma->vm_flags |=3D VM_CHANGELOCK;
+=09=09vmoff =3D vma->vm_end;
+=09=09pages +=3D (vma->vm_end -vma->vm_start) >> PAGE_SHIFT;

-=09=09newflags =3D vma->vm_flags | VM_LOCKED;
-=09=09if (!on)
-=09=09=09newflags &=3D ~VM_LOCKED;
-
-=09=09tmp =3D vma->vm_end;
-=09=09if (tmp > end)
-=09=09=09tmp =3D end;
-=09=09error =3D mlock_fixup(vma, &prev, nstart, tmp, newflags);
-=09=09if (error)
-=09=09=09break;
-=09=09nstart =3D tmp;
-=09=09if (nstart < prev->vm_end)
-=09=09=09nstart =3D prev->vm_end;
-=09=09if (nstart >=3D end)
+next:
+=09=09if (vma->vm_end =3D=3D end)
 =09=09=09break;
+=09=09prev =3D vma;
+=09=09vma =3D vma->vm_next;

-=09=09vma =3D prev->vm_next;
-=09=09if (!vma || vma->vm_start !=3D nstart) {
-=09=09=09error =3D -ENOMEM;
+=09=09/* If called from munlockall,
+=09=09 * we may jump over holes.
+=09=09 */
+=09=09if (jump_hole) {
+=09=09=09if (!vma)
+=09=09=09=09break;
+=09=09=09else
+=09=09=09=09continue;
+=09=09}
+=09=09else if (!vma || (vma->vm_start !=3D prev->vm_end)) {
+=09=09=09ret =3D -ENOMEM;
 =09=09=09break;
 =09=09}
 =09}
-=09return error;
+
+=09pprev =3D &prev;
+=09vma =3D find_vma_prev(current->mm, start, pprev);
+
+=09while (vma && vma->vm_end <=3D vmoff) {
+=09=09if (vma->vm_flags & VM_CHANGELOCK) {
+=09=09=09vma->vm_flags &=3D ~VM_CHANGELOCK;
+=09=09=09if (!ret)
+=09=09=09=09vma->vm_flags &=3D~VM_LOCKED;
+=09=09}
+=09=09next =3D vma->vm_next;
+=09=09if (next && (next->vm_flags & VM_CHANGELOCK)) {
+=09=09=09next->vm_flags &=3D ~VM_CHANGELOCK;
+=09=09=09if (!ret)
+=09=09=09=09next->vm_flags &=3D ~VM_LOCKED;
+=09=09}
+=09=09*pprev =3D vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm=
_flags,
+=09=09=09=09vma->anon_vma, vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+=09=09if (*pprev)
+=09=09=09vma =3D *pprev;
+=09=09vma =3D vma->vm_next;
+=09}
+
+=09if (!ret)
+=09=09mm->locked_vm -=3D pages;
+=09
+=09return ret;
 }

 asmlinkage long sys_mlock(unsigned long start, size_t len)
@@ -142,7 +240,7 @@ asmlinkage long sys_mlock(unsigned long

 =09/* check against resource limits */
 =09if ((locked <=3D lock_limit) || capable(CAP_IPC_LOCK))
-=09=09error =3D do_mlock(start, len, 1);
+=09=09error =3D do_mlock(start, len, 0);
 =09up_write(&current->mm->mmap_sem);
 =09return error;
 }
@@ -154,34 +252,43 @@ asmlinkage long sys_munlock(unsigned lon
 =09down_write(&current->mm->mmap_sem);
 =09len =3D PAGE_ALIGN(len + (start & ~PAGE_MASK));
 =09start &=3D PAGE_MASK;
-=09ret =3D do_mlock(start, len, 0);
+=09ret =3D do_munlock(start, len, 0);
 =09up_write(&current->mm->mmap_sem);
 =09return ret;
 }

 static int do_mlockall(int flags)
 {
-=09struct vm_area_struct * vma, * prev =3D NULL;
+=09struct mm_struct *mm =3D current->mm;
+=09struct vm_area_struct * vma;
 =09unsigned int def_flags =3D 0;
+=09unsigned long start;
+=09int ret =3D 0;

 =09if (flags & MCL_FUTURE)
 =09=09def_flags =3D VM_LOCKED;
-=09current->mm->def_flags =3D def_flags;
+=09mm->def_flags =3D def_flags;
 =09if (flags =3D=3D MCL_FUTURE)
 =09=09goto out;
+=09vma =3D mm->mmap;
+=09start =3D vma->vm_start;
+=09ret =3D do_mlock(start, TASK_SIZE, 1);
+out:
+=09return ret;
+}

-=09for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
-=09=09unsigned int newflags;
+static int do_munlockall(void)
+{
+=09struct mm_struct *mm =3D current->mm;
+=09struct vm_area_struct * vma;
+=09unsigned long start;
+=09int ret;

-=09=09newflags =3D vma->vm_flags | VM_LOCKED;
-=09=09if (!(flags & MCL_CURRENT))
-=09=09=09newflags &=3D ~VM_LOCKED;
+=09vma =3D mm->mmap;
+=09start =3D vma->vm_start;
+=09ret =3D do_munlock(start, TASK_SIZE, 1);

-=09=09/* Ignore errors */
-=09=09mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-=09}
-out:
-=09return 0;
+=09return ret;
 }

 asmlinkage long sys_mlockall(int flags)
@@ -215,7 +322,7 @@ asmlinkage long sys_munlockall(void)
 =09int ret;

 =09down_write(&current->mm->mmap_sem);
-=09ret =3D do_mlockall(0);
+=09ret =3D do_munlockall();
 =09up_write(&current->mm->mmap_sem);
 =09return ret;
 }

------=_Part_491_15230155.1143639068678
Content-Type: application/octet-stream; name=patch-2.6.16-posixmlock
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="patch-2.6.16-posixmlock"

diff -urNp linux-2.6.16/include/linux/mm.h linux-2.6.16-release/include/linux/mm.h
--- linux-2.6.16/include/linux/mm.h	2006-03-28 02:38:07.000000000 -0500
+++ linux-2.6.16-posixmlock/include/linux/mm.h	2006-03-29 05:40:55.000000000 -0500
@@ -166,6 +166,7 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_CHANGELOCK	0x04000000	/* The vma just has VM_LOCKED bit changed */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -urNp linux-2.6.16/mm/mlock.c linux-2.6.16-release/mm/mlock.c
--- linux-2.6.16/mm/mlock.c	2006-03-28 02:38:07.000000000 -0500
+++ linux-2.6.16-posixmlock/mm/mlock.c	2006-03-29 05:38:59.000000000 -0500
@@ -3,6 +3,7 @@
  *
  *  (C) Copyright 1995 Linus Torvalds
  *  (C) Copyright 2002 Christoph Hellwig
+ *  (C) Copyright 2006 Peter Wang
  */
 
 #include <linux/capability.h>
@@ -11,72 +12,120 @@
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 
-
-static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
-	unsigned long start, unsigned long end, unsigned int newflags)
+static int do_mlock(unsigned long start, size_t len,unsigned int jump_hole)
 {
-	struct mm_struct * mm = vma->vm_mm;
-	pgoff_t pgoff;
-	int pages;
+	unsigned long  end = 0, vmoff = 0;
+	unsigned long  pages = 0;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma, *prev, **pprev,*next;
 	int ret = 0;
 
-	if (newflags == vma->vm_flags) {
-		*prev = vma;
-		goto out;
-	}
+	len = PAGE_ALIGN(len);
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma));
-	if (*prev) {
-		vma = *prev;
-		goto success;
-	}
+	vma = find_vma_prev(current->mm, start, &prev);
+	if (!vma || vma->vm_start > start)
+		return -ENOMEM;
 
-	*prev = vma;
+	while (vma->vm_start < end) {
+		if (vma->vm_flags & VM_LOCKED) {
+			if (vma->vm_end < end)
+				goto next;
+			else
+				break;
+		} else {
+			if (vma->vm_start < start) {
+				prev = vma;
+				ret = split_vma(mm, prev, start, 0);
+				if (!ret) {
+					vma = prev->vm_next;
+					vmoff = vma->vm_end;
+				}
+				else		
+					break;
+			}
+			if (vma->vm_end > end) {
+				ret = split_vma(mm, vma, end, 0);
+   				if (!ret) 
+					vmoff = vma->vm_end;
+				else
+					break;
+			}
+		}
 
-	if (start != vma->vm_start) {
-		ret = split_vma(mm, vma, start, 1);
-		if (ret)
-			goto out;
-	}
+		pages += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
-	if (end != vma->vm_end) {
-		ret = split_vma(mm, vma, end, 0);
-		if (ret)
-			goto out;
+		vma->vm_flags |= VM_LOCKED;
+		vma->vm_flags |= VM_CHANGELOCK;
+		vmoff = vma->vm_end;
+		if (!(vma->vm_flags & VM_IO)) {
+   			ret = make_pages_present(vma->vm_start, vma->vm_end);
+			if (ret)
+				break;
+		}
+next:
+		if (vma->vm_end == end)
+			break;
+		prev = vma;
+		vma = vma->vm_next;
+		
+		/* If called from do_mlockall, 
+		 * we may jump over holes. 
+		 */
+		if (jump_hole) { 
+			if (vma)
+				continue;
+			else
+				break;
+		}
+		else if (!vma || vma->vm_start != prev->vm_end) {
+			ret = -ENOMEM;
+			break;
+		}
 	}
 
-success:
-	/*
-	 * vm_flags is protected by the mmap_sem held in write mode.
-	 * It's okay if try_to_unmap_one unmaps a page just after we
-	 * set VM_LOCKED, make_pages_present below will bring it back.
-	 */
-	vma->vm_flags = newflags;
+	pprev = &prev;
+	vma = find_vma_prev(mm, start, pprev);
 
-	/*
-	 * Keep track of amount of locked VM.
+	/* 
+	 * Try to merge the vmas.
+	 * If error happened, rollback vmas to original status.
 	 */
-	pages = (end - start) >> PAGE_SHIFT;
-	if (newflags & VM_LOCKED) {
-		pages = -pages;
-		if (!(newflags & VM_IO))
-			ret = make_pages_present(start, end);
+	while (vma && vma->vm_end <= vmoff ) {
+		if (vma->vm_flags & VM_CHANGELOCK) {
+			vma->vm_flags &= ~VM_CHANGELOCK;
+			if (ret)
+				vma->vm_flags &= ~VM_LOCKED;
+		}
+		next = vma->vm_next;
+		if (next && (next->vm_flags & VM_CHANGELOCK)) {
+			next->vm_flags &= ~VM_CHANGELOCK;
+			if (ret)
+				next->vm_flags &= ~VM_LOCKED;
+		}
+		*pprev = vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm_flags,
+					vma->anon_vma,vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+		if (*pprev)
+			vma = *pprev;
+		vma = vma->vm_next;
 	}
 
-	vma->vm_mm->locked_vm -= pages;
-out:
-	if (ret == -ENOMEM)
-		ret = -EAGAIN;
+	if (!ret)
+		mm->locked_vm += pages;
 	return ret;
 }
 
-static int do_mlock(unsigned long start, size_t len, int on)
+static int do_munlock(unsigned long start, size_t len, unsigned int jump_hole)
 {
-	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * prev;
-	int error;
+	unsigned long  end = 0,vmoff = 0;
+	unsigned long  pages = 0;
+	struct mm_struct *mm=current->mm;
+	struct vm_area_struct * vma, *prev, **pprev, *next;
+	int ret = 0;
 
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -88,37 +137,86 @@ static int do_mlock(unsigned long start,
 	if (!vma || vma->vm_start > start)
 		return -ENOMEM;
 
-	if (start > vma->vm_start)
-		prev = vma;
-
-	for (nstart = start ; ; ) {
-		unsigned int newflags;
+	while (vma->vm_start < end) {
+		if (!(vma->vm_flags & VM_LOCKED)) {
+			if(vma->vm_end < end)
+				goto next;
+			else
+				break;
+		} else {
+			if (vma->vm_start < start) {
+				prev = vma;
+				ret = split_vma(mm, prev, start, 0);
+				if (!ret) {
+					vma = prev->vm_next;
+					vmoff = vma->vm_end;
+				}
+				else 
+					break;
+			}
+			if (vma->vm_end > end) {
+				ret = split_vma(mm, vma, end, 0);
+				if (!ret)
+					vmoff = vma->vm_end;
+				else
+					break;
+			}
+		}
 
-		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
+		/* Delay clearing VM_LOCKED bit here,
+		 * thus make the possibly rollback easy.
+		 */
+		vma->vm_flags |= VM_CHANGELOCK;
+		vmoff = vma->vm_end;
+		pages += (vma->vm_end -vma->vm_start) >> PAGE_SHIFT;
 
-		newflags = vma->vm_flags | VM_LOCKED;
-		if (!on)
-			newflags &= ~VM_LOCKED;
-
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
-		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
-		if (error)
-			break;
-		nstart = tmp;
-		if (nstart < prev->vm_end)
-			nstart = prev->vm_end;
-		if (nstart >= end)
+next:
+		if (vma->vm_end == end)
 			break;
+		prev = vma;
+		vma = vma->vm_next;
 
-		vma = prev->vm_next;
-		if (!vma || vma->vm_start != nstart) {
-			error = -ENOMEM;
+		/* If called from munlockall,
+		 * we may jump over holes.
+		 */
+		if (jump_hole) {
+			if (!vma)
+				break;
+			else
+				continue;
+		}
+		else if (!vma || (vma->vm_start != prev->vm_end)) {
+			ret = -ENOMEM;
 			break;
 		}
 	}
-	return error;
+
+	pprev = &prev;
+	vma = find_vma_prev(current->mm, start, pprev);
+
+	while (vma && vma->vm_end <= vmoff) {
+		if (vma->vm_flags & VM_CHANGELOCK) {
+			vma->vm_flags &= ~VM_CHANGELOCK;
+			if (!ret)
+				vma->vm_flags &=~VM_LOCKED;
+		}
+		next = vma->vm_next;
+		if (next && (next->vm_flags & VM_CHANGELOCK)) {
+			next->vm_flags &= ~VM_CHANGELOCK;
+			if (!ret)
+				next->vm_flags &= ~VM_LOCKED;
+		}
+		*pprev = vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm_flags,
+				vma->anon_vma, vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+		if (*pprev)
+			vma = *pprev;
+		vma = vma->vm_next;
+	}
+
+	if (!ret)
+		mm->locked_vm -= pages;
+	
+	return ret;
 }
 
 asmlinkage long sys_mlock(unsigned long start, size_t len)
@@ -142,7 +240,7 @@ asmlinkage long sys_mlock(unsigned long 
 
 	/* check against resource limits */
 	if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
-		error = do_mlock(start, len, 1);
+		error = do_mlock(start, len, 0);
 	up_write(&current->mm->mmap_sem);
 	return error;
 }
@@ -154,34 +252,43 @@ asmlinkage long sys_munlock(unsigned lon
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
-	ret = do_mlock(start, len, 0);
+	ret = do_munlock(start, len, 0);
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }
 
 static int do_mlockall(int flags)
 {
-	struct vm_area_struct * vma, * prev = NULL;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
 	unsigned int def_flags = 0;
+	unsigned long start;
+	int ret = 0;
 
 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
-	current->mm->def_flags = def_flags;
+	mm->def_flags = def_flags;
 	if (flags == MCL_FUTURE)
 		goto out;
+	vma = mm->mmap;
+	start = vma->vm_start;
+	ret = do_mlock(start, TASK_SIZE, 1);
+out:
+	return ret;
+}
 
-	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
-		unsigned int newflags;
+static int do_munlockall(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
+	unsigned long start;
+	int ret;
 
-		newflags = vma->vm_flags | VM_LOCKED;
-		if (!(flags & MCL_CURRENT))
-			newflags &= ~VM_LOCKED;
+	vma = mm->mmap;
+	start = vma->vm_start;
+	ret = do_munlock(start, TASK_SIZE, 1);
 
-		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-	}
-out:
-	return 0;
+	return ret;
 }
 
 asmlinkage long sys_mlockall(int flags)
@@ -215,7 +322,7 @@ asmlinkage long sys_munlockall(void)
 	int ret;
 
 	down_write(&current->mm->mmap_sem);
-	ret = do_mlockall(0);
+	ret = do_munlockall();
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }

------=_Part_491_15230155.1143639068678--
