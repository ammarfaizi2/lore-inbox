Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBTCyA>; Mon, 19 Feb 2001 21:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbRBTCxv>; Mon, 19 Feb 2001 21:53:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:17925 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129066AbRBTCxb>; Mon, 19 Feb 2001 21:53:31 -0500
Date: Mon, 19 Feb 2001 23:05:23 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __lock_page calls run_task_queue(&tq_disk) unecessarily?
In-Reply-To: <Pine.LNX.4.21.0102192051150.3008-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0102192302290.3338-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw ___wait_on_page() does something similar.

Here goes the patch for both __lock_page() and ___wait_on_page().


--- linux/mm/filemap.c.orig     Mon Feb 19 23:51:02 2001
+++ linux/mm/filemap.c  Mon Feb 19 23:51:33 2001
@@ -611,11 +611,11 @@
 
        add_wait_queue(&page->wait, &wait);
        do {
-               sync_page(page);
                set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                if (!PageLocked(page))
                        break;
-               run_task_queue(&tq_disk);
+
+               sync_page(page);
                schedule();
        } while (PageLocked(page));
        tsk->state = TASK_RUNNING;
@@ -633,10 +633,9 @@
 
        add_wait_queue_exclusive(&page->wait, &wait);
        for (;;) {
-               sync_page(page);
                set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                if (PageLocked(page)) {
-                       run_task_queue(&tq_disk);
+                       sync_page(page);
                        schedule();
                        continue;
                }


On Mon, 19 Feb 2001, Marcelo Tosatti wrote:

> 
> Hi Linus,
> 
> Take a look at __lock_page:
> 
> static void __lock_page(struct page *page)
> {
>         struct task_struct *tsk = current;
>         DECLARE_WAITQUEUE(wait, tsk);
> 
>         add_wait_queue_exclusive(&page->wait, &wait);
>         for (;;) {
>                 sync_page(page);
>                 set_task_state(tsk, TASK_UNINTERRUPTIBLE);
>                 if (PageLocked(page)) {
>                         run_task_queue(&tq_disk);
>                         schedule();
>                         continue;
>                 }
>                 if (!TryLockPage(page))
>                         break;
>         }
>         tsk->state = TASK_RUNNING;
>         remove_wait_queue(&page->wait, &wait);
> }
> 
> 
> Af a process sleeps in __lock_page, sync_page() will be called even if the
> page is already unlocked. (block_sync_page(), the sync_page routine for
> generic block based filesystem calls run_task_queue(&tq_disk)).
> 
> I don't see any problem if we remove the run_task_queue(&tq_disk) and put
> sync_page(page) there instead, removing the other sync_page(page) at the
> beginning of the loop.
> 
> Comments?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

