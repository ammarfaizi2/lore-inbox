Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTICPzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTICPz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:55:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:36060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263705AbTICPwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:52:03 -0400
Date: Wed, 3 Sep 2003 08:34:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: rusty@rustcorp.com.au, hugh@veritas.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-Id: <20030903083451.7fa78c95.akpm@osdl.org>
In-Reply-To: <20030903073628.GA19920@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain>
	<20030903025605.5C1722C05F@lists.samba.org>
	<20030903073628.GA19920@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> You will be please to know I have written a complete patch :)

Looks pretty sane to me.  A couple of (untested) fixups:



Take mmap_sem for writing around the modification of vma->vm_flags.

But hold it for reading across the populate function: it does I/O and is
slow.



 25-akpm/mm/fremap.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff -puN mm/fremap.c~futex-non-page-pinning-akpm-1 mm/fremap.c
--- 25/mm/fremap.c~futex-non-page-pinning-akpm-1	Wed Sep  3 08:16:30 2003
+++ 25-akpm/mm/fremap.c	Wed Sep  3 08:19:21 2003
@@ -144,7 +144,10 @@ long sys_remap_file_pages(unsigned long 
 		return err;
 #endif
 
-	down_read(&mm->mmap_sem);
+	/*
+	 * vm_flags is protected by down_write(mmap_sem)
+	 */
+	down_write(&mm->mmap_sem);
 
 	vma = find_vma(mm, start);
 	/*
@@ -161,13 +164,12 @@ long sys_remap_file_pages(unsigned long 
 		if (start == vma->vm_start && end == vma->vm_end &&
 				pgoff == vma->vm_pgoff)
 			vma->vm_flags &= ~VM_NONLINEAR;
-
+		downgrade_write(&mm->mmap_sem);
 		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
 				pgoff, flags & MAP_NONBLOCK);
+		up_read(&mm->mmap_sem);
+	} else {
+		up_write(&mm->mmap_sem);
 	}
-
-	up_read(&mm->mmap_sem);
-
 	return err;
 }
-

_


schedule_timeout() returns in state TASK_RUNNING.


 25-akpm/kernel/futex.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN kernel/futex.c~futex-non-page-pinning-akpm-2 kernel/futex.c
--- 25/kernel/futex.c~futex-non-page-pinning-akpm-2	Wed Sep  3 08:31:34 2003
+++ 25-akpm/kernel/futex.c	Wed Sep  3 08:31:47 2003
@@ -358,7 +358,6 @@ static inline int futex_wait(unsigned lo
 
 	spin_unlock(&futex_lock);
 	time = schedule_timeout(time);
-	set_current_state(TASK_RUNNING);
 
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because

_

