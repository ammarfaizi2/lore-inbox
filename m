Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSCYCeR>; Sun, 24 Mar 2002 21:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312268AbSCYCeI>; Sun, 24 Mar 2002 21:34:08 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:21391 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312267AbSCYCd6>; Sun, 24 Mar 2002 21:33:58 -0500
Message-Id: <5.1.0.14.2.20020325023128.03e40850@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 25 Mar 2002 02:33:53 +0000
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: preempt-related hangs
Cc: Robert Love <rml@tech9.net>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
In-Reply-To: <3C9E8767.4F57CB0A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:11 25/03/02, Andrew Morton wrote:
>Andrew Morton wrote:
> >
> > ..
> > Kernel is 2.5.7, dual PIII.  When I enable preempt it
> > locks during boot.
>
>OK, this patch fixed it.  I don't know why.

Er, because you disable preemption twice and it never gets enabled again? (-:

You probably meant that to be preemt_enable() at the bottom of the patch... 
That might not solve your problem of course... But with the patch you 
basically have completely disabled preemption, you might as well not 
configure it into the kernel. (-;

Anton



>--- linux-2.5.7/kernel/sched.c  Mon Mar 18 13:04:41 2002
>+++ 25/kernel/sched.c   Sun Mar 24 18:09:09 2002
>@@ -1545,6 +1545,8 @@ void set_cpus_allowed(task_t *p, unsigne
>         migration_req_t req;
>         runqueue_t *rq;
>
>+       preempt_disable();
>+
>         new_mask &= cpu_online_map;
>         if (!new_mask)
>                 BUG();
>@@ -1557,7 +1559,7 @@ void set_cpus_allowed(task_t *p, unsigne
>         */
>         if (new_mask & (1UL << p->thread_info->cpu)) {
>                 task_rq_unlock(rq, &flags);
>-               return;
>+               goto out;
>         }
>
>         init_MUTEX_LOCKED(&req.sem);
>@@ -1567,6 +1569,8 @@ void set_cpus_allowed(task_t *p, unsigne
>         wake_up_process(rq->migration_thread);
>
>         down(&req.sem);
>+out:
>+       preempt_disable();
>  }
>
>  static volatile unsigned long migration_mask;
>
>
>-
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

