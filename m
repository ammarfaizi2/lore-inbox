Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbUK1RTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUK1RTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUK1RTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:19:08 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:63873 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261538AbUK1RJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:09:45 -0500
Date: Sun, 28 Nov 2004 18:08:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [4/6]
Message-ID: <20041128170859.GC1214@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com> <20041128162512.GD28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162512.GD28881@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- 2.6.9-lzf/drivers/ide/ppc/pmac.c	2004-11-26 12:33:06.000000000 +0800
> +++ 2.6.9/drivers/ide/ppc/pmac.c	2004-11-28 23:17:00.000000000 +0800
> @@ -32,6 +32,7 @@
>  #include <linux/notifier.h>
>  #include <linux/reboot.h>
>  #include <linux/pci.h>
> +#include <linux/pm.h>
>  #include <linux/adb.h>
>  #include <linux/pmu.h>
>  
> @@ -1364,7 +1365,7 @@ pmac_ide_macio_suspend(struct macio_dev 
>  	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
>  	int		rc = 0;
>  
> -	if (state != mdev->ofdev.dev.power_state && state >= 2) {
> +	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
>  		rc = pmac_ide_do_suspend(hwif);
>  		if (rc == 0)
>  			mdev->ofdev.dev.power_state = state;
> @@ -1472,7 +1473,7 @@ pmac_ide_pci_suspend(struct pci_dev *pde
>  	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
>  	int		rc = 0;
>  	
> -	if (state != pdev->dev.power_state && state >= 2) {
> +	if (state != pdev->dev.power_state && state == PM_SUSPEND_MEM ) {
>  		rc = pmac_ide_do_suspend(hwif);
>  		if (rc == 0)
>  			pdev->dev.power_state = state;

Please wait with this one.

> --- 2.6.9-lzf/drivers/macintosh/Kconfig	2004-11-26 12:33:06.000000000 +0800
> +++ 2.6.9/drivers/macintosh/Kconfig	2004-11-28 23:17:00.000000000 +0800
> @@ -80,7 +80,7 @@ config ADB_PMU
>  
>  config PMAC_PBOOK
>  	bool "Power management support for PowerBooks"
> -	depends on ADB_PMU
> +	depends on PM && ADB_PMU
>  	---help---
>  	  This provides support for putting a PowerBook to sleep; it also
>  	  enables media bay support.  Power management works on the
> @@ -97,11 +97,6 @@ config PMAC_PBOOK
>  	  have it autoloaded. The act of removing the module shuts down the
>  	  sound hardware for more power savings.
>  
> -config PM
> -	bool
> -	depends on PPC_PMAC && ADB_PMU && PMAC_PBOOK
> -	default y
> -
>  config PMAC_APM_EMU
>  	tristate "APM emulation"
>  	depends on PMAC_PBOOK

Ok, merge with BenH.

> --- 2.6.9-lzf/drivers/macintosh/via-pmu.c	2004-11-26 12:33:07.000000000 +0800
> +++ 2.6.9/drivers/macintosh/via-pmu.c	2004-11-28 23:17:00.000000000 +0800
> @@ -43,6 +43,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
> +#include <linux/sysdev.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
>  #include <asm/prom.h>
> @@ -2326,7 +2327,7 @@ pmac_suspend_devices(void)
>  	/* Sync the disks. */
>  	/* XXX It would be nice to have some way to ensure that
>  	 * nobody is dirtying any new buffers while we wait. That
> -	 * could be acheived using the refrigerator for processes
> +	 * could be achieved using the refrigerator for processes
>  	 * that swsusp uses
>  	 */
>  	sys_sync();
> @@ -2379,7 +2380,6 @@ pmac_suspend_devices(void)
>  
>  	/* Wait for completion of async backlight requests */
>  	while (!bright_req_1.complete || !bright_req_2.complete ||
> -
>  			!batt_req.complete)
>  		pmu_poll();
>  
> @@ -3048,6 +3048,88 @@ pmu_polled_request(struct adb_request *r
>  }
>  #endif /* DEBUG_SLEEP */
>  
> +
> +/* FIXME: This is a temporary set of callbacks to enable us
> + * to do suspend-to-disk.
> + */
> +
> +#ifdef CONFIG_PM
> +
> +static int pmu_sys_suspended = 0;
> +
> +static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
> +{
> +	if (state != PMSG_FREEZE || pmu_sys_suspended)
> +		return 0;
> +
> +	/* Suspend PMU event interrupts */
> +	pmu_suspend();
> +
> +	pmu_sys_suspended = 1;
> +	return 0;
> +}
> +
> +static int pmu_sys_resume(struct sys_device *sysdev)
> +{
> +	struct adb_request req;
> +
> +	if (!pmu_sys_suspended)
> +		return 0;
> +
> +	/* Tell PMU we are ready */
> +	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
> +	pmu_wait_complete(&req);
> +
> +	/* Resume PMU event interrupts */
> +	pmu_resume();
> +
> +	pmu_sys_suspended = 0;
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_PM */
> +
> +static struct sysdev_class pmu_sysclass = {
> +	set_kset_name("pmu"),
> +};
> +
> +static struct sys_device device_pmu = {
> +	.id		= 0,
> +	.cls		= &pmu_sysclass,
> +};
> +
> +static struct sysdev_driver driver_pmu = {
> +#ifdef CONFIG_PM
> +	.suspend	= &pmu_sys_suspend,
> +	.resume		= &pmu_sys_resume,
> +#endif /* CONFIG_PM */
> +};
> +
> +static int __init init_pmu_sysfs(void)
> +{
> +	int rc;
> +
> +	rc = sysdev_class_register(&pmu_sysclass);
> +	if (rc) {
> +		printk(KERN_ERR "Failed registering PMU sys class\n");
> +		return -ENODEV;
> +	}
> +	rc = sysdev_register(&device_pmu);
> +	if (rc) {
> +		printk(KERN_ERR "Failed registering PMU sys device\n");
> +		return -ENODEV;
> +	}
> +	rc = sysdev_driver_register(&pmu_sysclass, &driver_pmu);
> +	if (rc) {
> +		printk(KERN_ERR "Failed registering PMU sys driver\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}

The error handling is not okay: 

> --- /dev/null	2004-06-07 18:45:47.000000000 +0800
> +++ 2.6.9/include/asm-ppc/suspend.h	2004-11-28 23:16:57.000000000 +0800
> @@ -0,0 +1,12 @@
> +static inline int arch_prepare_suspend(void)
> +{
> +	return 0;
> +}
> +
> +static inline void save_processor_state(void)
> +{
> +}
> +
> +static inline void restore_processor_state(void)
> +{
> +}
> --- 2.6.9-lzf/arch/ppc/Kconfig	2004-11-26 12:32:56.000000000 +0800
> +++ 2.6.9/arch/ppc/Kconfig	2004-11-28 23:16:58.000000000 +0800
> @@ -983,6 +983,8 @@ config PROC_HARDWARE
>  
>  source "drivers/zorro/Kconfig"
>  
> +source kernel/power/Kconfig
> +
>  endmenu
>  
>  menu "Bus options"
> --- 2.6.9-lzf/arch/ppc/kernel/Makefile	2004-11-26 12:32:56.000000000 +0800
> +++ 2.6.9/arch/ppc/kernel/Makefile	2004-11-28 23:16:58.000000000 +0800
> @@ -16,6 +16,7 @@ obj-y				:= entry.o traps.o irq.o idle.o
>  					semaphore.o syscalls.o setup.o \
>  					cputable.o ppc_htab.o
>  obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
> +obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
>  obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
>  obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
>  obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
> --- 2.6.9-lzf/arch/ppc/kernel/signal.c	2004-11-26 12:32:57.000000000 +0800
> +++ 2.6.9/arch/ppc/kernel/signal.c	2004-11-28 23:16:58.000000000 +0800
> @@ -28,6 +28,7 @@
>  #include <linux/elf.h>
>  #include <linux/tty.h>
>  #include <linux/binfmts.h>
> +#include <linux/suspend.h>
>  #include <asm/ucontext.h>
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -604,6 +605,15 @@ int do_signal(sigset_t *oldset, struct p
>  	unsigned long frame, newsp;
>  	int signr, ret;
>  
> +	if (current->flags & PF_FREEZE) {
> +		refrigerator(0);
> +		signr = 0;
> +		ret = regs->gpr[3];
> +		recalc_sigpending();
> +		if (!signal_pending(current))
> +			goto no_signal;
> +	}
> +
>  	if (!oldset)
>  		oldset = &current->blocked;
>  
> @@ -626,6 +636,7 @@ int do_signal(sigset_t *oldset, struct p
>  			regs->gpr[3] = EINTR;
>  			/* note that the cr0.SO bit is already set */
>  		} else {
> +no_signal:
>  			regs->nip -= 4;	/* Back up & retry system call */
>  			regs->result = 0;
>  			regs->trap = 0;

Ok, merge with BenH.

> --- /dev/null	2004-06-07 18:45:47.000000000 +0800
> +++ 2.6.9/arch/ppc/kernel/swsusp.S	2004-11-28 23:16:57.000000000 +0800
> @@ -0,0 +1,366 @@
> +#include <linux/config.h>
> +#include <linux/threads.h>
> +#include <asm/processor.h>
> +#include <asm/page.h>
> +#include <asm/cputable.h>
> +#include <asm/thread_info.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/offsets.h>
> +
> +
> +/*
> + * Structure for storing CPU registers on the save area.
> + */
> +#define SL_SP		0
> +#define SL_PC		4
> +#define SL_MSR		8
> +#define SL_SDR1		0xc
> +#define SL_SPRG0	0x10	/* 4 sprg's */
> +#define SL_DBAT0	0x20
> +#define SL_IBAT0	0x28
> +#define SL_DBAT1	0x30
> +#define SL_IBAT1	0x38
> +#define SL_DBAT2	0x40
> +#define SL_IBAT2	0x48
> +#define SL_DBAT3	0x50
> +#define SL_IBAT3	0x58
> +#define SL_TB		0x60
> +#define SL_R2		0x68
> +#define SL_CR		0x6c
> +#define SL_LR		0x70
> +#define SL_R12		0x74	/* r12 to r31 */
> +#define SL_SIZE		(SL_R12 + 80)
> +
> +	.section .data
> +	.align	5
> +
> +_GLOBAL(swsusp_save_area)
> +	.space	SL_SIZE
> +
> +
> +	.section .text
> +	.align	5
> +
> +_GLOBAL(swsusp_arch_suspend)
> +
> +	lis	r11,swsusp_save_area@h
> +	ori	r11,r11,swsusp_save_area@l
> +
> +	mflr	r0
> +	stw	r0,SL_LR(r11)
> +	mfcr	r0
> +	stw	r0,SL_CR(r11)
> +	stw	r1,SL_SP(r11)
> +	stw	r2,SL_R2(r11)
> +	stmw	r12,SL_R12(r11)
> +
> +	/* Save MSR & SDR1 */
> +	mfmsr	r4
> +	stw	r4,SL_MSR(r11)
> +	mfsdr1	r4
> +	stw	r4,SL_SDR1(r11)
> +
> +	/* Get a stable timebase and save it */
> +1:	mftbu	r4
> +	stw	r4,SL_TB(r11)
> +	mftb	r5
> +	stw	r5,SL_TB+4(r11)
> +	mftbu	r3
> +	cmpw	r3,r4
> +	bne	1b
> +
> +	/* Save SPRGs */
> +	mfsprg	r4,0
> +	stw	r4,SL_SPRG0(r11)
> +	mfsprg	r4,1
> +	stw	r4,SL_SPRG0+4(r11)
> +	mfsprg	r4,2
> +	stw	r4,SL_SPRG0+8(r11)
> +	mfsprg	r4,3
> +	stw	r4,SL_SPRG0+12(r11)
> +
> +	/* Save BATs */
> +	mfdbatu	r4,0
> +	stw	r4,SL_DBAT0(r11)
> +	mfdbatl	r4,0
> +	stw	r4,SL_DBAT0+4(r11)
> +	mfdbatu	r4,1
> +	stw	r4,SL_DBAT1(r11)
> +	mfdbatl	r4,1
> +	stw	r4,SL_DBAT1+4(r11)
> +	mfdbatu	r4,2
> +	stw	r4,SL_DBAT2(r11)
> +	mfdbatl	r4,2
> +	stw	r4,SL_DBAT2+4(r11)
> +	mfdbatu	r4,3
> +	stw	r4,SL_DBAT3(r11)
> +	mfdbatl	r4,3
> +	stw	r4,SL_DBAT3+4(r11)
> +	mfibatu	r4,0
> +	stw	r4,SL_IBAT0(r11)
> +	mfibatl	r4,0
> +	stw	r4,SL_IBAT0+4(r11)
> +	mfibatu	r4,1
> +	stw	r4,SL_IBAT1(r11)
> +	mfibatl	r4,1
> +	stw	r4,SL_IBAT1+4(r11)
> +	mfibatu	r4,2
> +	stw	r4,SL_IBAT2(r11)
> +	mfibatl	r4,2
> +	stw	r4,SL_IBAT2+4(r11)
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
> +
> +	/* Restore LR from the save area */
> +	lis	r11,swsusp_save_area@h
> +	ori	r11,r11,swsusp_save_area@l
> +	lwz	r0,SL_LR(r11)
> +	mtlr	r0
> +
> +	blr
> +
> +
> +/* Resume code */
> +_GLOBAL(swsusp_arch_resume)
> +
> +	/* Stop pending alitvec streams and memory accesses */
> +BEGIN_FTR_SECTION
> +	DSSALL
> +END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> + 	sync
> +
> +	/* Disable MSR:DR to make sure we don't take a TLB or
> +	 * hash miss during the copy, as our hash table will
> +	 * for a while be unuseable. For .text, we assume we are
> +	 * covered by a BAT. This works only for non-G5 at this
> +	 * point. G5 will need a better approach, possibly using
> +	 * a small temporary hash table filled with large mappings,
> +	 * disabling the MMU completely isn't a good option for
> +	 * performance reasons.
> +	 * (Note that 750's may have the same performance issue as
> +	 * the G5 in this case, we should investigate using moving
> +	 * BATs for these CPUs)
> +	 */
> +	mfmsr	r0
> +	sync
> +	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */
> +	mtmsr	r0
> +	sync
> +	isync
> +
> +	/* Load ptr the list of pages to copy in r11 */
> +	lis	    r9,pagedir_nosave@ha
> +	addi    r9,r9,pagedir_nosave@l
> +	tophys(r9,r9)
> +	lwz     r9, 0(r9)
> +#if 0
> +	twi     31,r0,0 /* triger trap */
> +#endif
> +	cmpwi   r9, 0
> +	beq copy_loop_end
> +copy_loop:
> +	tophys(r9,r9)
> +	lwz    r6, 12(r9)
> +	li     r10, 0
> +copy_one_pgdir:
> +	lwz    r11, 4(r9)
> +	addi   r8,r10,1
> +	cmpwi  r11, 0
> +	addi   r7,r9,16
> +	beq copy_loop_end
> +	li     r0, 256
> +	mtctr  r0
> +	lwz    r9,0(r9)
> +#if 0
> +	twi    31,r0,0 /* triger trap */
> +#endif
> +	tophys(r10,r11)
> +	tophys(r11,r9)
> +copy_one_page:
> +	lwz    r0, 0(r11)
> +	stw    r0, 0(r10)
> +	lwz    r9, 4(r11)
> +	stw    r9, 4(r10)
> +	lwz    r0, 8(r11)
> +	stw    r0, 8(r10)
> +	lwz    r9, 12(r11)
> +	addi   r11,r11,16
> +	stw    r9, 12(r10)
> +	addi   r10,r10,16
> +	bdnz copy_one_page
> +	mr     r10, r8
> +	cmplwi r10, 255
> +	mr     r9, r7
> +	ble copy_one_pgdir
> +	mr     r9, r6
> +	bne copy_loop
> +copy_loop_end:
> +
> +	/* Do a very simple cache flush/inval of the L1 to ensure
> +	 * coherency of the icache
> +	 */
> +	lis	r3,0x0002
> +	mtctr	r3
> +	li	r3, 0
> +1:
> +	lwz	r0,0(r3)
> +	addi	r3,r3,0x0020
> +	bdnz	1b
> +	isync
> +	sync
> +
> +	/* Now flush those cache lines */
> +	lis	r3,0x0002
> +	mtctr	r3
> +	li	r3, 0
> +1:
> +	dcbf	0,r3
> +	addi	r3,r3,0x0020
> +	bdnz	1b
> +	sync
> +
> +	/* Ok, we are now running with the kernel data of the old
> +	 * kernel fully restored. We can get to the save area
> +	 * easily now. As for the rest of the code, it assumes the
> +	 * loader kernel and the booted one are exactly identical
> +	 */
> +	lis	r11,swsusp_save_area@h
> +	ori	r11,r11,swsusp_save_area@l
> +	tophys(r11,r11)
> +
> +#if 0
> +	/* Restore various CPU config stuffs */
> +	bl	__restore_cpu_setup
> +#endif
> +	/* Restore the BATs, and SDR1.  Then we can turn on the MMU.
> +	 * This is a bit hairy as we are running out of those BATs,
> +	 * but first, our code is probably in the icache, and we are
> +	 * writing the same value to the BAT, so that should be fine,
> +	 * though a better solution will have to be found long-term
> +	 */
> +	lwz	r4,SL_SDR1(r11)
> +	mtsdr1	r4
> +	lwz	r4,SL_SPRG0(r11)
> +	mtsprg	0,r4
> +	lwz	r4,SL_SPRG0+4(r11)
> +	mtsprg	1,r4
> +	lwz	r4,SL_SPRG0+8(r11)
> +	mtsprg	2,r4
> +	lwz	r4,SL_SPRG0+12(r11)
> +	mtsprg	3,r4
> +
> +#if 0
> +	lwz	r4,SL_DBAT0(r11)
> +	mtdbatu	0,r4
> +	lwz	r4,SL_DBAT0+4(r11)
> +	mtdbatl	0,r4
> +	lwz	r4,SL_DBAT1(r11)
> +	mtdbatu	1,r4
> +	lwz	r4,SL_DBAT1+4(r11)
> +	mtdbatl	1,r4
> +	lwz	r4,SL_DBAT2(r11)
> +	mtdbatu	2,r4
> +	lwz	r4,SL_DBAT2+4(r11)
> +	mtdbatl	2,r4
> +	lwz	r4,SL_DBAT3(r11)
> +	mtdbatu	3,r4
> +	lwz	r4,SL_DBAT3+4(r11)
> +	mtdbatl	3,r4
> +	lwz	r4,SL_IBAT0(r11)
> +	mtibatu	0,r4
> +	lwz	r4,SL_IBAT0+4(r11)
> +	mtibatl	0,r4
> +	lwz	r4,SL_IBAT1(r11)
> +	mtibatu	1,r4
> +	lwz	r4,SL_IBAT1+4(r11)
> +	mtibatl	1,r4
> +	lwz	r4,SL_IBAT2(r11)
> +	mtibatu	2,r4
> +	lwz	r4,SL_IBAT2+4(r11)
> +	mtibatl	2,r4
> +	lwz	r4,SL_IBAT3(r11)
> +	mtibatu	3,r4
> +	lwz	r4,SL_IBAT3+4(r11)
> +	mtibatl	3,r4
> +#endif
> +
> +BEGIN_FTR_SECTION
> +	li	r4,0
> +	mtspr	SPRN_DBAT4U,r4
> +	mtspr	SPRN_DBAT4L,r4
> +	mtspr	SPRN_DBAT5U,r4
> +	mtspr	SPRN_DBAT5L,r4
> +	mtspr	SPRN_DBAT6U,r4
> +	mtspr	SPRN_DBAT6L,r4
> +	mtspr	SPRN_DBAT7U,r4
> +	mtspr	SPRN_DBAT7L,r4
> +	mtspr	SPRN_IBAT4U,r4
> +	mtspr	SPRN_IBAT4L,r4
> +	mtspr	SPRN_IBAT5U,r4
> +	mtspr	SPRN_IBAT5L,r4
> +	mtspr	SPRN_IBAT6U,r4
> +	mtspr	SPRN_IBAT6L,r4
> +	mtspr	SPRN_IBAT7U,r4
> +	mtspr	SPRN_IBAT7L,r4
> +END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
> +
> +	/* Flush all TLBs */
> +	lis	r4,0x1000
> +1:	addic.	r4,r4,-0x1000
> +	tlbie	r4
> +	blt	1b
> +	sync
> +
> +	/* restore the MSR and turn on the MMU */
> +	lwz	r3,SL_MSR(r11)
> +	bl	turn_on_mmu
> +	tovirt(r11,r11)
> +
> +	/* Restore TB */
> +	li	r3,0
> +	mttbl	r3
> +	lwz	r3,SL_TB(r11)
> +	lwz	r4,SL_TB+4(r11)
> +	mttbu	r3
> +	mttbl	r4
> +
> +	/* Kick decrementer */
> +	li	r0,1
> +	mtdec	r0
> +
> +	/* Restore the callee-saved registers and return */
> +	lwz	r0,SL_CR(r11)
> +	mtcr	r0
> +	lwz	r2,SL_R2(r11)
> +	lmw	r12,SL_R12(r11)
> +	lwz	r1,SL_SP(r11)
> +	lwz	r0,SL_LR(r11)
> +	mtlr	r0
> +
> +	// XXX Note: we don't really need to call swsusp_resume
> +
> +	li	r3,0
> +	blr
> +
> +/* FIXME:This construct is actually not useful since we don't shut
> + * down the instruction MMU, we could just flip back MSR-DR on.
> + */
> +turn_on_mmu:
> +	mflr	r4
> +	mtsrr0	r4
> +	mtsrr1	r3
> +	sync
> +	isync
> +	rfi
> +

This version will probably not work with 2.6.9 kernel (if you have
version that works with 2.6.9, it would be even better to merge that).

> --- 2.6.9-lzf/arch/ppc/kernel/vmlinux.lds.S	2004-11-26 12:32:57.000000000 +0800
> +++ 2.6.9/arch/ppc/kernel/vmlinux.lds.S	2004-11-28 23:16:58.000000000 +0800
> @@ -74,6 +74,12 @@ SECTIONS
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
> --- 2.6.9-lzf/arch/ppc/platforms/pmac_feature.c	2004-11-27 17:33:17.000000000 +0800
> +++ 2.6.9/arch/ppc/platforms/pmac_feature.c	2004-11-28 23:16:59.000000000 +0800
> @@ -2146,7 +2146,7 @@ static struct pmac_mb_def pmac_mb_defs[]
>  	},
>  	{	"PowerBook6,1",			"PowerBook G4 12\"",
>  		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
> -		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
> +		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
>  	},
>  	{	"PowerBook6,2",			"PowerBook G4",
>  		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,

Ok, merge with BenH.

> --- 2.6.9-lzf/arch/ppc/platforms/pmac_setup.c	2004-11-26 12:32:57.000000000 +0800
> +++ 2.6.9/arch/ppc/platforms/pmac_setup.c	2004-11-28 23:16:59.000000000 +0800
> @@ -51,6 +51,7 @@
>  #include <linux/irq.h>
>  #include <linux/seq_file.h>
>  #include <linux/root_dev.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/reg.h>
>  #include <asm/sections.h>
> @@ -70,6 +71,8 @@
>  #include <asm/pmac_feature.h>
>  #include <asm/time.h>
>  #include <asm/of_device.h>
> +#include <asm/mmu_context.h>
> +
>  #include "pmac_pic.h"
>  #include "mem_pieces.h"
>  
> @@ -420,11 +423,67 @@ find_boot_device(void)
>  #endif
>  }
>  
> +/* TODO: Merge the suspend-to-ram with the common code !!!
> + * currently, this is a stub implementation for suspend-to-disk
> + * only
> + */
> +
> +#ifdef CONFIG_PM
> +
> +extern void enable_kernel_altivec(void);
> +
> +static int pmac_pm_prepare(suspend_state_t state)
> +{
> +	printk(KERN_DEBUG "pmac_pm_prepare(%d)\n", state);
> +
> +	return 0;
> +}
> +
> +static int pmac_pm_enter(suspend_state_t state)
> +{
> +	printk(KERN_DEBUG "pmac_pm_enter(%d)\n", state);
> +
> +	/* Giveup the lazy FPU & vec so we don't have to back them
> +	 * up from the low level code
> +	 */
> +	enable_kernel_fp();
> +
> +#ifdef CONFIG_ALTIVEC
> +	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
> +		enable_kernel_altivec();
> +#endif /* CONFIG_ALTIVEC */
> +
> +	return 0;
> +}
> +
> +static int pmac_pm_finish(suspend_state_t state)
> +{
> +	printk(KERN_DEBUG "pmac_pm_finish(%d)\n", state);
> +
> +	/* Restore userland MMU context */
> +	set_context(current->active_mm->context, current->active_mm->pgd);
> +
> +	return 0;
> +}
> +
> +static struct pm_ops pmac_pm_ops = {
> +	.pm_disk_mode	= PM_DISK_SHUTDOWN,
> +	.prepare	= pmac_pm_prepare,
> +	.enter		= pmac_pm_enter,
> +	.finish		= pmac_pm_finish,
> +};
> +
> +#endif /* CONFIG_PM */
> +
>  static int initializing = 1;
>  
>  static int pmac_late_init(void)
>  {
>  	initializing = 0;
> +
> +#ifdef CONFIG_PM
> +	pm_set_ops(&pmac_pm_ops);
> +#endif /* CONFIG_PM */
>  	return 0;
>  }

Ok, merge with BenH.
								Pavel								

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
