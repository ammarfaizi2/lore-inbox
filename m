Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316008AbSENTe1>; Tue, 14 May 2002 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316009AbSENTe0>; Tue, 14 May 2002 15:34:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32014 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316008AbSENTeZ>;
	Tue, 14 May 2002 15:34:25 -0400
Message-ID: <3CE16683.29A888F8@zip.com.au>
Date: Tue, 14 May 2002 12:33:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug with shared memory.
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> 
> Hi,
> we managed to hang the kernel with a db/2 stress test on s/390. The test
> was done on 2.4.7 but the problem is present on all recent 2.4.x and 2.5.x
> kernels (all architectures). In short a schedule is done while holding
> the shm_lock of a shared memory segment. The system call that caused
> this has been sys_ipc with IPC_RMID and from there the call chain is
> as follows: sys_shmctl, shm_destroy, fput, dput, iput, truncate_inode_pages,
> truncate_list_pages, schedule. The scheduler picked a process that called
> sys_shmat. It tries to get the lock and hangs.

There's no way the kernel can successfully hold a spinlock
across that call chain.

> One way to fix this is to remove the schedule call from truncate_list_pages:
> 
> --- linux-2.5/mm/filemap.c~   Tue May 14 17:04:14 2002
> +++ linux-2.5/mm/filemap.c    Tue May 14 17:04:33 2002
> @@ -237,11 +237,6 @@
> 
>                   page_cache_release(page);
> 
> -                 if (need_resched()) {
> -                       __set_current_state(TASK_RUNNING);
> -                       schedule();
> -                 }
> -
>                   write_lock(&mapping->page_lock);
>                   goto restart;
>             }
> 
> Another way is to free the lock before calling fput in shm_destroy but the
> comment says that this functions has to be called with shp and shm_ids.sem
> locked. Comments?

Maybe ipc_ids.ary should become a semaphore?

-
