Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKXVrh>; Fri, 24 Nov 2000 16:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130208AbQKXVr1>; Fri, 24 Nov 2000 16:47:27 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:49161 "EHLO
        mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
        id <S129518AbQKXVrO>; Fri, 24 Nov 2000 16:47:14 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
From: buhr@stat.wisc.edu (Kevin Buhr)
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
Date: 24 Nov 2000 15:17:13 -0600
Message-ID: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been chasing after a bug in 2.4.0-test5 that I can't quite nail
down.  I don't see anything obvious between test5 and test11 that
leads me to believe it's been fixed.

I encountered a lockup on my SMP box.  One CPU got stuck in a spinlock
via the following call trace.  There were enough args and saved
registers on the stack for me to reconstruct a few of the calls:

  valid_swaphandles(entry=c218b268, offset=c68e7e78)
  swapin_readahead(entry=c218b268)
  shm_nopage_core(shp=c218b240, idx=0, address=40014000)
  shm_nopage
  do_no_page
  handle_mm_fault
  do_page_fault
  schedule
  sys_ipc (at call to sys_shmat)

"valid_swaphandles" locked on the:

        swap_device_lock(swapdev)

and it's not surprising it did.  The SWP_TYPE(entry) was swapfile
index 52 on my 2-swapfile system, so it was spinning on some random
piece of memory.

In "shm_nopage", the code

        if(!(shp = shm_lock(inode->i_ino)))
                BUG();

got a "shp" of 0xc218b240.  For some reason, this wasn't a valid
"shp", because in "shm_nopage_core", the

        pte = SHM_ENTRY(shp,idx);  // in our case, shp->shm_dir[0][0]

returned 0xc218b268 (i.e., the value of &shp->shm_dir, so maybe
shp->shm_dir was a pointer to itself---not possible if "shp" pointed
to a valid "struct shmid_kernel").

The SHM locking has thwarted my attempts at understanding.  Maybe
someone else can see the bug or reassure me that it's already been
fixed in test11?

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
