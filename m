Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291325AbSBGVeh>; Thu, 7 Feb 2002 16:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291329AbSBGVe2>; Thu, 7 Feb 2002 16:34:28 -0500
Received: from colorfullife.com ([216.156.138.34]:30993 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S291325AbSBGVeO>;
	Thu, 7 Feb 2002 16:34:14 -0500
Date: Thu, 7 Feb 2002 22:34:10 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.localdomain
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] VM_IO fixes
In-Reply-To: <3C621B44.10C424B9@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202072204150.6350-100000@dbl.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Andrew Morton wrote:
> This patch doesn't fix the PTRACE_PEEKUSR bug - for that we need
> this patch as well as the patch Andrea, Manfred and I pieced
> together - it's at http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre7aa2/00_get_user_pages-2
> I understand that Manfred will be sending you a version of that patch.
> 
My patch is below.
The only difference between my and Andrea's version is one indentation and 
a new comment that warns about possible cache coherency problems.

Tested only on i386 with -pre9, the PTRACE_PEEKUSR oops is fixed (ok, I've 
tested pread from /proc/pid/mem, but that's the same code)

--
	Manfred
<<<<<<<<<<<<<
--- 2.4/mm/memory.c	Tue Dec 25 17:12:07 2001
+++ build-2.4/mm/memory.c	Thu Feb  7 21:53:32 2002
@@ -442,6 +442,13 @@
 	return page;
 }
 
+/*
+ * Please read Documentation/cachetlb.txt before using this function,
+ * accessing foreign memory spaces can cause cache coherency problems.
+ *
+ * Accessing a VM_IO area is even more dangerous, therefore the function
+ * fails if pages is != NULL and a VM_IO area is found.
+ */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas)
 {
@@ -453,6 +460,7 @@
 		vma = find_extend_vma(mm, start);
 
 		if ( !vma ||
+		    (pages && vma->vm_flags & VM_IO) ||
 		    (!force &&
 		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
 		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {
@@ -486,8 +494,9 @@
 				/* FIXME: call the correct function,
 				 * depending on the type of the found page
 				 */
-				if (pages[i])
-					page_cache_get(pages[i]);
+				if (!pages[i])
+					goto bad_page;
+				page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -497,7 +506,19 @@
 		} while(len && start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
 	} while(len);
+out:
 	return i;
+
+	/*
+	 * We found an invalid page in the VMA.  Release all we have
+	 * so far and fail.
+	 */
+bad_page:
+	spin_unlock(&mm->page_table_lock);
+	while (i--)
+		page_cache_release(pages[i]);
+	i = -EFAULT;
+	goto out;
 }
 
 /*
<<<<<<<<<<

