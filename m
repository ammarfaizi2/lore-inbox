Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVFFWQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVFFWQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVFFWOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:14:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:22677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261728AbVFFWLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:11:25 -0400
Date: Mon, 6 Jun 2005 15:11:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk, vatsa@in.ibm.com,
       discuss@x86-64.org, rusty@rustycorp.com.au, ashok.raj@intel.com
Subject: Re: [patch 2/5] try2: x86_64: CPU hotplug support.
Message-Id: <20050606151156.7b26167f.akpm@osdl.org>
In-Reply-To: <20050606192113.044405000@araj-em64t>
References: <20050606191433.104273000@araj-em64t>
	<20050606192113.044405000@araj-em64t>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> Experimental CPU hotplug patch for x86_64

What does "experimental" mean?

>  static int __cpuinit do_boot_cpu(int cpu, int apicid)
>  {
> -	struct task_struct *idle;
>  	unsigned long boot_error;
>  	int timeout;
>  	unsigned long start_rip;
> -	/*
> -	 * We can't use kernel_thread since we must avoid to
> -	 * reschedule the child.
> -	 */
> -	idle = fork_idle(cpu);
> -	if (IS_ERR(idle)) {
> +	struct create_idle c_idle = {
> +		.cpu = cpu,
> +		.done = COMPLETION_INITIALIZER(c_idle.done),
> +	};
> +	DECLARE_WORK(work, do_fork_idle, &c_idle);
> +
> +	c_idle.idle = get_idle_for_cpu(cpu);
> +
> +	if (c_idle.idle) {
> +		c_idle.idle->thread.rsp = (unsigned long) (((struct pt_regs *)
> +			(THREAD_SIZE + (unsigned long) c_idle.idle->thread_info)) - 1);
> +		init_idle(c_idle.idle, cpu);
> +		goto do_rest;
> +	}
> +
> +	if (!keventd_up() || current_is_keventd())
> +		work.func(work.data);
> +	else {
> +		schedule_work(&work);
> +		wait_for_completion(&c_idle.done);
> +	}

This shouldn't be diddling with workqueue internals.  Why is this code
here?  If the workqueue API is inadequate then we should prefer to extend
it rather than working around any shortcoming.

> +		Dprintk ("do_boot_cpu %d Already started\n", cpu);

Please try to adopt a consistent coding style.

Using printk("%s", __FUNCTION__); is preferred, as it will still work if
someone later refactors this code into a new function.  (It can increase
code size.  Or decrease it if the string gets shared.  But that's moot if
the code is inside a normally-disabled macro like Dprintk.  Whatever that
is.)

> +static void
> +remove_siblinginfo(int cpu)

Unneeded newline here.

> +/* We don't actually take CPU down, just spin without interrupts. */
> +static inline void play_dead(void)
> +{
> +	idle_task_exit();
> +	mb();
> +	/* Ack it */
> +	__get_cpu_var(cpu_state) = CPU_DEAD;
> +
> +	while (1)
> +		safe_halt();
> +}

The memory barrier needs a comment, please.  It is otherwise not possible
to determine why it is there.

>  asmlinkage void default_do_nmi(struct pt_regs *regs)
>  {
>  	unsigned char reason = 0;
> +	int cpu;
> +
> +	cpu = smp_processor_id();
>  
>  	/* Only the BSP gets external NMIs from the system.  */
> -	if (!smp_processor_id())
> +	if (!cpu)
>  		reason = get_nmi_reason();
>  
> +	if (!cpu_online(cpu))
> +		return;
> +

Why would an offlined CPU receive an NMI?  (A comment would be handy)


