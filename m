Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276856AbRJKUUu>; Thu, 11 Oct 2001 16:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276860AbRJKUUk>; Thu, 11 Oct 2001 16:20:40 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:31700 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S276856AbRJKUUa>; Thu, 11 Oct 2001 16:20:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adam Bottchen <bottchen@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Patch to sys_shmdt
Date: Thu, 11 Oct 2001 15:20:06 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Message-Id: <01101115200601.24484@scully>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Currently sys_shmdt() always returns success.  Below is a patch that changes
 this behavior to match the man page.  This patch will cause sys_shmdt() to 
return success only when it finds something to detach, and returns EINVAL 
otherwise.  The patch was run on a 2.4.10 kernel tree, but applies against a 2.4.12
tree with no problems.


--- linux-2.4.10old/ipc/shm.c   Fri Oct  5 11:53:12 2001
+++ linux-2.4.10/ipc/shm.c      Fri Oct  5 15:08:51 2001
@@ -649,16 +649,19 @@
 {
        struct mm_struct *mm = current->mm;
        struct vm_area_struct *shmd, *shmdnext;
+       int retcode=-EINVAL;

        down_write(&mm->mmap_sem);
        for (shmd = mm->mmap; shmd; shmd = shmdnext) {
                shmdnext = shmd->vm_next;
                if (shmd->vm_ops == &shm_vm_ops
-                   && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr)
+                   && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
                        do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
+                       retcode=0;
+               }
        }
        up_write(&mm->mmap_sem);
-       return 0;
+       return retcode;
 }

 #ifdef CONFIG_PROC_FS


Adam Bottchen
bottchen@earthlink.net
