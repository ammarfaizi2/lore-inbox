Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSENPOy>; Tue, 14 May 2002 11:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315780AbSENPOx>; Tue, 14 May 2002 11:14:53 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:57023 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S315779AbSENPOv> convert rfc822-to-8bit; Tue, 14 May 2002 11:14:51 -0400
Importance: Normal
Sensitivity: 
Subject: Bug with shared memory.
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 14 May 2002 17:13:06 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 14/05/2002 17:14:40
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we managed to hang the kernel with a db/2 stress test on s/390. The test
was done on 2.4.7 but the problem is present on all recent 2.4.x and 2.5.x
kernels (all architectures). In short a schedule is done while holding
the shm_lock of a shared memory segment. The system call that caused
this has been sys_ipc with IPC_RMID and from there the call chain is
as follows: sys_shmctl, shm_destroy, fput, dput, iput, truncate_inode_pages,
truncate_list_pages, schedule. The scheduler picked a process that called
sys_shmat. It tries to get the lock and hangs.

One way to fix this is to remove the schedule call from truncate_list_pages:

--- linux-2.5/mm/filemap.c~   Tue May 14 17:04:14 2002
+++ linux-2.5/mm/filemap.c    Tue May 14 17:04:33 2002
@@ -237,11 +237,6 @@

                  page_cache_release(page);

-                 if (need_resched()) {
-                       __set_current_state(TASK_RUNNING);
-                       schedule();
-                 }
-
                  write_lock(&mapping->page_lock);
                  goto restart;
            }

Another way is to free the lock before calling fput in shm_destroy but the
comment says that this functions has to be called with shp and shm_ids.sem
locked. Comments?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


