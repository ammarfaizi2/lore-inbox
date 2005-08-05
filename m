Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVHEUIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVHEUIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbVHEUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:06:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52165 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263106AbVHEUEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:04:36 -0400
Date: Fri, 5 Aug 2005 22:04:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Message-ID: <20050805200448.GA25002@elte.hu>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200508051958.12853.dominik.karall@gmx.net> <Pine.LNX.4.61.0508051939390.6479@goblin.wat.veritas.com> <200508052123.49640.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508052123.49640.dominik.karall@gmx.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Karall <dominik.karall@gmx.net> wrote:

> With FRAME_POINTERS enabled:
> 
> BUG: mono[3193] exited with nonzero preempt_count 1!
> ---------------------------
> | preempt count: 00000001 ]
> | 1 level deep critical section nesting:
> ----------------------------------------
> .. [<ffffffff80400a46>] .... _spin_lock+0x16/0x80
> .....[<ffffffff801ed30c>] ..   ( <= sys_semtimedop+0x28c/0x7c0)

thanks. It seems semundo->lock somehow leaked. One possibility would be 
of semundo->refcount going from 2 to 1 while another thread has it 
locked. I dont see what prevents this scenario from happening. To test 
this theory, could you apply the patch below, which will do semundo 
locking not conditional on the refcount - does it fix the bug?

	Ingo

 ipc/sem.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

Index: linux-preempt-trace/ipc/sem.c
===================================================================
--- linux-preempt-trace.orig/ipc/sem.c
+++ linux-preempt-trace/ipc/sem.c
@@ -895,7 +895,7 @@ static inline void lock_semundo(void)
 	struct sem_undo_list *undo_list;
 
 	undo_list = current->sysvsem.undo_list;
-	if ((undo_list != NULL) && (atomic_read(&undo_list->refcnt) != 1))
+	if (undo_list)
 		spin_lock(&undo_list->lock);
 }
 
@@ -915,7 +915,7 @@ static inline void unlock_semundo(void)
 	struct sem_undo_list *undo_list;
 
 	undo_list = current->sysvsem.undo_list;
-	if ((undo_list != NULL) && (atomic_read(&undo_list->refcnt) != 1))
+	if (undo_list)
 		spin_unlock(&undo_list->lock);
 }
 
@@ -943,9 +943,7 @@ static inline int get_undo_list(struct s
 		if (undo_list == NULL)
 			return -ENOMEM;
 		memset(undo_list, 0, size);
-		/* don't initialize unodhd->lock here.  It's done
-		 * in copy_semundo() instead.
-		 */
+		spin_lock_init(&undo_list->lock);
 		atomic_set(&undo_list->refcnt, 1);
 		current->sysvsem.undo_list = undo_list;
 	}
@@ -1231,8 +1229,6 @@ int copy_semundo(unsigned long clone_fla
 		error = get_undo_list(&undo_list);
 		if (error)
 			return error;
-		if (atomic_read(&undo_list->refcnt) == 1)
-			spin_lock_init(&undo_list->lock);
 		atomic_inc(&undo_list->refcnt);
 		tsk->sysvsem.undo_list = undo_list;
 	} else 

