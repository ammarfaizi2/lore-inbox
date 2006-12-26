Return-Path: <linux-kernel-owner+w=401wt.eu-S932735AbWLZRoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWLZRoL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWLZRoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:44:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:45812 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbWLZRoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:44:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Szh7Rl0S9HI3ZkC/EgWhW8R2ZguSPgIZrCqyYnWpkjF5AuBNZthUTQesQp8k6/AO7+qoJ7jX+XMp9R4269pJiNhqX/dqTZCB8Oof3jA6m3Or7FebRkXNXyswvDB9TRMkRuX8jZvk/vXSOGwR3UKho+ynskene5P6Hi3uuucVDa8=
Message-ID: <b637ec0b0612260944g15402295nd6f41d3ca9ed99ac@mail.gmail.com>
Date: Tue, 26 Dec 2006 12:44:07 -0500
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: Linux 2.6.20-rc2
Cc: "Randy Dunlap" <randy.dunlap@oracle.com>, "Andrew Morton" <akpm@osdl.org>,
       "Florin Iucha" <florin@iucha.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061226163713.GA9047@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061225224047.GB6087@iucha.net>
	 <20061225225616.GA22307@iucha.net>
	 <20061226022538.13ea8b3f.akpm@osdl.org>
	 <20061226124019.GA3701@elte.hu>
	 <20061226073610.1b86a7cc.randy.dunlap@oracle.com>
	 <20061226162616.GA6756@elte.hu> <20061226163713.GA9047@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Can you confirm that the problem I mentioned in
http://lkml.org/lkml/2006/12/24/32 is the same?

Best regards,
Fabio




On 12/26/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > > I've had at least one more occurrence of it:
> > >
> > > [   78.804940] BUG: scheduling while atomic: kbd/0x20000000/3444
> > > [   78.804944]
> > > [   78.804945] Call Trace:
> >
> > ok, i can think of a simpler scenario:
> > add_preempt_count(PREEMPT_ACTIVE) /twice/, nested into each other.
>
> doh - the BKL! That does a down() in a PREEMPT_ACTIVE section, which can
> trigger cond_resched(). The fix is to check for PREEMPT_ACTIVE in
> cond_resched(). (and only in cond_resched())
>
> Updated fix (against -rc2) attached.
>
>         Ingo
>
> ---------------------->
> Subject: [patch] sched: fix cond_resched_softirq() offset
> From: Ingo Molnar <mingo@elte.hu>
>
> remove the __resched_legal() check: it is conceptually broken.
> The biggest problem it had is that it can mask buggy cond_resched()
> calls. A cond_resched() call is only legal if we are not in an
> atomic context, with two narrow exceptions:
>
>  - if the system is booting
>  - a reacquire_kernel_lock() down() done while PREEMPT_ACTIVE is set
>
> But __resched_legal() hid this and just silently returned whenever
> these primitives were called from invalid contexts. (Same goes for
> cond_resched_locked() and cond_resched_softirq()).
>
> furthermore, the __legal_resched(0) call was buggy in that it caused
> unnecessarily long softirq latencies via cond_resched_softirq(). (which
> is only called from softirq-off sections, hence the code did nothing.)
>
> the fix is to resurrect the efficiency of the might_sleep checks and to
> only allow the narrow exceptions.
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/sched.c |   18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> Index: linux/kernel/sched.c
> ===================================================================
> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -4617,17 +4617,6 @@ asmlinkage long sys_sched_yield(void)
>         return 0;
>  }
>
> -static inline int __resched_legal(int expected_preempt_count)
> -{
> -#ifdef CONFIG_PREEMPT
> -       if (unlikely(preempt_count() != expected_preempt_count))
> -               return 0;
> -#endif
> -       if (unlikely(system_state != SYSTEM_RUNNING))
> -               return 0;
> -       return 1;
> -}
> -
>  static void __cond_resched(void)
>  {
>  #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
> @@ -4647,7 +4636,8 @@ static void __cond_resched(void)
>
>  int __sched cond_resched(void)
>  {
> -       if (need_resched() && __resched_legal(0)) {
> +       if (need_resched() && !(preempt_count() & PREEMPT_ACTIVE) &&
> +                                       system_state == SYSTEM_RUNNING) {
>                 __cond_resched();
>                 return 1;
>         }
> @@ -4673,7 +4663,7 @@ int cond_resched_lock(spinlock_t *lock)
>                 ret = 1;
>                 spin_lock(lock);
>         }
> -       if (need_resched() && __resched_legal(1)) {
> +       if (need_resched() && system_state == SYSTEM_RUNNING) {
>                 spin_release(&lock->dep_map, 1, _THIS_IP_);
>                 _raw_spin_unlock(lock);
>                 preempt_enable_no_resched();
> @@ -4689,7 +4679,7 @@ int __sched cond_resched_softirq(void)
>  {
>         BUG_ON(!in_softirq());
>
> -       if (need_resched() && __resched_legal(0)) {
> +       if (need_resched() && system_state == SYSTEM_RUNNING) {
>                 raw_local_irq_disable();
>                 _local_bh_enable();
>                 raw_local_irq_enable();
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
