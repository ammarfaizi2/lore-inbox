Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSB1A2o>; Wed, 27 Feb 2002 19:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293101AbSB1A1v>; Wed, 27 Feb 2002 19:27:51 -0500
Received: from mout0.freenet.de ([194.97.50.131]:1935 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S293098AbSB1A1S>;
	Wed, 27 Feb 2002 19:27:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19pre1-ac1
Date: Thu, 28 Feb 2002 01:27:32 +0100
X-Mailer: KMail [version 1.2]
Cc: florin@iucha.net (Florin Iucha), linux-kernel@vger.kernel.org
In-Reply-To: <E16gEWj-0006aD-00@the-village.bc.nu>
In-Reply-To: <E16gEWj-0006aD-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <02022801273203.01097@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

> > Will try this now, sounds possible - but does patch really use shared
> > memory? I will try to narrow it down a bit. There also were some changes
> > to mm/memory.c between 2.4.18-rc2-ac2 and 2.4.18-ac1. Also a possibility?
>
> Could be - as far as I can tell they are also in vanilla 2.4.18 (the
> ptrace ones)

The changes I see here between them do not seem to be related to ptrace. But 
I think I already found one possible glitch by manual inspection there. Both 
kernels are compiling just now so I can test later.

diff -u -r linux-2.4.18-rc2-ac2/mm/memory.c linux-2.4.18-ac1/mm/memory.c
--- linux-2.4.18-rc2-ac2/mm/memory.c    Thu Feb 28 01:01:51 2002
+++ linux-2.4.18-ac1/mm/memory.c        Thu Feb 28 00:54:09 2002
@@ -180,7 +180,7 @@
        pgd_t * src_pgd, * dst_pgd;
        unsigned long address = vma->vm_start;
        unsigned long end = vma->vm_end;
-       unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_WRITE)) == 
VM_WRITE;
+       unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == 
VM_MAYWRITE;
 
        src_pgd = pgd_offset(src, address)-1;
        dst_pgd = pgd_offset(dst, address)-1;
@@ -250,7 +250,7 @@
                                        goto cont_copy_pte_range;
 
                                /* If it's a COW mapping, write protect it 
both in the parent and the child */
-                               if (cow) {
+                               if (cow && pte_write(pte)) {
                                        ptep_set_wrprotect(src_pte);
                                        pte = *src_pte;
                                }
@@ -460,21 +460,24 @@
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned 
long start,
                int len, int write, int force, struct page **pages, struct 
vm_area_struct **vmas)
 {
-       int i = 0;
+       int i;
+       unsigned int flags;
+
+       /*
+        * Require read or write permissions.
+        * If 'force' is set, we only require the "MAY" flags.
+        */
+       flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
+       flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
+       i = 0;
 
        do {
                struct vm_area_struct * vma;
 
                vma = find_extend_vma(mm, start);
 
-               if ( !vma ||
-                   (pages && vma->vm_flags & VM_IO) ||
-                   (!force &&
-                       ((write && (!(vma->vm_flags & VM_WRITE))) ||
-                        (!write && (!(vma->vm_flags & VM_READ))) ) )) {
-                       if (i) return i;
-                       return -EFAULT;
-               }
+               if ( !vma || (pages && vma->vm_flags & VM_IO) || !(flags & 
vma->vm_flags) )
+                       return i ? : -EFAULT;
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ <- This looks somewhat bogus, 
shouldn't it be "return i ? i : -EFAULT;" instead?

Greetings,
Andreas
