Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVC3Kmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVC3Kmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVC3Kmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:42:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:8646 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261857AbVC3Km2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:42:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: smp/swsusp done right
Date: Wed, 30 Mar 2005 12:42:37 +0200
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
References: <20050323204019.GA11616@elf.ucw.cz>
In-Reply-To: <20050323204019.GA11616@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301242.38280.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 23 of March 2005 21:40, Pavel Machek wrote:
> Hi!
> 
> This is against -mm kernel; it is smp swsusp done right, and it
> actually works for me. Unlike previous hacks, it uses cpu hotplug
> infrastructure. Disable CONFIG_MTRR before you try this...
> 
> Test this if you can, and report any problems. If not enough people
> scream, this is going to -mm.
> 								Pavel
> 
> --- clean-mm/drivers/pci/pci.c	2005-03-21 11:39:32.000000000 +0100
> +++ linux-mm/drivers/pci/pci.c	2005-03-22 01:41:48.000000000 +0100
> @@ -376,11 +376,13 @@
>  	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
>  		return PCI_D0;
>  
> +#if 0
>  	if (platform_pci_choose_state) {
>  		ret = platform_pci_choose_state(dev, state);
>  		if (ret >= 0)
>  			state = ret;
>  	}
> +#endif
>  	switch (state) {
>  	case 0: return PCI_D0;
>  	case 3: return PCI_D3hot;

You probably don't want the above change to go in the final patch?


> --- clean-mm/kernel/power/Kconfig	2005-01-22 21:24:53.000000000 +0100
> +++ linux-mm/kernel/power/Kconfig	2005-03-23 11:40:14.000000000 +0100
> @@ -28,7 +28,7 @@
>  
>  config SOFTWARE_SUSPEND
>  	bool "Software Suspend (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL && PM && SWAP
> +	depends on EXPERIMENTAL && PM && SWAP && (HOTPLUG_CPU || !SMP)
>  	---help---
>  	  Enable the possibility of suspending the machine.
>  	  It doesn't need APM.
> --- clean-mm/kernel/power/smp.c	2005-03-19 00:32:32.000000000 +0100
> +++ linux-mm/kernel/power/smp.c	2005-03-23 15:38:30.000000000 +0100
> @@ -7,79 +7,53 @@
>   * This file is released under the GPLv2.
>   */
>  
> -#undef DEBUG
> -
>  #include <linux/smp_lock.h>
>  #include <linux/interrupt.h>
>  #include <linux/suspend.h>
>  #include <linux/module.h>
>  #include <asm/atomic.h>
>  #include <asm/tlbflush.h>
> +#include <asm/cpu.h>
>  
> -static atomic_t cpu_counter, freeze;
> -
> -
> -static void smp_pause(void * data)
> -{
> -	struct saved_context ctxt;
> -	__save_processor_state(&ctxt);
> -	printk("Sleeping in:\n");
> -	dump_stack();
> -	atomic_inc(&cpu_counter);
> -	while (atomic_read(&freeze)) {
> -		/* FIXME: restore takes place at random piece inside this.
> -		   This should probably be written in assembly, and
> -		   preserve general-purpose registers, too
> -
> -		   What about stack? We may need to move to new stack here.
> -
> -		   This should better be ran with interrupts disabled.
> -		 */
> -		cpu_relax();
> -		barrier();
> -	}
> -	atomic_dec(&cpu_counter);
> -	__restore_processor_state(&ctxt);
> -}
> -
> -static cpumask_t oldmask;
> +cpumask_t frozen_cpus;
>  
>  void disable_nonboot_cpus(void)
>  {
> -	printk("Freezing CPUs (at %d)", smp_processor_id());
> -	oldmask = current->cpus_allowed;
> -	set_cpus_allowed(current, cpumask_of_cpu(0));
> -	current->state = TASK_INTERRUPTIBLE;
> -	schedule_timeout(HZ);
> -	printk("...");
> -	BUG_ON(smp_processor_id() != 0);
> -
> -	/* FIXME: for this to work, all the CPUs must be running
> -	 * "idle" thread (or we deadlock). Is that guaranteed? */
> +	int cpu, error;
>  
> -	atomic_set(&cpu_counter, 0);
> -	atomic_set(&freeze, 1);
> -	smp_call_function(smp_pause, NULL, 0, 0);
> -	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
> -		cpu_relax();
> -		barrier();
> +	error = 0;
> +	cpus_clear(frozen_cpus);
> +	printk("Freezing cpus ...\n");
> +	for_each_online_cpu(cpu) {
> +		if (cpu == 0)
> +			continue;
> +		error = cpu_down(cpu);
> +		if (!error) {
> +			cpu_set(cpu, frozen_cpus);
> +			printk("CPU%d is down\n", cpu);
> +			continue;
> +		}
> +		printk("Error taking cpu %d down: %d\n", cpu, error);
>  	}
> -	printk("ok\n");
> +	BUG_ON(smp_processor_id() != 0);
> +	if (error)
> +		panic("cpus not sleeping");
>  }

I'm not sure whether we should panic() here.  It may be better to make
suspend fail and print a "please reboot immediately" message for the user.
In that case, the user may be able to reboot without loosing data ...


>  void enable_nonboot_cpus(void)
>  {
> -	printk("Restarting CPUs");
> -	atomic_set(&freeze, 0);
> -	while (atomic_read(&cpu_counter)) {
> -		cpu_relax();
> -		barrier();
> -	}
> -	printk("...");
> -	set_cpus_allowed(current, oldmask);
> -	schedule();
> -	printk("ok\n");
> +	int cpu, error;
>  
> +	printk("Thawing cpus ...\n");
> +	for_each_cpu_mask(cpu, frozen_cpus) {
> +		if (cpu == 0)
> +			continue;
> +		error = cpu_up(cpu);
> +		if (!error) {
> +			printk("CPU%d is up\n", cpu);
> +			continue;
> +		}
> +		printk("Error taking cpu %d up: %d\n", cpu, error);
> +		panic("Not enough cpus");
> +	}
>  }
> -
> -
> --- clean-mm/kernel/power/swsusp.c	2005-03-21 11:39:33.000000000 +0100
> +++ linux-mm/kernel/power/swsusp.c	2005-03-23 15:34:53.000000000 +0100
> @@ -1194,8 +1194,11 @@
>  		return "version";
>  	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
>  		return "machine";
> +#if 0
> +	/* We can't use number of CPUs when we use hotplug to remove them ;-))) */
>  	if(swsusp_info.cpus != num_online_cpus())
>  		return "number of cpus";
> +#endif
>  	return NULL;
>  }
>  
> 
> -- 

I'll test it when I get the CPU hotplug on x86-64 done.

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
