Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUFRVHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUFRVHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUFRVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:06:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263126AbUFRU54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:57:56 -0400
Message-ID: <40D35740.8070206@pobox.com>
Date: Fri, 18 Jun 2004 16:57:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert.Picco@hp.com
Subject: Re: [PATCH] HPET driver
References: <200406181616.i5IGGECd003812@hera.kernel.org>
In-Reply-To: <200406181616.i5IGGECd003812@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1817, 2004/06/18 07:57:53-07:00, Robert.Picco@hp.com
> 
> 	[PATCH] HPET driver
> 	
> 	The driver supports the High Precision Event Timer.  The driver has adopted
> 	a similar API to the Real Time Clock driver.  It can support any number of
> 	HPET devices and the maximum number of timers per HPET device.  For further
> 	information look at the documentation in the patch.
> 	
> 	Thanks to Venki at Intel for testing the driver on X86 hardware with HPET.
> 	
> 	HPET documentation is available at http://www.intel.com/design/chipsets/datashts/252516.htm
> 	
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>


Was this posted on lkml, or simply snuck in?

If it was reviewed, I shall presume it was reviewed by a drunken monitor 
lizard:  It has serious security and crash problems.

This should NOT have been merged without changes.  Please fix ASAP, or 
revert and keep in -mm for a while.


> diff -Nru a/arch/i386/kernel/time_hpet.c b/arch/i386/kernel/time_hpet.c
> --- a/arch/i386/kernel/time_hpet.c	2004-06-18 09:16:23 -07:00
> +++ b/arch/i386/kernel/time_hpet.c	2004-06-18 09:16:23 -07:00
> @@ -21,6 +21,7 @@
>  #include <linux/config.h>
>  
>  #include <asm/hpet.h>
> +#include <linux/hpet.h>
>  
>  unsigned long hpet_period;	/* fsecs / HPET clock */
>  unsigned long hpet_tick;	/* hpet clks count per tick */
> @@ -135,6 +136,51 @@
>  	hpet_writel(cfg, HPET_CFG);
>  
>  	use_hpet = 1;
> +
> +#ifdef	CONFIG_HPET
> +	{
> +		struct hpet_data	hd;
> +		unsigned int 		ntimer;
> +
> +		memset(&hd, 0, sizeof (hd));
> +
> +		ntimer = hpet_readl(HPET_ID);
> +		ntimer = (ntimer & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT;
> +		ntimer++;
> +
> +		/*
> +		 * Register with driver.
> +		 * Timer0 and Timer1 is used by platform.
> +		 */
> +		hd.hd_address = hpet_virt_address;
> +		hd.hd_nirqs = ntimer;
> +		hd.hd_flags = HPET_DATA_PLATFORM;
> +#ifndef	CONFIG_HPET_EMULATE_RTC
> +		hd.hd_state = 0x1;
> +#else
> +		hd.hd_state = 0x3;
> +#endif

don't use magic numbers


> +		hd.hd_irq[0] = HPET_LEGACY_8254;
> +		hd.hd_irq[1] = HPET_LEGACY_RTC;
> +		if (ntimer > 2) {
> +			struct hpet		*hpet;
> +			struct hpet_timer	*timer;
> +			int			i;
> +
> +			hpet = (struct hpet *) hpet_virt_address;
> +
> +			for (i = 2, timer = &hpet->hpet_timers[2]; i < ntimer;
> +				timer++, i++)
> +				hd.hd_irq[i] = (timer->hpet_config &
> +					Tn_INT_ROUTE_CNF_MASK) >>
> +					Tn_INT_ROUTE_CNF_SHIFT;
> +
> +		}
> +
> +		hpet_alloc(&hd);
> +	}
> +#endif
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  	wait_timer_tick = wait_hpet_tick;
>  #endif
> diff -Nru a/drivers/char/hpet.c b/drivers/char/hpet.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/char/hpet.c	2004-06-18 09:16:23 -07:00
> @@ -0,0 +1,1076 @@
> +/*
> + * Intel & MS High Precision Event Timer Implementation.
> + * Contributors:
> + *	Venki Pallipadi
> + * 	Bob Picco
> + */
> +
> +#include <linux/config.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/miscdevice.h>
> +#include <linux/major.h>
> +#include <linux/ioport.h>
> +#include <linux/fcntl.h>
> +#include <linux/init.h>
> +#include <linux/poll.h>
> +#include <linux/proc_fs.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysctl.h>
> +#include <linux/wait.h>
> +#include <linux/bcd.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/current.h>
> +#include <asm/uaccess.h>
> +#include <asm/system.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/bitops.h>
> +#include <asm/div64.h>
> +
> +#include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
> +#include <linux/hpet.h>
> +
> +/*
> + * The High Precision Event Timer driver.
> + * This driver is closely modelled after the rtc.c driver.
> + * http://www.intel.com/labs/platcomp/hpet/hpetspec.htm
> + */
> +#define	HPET_USER_FREQ	(64)
> +#define	HPET_DRIFT	(500)
> +
> +static u32 hpet_ntimer, hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
> +
> +/* A lock for concurrent access by app and isr hpet activity. */
> +static spinlock_t hpet_lock = SPIN_LOCK_UNLOCKED;
> +/* A lock for concurrent intermodule access to hpet and isr hpet activity. */
> +static spinlock_t hpet_task_lock = SPIN_LOCK_UNLOCKED;

Shouldn't this lock be elsewhere, since HPET may be enabled but this 
driver isn't?


> +struct hpet_dev {
> +	struct hpets *hd_hpets;
> +	struct hpet *hd_hpet;
> +	struct hpet_timer *hd_timer;
> +	unsigned long hd_ireqfreq;
> +	unsigned long hd_irqdata;
> +	wait_queue_head_t hd_waitqueue;
> +	struct fasync_struct *hd_async_queue;
> +	struct hpet_task *hd_task;
> +	unsigned int hd_flags;
> +	unsigned int hd_irq;
> +	unsigned int hd_hdwirq;
> +};
> +
> +struct hpets {
> +	struct hpets *hp_next;
> +	struct hpet *hp_hpet;
> +	unsigned long hp_period;
> +	unsigned long hp_delta;
> +	unsigned int hp_ntimer;
> +	unsigned int hp_which;
> +	struct hpet_dev hp_dev[1];
> +};
> +
> +static struct hpets *hpets;
> +
> +#define	HPET_OPEN		0x0001
> +#define	HPET_IE			0x0002	/* interrupt enabled */
> +#define	HPET_PERIODIC		0x0004
> +
> +#if BITS_PER_LONG == 64
> +#define	write_counter(V, MC)	writeq(V, MC)
> +#define	read_counter(MC)	readq(MC)
> +#else
> +#define	write_counter(V, MC) 	writel(V, MC)
> +#define	read_counter(MC)	readl(MC)
> +#endif
> +
> +#ifndef readq
> +static unsigned long long __inline readq(void *addr)
> +{
> +	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
> +}
> +#endif
> +
> +#ifndef writeq
> +static void __inline writeq(unsigned long long v, void *addr)
> +{
> +	writel(v & 0xffffffff, addr);
> +	writel(v >> 32, addr + 4);
> +}
> +#endif

don't define driver-local readq/writeq


> +static irqreturn_t hpet_interrupt(int irq, void *data, struct pt_regs *regs)
> +{
> +	struct hpet_dev *devp;
> +	unsigned long isr;
> +
> +	devp = data;
> +
> +	spin_lock(&hpet_lock);
> +	devp->hd_irqdata++;
> +
> +	/*
> +	 * For non-periodic timers, increment the accumulator.
> +	 * This has the effect of treating non-periodic like periodic.
> +	 */
> +	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
> +		unsigned long m, t;
> +
> +		t = devp->hd_ireqfreq;
> +		m = read_counter(&devp->hd_hpet->hpet_mc);
> +		write_counter(t + m + devp->hd_hpets->hp_delta,
> +			      &devp->hd_timer->hpet_compare);
> +	}
> +
> +	isr = (1 << (devp - devp->hd_hpets->hp_dev));
> +	writeq(isr, &devp->hd_hpet->hpet_isr);
> +	spin_unlock(&hpet_lock);
> +
> +	spin_lock(&hpet_task_lock);
> +	if (devp->hd_task)
> +		devp->hd_task->ht_func(devp->hd_task->ht_data);
> +	spin_unlock(&hpet_task_lock);

can the 'if' be moved outside the spinlock?


> +	wake_up_interruptible(&devp->hd_waitqueue);
> +
> +	kill_fasync(&devp->hd_async_queue, SIGIO, POLL_IN);

shared interrupt:  boom


> +	return IRQ_HANDLED;
> +}
> +
> +static int hpet_open(struct inode *inode, struct file *file)
> +{
> +	struct hpet_dev *devp;
> +	struct hpets *hpetp;
> +	int i;
> +
> +	spin_lock_irq(&hpet_lock);
> +
> +	for (devp = NULL, hpetp = hpets; hpetp && !devp; hpetp = hpetp->hp_next)
> +		for (i = 0; i < hpetp->hp_ntimer; i++)
> +			if (hpetp->hp_dev[i].hd_flags & HPET_OPEN
> +			    || hpetp->hp_dev[i].hd_task)
> +				continue;
> +			else {
> +				devp = &hpetp->hp_dev[i];
> +				break;
> +			}
> +
> +	if (!devp) {
> +		spin_unlock_irq(&hpet_lock);
> +		return -EBUSY;
> +	}
> +
> +	file->private_data = devp;
> +	devp->hd_irqdata = 0;
> +	devp->hd_flags |= HPET_OPEN;
> +	spin_unlock_irq(&hpet_lock);
> +
> +	return 0;
> +}

security/bug:  missing check for O_RDWR, no?


> +static ssize_t
> +hpet_read(struct file *file, char *buf, size_t count, loff_t * ppos)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	unsigned long data;
> +	ssize_t retval;
> +	struct hpet_dev *devp;
> +
> +	devp = file->private_data;
> +	if (!devp->hd_ireqfreq)
> +		return -EIO;
> +
> +	if (count < sizeof(unsigned long))
> +		return -EINVAL;

see comment below, re context switches


> +	add_wait_queue(&devp->hd_waitqueue, &wait);
> +
> +	do {
> +		__set_current_state(TASK_INTERRUPTIBLE);
> +
> +		spin_lock_irq(&hpet_lock);
> +		data = devp->hd_irqdata;
> +		devp->hd_irqdata = 0;
> +		spin_unlock_irq(&hpet_lock);
> +
> +		if (data)
> +			break;
> +		else if (file->f_flags & O_NONBLOCK) {
> +			retval = -EAGAIN;
> +			goto out;
> +		} else if (signal_pending(current)) {
> +			retval = -ERESTARTSYS;
> +			goto out;
> +		}
> +
> +		schedule();

why munge the task state, if you're not going to schedule (such as 
non-block)?


> +	} while (1);
> +
> +	retval = put_user(data, (unsigned long *)buf);
> +	if (!retval)
> +		retval = sizeof(unsigned long);

If you don't process more than one datum per read(2), you wind up with a 
lot of context switches


> +      out:
> +	current->state = TASK_RUNNING;
> +	remove_wait_queue(&devp->hd_waitqueue, &wait);
> +
> +	return retval;
> +}
> +
> +static unsigned int hpet_poll(struct file *file, poll_table * wait)
> +{
> +	unsigned long v;
> +	struct hpet_dev *devp;
> +
> +	devp = file->private_data;
> +
> +	if (!devp->hd_ireqfreq)
> +		return 0;
> +
> +	poll_wait(file, &devp->hd_waitqueue, wait);
> +
> +	spin_lock_irq(&hpet_lock);
> +	v = devp->hd_irqdata;
> +	spin_unlock_irq(&hpet_lock);
> +
> +	if (v != 0)
> +		return POLLIN | POLLRDNORM;
> +
> +	return 0;
> +}

I need to review ->poll hook again, but I thought this (via __pollwait) 
just sets up the poll, not actually does the poll.


> +static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +#ifdef	CONFIG_HPET_NOMMAP
> +	return -ENOSYS;
> +#else
> +	struct hpet_dev *devp;
> +	unsigned long addr;
> +
> +	if (((vma->vm_end - vma->vm_start) != PAGE_SIZE) || vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		return -EPERM;

can this be prevented at open(2) time?


> +	devp = file->private_data;
> +	addr = (unsigned long)devp->hd_hpet;

locking/refcounting?


> +	if (addr & (PAGE_SIZE - 1))
> +		return -ENOSYS;

BUG() ?


> +	vma->vm_flags |= VM_IO;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	addr = __pa(addr);
> +
> +	if (remap_page_range
> +	    (vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
> +		printk(KERN_ERR "remap_page_range failed in hpet.c\n");
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +#endif
> +}

why not use ->nopage?  And isn't VM_RESERVED needed?


> +static int hpet_fasync(int fd, struct file *file, int on)
> +{
> +	struct hpet_dev *devp;
> +
> +	devp = file->private_data;
> +
> +	if (fasync_helper(fd, file, on, &devp->hd_async_queue) >= 0)
> +		return 0;
> +	else
> +		return -EIO;
> +}
> +
> +static int hpet_release(struct inode *inode, struct file *file)
> +{
> +	struct hpet_dev *devp;
> +	struct hpet_timer *timer;
> +	int irq = 0;
> +
> +	devp = file->private_data;
> +	timer = devp->hd_timer;
> +
> +	spin_lock_irq(&hpet_lock);
> +
> +	writeq((readq(&timer->hpet_config) & ~Tn_INT_ENB_CNF_MASK),
> +	       &timer->hpet_config);
> +
> +	irq = devp->hd_irq;
> +	devp->hd_irq = 0;
> +
> +	devp->hd_ireqfreq = 0;
> +
> +	if (devp->hd_flags & HPET_PERIODIC
> +	    && readq(&timer->hpet_config) & Tn_TYPE_CNF_MASK) {
> +		unsigned long v;
> +
> +		v = readq(&timer->hpet_config);
> +		v ^= Tn_TYPE_CNF_MASK;
> +		writeq(v, &timer->hpet_config);
> +	}
> +
> +	devp->hd_flags &= ~(HPET_OPEN | HPET_IE | HPET_PERIODIC);
> +	spin_unlock_irq(&hpet_lock);
> +
> +	if (irq)
> +		free_irq(irq, devp);
> +
> +	if (file->f_flags & FASYNC)
> +		hpet_fasync(-1, file, 0);

is this safe to do in ->release?


> +	file->private_data = 0;
> +	return 0;
> +}
> +
> +static int hpet_ioctl_common(struct hpet_dev *, int, unsigned long, int);
> +
> +static int
> +hpet_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
> +	   unsigned long arg)
> +{
> +	struct hpet_dev *devp;
> +
> +	devp = file->private_data;
> +	return hpet_ioctl_common(devp, cmd, arg, 0);
> +}
> +
> +static int hpet_ioctl_ieon(struct hpet_dev *devp)
> +{
> +	struct hpet_timer *timer;
> +	struct hpet *hpet;
> +	struct hpets *hpetp;
> +	int irq;
> +	unsigned long g, v, t, m;
> +	unsigned long flags, isr;
> +
> +	timer = devp->hd_timer;
> +	hpet = devp->hd_hpet;
> +	hpetp = devp->hd_hpets;
> +
> +	v = readq(&timer->hpet_config);
> +	spin_lock_irq(&hpet_lock);
> +
> +	if (devp->hd_flags & HPET_IE) {
> +		spin_unlock_irq(&hpet_lock);
> +		return -EBUSY;
> +	}
> +
> +	devp->hd_flags |= HPET_IE;
> +	spin_unlock_irq(&hpet_lock);
> +
> +	t = readq(&timer->hpet_config);
> +	irq = devp->hd_hdwirq;
> +
> +	if (irq) {
> +		char name[7];
> +
> +		sprintf(name, "hpet%d", (int)(devp - hpetp->hp_dev));

requesting irq in an ioctl is, um, unusual...


> +		if (request_irq
> +		    (irq, hpet_interrupt, SA_INTERRUPT, name, (void *)devp)) {
> +			printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
> +			irq = 0;
> +		}
> +	}

SECURITY/OOPS:  request_irq stores a C pointer to the device name. 
having the device name on the stack is very bad news.

cat /proc/interrupts for an oops, or at least leaking kernel memory to 
any user.


> +	if (irq == 0) {
> +		spin_lock_irq(&hpet_lock);
> +		devp->hd_flags ^= HPET_IE;
> +		spin_unlock_irq(&hpet_lock);
> +		return -EIO;
> +	}

Don't set HPET_IE then unset it


> +	devp->hd_irq = irq;
> +	t = devp->hd_ireqfreq;
> +	v = readq(&timer->hpet_config);
> +	g = v | Tn_INT_ENB_CNF_MASK;
> +
> +	if (devp->hd_flags & HPET_PERIODIC) {
> +		write_counter(t, &timer->hpet_compare);
> +		g |= Tn_TYPE_CNF_MASK;
> +		v |= Tn_TYPE_CNF_MASK;
> +		writeq(v, &timer->hpet_config);
> +		v |= Tn_VAL_SET_CNF_MASK;
> +		writeq(v, &timer->hpet_config);
> +		local_irq_save(flags);
> +		m = read_counter(&hpet->hpet_mc);
> +		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
> +	} else {
> +		local_irq_save(flags);
> +		m = read_counter(&hpet->hpet_mc);
> +		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
> +	}
> +
> +	isr = (1 << (devp - hpets->hp_dev));
> +	writeq(isr, &hpet->hpet_isr);
> +	writeq(g, &timer->hpet_config);
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +static inline unsigned long hpet_time_div(unsigned long dis)
> +{
> +	unsigned long long m = 1000000000000000ULL;
> +
> +	do_div(m, dis);
> +
> +	return (unsigned long)m;
> +}
> +
> +static int
> +hpet_ioctl_common(struct hpet_dev *devp, int cmd, unsigned long arg, int kernel)
> +{
> +	struct hpet_timer *timer;
> +	struct hpet *hpet;
> +	struct hpets *hpetp;
> +	int err;
> +	unsigned long v;
> +
> +	switch (cmd) {
> +	case HPET_IE_OFF:
> +	case HPET_INFO:
> +	case HPET_EPI:
> +	case HPET_DPI:
> +	case HPET_IRQFREQ:
> +		timer = devp->hd_timer;
> +		hpet = devp->hd_hpet;
> +		hpetp = devp->hd_hpets;
> +		break;
> +	case HPET_IE_ON:
> +		return hpet_ioctl_ieon(devp);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err = 0;
> +
> +	switch (cmd) {
> +	case HPET_IE_OFF:
> +		if ((devp->hd_flags & HPET_IE) == 0)
> +			break;
> +		v = readq(&timer->hpet_config);
> +		v &= ~Tn_INT_ENB_CNF_MASK;
> +		writeq(v, &timer->hpet_config);
> +		if (devp->hd_irq) {
> +			free_irq(devp->hd_irq, devp);
> +			devp->hd_irq = 0;
> +		}
> +		devp->hd_flags ^= HPET_IE;
> +		break;

where did the spin-locking disappear to?


> +	case HPET_INFO:
> +		{
> +			struct hpet_info info;
> +
> +			info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
> +							 devp->hd_ireqfreq);
> +			info.hi_flags =
> +			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
> +			info.hi_hpet = devp->hd_hpets->hp_which;
> +			info.hi_timer = devp - devp->hd_hpets->hp_dev;
> +			if (copy_to_user((void *)arg, &info, sizeof(info)))
> +				err = -EFAULT;
> +			break;
> +		}
> +	case HPET_EPI:
> +		v = readq(&timer->hpet_config);
> +		if ((v & Tn_PER_INT_CAP_MASK) == 0) {
> +			err = -ENXIO;
> +			break;
> +		}
> +		devp->hd_flags |= HPET_PERIODIC;
> +		break;

locking?


> +	case HPET_DPI:
> +		v = readq(&timer->hpet_config);
> +		if ((v & Tn_PER_INT_CAP_MASK) == 0) {
> +			err = -ENXIO;
> +			break;
> +		}
> +		if (devp->hd_flags & HPET_PERIODIC &&
> +		    readq(&timer->hpet_config) & Tn_TYPE_CNF_MASK) {
> +			v = readq(&timer->hpet_config);
> +			v ^= Tn_TYPE_CNF_MASK;
> +			writeq(v, &timer->hpet_config);
> +		}
> +		devp->hd_flags &= ~HPET_PERIODIC;
> +		break;

locking?


> +	case HPET_IRQFREQ:
> +		if (!kernel && (arg > hpet_max_freq) &&
> +		    !capable(CAP_SYS_RESOURCE)) {
> +			err = -EACCES;
> +			break;
> +		}
> +
> +		if (arg & (arg - 1)) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		devp->hd_ireqfreq = hpet_time_div(hpetp->hp_period * arg);
> +	}
> +
> +	return err;
> +}
> +
> +static struct file_operations hpet_fops = {
> +	.owner = THIS_MODULE,
> +	.llseek = no_llseek,
> +	.read = hpet_read,
> +	.poll = hpet_poll,
> +	.ioctl = hpet_ioctl,
> +	.open = hpet_open,
> +	.release = hpet_release,
> +	.fasync = hpet_fasync,
> +	.mmap = hpet_mmap,
> +};
> +
> +EXPORT_SYMBOL(hpet_alloc);
> +EXPORT_SYMBOL(hpet_register);
> +EXPORT_SYMBOL(hpet_unregister);
> +EXPORT_SYMBOL(hpet_control);
> +
> +int hpet_register(struct hpet_task *tp, int periodic)
> +{
> +	unsigned int i;
> +	u64 mask;
> +	struct hpet_timer *timer;
> +	struct hpet_dev *devp;
> +	struct hpets *hpetp;
> +
> +	switch (periodic) {
> +	case 1:
> +		mask = Tn_PER_INT_CAP_MASK;
> +		break;
> +	case 0:
> +		mask = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irq(&hpet_task_lock);
> +	spin_lock(&hpet_lock);
> +
> +	for (devp = 0, hpetp = hpets; hpetp && !devp; hpetp = hpetp->hp_next)
> +		for (timer = hpetp->hp_hpet->hpet_timers, i = 0;
> +		     i < hpetp->hp_ntimer; i++, timer++) {
> +			if ((readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK)
> +			    != mask)
> +				continue;
> +
> +			devp = &hpetp->hp_dev[i];
> +
> +			if (devp->hd_flags & HPET_OPEN || devp->hd_task) {
> +				devp = 0;
> +				continue;
> +			}
> +
> +			tp->ht_opaque = devp;
> +			devp->hd_task = tp;
> +			break;
> +		}
> +
> +	spin_unlock(&hpet_lock);
> +	spin_unlock_irq(&hpet_task_lock);
> +
> +	if (tp->ht_opaque)
> +		return 0;
> +	else
> +		return -EBUSY;
> +}
> +
> +static inline int hpet_tpcheck(struct hpet_task *tp)
> +{
> +	struct hpet_dev *devp;
> +	struct hpets *hpetp;
> +
> +	devp = tp->ht_opaque;
> +
> +	if (!devp)
> +		return -ENXIO;
> +
> +	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +		if (devp >= hpetp->hp_dev
> +		    && devp < (hpetp->hp_dev + hpetp->hp_ntimer)
> +		    && devp->hd_hpet == hpetp->hp_hpet)
> +			return 0;
> +
> +	return -ENXIO;
> +}

locking?


> +int hpet_unregister(struct hpet_task *tp)
> +{
> +	struct hpet_dev *devp;
> +	struct hpet_timer *timer;
> +	int err;
> +
> +	if ((err = hpet_tpcheck(tp)))
> +		return err;
> +
> +	spin_lock_irq(&hpet_task_lock);
> +	spin_lock(&hpet_lock);
> +
> +	devp = tp->ht_opaque;
> +	if (devp->hd_task != tp) {
> +		spin_unlock(&hpet_lock);
> +		spin_unlock_irq(&hpet_task_lock);
> +		return -ENXIO;
> +	}
> +
> +	timer = devp->hd_timer;
> +	writeq((readq(&timer->hpet_config) & ~Tn_INT_ENB_CNF_MASK),
> +	       &timer->hpet_config);
> +	devp->hd_flags &= ~(HPET_IE | HPET_PERIODIC);
> +	devp->hd_task = 0;
> +	spin_unlock(&hpet_lock);
> +	spin_unlock_irq(&hpet_task_lock);
> +
> +	return 0;
> +}
> +
> +int hpet_control(struct hpet_task *tp, unsigned int cmd, unsigned long arg)
> +{
> +	struct hpet_dev *devp;
> +	int err;
> +
> +	if ((err = hpet_tpcheck(tp)))
> +		return err;
> +
> +	spin_lock_irq(&hpet_lock);
> +	devp = tp->ht_opaque;
> +	if (devp->hd_task != tp) {
> +		spin_unlock_irq(&hpet_lock);
> +		return -ENXIO;
> +	}
> +	spin_unlock_irq(&hpet_lock);
> +	return hpet_ioctl_common(devp, cmd, arg, 1);
> +}
> +
> +#ifdef	CONFIG_TIME_INTERPOLATION
> +
> +static unsigned long hpet_offset, last_wall_hpet;
> +static long hpet_nsecs_per_cycle, hpet_cycles_per_sec;
> +
> +static unsigned long hpet_getoffset(void)
> +{
> +	return hpet_offset + (read_counter(&hpets->hp_hpet->hpet_mc) -
> +			      last_wall_hpet) * hpet_nsecs_per_cycle;
> +}
> +
> +static void hpet_update(long delta)
> +{
> +	unsigned long mc;
> +	unsigned long offset;
> +
> +	mc = read_counter(&hpets->hp_hpet->hpet_mc);
> +	offset = hpet_offset + (mc - last_wall_hpet) * hpet_nsecs_per_cycle;
> +
> +	if (delta < 0 || (unsigned long)delta < offset)
> +		hpet_offset = offset - delta;
> +	else
> +		hpet_offset = 0;
> +	last_wall_hpet = mc;
> +}
> +
> +static void hpet_reset(void)
> +{
> +	hpet_offset = 0;
> +	last_wall_hpet = read_counter(&hpets->hp_hpet->hpet_mc);
> +}
> +
> +static struct time_interpolator hpet_interpolator = {
> +	.get_offset = hpet_getoffset,
> +	.update = hpet_update,
> +	.reset = hpet_reset
> +};
> +
> +#endif
> +
> +static ctl_table hpet_table[] = {
> +	{
> +	 .ctl_name = 1,
> +	 .procname = "max-user-freq",
> +	 .data = &hpet_max_freq,
> +	 .maxlen = sizeof(int),
> +	 .mode = 0644,
> +	 .proc_handler = &proc_dointvec,
> +	 },
> +	{.ctl_name = 0}
> +};
> +
> +static ctl_table hpet_root[] = {
> +	{
> +	 .ctl_name = 1,
> +	 .procname = "hpet",
> +	 .maxlen = 0,
> +	 .mode = 0555,
> +	 .child = hpet_table,
> +	 },
> +	{.ctl_name = 0}
> +};
> +
> +static ctl_table dev_root[] = {
> +	{
> +	 .ctl_name = CTL_DEV,
> +	 .procname = "dev",
> +	 .maxlen = 0,
> +	 .mode = 0555,
> +	 .child = hpet_root,
> +	 },
> +	{.ctl_name = 0}
> +};
> +
> +static struct ctl_table_header *sysctl_header;

why is this not sysfs?


> +static void *hpet_start(struct seq_file *s, loff_t * pos)
> +{
> +	struct hpets *hpetp;
> +	loff_t n;
> +
> +	for (n = *pos, hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +		if (!n--)
> +			return hpetp;
> +
> +	return 0;
> +}
> +
> +static void *hpet_next(struct seq_file *s, void *v, loff_t * pos)
> +{
> +	struct hpets *hpetp;
> +
> +	hpetp = v;
> +	++*pos;
> +	return hpetp->hp_next;
> +}
> +
> +static void hpet_stop(struct seq_file *s, void *v)
> +{
> +	return;
> +}
> +
> +static int hpet_show(struct seq_file *s, void *v)
> +{
> +	struct hpets *hpetp;
> +	struct hpet *hpet;
> +	u64 cap, vendor, period;
> +
> +	hpetp = v;
> +	hpet = hpetp->hp_hpet;
> +
> +	cap = readq(&hpet->hpet_cap);
> +	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> +	    HPET_COUNTER_CLK_PERIOD_SHIFT;
> +	vendor = (cap & HPET_VENDOR_ID_MASK) >> HPET_VENDOR_ID_SHIFT;
> +
> +	seq_printf(s,
> +		   "HPET%d period = %d 10**-15  vendor = 0x%x number timer = %d\n",
> +		   hpetp->hp_which, (u32) period, (u32) vendor,
> +		   hpetp->hp_ntimer);
> +
> +	return 0;
> +}
> +
> +static struct seq_operations hpet_seq_ops = {
> +	.start = hpet_start,
> +	.next = hpet_next,
> +	.stop = hpet_stop,
> +	.show = hpet_show
> +};
> +
> +static int hpet_proc_open(struct inode *inode, struct file *file)
> +{
> +	return seq_open(file, &hpet_seq_ops);
> +}
> +
> +static struct file_operations hpet_proc_fops = {
> +	.open = hpet_proc_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = seq_release
> +};

why is this not sysfs?


> +/*
> + * Adjustment for when arming the timer with
> + * initial conditions.  That is, main counter
> + * ticks expired before interrupts are enabled.
> + */
> +#define	TICK_CALIBRATE	(1000UL)
> +
> +static unsigned long __init hpet_calibrate(struct hpets *hpetp)
> +{
> +	struct hpet_timer *timer;
> +	unsigned long t, m, count, i, flags, start;
> +	struct hpet_dev *devp;
> +	int j;
> +	struct hpet *hpet;
> +
> +	for (timer = 0, j = 0, devp = hpetp->hp_dev; j < hpetp->hp_ntimer;
> +	     j++, devp++)
> +		if ((devp->hd_flags & HPET_OPEN) == 0) {
> +			timer = devp->hd_timer;
> +			break;
> +		}
> +
> +	if (!timer)
> +		return 0;
> +
> +	hpet = hpets->hp_hpet;
> +	t = read_counter(&timer->hpet_compare);
> +
> +	i = 0;
> +	count = hpet_time_div(hpetp->hp_period * TICK_CALIBRATE);
> +
> +	local_irq_save(flags);
> +
> +	start = read_counter(&hpet->hpet_mc);
> +
> +	do {
> +		m = read_counter(&hpet->hpet_mc);
> +		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
> +	} while (i++, (m - start) < count);
> +
> +	local_irq_restore(flags);
> +
> +	return (m - start) / i;
> +}
> +
> +int __init hpet_alloc(struct hpet_data *hdp)
> +{
> +	u64 cap, mcfg;
> +	struct hpet_dev *devp;
> +	u32 i, ntimer;
> +	struct hpets *hpetp;
> +	size_t siz;
> +	struct hpet *hpet;
> +	static struct hpets *last __initdata = (struct hpets *)0;
> +
> +	/*
> +	 * hpet_alloc can be called by platform dependent code.
> +	 * if platform dependent code has allocated the hpet
> +	 * ACPI also reports hpet, then we catch it here.
> +	 */
> +	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +		if (hpetp->hp_hpet == (struct hpet *)(hdp->hd_address))
> +			return 0;
> +
> +	siz = sizeof(struct hpets) + ((hdp->hd_nirqs - 1) *
> +				      sizeof(struct hpet_dev));
> +
> +	hpetp = kmalloc(siz, GFP_KERNEL);
> +
> +	if (!hpetp)
> +		return -ENOMEM;
> +
> +	memset(hpetp, 0, siz);
> +
> +	hpetp->hp_which = hpet_nhpet++;
> +	hpetp->hp_hpet = (struct hpet *)hdp->hd_address;
> +
> +	hpetp->hp_ntimer = hdp->hd_nirqs;
> +
> +	for (i = 0; i < hdp->hd_nirqs; i++)
> +		hpetp->hp_dev[i].hd_hdwirq = hdp->hd_irq[i];
> +
> +	hpet = hpetp->hp_hpet;
> +
> +	cap = readq(&hpet->hpet_cap);
> +
> +	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
> +
> +	if (hpetp->hp_ntimer != ntimer) {
> +		printk(KERN_WARNING "hpet: number irqs doesn't agree"
> +		       " with number of timers\n");
> +		kfree(hpetp);
> +		return -ENODEV;
> +	}
> +
> +	if (last)
> +		last->hp_next = hpetp;
> +	else
> +		hpets = hpetp;
> +
> +	last = hpetp;
> +
> +	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> +	    HPET_COUNTER_CLK_PERIOD_SHIFT;
> +
> +	mcfg = readq(&hpet->hpet_config);
> +	if ((mcfg & HPET_ENABLE_CNF_MASK) == 0) {
> +		write_counter(0L, &hpet->hpet_mc);
> +		mcfg |= HPET_ENABLE_CNF_MASK;
> +		writeq(mcfg, &hpet->hpet_config);
> +	}
> +
> +	for (i = 0, devp = hpetp->hp_dev; i < hpetp->hp_ntimer;
> +	     i++, hpet_ntimer++, devp++) {
> +		unsigned long v;
> +		struct hpet_timer *timer;
> +
> +		timer = &hpet->hpet_timers[devp - hpetp->hp_dev];
> +		v = readq(&timer->hpet_config);
> +
> +		devp->hd_hpets = hpetp;
> +		devp->hd_hpet = hpet;
> +		devp->hd_timer = timer;
> +
> +		/*
> +		 * If the timer was reserved by platform code,
> +		 * then make timer unavailable for opens.
> +		 */
> +		if (hdp->hd_state & (1 << i)) {
> +			devp->hd_flags = HPET_OPEN;
> +			continue;
> +		}
> +
> +		init_waitqueue_head(&devp->hd_waitqueue);
> +	}
> +
> +	hpetp->hp_delta = hpet_calibrate(hpetp);
> +
> +	return 0;
> +}


> +static acpi_status __init hpet_resources(struct acpi_resource *res, void *data)
> +{
> +	struct hpet_data *hdp;
> +	acpi_status status;
> +	struct acpi_resource_address64 addr;
> +	struct hpets *hpetp;
> +
> +	hdp = data;
> +
> +	status = acpi_resource_to_address64(res, &addr);
> +
> +	if (ACPI_SUCCESS(status)) {
> +		unsigned long size;
> +
> +		size = addr.max_address_range - addr.min_address_range + 1;
> +		hdp->hd_address =
> +		    (unsigned long)ioremap(addr.min_address_range, size);
> +
> +		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +			if (hpetp->hp_hpet == (struct hpet *)(hdp->hd_address))
> +				return -EBUSY;
> +	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
> +		struct acpi_resource_ext_irq *irqp;
> +		int i;
> +
> +		irqp = &res->data.extended_irq;
> +
> +		if (irqp->number_of_interrupts > 0) {
> +			hdp->hd_nirqs = irqp->number_of_interrupts;
> +
> +			for (i = 0; i < hdp->hd_nirqs; i++)
> +#ifdef	CONFIG_IA64
> +				hdp->hd_irq[i] =
> +				    acpi_register_gsi(irqp->interrupts[i],
> +						      irqp->edge_level,
> +						      irqp->active_high_low);
> +#else
> +				hdp->hd_irq[i] = irqp->interrupts[i];
> +#endif
> +		}
> +	}
> +
> +	return AE_OK;
> +}

> +static int __init hpet_acpi_add(struct acpi_device *device)
> +{
> +	acpi_status result;
> +	struct hpet_data data;
> +
> +	memset(&data, 0, sizeof(data));
> +
> +	result =
> +	    acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +				hpet_resources, &data);
> +
> +	if (ACPI_FAILURE(result))
> +		return -ENODEV;
> +
> +	if (!data.hd_address || !data.hd_nirqs) {
> +		printk("%s: no address or irqs in _CRS\n", __FUNCTION__);
> +		return -ENODEV;
> +	}
> +
> +	return hpet_alloc(&data);
> +}


> +static int __init hpet_acpi_remove(struct acpi_device *device, int type)
> +{
> +	return 0;
> +}
> +
> +static struct acpi_driver hpet_acpi_driver __initdata = {
> +	.name = "hpet",
> +	.class = "",
> +	.ids = "PNP0103",
> +	.ops = {
> +		.add = hpet_acpi_add,
> +		.remove = hpet_acpi_remove,
> +		},
> +};

where is CONFIG_ACPI ifdef?


> +static struct miscdevice hpet_misc = { HPET_MINOR, "hpet", &hpet_fops };
> +
> +static int __init hpet_init(void)
> +{
> +	struct proc_dir_entry *entry;
> +
> +	(void)acpi_bus_register_driver(&hpet_acpi_driver);
> +
> +	if (hpets) {
> +		if (misc_register(&hpet_misc))
> +			return -ENODEV;
> +
> +		entry = create_proc_entry("driver/hpet", 0, 0);
> +
> +		if (entry)
> +			entry->proc_fops = &hpet_proc_fops;
> +
> +		sysctl_header = register_sysctl_table(dev_root, 0);
> +
> +#ifdef	CONFIG_TIME_INTERPOLATION
> +		{
> +			struct hpet *hpet;
> +
> +			hpet = hpets->hp_hpet;
> +			hpet_cycles_per_sec = hpet_time_div(hpets->hp_period);
> +			hpet_interpolator.frequency = hpet_cycles_per_sec;
> +			hpet_interpolator.drift = hpet_cycles_per_sec *
> +			    HPET_DRIFT / 1000000;
> +			hpet_nsecs_per_cycle = 1000000000 / hpet_cycles_per_sec;
> +			register_time_interpolator(&hpet_interpolator);
> +		}
> +#endif
> +		return 0;
> +	} else
> +		return -ENODEV;
> +}
> +
> +static void __exit hpet_exit(void)
> +{
> +	acpi_bus_unregister_driver(&hpet_acpi_driver);
> +
> +	if (hpets) {
> +		unregister_sysctl_table(sysctl_header);
> +		remove_proc_entry("driver/hpet", NULL);
> +	}
> +
> +	return;
> +}
> +
> +module_init(hpet_init);
> +module_exit(hpet_exit);
> +MODULE_AUTHOR("Bob Picco <Robert.Picco@hp.com>");
> +MODULE_LICENSE("GPL");
> diff -Nru a/drivers/char/rtc.c b/drivers/char/rtc.c
> --- a/drivers/char/rtc.c	2004-06-18 09:16:23 -07:00
> +++ b/drivers/char/rtc.c	2004-06-18 09:16:23 -07:00
> @@ -97,6 +97,11 @@
>  static int rtc_irq = PCI_IRQ_NONE;
>  #endif
>  
> +#ifdef	CONFIG_HPET_RTC_IRQ
> +#undef	RTC_IRQ
> +#define	RTC_IRQ	0
> +#endif
> +
>  #ifdef RTC_IRQ
>  static int rtc_has_irq = 1;
>  #endif
> diff -Nru a/include/asm-i386/hpet.h b/include/asm-i386/hpet.h
> --- a/include/asm-i386/hpet.h	2004-06-18 09:16:23 -07:00
> +++ b/include/asm-i386/hpet.h	2004-06-18 09:16:23 -07:00
> @@ -57,9 +57,12 @@
>  #define HPET_ID_LEGSUP	0x00008000
>  #define HPET_ID_NUMBER	0x00001f00
>  #define HPET_ID_REV	0x000000ff
> +#define	HPET_ID_NUMBER_SHIFT	8
>  
>  #define HPET_CFG_ENABLE	0x001
>  #define HPET_CFG_LEGACY	0x002
> +#define	HPET_LEGACY_8254	2
> +#define	HPET_LEGACY_RTC		8
>  
>  #define HPET_TN_ENABLE		0x004
>  #define HPET_TN_PERIODIC	0x008
> diff -Nru a/include/linux/hpet.h b/include/linux/hpet.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/include/linux/hpet.h	2004-06-18 09:16:23 -07:00
> @@ -0,0 +1,133 @@
> +#ifndef	__HPET__
> +#define	__HPET__ 1
> +
> +/*
> + * Offsets into HPET Registers
> + */
> +
> +struct hpet {
> +	u64 hpet_cap;		/* capabilities */
> +	u64 res0;		/* reserved */
> +	u64 hpet_config;	/* configuration */
> +	u64 res1;		/* reserved */
> +	u64 hpet_isr;		/* interrupt status reg */
> +	u64 res2[25];		/* reserved */
> +	union {			/* main counter */
> +		u64 _hpet_mc64;
> +		u32 _hpet_mc32;
> +		unsigned long _hpet_mc;
> +	} _u0;
> +	u64 res3;		/* reserved */
> +	struct hpet_timer {
> +		u64 hpet_config;	/* configuration/cap */
> +		union {		/* timer compare register */
> +			u64 _hpet_hc64;
> +			u32 _hpet_hc32;
> +			unsigned long _hpet_compare;
> +		} _u1;
> +		u64 hpet_fsb[2];	/* FSB route */
> +	} hpet_timers[1];
> +};
> +
> +#define	hpet_mc		_u0._hpet_mc
> +#define	hpet_compare	_u1._hpet_compare
> +
> +#define	HPET_MAX_TIMERS	(32)
> +
> +/*
> + * HPET general capabilities register
> + */
> +
> +#define	HPET_COUNTER_CLK_PERIOD_MASK	(0xffffffff00000000ULL)
> +#define	HPET_COUNTER_CLK_PERIOD_SHIFT	(32UL)
> +#define	HPET_VENDOR_ID_MASK		(0x00000000ffff0000ULL)
> +#define	HPET_VENDOR_ID_SHIFT		(16ULL)
> +#define	HPET_LEG_RT_CAP_MASK		(0x8000)
> +#define	HPET_COUNTER_SIZE_MASK		(0x2000)
> +#define	HPET_NUM_TIM_CAP_MASK		(0x1f00)
> +#define	HPET_NUM_TIM_CAP_SHIFT		(8ULL)
> +
> +/*
> + * HPET general configuration register
> + */
> +
> +#define	HPET_LEG_RT_CNF_MASK		(2UL)
> +#define	HPET_ENABLE_CNF_MASK		(1UL)
> +
> +/*
> + * HPET interrupt status register
> + */
> +
> +#define	HPET_ISR_CLEAR(HPET, TIMER)				\
> +		(HPET)->hpet_isr |= (1UL << TIMER)
> +
> +/*
> + * Timer configuration register
> + */
> +
> +#define	Tn_INT_ROUTE_CAP_MASK		(0xffffffff00000000ULL)
> +#define	Tn_INI_ROUTE_CAP_SHIFT		(32UL)
> +#define	Tn_FSB_INT_DELCAP_MASK		(0x8000UL)
> +#define	Tn_FSB_INT_DELCAP_SHIFT		(15)
> +#define	Tn_FSB_EN_CNF_MASK		(0x4000UL)
> +#define	Tn_FSB_EN_CNF_SHIFT		(14)
> +#define	Tn_INT_ROUTE_CNF_MASK		(0x3e00UL)
> +#define	Tn_INT_ROUTE_CNF_SHIFT		(9)
> +#define	Tn_32MODE_CNF_MASK		(0x0100UL)
> +#define	Tn_VAL_SET_CNF_MASK		(0x0040UL)
> +#define	Tn_SIZE_CAP_MASK		(0x0020UL)
> +#define	Tn_PER_INT_CAP_MASK		(0x0010UL)
> +#define	Tn_TYPE_CNF_MASK		(0x0008UL)
> +#define	Tn_INT_ENB_CNF_MASK		(0x0004UL)
> +#define	Tn_INT_TYPE_CNF_MASK		(0x0002UL)
> +
> +/*
> + * Timer FSB Interrupt Route Register
> + */
> +
> +#define	Tn_FSB_INT_ADDR_MASK		(0xffffffff00000000ULL)
> +#define	Tn_FSB_INT_ADDR_SHIFT		(32UL)
> +#define	Tn_FSB_INT_VAL_MASK		(0x00000000ffffffffULL)
> +
> +struct hpet_info {
> +	unsigned long hi_ireqfreq;	/* Hz */
> +	unsigned long hi_flags;	/* information */
> +	unsigned short hi_hpet;
> +	unsigned short hi_timer;
> +};
> +
> +#define	HPET_INFO_PERIODIC	0x0001	/* timer is periodic */
> +
> +#define	HPET_IE_ON	_IO('h', 0x01)	/* interrupt on */
> +#define	HPET_IE_OFF	_IO('h', 0x02)	/* interrupt off */
> +#define	HPET_INFO	_IOR('h', 0x03, struct hpet_info)
> +#define	HPET_EPI	_IO('h', 0x04)	/* enable periodic */
> +#define	HPET_DPI	_IO('h', 0x05)	/* disable periodic */
> +#define	HPET_IRQFREQ	_IOW('h', 0x6, unsigned long)	/* IRQFREQ usec */
> +
> +/*
> + * exported interfaces
> + */
> +
> +struct hpet_task {
> +	void (*ht_func) (void *);
> +	void *ht_data;
> +	void *ht_opaque;
> +};
> +
> +struct hpet_data {
> +	unsigned long hd_address;
> +	unsigned short hd_nirqs;
> +	unsigned short hd_flags;
> +	unsigned int hd_state;	/* timer allocated */
> +	unsigned int hd_irq[HPET_MAX_TIMERS];
> +};
> +
> +#define	HPET_DATA_PLATFORM	0x0001	/* platform call to hpet_alloc */
> +
> +int hpet_alloc(struct hpet_data *);
> +int hpet_register(struct hpet_task *, int);
> +int hpet_unregister(struct hpet_task *);
> +int hpet_control(struct hpet_task *, unsigned int, unsigned long);
> +
> +#endif				/* !__HPET__ */
> diff -Nru a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> --- a/include/linux/miscdevice.h	2004-06-18 09:16:23 -07:00
> +++ b/include/linux/miscdevice.h	2004-06-18 09:16:23 -07:00
> @@ -33,6 +33,7 @@
>  #define SGI_STREAMS_KEYBOARD 150
>  /* drivers/sgi/char/usema.c */
>  #define SGI_USEMACLONE	     151
> +#define	HPET_MINOR	     152

Is this officially allocated by LANANA?

Where is the devices.txt update?

	Jeff


