Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVCOWgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVCOWgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVCOWf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:35:58 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:21654 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261936AbVCOWdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:33:13 -0500
Date: Tue, 15 Mar 2005 17:33:39 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] APM: fix interrupts enabled in device_power_up
Message-ID: <20050315223339.GF11916@fieldses.org>
References: <20050312131143.GA31038@fieldses.org> <Pine.LNX.4.61.0503120806001.17127@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503120806001.17127@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 08:21:29AM -0700, Zwane Mwaikambo wrote:
> On Sat, 12 Mar 2005, J. Bruce Fields wrote:
> 
> > On APM resume this morning on my Thinkpad X31, I got a "spin_lock is
> > already locked" error; see below.  This doesn't happen on every resume,
> > though it's happened before.  The kernel is 2.6.11 plus a bunch of
> > (hopefully unrelated...) NFS patches.
> >
> > Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
> > Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:179: spin_lock(arch/i386/kernel/time.c:c0603c28) already locked by arch/i386/kernel/time.c/309
> > Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:316: spin_unlock(arch/i386/kernel/time.c:c0603c28) not locked
> 
> APM was calling device_power_down and device_power_up with interrupts 
> enabled, resulting in a few calls to get_cmos_time being done with 
> interrupts enabled (rtc_lock needs to be acquired with interrupts 
> disabled).

Thanks, I haven't been following the discussion carefully, but for
what's it worth I did apply that patch and now (a few suspend-resume
cycles later) haven't seen the spin_lock warning or seen any other ill
effects.

Let me know if there's any testing it would be useful for me to do.

--Bruce Fields

> Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> 
> ===== arch/i386/kernel/apm.c 1.72 vs edited =====
> --- 1.72/arch/i386/kernel/apm.c	2005-01-20 22:02:11 -07:00
> +++ edited/arch/i386/kernel/apm.c	2005-03-12 08:17:52 -07:00
> @@ -1202,10 +1202,11 @@
>  	}
>  
>  	device_suspend(PMSG_SUSPEND);
> +	local_irq_disable();
>  	device_power_down(PMSG_SUSPEND);
>  
>  	/* serialize with the timer interrupt */
> -	write_seqlock_irq(&xtime_lock);
> +	write_seqlock(&xtime_lock);
>  
>  	/* protect against access to timer chip registers */
>  	spin_lock(&i8253_lock);
> @@ -1216,20 +1217,22 @@
>  	 * We'll undo any timer changes due to interrupts below.
>  	 */
>  	spin_unlock(&i8253_lock);
> -	write_sequnlock_irq(&xtime_lock);
> +	write_sequnlock(&xtime_lock);
> +	local_irq_enable();
>  
>  	save_processor_state();
>  	err = set_system_power_state(APM_STATE_SUSPEND);
>  	restore_processor_state();
>  
> -	write_seqlock_irq(&xtime_lock);
> +	local_irq_disable();
> +	write_seqlock(&xtime_lock);
>  	spin_lock(&i8253_lock);
>  	reinit_timer();
>  	set_time();
>  	ignore_normal_resume = 1;
>  
>  	spin_unlock(&i8253_lock);
> -	write_sequnlock_irq(&xtime_lock);
> +	write_sequnlock(&xtime_lock);
>  
>  	if (err == APM_NO_ERROR)
>  		err = APM_SUCCESS;
> @@ -1237,6 +1240,7 @@
>  		apm_error("suspend", err);
>  	err = (err == APM_SUCCESS) ? 0 : -EIO;
>  	device_power_up();
> +	local_irq_enable();
>  	device_resume();
>  	pm_send_all(PM_RESUME, (void *)0);
>  	queue_event(APM_NORMAL_RESUME, NULL);
> @@ -1255,17 +1259,22 @@
>  {
>  	int	err;
>  
> +	local_irq_disable();
>  	device_power_down(PMSG_SUSPEND);
>  	/* serialize with the timer interrupt */
> -	write_seqlock_irq(&xtime_lock);
> +	write_seqlock(&xtime_lock);
>  	/* If needed, notify drivers here */
>  	get_time_diff();
> -	write_sequnlock_irq(&xtime_lock);
> +	write_sequnlock(&xtime_lock);
> +	local_irq_enable();
>  
>  	err = set_system_power_state(APM_STATE_STANDBY);
>  	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
>  		apm_error("standby", err);
> +
> +	local_irq_disable();	
>  	device_power_up();
> +	local_irq_enable();
>  }
>  
>  static apm_event_t get_event(void)
