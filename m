Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbUKQNo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbUKQNo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbUKQNo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:44:57 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:63909 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262317AbUKQNog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:44:36 -0500
Date: Wed, 17 Nov 2004 14:44:08 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: loops in get_user_pages() for VM_IO
Message-ID: <20041117134408.GA5114@dualathlon.random>
References: <20041116175328.5e425e01.davem@davemloft.net> <20041116180718.2fa35fbb.davem@davemloft.net> <20041116223338.08bb6701.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116223338.08bb6701.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 10:33:38PM -0800, Andrew Morton wrote:
> short result to userspace if the caller had a VM_IO region mapped, which
> doesn't seem appropriate.  So perhaps we should silently bale out in the

why don't we simply make make_pages_present void, nobody but mlock.c is
checking its retval anyways despite many more are calling it? Somebody
else may still want to be notified by get_user_pages about the -EFAULT
on non-ram. It's really make_pages_protected and not get_user_pages that
doesn't want to ever return failure (in most cases nobody checks the
reval of make_pages_protected in the first place). So if we've to hide
the error, I'd prefer to hide it in the higher layer. I even noticed the
kernel tree I'm working with has another hack in mlock.c just to hide
_more_ errors returned by make_pages_present, see what a fraction of my
patch looks like now:

@@ -1835,11 +1835,8 @@ int make_pages_present(unsigned long add
 	if (end > vma->vm_end)
 		BUG();
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
-	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
-	if (ret < 0)
-		return ret;
-	return ret == len ? 0 : -1;
+	get_user_pages(current, current->mm, addr,
+		       len, write, 0, NULL, NULL);
 }
 
 /* 

this would be the full port against mainline:

Signed-off-by: Andrea Arcangeli <andrea@novell.com>

Index: linux-2.5/include/linux/mm.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/mm.h,v
retrieving revision 1.195
diff -u -p -r1.195 mm.h
--- linux-2.5/include/linux/mm.h	14 Nov 2004 04:35:49 -0000	1.195
+++ linux-2.5/include/linux/mm.h	17 Nov 2004 13:42:02 -0000
@@ -587,7 +587,7 @@ extern pte_t *FASTCALL(pte_alloc_map(str
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
-extern int make_pages_present(unsigned long addr, unsigned long end);
+extern void make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
 
Index: linux-2.5/mm/memory.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/memory.c,v
retrieving revision 1.191
diff -u -p -r1.191 memory.c
--- linux-2.5/mm/memory.c	16 Nov 2004 03:53:40 -0000	1.191
+++ linux-2.5/mm/memory.c	17 Nov 2004 13:42:02 -0000
@@ -761,7 +761,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
+		if (!vma || (vma->vm_flags & VM_IO)
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
@@ -1754,7 +1754,7 @@ out:
 	return pmd_offset(pgd, address);
 }
 
-int make_pages_present(unsigned long addr, unsigned long end)
+void make_pages_present(unsigned long addr, unsigned long end)
 {
 	int ret, len, write;
 	struct vm_area_struct * vma;
@@ -1768,11 +1768,8 @@ int make_pages_present(unsigned long add
 	if (end > vma->vm_end)
 		BUG();
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
-	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
-	if (ret < 0)
-		return ret;
-	return ret == len ? 0 : -1;
+	get_user_pages(current, current->mm, addr,
+		       len, write, 0, NULL, NULL);
 }
 
 /* 
Index: linux-2.5/mm/mlock.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/mlock.c,v
retrieving revision 1.16
diff -u -p -r1.16 mlock.c
--- linux-2.5/mm/mlock.c	19 Oct 2004 05:54:02 -0000	1.16
+++ linux-2.5/mm/mlock.c	17 Nov 2004 13:42:26 -0000
@@ -47,7 +47,7 @@ static int mlock_fixup(struct vm_area_st
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
 		pages = -pages;
-		ret = make_pages_present(start, end);
+		make_pages_present(start, end);
 	}
 
 	vma->vm_mm->locked_vm -= pages;
