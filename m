Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWBADfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWBADfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 22:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWBADfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 22:35:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030188AbWBADfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 22:35:20 -0500
Date: Tue, 31 Jan 2006 19:34:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       arjan@infradead.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-Id: <20060131193446.7904ac6f.akpm@osdl.org>
In-Reply-To: <20060131185516.GA21769@sommrey.de>
References: <20060131185516.GA21769@sommrey.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Sommrey <jo@sommrey.de> wrote:
>
> This is a processor idle module for AMD SMP 760MP(X) based systems.
>  The patch was originally written by Tony Lindgren and has been around
>  since 2002.  It enables C2 mode on AMD SMP systems and thus saves
>  about 70 - 90 W of energy in the idle mode compared to the default idle
>  mode.  The idle function has been rewritten and is now free of locking
>  issues and is independent from the number of CPUs.  The impact
>  from this module on the system clock and on i/o transfer are now fairly
>  low.
> 
>  This patch can also be found at
>  http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.15-4.patch
> 
>  In this version more locking was added to make sure all or no CPU enter
>  C3 mode.
> 
>  Signed-off-by: Joerg Sommrey <jo@sommrey.de>

Thanks.  I'll merge this into -mm and shall plague the ACPI guys with it. 
They have said discouraging things about board-specific drivers in the
past.  We shall see.

Tony, could you please review section 11 of Documentation/SubmittingPatches
and if OK, send a Signed-off-by:?

Some minor pointlets, and a bug:


Should CONFIG_AMD76X_PM depend on ACPI?

> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/version.h>
> +#include <asm/atomic.h>
> +#include <linux/kernel.h>
> +#include <linux/workqueue.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/amd76x_pm.h>

We conventionally put <asm> includes after the <linux> includes.

> +#define VERSION	"20060129"

Driver versions go out of date very quickly once they're merged up.

> +// #define AMD76X_LOG_C1 1
> +
> +extern void default_idle(void);

Please don't put extern declarations in .c.  We should find a header file
for this.  IIRC, it'll need to be arch-specific - default_idle() doesn't
have the same prototype on all architectures, or doesn't exist on some, or
something.  I do recall there were problems.

> +static void amd76x_smp_idle(void);
> +static int amd76x_pm_main(void);
> +
> +static unsigned long lazy_idle = 0;
> +static unsigned long spin_idle = 0;
> +static unsigned long watch_int = 0;
> +static unsigned long min_C1 = AMD76X_MIN_C1;
> +static unsigned int sb_id = 0;
> +static unsigned int nb_id = 0;

Unneeded (and undesirable) initialisation-to-zero.

> +static struct idle_stat amd76x_stat __cacheline_aligned_in_smp = {
> +	.num_idle = ATOMIC_INIT(0),
> +	.lock = SPIN_LOCK_UNLOCKED,
> +	.num_prepare = 0,
> +	.num_ready = 0,
> +	.num_C3 = ATOMIC_INIT(0),
> +};

Two unneeded (but harmless) initialisations-to-zero.

> +static void
> +amd76x_get_PM(void)

We prefer to do

static void amd76x_get_PM(void)

> +	if(enable) {

	if (enable) {

(many instances)

> +	if (likely(++(prs->idle_count) <= lazy_idle)) {
> +		return;
> +	}

Unneeded braces.

> +	/* Now we are ready do go C3. */
> +	local_irq_disable();
> +	num_online = num_online_cpus();
> +
> +	/* to enter prepare phase no CPU must be in ready phase */
> +	for (;;) {
> +		smp_mb();
> +		spin_lock(&amd76x_stat.lock);
> +		if (!amd76x_stat.num_ready) {
> +			amd76x_stat.num_prepare++;
> +			break;
> +		}
> +		spin_unlock(&amd76x_stat.lock);
> +	}
> +	spin_unlock(&amd76x_stat.lock);

What does the smp_mb() do?

Maybe add a cpu_relax() into the tight loop?

> +	atomic_inc(&amd76x_stat.num_idle);
> +	/* Spin inside inner loop until either
> +	 * - spin_idle cycles are reached
> +	 * - there is work
> +	 * - another CPU has left the inner loop
> +	 * - all CPUs are idle
> +	 */
> +
> +	ready_for_C3 = 0;
> +	for (i = 0; i < spin_idle; i++) {
> +		if (unlikely(need_resched()))
> +			break;
> +
> +		smp_mb();
> +		if (unlikely(atomic_read(&amd76x_stat.num_idle)
> +					== num_online)) {
> +			ready_for_C3 = 1;
> +			atomic_inc(&amd76x_stat.num_C3);
> +			break;
> +		}
> +	}

Ditto.

> +static void
> +setup_watch(void)
> +{
> +	if (watch_int <= 0)
> +		watch_int = AMD76X_WATCH_INT;
> +	if (watch_item[0].irq != -1 && watch_int) {
> +		schedule_work(&work);
> +		printk(KERN_INFO "amd76x_pm: irq rate watcher started. "
> +				"watch_int = %lu ms, min_C1 = %lu\n",
> +				watch_int, min_C1);
> +	} else
> +		printk(KERN_INFO "amd76x_pm: irq rate watcher disabled.\n");
> +}
> +
> +static void
> +watch_irq(void *parm)
> +{

Some comments which describe what these functions do would be nice.

> +/*
> + * Finds and initializes the bridges, and then sets the idle function
> + */
> +static int
> +amd76x_pm_main(void)
> +{
> +	int i;
> +	struct cpu_stat *prs;
> +
> +	amd76x_pm_cfg.orig_idle = 0;
> +	if(lazy_idle == 0)
> +	    lazy_idle = AMD76X_LAZY_IDLE;

Use hard tabs, please.

> +	printk(KERN_INFO "amd76x_pm: lazy_idle = %lu\n", lazy_idle);
> +	if(spin_idle == 0)
> +		spin_idle = 2 * lazy_idle;
> +	printk(KERN_INFO "amd76x_pm: spin_idle = %lu\n", spin_idle);
> +
> +	/* Find southbridge */
> +	pdev_sb = NULL;
> +	while((pdev_sb =
> +		pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb)) != NULL) {
> +		if(pci_match_id(amd_sb_tbl, pdev_sb) != NULL)
> +			goto found_sb;

for_each_pci_dev()?

> +	}
> +	printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
> +	return -ENODEV;
> +
> +found_sb:
> +	/* Find northbridge */
> +	pdev_nb = NULL;
> +	while((pdev_nb =
> +		pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_nb)) != NULL) {
> +		if(pci_match_id(amd_nb_tbl, pdev_nb) != NULL)
> +			goto found_nb;

Ditto.

> +
> +	prs_ref = alloc_percpu(struct cpu_stat);
> +
> +	for (i = 0; i < NR_CPUS; i++) {
> +		prs = per_cpu_ptr(prs_ref, i);
> +		prs->idle_count = 0;
> +		prs->C3_cnt = 0;
> +	}

alloc_percpu() only allocates stuff for cpu_possible() CPUs.  Use
for_each_cpu() here.

> +static void __exit
> +amd76x_pm_cleanup(void)
> +{
> +	int i;
> +	unsigned int C3_cnt = 0;
> +	struct cpu_stat *prs;
> +
> +	pm_idle = amd76x_pm_cfg.orig_idle;
> +
> +	cpu_idle_wait();
> +
> +
> +	/* This isn't really needed. */
> +	for_each_online_cpu(i) {
> +		prs = per_cpu_ptr(prs_ref, i);
> +		C3_cnt += prs->C3_cnt;
> +	}
> +	printk(KERN_INFO "amd76x_pm: %u C3 calls\n", C3_cnt);
> +
> +	/* remove sysfs */
> +	device_remove_file(&pdev_nb->dev, &dev_attr_C3_cnt);
> +
> +	schedule_watch = 0;
> +	flush_scheduled_work();
> +	cancel_delayed_work(&work);
> +	flush_scheduled_work();

That'll stop it for sure ;)

