Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbUKDWf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUKDWf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbUKDWfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:35:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:18156 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262448AbUKDWNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:13:34 -0500
Date: Fri, 5 Nov 2004 03:46:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, edwardsg@sgi.com, levon@movementarian.org
Subject: Re: contention on profile_lock
Message-ID: <20041104221655.GA4099@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200411021152.16038.jbarnes@engr.sgi.com> <20041104201257.GA14786@holomorphy.com> <200411041249.21718.jbarnes@engr.sgi.com> <200411041355.27228.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041355.27228.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 01:55:27PM -0800, Jesse Barnes wrote:
> On Thursday, November 4, 2004 12:49 pm, Jesse Barnes wrote:
> > John pointed out that this breaks modules.  Would registering and
>  
>  static void timer_stop(void)
>  {
> -	unregister_profile_notifier(&timer_notifier);
> +	/* Tear down the callback pointer after sync_kernel */
> +	synchronize_kernel();
> +	oprofile_timer_notify = NULL;
>  }
>  
>  
> +/* Oprofile timer tick hook */
> +int (*oprofile_timer_notify)(struct pt_regs *);
> +
>  static atomic_t *prof_buffer;
>  static unsigned long prof_len, prof_shift;
>  static int prof_on;
> @@ -168,38 +172,6 @@
>  	return err;
>  }
>  


> -void profile_hook(struct pt_regs * regs)
> -{
> -	read_lock(&profile_lock);
> -	notifier_call_chain(&profile_listeners, 0, regs);
> -	read_unlock(&profile_lock);
> -}
> -
> -EXPORT_SYMBOL_GPL(register_profile_notifier);
> -EXPORT_SYMBOL_GPL(unregister_profile_notifier);
>  EXPORT_SYMBOL_GPL(task_handoff_register);
>  EXPORT_SYMBOL_GPL(task_handoff_unregister);
>  
> @@ -394,8 +366,8 @@
>  
>  void profile_tick(int type, struct pt_regs *regs)
>  {
> -	if (type == CPU_PROFILING)
> -		profile_hook(regs);
> +	if (type == CPU_PROFILING && oprofile_timer_notify)
> +		oprofile_timer_notify(regs);
>  	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
>  		profile_hit(type, (void *)profile_pc(regs));
>  }


Or you could just do -

void profile_tick(int type, struct pt_regs *regs)
{
	int (*timer_notify)(struct pt_regs *);

	timer_notify = oprofile_timer_notify;
	smp_read_barrier_depends();
	if (type == CPU_PROFILING && timer_notify) {
		timer_notify(regs);
	}
	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
		profile_hit(type, (void *)profile_pc(regs));
}

And avoid the synchronize_kernel(). But I think the synchronize_kernel()
thing is cleaner.

I am looking at the notifier chain mechanism itself and its
lack of proper locking. That is a different story.

Thanks
Dipankar
