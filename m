Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUKWWde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUKWWde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUKWWcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:32:25 -0500
Received: from gprs214-143.eurotel.cz ([160.218.214.143]:8074 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261561AbUKWW3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:29:23 -0500
Date: Tue, 23 Nov 2004 23:29:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATH] swsusp update 3/3
Message-ID: <20041123222908.GK25926@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165858.GC10609@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122165858.GC10609@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Can you start pushing this through maintainers?

LINUX FOR POWERPC
P:      Paul Mackerras
M:      paulus@samba.org
W:      http://www.penguinppc.org/
L:      linuxppc-dev@lists.linuxppc.org
S:      Supported

LINUX FOR POWER MACINTOSH
P:      Benjamin Herrenschmidt
M:      benh@kernel.crashing.org
W:      http://www.penguinppc.org/
L:      linuxppc-dev@lists.linuxppc.org
S:      Maintained

> --- linux-2.6.9-ppc-g4-peval/arch/ppc/Kconfig	2004-10-20 15:58:39.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/arch/ppc/Kconfig	2004-11-22 17:16:58.000000000 +0800
> @@ -983,6 +983,8 @@
>  
>  source "drivers/zorro/Kconfig"
>  
> +source kernel/power/Kconfig
> +
>  endmenu
>  
>  menu "Bus options"
> --- linux-2.6.9-ppc-g4-peval/arch/ppc/kernel/Makefile	2004-10-20 15:58:40.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/arch/ppc/kernel/Makefile	2004-11-22 17:16:58.000000000 +0800
> @@ -16,6 +16,7 @@
>  					semaphore.o syscalls.o setup.o \
>  					cputable.o ppc_htab.o
>  obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
> +obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
>  obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
>  obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
>  obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o

Ok. Or perhaps you want Kconfig part to go in last...

> --- /dev/null	2004-06-07 18:45:47.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/arch/ppc/kernel/swsusp.S	1904-01-01 08:47:25.000000000 +0706
...
> +	mfibatu	r4,3
> +	stw	r4,SL_IBAT3(r11)
> +	mfibatl	r4,3
> +	stw	r4,SL_IBAT3+4(r11)
> +
> +#if  0
> +	/* Backup various CPU config stuffs */
> +	bl	__save_cpu_setup
> +#endif
> +	/* Call the low level suspend stuff (we should probably have made
> +	 * a stackframe...
> +	 */
> +	bl	swsusp_save

I can't really check ppc assembly, but you probably want to kill that
#if 0s.

> --- linux-2.6.9-ppc-g4-peval/arch/ppc/kernel/signal.c	2004-10-20 15:58:41.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/arch/ppc/kernel/signal.c	2004-11-22 17:16:58.000000000 +0800
> @@ -28,6 +28,7 @@
>  #include <linux/elf.h>
>  #include <linux/tty.h>
>  #include <linux/binfmts.h>
> +#include <linux/suspend.h>
>  #include <asm/ucontext.h>
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -604,6 +605,14 @@
>  	unsigned long frame, newsp;
>  	int signr, ret;
>  
> +	if (current->flags & PF_FREEZE) {
> +		refrigerator(PF_FREEZE);
> +		signr = 0;
> +		ret = regs->gpr[3];
> +		if (!signal_pending(current))
> +			goto no_signal;
> +	}
> +
>  	if (!oldset)
>  		oldset = &current->blocked;
>  
> @@ -626,6 +635,7 @@
>  			regs->gpr[3] = EINTR;
>  			/* note that the cr0.SO bit is already set */
>  		} else {
> +no_signal:
>  			regs->nip -= 4;	/* Back up & retry system call */
>  			regs->result = 0;
>  			regs->trap = 0;

Ok.

> --- linux-2.6.9-ppc-g4-peval/arch/ppc/kernel/vmlinux.lds.S	2004-10-20 15:58:41.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/arch/ppc/kernel/vmlinux.lds.S	2004-11-22 17:16:58.000000000 +0800
> @@ -74,6 +74,12 @@
>      CONSTRUCTORS
>    }
>  
> +  . = ALIGN(4096);
> +  __nosave_begin = .;
> +  .data_nosave : { *(.data.nosave) }
> +  . = ALIGN(4096);
> +  __nosave_end = .;
> +
>    . = ALIGN(32);
>    .data.cacheline_aligned : { *(.data.cacheline_aligned) }
>  

Ok.

> --- linux-2.6.9-ppc-g4-peval/arch/ppc/syslib/open_pic.c	2004-10-20 15:58:42.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/arch/ppc/syslib/open_pic.c	2004-11-22 17:16:58.000000000 +0800
> @@ -776,7 +776,8 @@
>  	if (ISR[irq] == 0)
>  		return;
>  	if (!cpus_empty(keepmask)) {
> -		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
> +		cpumask_t irqdest;
> +		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
>  		cpus_and(irqdest, irqdest, keepmask);
>  		cpus_or(physmask, physmask, irqdest);
>  	}

Why this?

> --- linux-2.6.9-ppc-g4-peval/drivers/ide/ppc/pmac.c	2004-10-20 15:59:12.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/ide/ppc/pmac.c	2004-11-22 17:16:58.000000000 +0800
> @@ -32,6 +32,7 @@
>  #include <linux/notifier.h>
>  #include <linux/reboot.h>
>  #include <linux/pci.h>
> +#include <linux/pm.h>
>  #include <linux/adb.h>
>  #include <linux/pmu.h>
>  
> @@ -1364,7 +1365,7 @@
>  	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
>  	int		rc = 0;
>  
> -	if (state != mdev->ofdev.dev.power_state && state >= 2) {
> +	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
>  		rc = pmac_ide_do_suspend(hwif);
>  		if (rc == 0)
>  			mdev->ofdev.dev.power_state = state;
> @@ -1472,7 +1473,7 @@
>  	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
>  	int		rc = 0;
>  	
> -	if (state != pdev->dev.power_state && state >= 2) {
> +	if (state != pdev->dev.power_state && state == PM_SUSPEND_MEM ) {
>  		rc = pmac_ide_do_suspend(hwif);
>  		if (rc == 0)
>  			pdev->dev.power_state = state;

Don't do this just yet. Big changes in this area are pending. 

> --- linux-2.6.9-ppc-g4-peval/drivers/macintosh/mediabay.c	2004-10-20 15:53:32.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/macintosh/mediabay.c	2004-11-22 17:16:58.000000000 +0800
> @@ -713,7 +713,7 @@
>  {
>  	struct media_bay_info	*bay = macio_get_drvdata(mdev);
>  
> -	if (state != mdev->ofdev.dev.power_state && state >= 2) {
> +	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
>  		down(&bay->lock);
>  		bay->sleeping = 1;
>  		set_mb_power(bay, 0);

Wait with this one, too.

> --- linux-2.6.9-ppc-g4-peval/drivers/macintosh/therm_adt746x.c	2004-10-20 15:59:24.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/macintosh/therm_adt746x.c	2004-11-22 17:16:58.000000000 +0800
> @@ -22,6 +22,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/smp_lock.h>
>  #include <linux/wait.h>
> +#include <linux/suspend.h>
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
>  #include <asm/io.h>
> @@ -238,6 +239,11 @@
>  #endif
>  	while(!kthread_should_stop())
>  	{
> + 		if (current->flags & PF_FREEZE) {
> + 			printk(KERN_INFO "therm_adt746x: freezing thermostat\n");
> + 			refrigerator(PF_FREEZE);
> + 		}
> + 
>  		msleep_interruptible(2000);
>  
>  		/* Check status */

You probably want to avoid that printk. (And similar for
therm_pm72). Otherwise good.

> --- linux-2.6.9-ppc-g4-peval/drivers/macintosh/via-pmu.c	2004-10-20 15:59:24.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/macintosh/via-pmu.c	2004-11-22 17:16:58.000000000 +0800
> @@ -43,6 +43,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
> +#include <linux/sysdev.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
>  #include <asm/prom.h>
> @@ -2326,7 +2327,7 @@
>  	/* Sync the disks. */
>  	/* XXX It would be nice to have some way to ensure that
>  	 * nobody is dirtying any new buffers while we wait. That
> -	 * could be acheived using the refrigerator for processes
> +	 * could be achieved using the refrigerator for processes
>  	 * that swsusp uses
>  	 */
>  	sys_sync();
> @@ -2379,7 +2380,6 @@
>  
>  	/* Wait for completion of async backlight requests */
>  	while (!bright_req_1.complete || !bright_req_2.complete ||
> -
>  			!batt_req.complete)
>  		pmu_poll();
>  

Ok.

> --- linux-2.6.9-ppc-g4-peval/drivers/video/aty/radeon_pm.c	2004-10-20 15:55:34.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/video/aty/radeon_pm.c	2004-11-22 17:16:58.000000000 +0800
> @@ -859,6 +859,10 @@
>  	 * know we'll be rebooted, ...
>  	 */
>  
> +#if 0	/* this breaks suspend to ram until the dust settles... */
> +	if (state != PM_SUSPEND_MEM)
> +#endif
> +		return 0;
>  	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
>  	
>  	acquire_console_sem();

Wait with this one. (And notice that this is not ppc-specific and
could do some damage...)
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
