Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLGBoD>; Wed, 6 Dec 2000 20:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGBnw>; Wed, 6 Dec 2000 20:43:52 -0500
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:42493
	"EHLO hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129248AbQLGBnc>; Wed, 6 Dec 2000 20:43:32 -0500
Message-ID: <3A2EE42C.F59317E9@mvista.com>
Date: Wed, 06 Dec 2000 17:13:16 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: lost need_resched flag re-introduced?]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did not get reply from Linus.  Now try my luck with the kernel mailing
list.  Please cc your reply to my email account.  I stopped watching the
mailing list anymore.

Thanks.

Jun

Jun Sun wrote:
> 
> Linus,
> 
> A while back I reported the lost need_resched flag bug ( it happens if
> need_resched is set right before switch_to() is called).  Later on a one-line
> fix is added to __schedule_tail().
> 
>         current->need_resched |= prev->need_resched;
> 
> I looked at the latest kernel and found this one is gone.  Is the lost
> need_resched problem taken care of in some other way?  Or is it re-introduced?
> 
> In any case, I was going to propose a minor fix over the original one-line
> fix.  See the patch below.
> 
> On RISC machines, the original fix leaves a small window for setting the wrong
> flag.  A pseudo assembly code for the original fix is shown as follows:
> 
> 1. load current->need_resched to R1
> 2. load prev->need_resched to R2
> 3. R1 = R1 | R2
> 4. store R1 to current->need_resched
> 
> If at 1) both need_resched flags are 0, and an interrupt happens between 1)
> and 4), which sets current->resched to 1, we will have wrong result for
> current->need_resched after step 4).
> 
> Jun
> 
> inux/kernel/sched.c:   1.1 1.2 jsun 00/10/31 10:22:44 (modified, needs delta)
> 
> @@ -455,7 +455,9 @@
>   */
>  static inline void __schedule_tail(struct task_struct *prev)
>  {
> -       current->need_resched |= prev->need_resched;
> +       if (prev->need_resched) {
> +               current->need_resched = 1;
> +       }
>  #ifdef CONFIG_SMP
>         if ((prev->state == TASK_RUNNING) &&
>                         (prev != idle_task(smp_processor_id()))) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
