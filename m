Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBTAvd>; Mon, 19 Feb 2001 19:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRBTAvX>; Mon, 19 Feb 2001 19:51:23 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12293 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129115AbRBTAvT>; Mon, 19 Feb 2001 19:51:19 -0500
Date: Mon, 19 Feb 2001 21:02:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: __lock_page calls run_task_queue(&tq_disk) unecessarily?
Message-ID: <Pine.LNX.4.21.0102192051150.3008-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Take a look at __lock_page:

static void __lock_page(struct page *page)
{
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);

        add_wait_queue_exclusive(&page->wait, &wait);
        for (;;) {
                sync_page(page);
                set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                if (PageLocked(page)) {
                        run_task_queue(&tq_disk);
                        schedule();
                        continue;
                }
                if (!TryLockPage(page))
                        break;
        }
        tsk->state = TASK_RUNNING;
        remove_wait_queue(&page->wait, &wait);
}


Af a process sleeps in __lock_page, sync_page() will be called even if the
page is already unlocked. (block_sync_page(), the sync_page routine for
generic block based filesystem calls run_task_queue(&tq_disk)).

I don't see any problem if we remove the run_task_queue(&tq_disk) and put
sync_page(page) there instead, removing the other sync_page(page) at the
beginning of the loop.

Comments?

