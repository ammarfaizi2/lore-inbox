Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284738AbRLJXxo>; Mon, 10 Dec 2001 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284744AbRLJXxf>; Mon, 10 Dec 2001 18:53:35 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38096 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284738AbRLJXxS>;
	Mon, 10 Dec 2001 18:53:18 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 23:53:00 GMT
Message-Id: <UTC200112102353.XAA288298.aeb@cwi.nl>
To: bottchen@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Sorry to be annoying, but "PATCH for shmdt"
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: <bottchen@earthlink.net>

        Unfortunately the patch I submitted for shmdt has been overlooked.
    It's not a very exciting patch, but it does bring the code into agreement
    with the manpage.  Here is an version of the patch updated for 2.4.16.

Yes, I agree. Referring to POSIX would have been more convincing,
but it is true that shmdt is supposed to return EINVAL when the
memory to be detached is not found.

Andries


    --- linux-2.4.16old/ipc/shm.c   Mon Dec  10 11:53:12 2001
    +++ linux-2.4.16/ipc/shm.c      Mon Dec  10 15:08:51 2001
    @@ -651,16 +651,19 @@
     {
            struct mm_struct *mm = current->mm;
            struct vm_area_struct *shmd, *shmdnext;
    +       int retcode = -EINVAL;

            down_write(&mm->mmap_sem);
            for (shmd = mm->mmap; shmd; shmd = shmdnext) {
                    shmdnext = shmd->vm_next;
                    if (shmd->vm_ops == &shm_vm_ops
    -                   && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr)
    +                   && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
                            do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
    +                       retcode = 0;
    +               }
            }
            up_write(&mm->mmap_sem);
    -       return 0;
    +       return retcode;
     }

     #ifdef CONFIG_PROC_FS

