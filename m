Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293317AbSCOVex>; Fri, 15 Mar 2002 16:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCOVep>; Fri, 15 Mar 2002 16:34:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40614 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293317AbSCOVei>; Fri, 15 Mar 2002 16:34:38 -0500
Subject: shmdt fix
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosati <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 15 Mar 2002 15:31:44 -0600
Message-Id: <1016227905.28607.36.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, in 2.4.19-pre1 the changelog said that the shmdt fix was
included, but it is still failing the LTP testcase that found this
problem.  There is a small, but important set of {}'s that got missed,
so it is still always returning 0 even if there is nothing to detach. 
The attached diff will clean this up on 2.4.19-pre3.

Thanks,
Paul Larson


diff -Naur linux/ipc/shm.c linux-shmdt/ipc/shm.c
--- linux/ipc/shm.c	Fri Mar 15 15:13:07 2002
+++ linux-shmdt/ipc/shm.c	Fri Mar 15 15:16:21 2002
@@ -678,9 +678,10 @@
 	for (shmd = mm->mmap; shmd; shmd = shmdnext) {
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
-		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr)
+		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
 			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
 			retval = 0;
+		}
 	}
 	up_write(&mm->mmap_sem);
 	return retval;

