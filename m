Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbUKQGeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUKQGeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbUKQGeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:34:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:59365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbUKQGd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:33:56 -0500
Date: Tue, 16 Nov 2004 22:33:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@novell.com>
Subject: Re: loops in get_user_pages() for VM_IO
Message-Id: <20041116223338.08bb6701.akpm@osdl.org>
In-Reply-To: <20041116180718.2fa35fbb.davem@davemloft.net>
References: <20041116175328.5e425e01.davem@davemloft.net>
	<20041116180718.2fa35fbb.davem@davemloft.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> In any event, it is still an open question whether get_user_pages()
>  and thus make_pages_present() is meant to be able to handle
>  VM_IO areas.

It doesn't make a lot of sense.  Andrea says that the only caller of
get_user_pages() which uses a null `pages' arg is mlock(), and mlock of a
VM_IO region is currently causing hangs, and proposes this change:


--- sles/mm/memory.c.~1~	2004-11-12 12:30:25.000000000 +0100
+++ sles/mm/memory.c	2004-11-16 17:58:02.752131952 +0100
@@ -753,7 +753,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
+		if (!vma || (vma->vm_flags & VM_IO)
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;

which should fix up the sbuslib.c problem.

Although I suspect this change will make mlockall() return -EFAULT or a
short result to userspace if the caller had a VM_IO region mapped, which
doesn't seem appropriate.  So perhaps we should silently bale out in the
VM_IO case.

Or, better, simply advance over the VM_IO vma and onto the next one?


--- 25/mm/memory.c~get_user_pages-skip-VM_IO	2004-11-16 22:24:34.470017896 -0800
+++ 25-akpm/mm/memory.c	2004-11-16 22:32:04.890543568 -0800
@@ -761,9 +761,27 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
-				|| !(flags & vma->vm_flags))
-			return i ? : -EFAULT;
+		if (!vma || !(flags & vma->vm_flags))
+			return i ? i : -EFAULT;
+
+		if (vma->vm_flags & VM_IO) {
+			if (pages) {
+				/*
+				 * No, you cannot gather pageframes from VM_IO
+				 * regions
+				 */
+				return i ? i : -EFAULT;
+			}
+			/*
+			 * OK, someone is simply trying to fault in some pages
+			 * and they encountered a VM_IO region.  mlockall()
+			 * can do this.  Simply skip the vma
+			 */
+			start = vma->vm_end;
+			len -= (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+			i += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+			continue;
+		}
 
 		if (is_vm_hugetlb_page(vma)) {
 			i = follow_hugetlb_page(mm, vma, pages, vmas,
_

(I've probably screwed something up there.)
