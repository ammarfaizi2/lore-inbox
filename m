Return-Path: <linux-kernel-owner+w=401wt.eu-S932939AbWL0H4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbWL0H4j (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 02:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932957AbWL0H4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 02:56:39 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2890 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932939AbWL0H4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 02:56:38 -0500
X-AuthUser: hirofumi@parknet.jp
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sched: remove __resched_legal() and fix cond_resched_softirq()
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com>
	<87psa9z0wu.fsf@duaron.myhome.or.jp> <20061226130739.GB3701@elte.hu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 27 Dec 2006 16:56:28 +0900
In-Reply-To: <20061226130739.GB3701@elte.hu> (Ingo Molnar's message of "Tue\, 26 Dec 2006 14\:07\:39 +0100")
Message-ID: <87ac19epqr.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> "Fabio Comolli" <fabio.comolli@gmail.com> writes:
>> 
>> > Just found this in syslog. It was during normal activity, about 6
>> > minutes after resume-from-ram. I never saw this before.
>> 
>> It seems someone missed to check PREEMPT_ACTIVE in __resched_legal().
>
> but PREEMPT_ACTIVE is 0x10000000, not 0x20000000.
>
>> Could you please test the following patch?
>
> no. cond_resched() is always legal in the !PREEMPT case.
>
> i found another bug and realized that the whole __resched_legal() 
> approach is fundamentally wrong! The patch below fixes this.

Hmm.. but the path seems,

-> cond_resched()
  -> if (__resched_legal())		/* preempt_count == 0 */
    -> __cond_resched()			/* preempt_count == 0x10000000 */
      -> schedule()
        [...]
        -> cond_resched()
          -> if (__resched_legal())	/* preempt_count == 0x10000000 */
            -> __cond_resched()		/* preempt_count == 0x20000000 */
              -> schedule()             /* warning */

Where is it prevented? Or warning is just wrong?

> ------------------->
> Subject: [patch] sched: remove __resched_legal() and fix cond_resched_softirq()
> From: Ingo Molnar <mingo@elte.hu>
>
> remove the __resched_legal() check: it is conceptually broken. The 
> biggest problem it had is that it can mask buggy cond_resched() calls. A 
> cond_resched() call is only legal if we are not in an atomic context. 
> But __resched_legal() hid this fact. Same goes for cond_resched_locked() 
> and cond_resched_softirq().
>
> furthermore, the __legal_resched(0) call was buggy in 
> cond_resched_softirq() and caused unnecessary long softirq latencies!
>
> the fix is to preserve the only valid inhibitor to voluntary preemption: 
> if the system is still booting. None of the other behavior of 
> __resched_legal() made any sense.
>
> the effect of this fix should be more real bugs exposed, and shorter 
> softirq latencies.
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/sched.c |   17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> Index: linux/kernel/sched.c
> ===================================================================
> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -4617,17 +4617,6 @@ asmlinkage long sys_sched_yield(void)
>  	return 0;
>  }
>  
> -static inline int __resched_legal(int expected_preempt_count)
> -{
> -#ifdef CONFIG_PREEMPT
> -	if (unlikely(preempt_count() != expected_preempt_count))
> -		return 0;
> -#endif
> -	if (unlikely(system_state != SYSTEM_RUNNING))
> -		return 0;
> -	return 1;
> -}
> -
>  static void __cond_resched(void)
>  {
>  #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
> @@ -4647,7 +4636,7 @@ static void __cond_resched(void)
>  
>  int __sched cond_resched(void)
>  {
> -	if (need_resched() && __resched_legal(0)) {
> +	if (need_resched() && system_state == SYSTEM_RUNNING) {
>  		__cond_resched();
>  		return 1;
>  	}
> @@ -4673,7 +4662,7 @@ int cond_resched_lock(spinlock_t *lock)
>  		ret = 1;
>  		spin_lock(lock);
>  	}
> -	if (need_resched() && __resched_legal(1)) {
> +	if (need_resched() && system_state == SYSTEM_RUNNING) {
>  		spin_release(&lock->dep_map, 1, _THIS_IP_);
>  		_raw_spin_unlock(lock);
>  		preempt_enable_no_resched();
> @@ -4689,7 +4678,7 @@ int __sched cond_resched_softirq(void)
>  {
>  	BUG_ON(!in_softirq());
>  
> -	if (need_resched() && __resched_legal(0)) {
> +	if (need_resched() && system_state == SYSTEM_RUNNING) {
>  		raw_local_irq_disable();
>  		_local_bh_enable();
>  		raw_local_irq_enable();

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
