Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUEMXUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUEMXUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUEMXUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:20:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265247AbUEMXRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:17:39 -0400
Message-ID: <40A40204.1060509@pobox.com>
Date: Thu, 13 May 2004 19:17:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Picco <Robert.Picco@hp.com>
CC: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com>
In-Reply-To: <40A3F805.5090804@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Picco wrote:
> diff -ruN -X /home/picco/losl/dontdiff 
> linux-2.6.6-orig/drivers/char/hpet.c linux-2.6.6-hpet/drivers/char/hpet.c
> --- linux-2.6.6-orig/drivers/char/hpet.c    1969-12-31 
> 19:00:00.000000000 -0500
> +++ linux-2.6.6-hpet/drivers/char/hpet.c    2004-05-10 
> 15:43:48.000000000 -0400
> @@ -0,0 +1,1116 @@

run this through Lindent... non-standard indentation


> +/*
> + * Intel & MS High Precision Event Timer Implementation.
> + * Contributors:
> + *    Venki Pallipadi
> + *     Bob Picco
> + */
> +
> +#include <linux/config.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/devfs_fs_kernel.h>
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
> +#define    HPET_USER_FREQ    (64)
> +#define    HPET_DRIFT    (500)
> +
> +static u32 hpet_ntimer, hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
> +static char hpetname[] = "hpet/XX";
> +
> +/* A lock for concurrent access by app and isr hpet activity. */
> +static spinlock_t hpet_lock = SPIN_LOCK_UNLOCKED;
> +/* A lock for concurrent intermodule access to hpet and isr hpet 
> activity. */
> +static spinlock_t hpet_task_lock = SPIN_LOCK_UNLOCKED;
> +
> +struct hpet_dev {
> +    struct hpets        *hd_hpets;
> +    volatile struct hpet    *hd_hpet;
> +    volatile struct hpet_timer
> +                *hd_timer;
> +    unsigned long        hd_ireqfreq;
> +    unsigned long        hd_irqdata;
> +    wait_queue_head_t    hd_waitqueue;
> +    struct fasync_struct    *hd_async_queue;
> +    struct hpet_task    *hd_task;
> +    unsigned int        hd_flags;
> +    unsigned int        hd_irq;
> +    unsigned int        hd_hdwirq;
> +    int            hd_minor;
> +};

kill the 'volatile', it's preferred to put barriers and such in the code 
where they are needed.


> +struct hpets {
> +    struct hpets        *hp_next;
> +    volatile struct hpet    *hp_hpet;
> +    unsigned long        hp_period;
> +    unsigned long        hp_delta;
> +    unsigned int        hp_ntimer;
> +    unsigned int        hp_which;
> +    struct hpet_dev        hp_dev[1];
> +};
> +
> +static struct hpets *hpets;
> +
> +#define    HPET_OPEN        0x0001
> +#define    HPET_IE            0x0002            /* interrupt enabled */
> +#define    HPET_PERIODIC        0x0004
> +
> +static irqreturn_t
> +hpet_interrupt (int irq, void *data, struct pt_regs *regs)
> +{
> +    struct hpet_dev *devp;
> +    unsigned long isr;
> +
> +    devp = data;
> +
> +    spin_lock(&hpet_lock);
> +    devp->hd_irqdata++;
> +
> +    if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
> +        unsigned long m, t;
> +
> +        t = devp->hd_ireqfreq;
> +        m = devp->hd_hpet->hpet_mc;
> +        devp->hd_timer->hpet_compare = t + m + devp->hd_hpets->hp_delta;
> +    }
> +
> +    isr = (1 << (devp - devp->hd_hpets->hp_dev));
> +    devp->hd_hpet->hpet_isr = isr;
> +    spin_unlock(&hpet_lock);
> +
> +    spin_lock(&hpet_task_lock);
> +    if (devp->hd_task)
> +        devp->hd_task->ht_func(devp->hd_task->ht_data);
> +    spin_unlock(&hpet_task_lock);
> +
> +    wake_up_interruptible(&devp->hd_waitqueue);
> +
> +    kill_fasync(&devp->hd_async_queue, SIGIO, POLL_IN);
> +
> +    return IRQ_HANDLED;
> +}
> +
> +static struct hpet_dev *
> +hpet_minor_to_dev (int minor)
> +{
> +    struct hpets *hpetp;
> +    int i;
> +
> +    for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +        for (i = 0; i <  hpetp->hp_ntimer; i++)
> +            if (hpetp->hp_dev[i].hd_minor == minor)
> +                return &hpetp->hp_dev[i];
> +    return 0;
> +}
> +
> +static int
> +hpet_open (struct inode *inode, struct file *file)
> +{
> +    struct hpet_dev *devp;
> +
> +    devp = hpet_minor_to_dev(MINOR(inode->i_rdev));

locking of hpets?


> +    vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
> +    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +    addr = __pa(addr);

where did these flags come from?  don't you just want VM_RESERVED?


> +    if (remap_page_range(vma, vma->vm_start, addr, PAGE_SIZE, 
> vma->vm_page_prot)) {
> +        printk(KERN_ERR "remap_page_range failed in hpet.c\n");
> +        return -EAGAIN;
> +    }

why not ->nopage like in sound/oss/via82cxxx_audio.c?


> +static int
> +hpet_release (struct inode *inode, struct file *file)
> +{
> +    struct hpet_dev    *devp;
> +    volatile struct hpet_timer *timer;
> +
> +    devp = file->private_data;
> +    timer = devp->hd_timer;
> +
> +    spin_lock_irq(&hpet_lock);
> +
> +    timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;
> +
> +    if (devp->hd_irq) {
> +        free_irq(devp->hd_irq, devp);
> +        devp->hd_irq = 0;
> +    }
> +
> +    devp->hd_ireqfreq = 0;
> +
> +    if (devp->hd_flags & HPET_PERIODIC && timer->hpet_config & 
> Tn_TYPE_CNF_MASK) {
> +        unsigned long v;
> +
> +        v = timer->hpet_config;
> +        v ^= Tn_TYPE_CNF_MASK;
> +        timer->hpet_config = v;
> +    }
> +
> +    devp->hd_flags &= ~(HPET_OPEN | HPET_IE | HPET_PERIODIC);
> +    spin_unlock_irq(&hpet_lock);
> +
> +    if (file->f_flags & FASYNC)
> +        hpet_fasync(-1, file, 0);
> +
> +    file->private_data = 0;
> +    return 0;
> +}
> +
> +static int hpet_ioctl_common(struct hpet_dev *, int, unsigned long, int);
> +
> +static int
> +hpet_ioctl (struct inode *inode, struct file *file, unsigned int cmd, 
> unsigned long arg)
> +{
> +    struct hpet_dev    *devp;
> +
> +    devp = file->private_data;
> +    return hpet_ioctl_common(devp, cmd, arg, 0);
> +}
> +
> +static int
> +hpet_ioctl_ieon (struct hpet_dev *devp)
> +{
> +    volatile struct hpet_timer *timer;
> +    volatile struct hpet *hpet;
> +    struct hpets *hpetp;
> +    int irq;
> +    unsigned long g, v, t, m;
> +    unsigned long flags, isr;
> +
> +    timer = devp->hd_timer;
> +    hpet = devp->hd_hpet;
> +    hpetp = devp->hd_hpets;
> +
> +    v = timer->hpet_config;
> +    spin_lock_irq(&hpet_lock);
> +
> +    if (devp->hd_flags & HPET_IE) {
> +        spin_unlock_irq(&hpet_lock);
> +        return -EBUSY;
> +    }
> +
> +    devp->hd_flags |= HPET_IE;
> +    spin_unlock_irq(&hpet_lock);
> +
> +    t = timer->hpet_config;
> +    irq = devp->hd_hdwirq;
> +
> +    if (irq) {
> +        char name[7];
> +
> +        sprintf(name, "hpet%d", (int) (devp - hpetp->hp_dev));
> +
> +        if (request_irq(irq, hpet_interrupt, SA_INTERRUPT, name, (void 
> *) devp)) {
> +            printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
> +            irq = 0;
> +        }
> +    }
> +
> +    if (irq == 0) {
> +        spin_lock_irq(&hpet_lock);
> +        devp->hd_flags ^= HPET_IE;
> +        spin_unlock_irq(&hpet_lock);
> +        return -EIO;
> +    }
> +
> +    devp->hd_irq = irq;
> +    t = devp->hd_ireqfreq;
> +    v = timer->hpet_config;
> +    g = v | Tn_INT_ENB_CNF_MASK;
> +
> +    if (devp->hd_flags & HPET_PERIODIC) {
> +        timer->hpet_compare = t;
> +        g |= Tn_TYPE_CNF_MASK;
> +        v |= Tn_TYPE_CNF_MASK;
> +        timer->hpet_config = v;
> +        v |= Tn_VAL_SET_CNF_MASK;
> +        timer->hpet_config = v;
> +        local_irq_save(flags);
> +        m = hpet->hpet_mc;
> +        timer->hpet_compare = t + m + hpetp->hp_delta;
> +    } else {
> +        local_irq_save(flags);
> +        m = hpet->hpet_mc;
> +        timer->hpet_compare = t + m + hpetp->hp_delta;
> +    }
> +
> +    isr = (1 << (devp - hpets->hp_dev));
> +    hpet->hpet_isr = isr;
> +    timer->hpet_config = g;
> +    local_irq_restore(flags);
> +
> +    return 0;
> +}
> +
> +static inline unsigned long
> +hpet_time_div (unsigned long dis)
> +{
> +    unsigned long long m = 1000000000000000ULL;
> +
> +    do_div(m, dis);
> +
> +    return (unsigned long) m;
> +}
> +
> +static int
> +hpet_ioctl_common (struct hpet_dev *devp, int cmd, unsigned long arg, 
> int kernel)
> +{
> +    volatile struct hpet_timer *timer;
> +    volatile struct hpet *hpet;
> +    struct hpets *hpetp;
> +    int err;
> +    unsigned long v;
> +
> +    switch (cmd) {
> +    case HPET_IE_OFF:
> +    case HPET_INFO:
> +    case HPET_EPI:
> +    case HPET_DPI:
> +    case HPET_IRQFREQ:
> +        timer = devp->hd_timer;
> +        hpet = devp->hd_hpet;
> +        hpetp = devp->hd_hpets;
> +        break;
> +    case HPET_IE_ON:
> +        return hpet_ioctl_ieon(devp);
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    err = 0;
> +
> +    switch (cmd) {
> +    case HPET_IE_OFF:
> +        if ((devp->hd_flags & HPET_IE) == 0)
> +            break;
> +        v = timer->hpet_config;
> +        v &= ~Tn_INT_ENB_CNF_MASK;
> +        timer->hpet_config = v;
> +        if (devp->hd_irq) {
> +            free_irq(devp->hd_irq, devp);
> +            devp->hd_irq = 0;
> +        }
> +        devp->hd_flags ^= HPET_IE;
> +        break;

do you really want to be freeing the irq outside of the open-close model?


> +    case HPET_INFO:
> +    {
> +        struct hpet_info        info;
> +
> +        info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
> +            devp->hd_ireqfreq);
> +        info.hi_flags = timer->hpet_config & Tn_PER_INT_CAP_MASK;
> +        if (copy_to_user((void *) arg, &info , sizeof (info)))
> +            err = -EFAULT;
> +        break;
> +    }
> +    case HPET_EPI:
> +        v = timer->hpet_config;
> +        if ((v & Tn_PER_INT_CAP_MASK) == 0) {
> +            err = -ENXIO;
> +            break;
> +        }
> +        devp->hd_flags |= HPET_PERIODIC;
> +        break;
> +    case HPET_DPI:
> +        v = timer->hpet_config;
> +        if ((v & Tn_PER_INT_CAP_MASK) == 0) {
> +            err = -ENXIO;
> +            break;
> +        }
> +        if (devp->hd_flags & HPET_PERIODIC &&
> +            timer->hpet_config & Tn_TYPE_CNF_MASK) {
> +            v = timer->hpet_config;
> +            v ^= Tn_TYPE_CNF_MASK;
> +            timer->hpet_config = v;
> +        }
> +        devp->hd_flags &= ~HPET_PERIODIC;
> +        break;
> +    case HPET_IRQFREQ:
> +        if (!kernel && (arg > hpet_max_freq) &&
> +            !capable(CAP_SYS_RESOURCE)) {
> +            err = -EACCES;
> +            break;
> +        }
> +
> +        if (arg & (arg - 1)) {
> +            err = -EINVAL;
> +            break;
> +        }
> +
> +        devp->hd_ireqfreq = hpet_time_div(hpetp->hp_period * arg);
> +    }
> +
> +    return err;
> +}
> +
> +static struct file_operations hpet_fops = {
> +    .owner        = THIS_MODULE,
> +    .llseek        = no_llseek,
> +    .read        = hpet_read,
> +    .poll        = hpet_poll,
> +    .ioctl        = hpet_ioctl,
> +    .open        = hpet_open,
> +    .release    = hpet_release,
> +    .fasync        = hpet_fasync,
> +    .mmap        = hpet_mmap,
> +};
> +
> +EXPORT_SYMBOL(hpet_alloc);
> +EXPORT_SYMBOL(hpet_register);
> +EXPORT_SYMBOL(hpet_unregister);
> +EXPORT_SYMBOL(hpet_control);
> +
> +int
> +hpet_register (struct hpet_task *tp, int periodic)
> +{
> +    unsigned int i;
> +    u64 mask;
> +    volatile struct hpet_timer *timer;
> +    struct hpet_dev *devp;
> +    struct hpets *hpetp;
> +
> +    switch (periodic) {
> +    case 1:
> +        mask = Tn_PER_INT_CAP_MASK;
> +        break;
> +    case 0:
> +        mask = 0;
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    spin_lock_irq(&hpet_task_lock);
> +    spin_lock(&hpet_lock);
> +
> +    for (devp = 0, hpetp = hpets; hpetp && !devp; hpetp = hpetp->hp_next)
> +    for (timer = hpetp->hp_hpet->hpet_timers, i = 0; i < 
> hpetp->hp_ntimer; i++, timer++) {
> +        if ((timer->hpet_config & Tn_PER_INT_CAP_MASK) != mask)
> +            continue;
> +
> +        devp = &hpetp->hp_dev[i];
> +
> +        if (devp->hd_flags & HPET_OPEN || devp->hd_task) {
> +            devp = 0;
> +            continue;
> +        }
> +
> +        tp->ht_opaque = devp;
> +        devp->hd_task = tp;
> +        break;
> +    }
> +
> +    spin_unlock(&hpet_lock);
> +    spin_unlock_irq(&hpet_task_lock);
> +
> +    if (tp->ht_opaque)
> +        return 0;
> +    else
> +        return -EBUSY;
> +}
> +
> +static inline int
> +hpet_tpcheck (struct hpet_task *tp)
> +{
> +    struct hpet_dev    *devp;
> +    struct hpets *hpetp;
> +
> +    devp = tp->ht_opaque;
> +
> +    if (!devp)
> +        return -ENXIO;
> +
> +    for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +        if (devp >= hpetp->hp_dev && devp < (hpetp->hp_dev + 
> hpetp->hp_ntimer) &&
> +            devp->hd_hpet == hpetp->hp_hpet)
> +            return 0;
> +
> +    return -ENXIO;
> +}
> +
> +
> +int
> +hpet_unregister (struct hpet_task *tp)
> +{
> +    struct hpet_dev    *devp;
> +    volatile struct hpet_timer *timer;
> +    int err;
> +
> +    if ((err = hpet_tpcheck(tp)))
> +        return err;
> +
> +    spin_lock_irq(&hpet_task_lock);
> +    spin_lock(&hpet_lock);
> +
> +    devp = tp->ht_opaque;
> +    if (devp->hd_task != tp) {
> +        spin_unlock(&hpet_lock);
> +        spin_unlock_irq(&hpet_task_lock);
> +        return -ENXIO;
> +    }
> +
> +    timer = devp->hd_timer;
> +    timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;
> +    devp->hd_flags &= ~( HPET_IE | HPET_PERIODIC);
> +    devp->hd_task = 0;
> +    spin_unlock(&hpet_lock);
> +    spin_unlock_irq(&hpet_task_lock);
> +
> +    return 0;
> +}
> +
> +int
> +hpet_control (struct hpet_task *tp, unsigned int cmd, unsigned long arg)
> +{
> +    struct hpet_dev    *devp;
> +    int err;
> +
> +    if ((err = hpet_tpcheck(tp)))
> +        return err;
> +
> +    spin_lock_irq(&hpet_lock);
> +    devp = tp->ht_opaque;
> +    if (devp->hd_task != tp) {
> +        spin_unlock_irq(&hpet_lock);
> +        return -ENXIO;
> +    }
> +    spin_unlock_irq(&hpet_lock);
> +    return hpet_ioctl_common(devp, cmd, arg, 1);
> +}
> +
> +
> +
> +#ifdef    CONFIG_TIME_INTERPOLATION
> +
> +static unsigned long hpet_offset, last_wall_hpet;
> +static long hpet_nsecs_per_cycle, hpet_cycles_per_sec;
> +
> +static unsigned long
> +hpet_getoffset (void)
> +{
> +    return hpet_offset + (hpets->hp_hpet->hpet_mc - last_wall_hpet) * 
> hpet_nsecs_per_cycle;
> +}
> +
> +static void
> +hpet_update (long delta)
> +{
> +    unsigned long mc;
> +    unsigned long offset;
> +    volatile struct hpet *hpet;
> +
> +    hpet = hpets->hp_hpet;
> +    mc = hpet->hpet_mc;
> +    offset = hpet_offset + (mc - last_wall_hpet) * hpet_nsecs_per_cycle;
> +
> +    if (delta < 0 || (unsigned long) delta < offset)
> +        hpet_offset = offset - delta;
> +    else
> +        hpet_offset = 0;
> +    last_wall_hpet = mc;
> +}
> +
> +static void
> +hpet_reset (void)
> +{
> +    volatile struct hpet *hpet;
> +
> +    hpet = hpets->hp_hpet;
> +    hpet_offset = 0;
> +    last_wall_hpet = hpet->hpet_mc;
> +}
> +
> +static struct time_interpolator hpet_interpolator = {
> +    .get_offset    =    hpet_getoffset,
> +    .update        =    hpet_update,
> +    .reset        =    hpet_reset
> +};
> +
> +#endif
> +
> +static ctl_table hpet_table[] = {
> +    {
> +        .ctl_name    = 1,
> +        .procname    = "max-user-freq",
> +        .data        = &hpet_max_freq,
> +        .maxlen        = sizeof(int),
> +        .mode        = 0644,
> +        .proc_handler    = &proc_dointvec,
> +    },
> +    { .ctl_name = 0 }
> +};
> +
> +static ctl_table hpet_root[] = {
> +    {
> +        .ctl_name    = 1,
> +        .procname    = "hpet",
> +        .maxlen        = 0,
> +        .mode        = 0555,
> +        .child        = hpet_table,
> +    },
> +    { .ctl_name = 0 }
> +};
> +
> +static ctl_table dev_root[] = {
> +    {
> +        .ctl_name    = CTL_DEV,
> +        .procname    = "dev",
> +        .maxlen        = 0,
> +        .mode        = 0555,
> +        .child        = hpet_root,
> +    },
> +    { .ctl_name = 0 }
> +};
> +
> +static struct ctl_table_header *sysctl_header;
> +
> +static void *
> +hpet_start (struct seq_file *s, loff_t *pos)
> +{
> +    struct hpets *hpetp;
> +    loff_t n;
> +
> +    for (n = *pos, hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +        if (!n--)
> +            return hpetp;
> +
> +    return 0;
> +}
> +
> +static void *
> +hpet_next (struct seq_file *s, void *v, loff_t *pos)
> +{
> +    struct hpets *hpetp;
> +
> +    hpetp = v;
> +    ++*pos;
> +    return hpetp->hp_next;
> +}
> +
> +static void
> +hpet_stop (struct seq_file *s, void *v)
> +{
> +    return;
> +}
> +
> +static int
> +hpet_show (struct seq_file *s, void *v)
> +{
> +    struct hpets *hpetp;
> +    volatile struct hpet *hpet;
> +    u64 cap, vendor, period;
> +
> +    hpetp = v;
> +    hpet = hpetp->hp_hpet;
> +
> +    cap = hpet->hpet_cap;
> +    period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> +        HPET_COUNTER_CLK_PERIOD_SHIFT;
> +    vendor = (cap & HPET_VENDOR_ID_MASK) >> HPET_VENDOR_ID_SHIFT;
> +
> +    seq_printf(s, "HPET%d period = %d 10**-15  vendor = 0x%x number 
> timer = %d\n",
> +        hpetp->hp_which, (u32) period, (u32) vendor, hpetp->hp_ntimer);
> +
> +    return 0;
> +}
> +
> +static struct seq_operations hpet_seq_ops = {
> +    .start    =    hpet_start,
> +    .next    =    hpet_next,
> +    .stop    =    hpet_stop,
> +    .show    =    hpet_show
> +};
> +
> +static int
> +hpet_proc_open (struct inode *inode, struct file *file)
> +{
> +    return seq_open(file, &hpet_seq_ops);
> +}
> +
> +static struct file_operations hpet_proc_fops = {
> +    .open        =    hpet_proc_open,
> +    .read        =    seq_read,
> +    .llseek        =    seq_lseek,
> +    .release    =    seq_release
> +};
> +
> +
> +/*
> + * Adjustment for when arming the timer with
> + * initial conditions.  That is, main counter
> + * ticks expired before interrupts are enabled.
> + */
> +#define    TICK_CALIBRATE    (1000UL)
> +
> +static unsigned long __init
> +hpet_calibrate (struct hpets *hpetp)
> +{
> +    volatile struct hpet_timer *timer;
> +    unsigned long t, m, count, i, flags, start;
> +    struct hpet_dev *devp;
> +    int j;
> +    volatile struct hpet *hpet;
> +
> +    for (timer = 0, j = 0, devp = hpetp->hp_dev;  j < hpetp->hp_ntimer; 
> j++, devp++)
> +        if ((devp->hd_flags & HPET_OPEN) == 0) {
> +            timer = devp->hd_timer;
> +            break;
> +        }
> +
> +    if (!timer)
> +        return 0;
> +
> +    hpet = hpets->hp_hpet;
> +    t = timer->hpet_compare;
> +
> +    i = 0;
> +    count = hpet_time_div(hpetp->hp_period * TICK_CALIBRATE);
> +
> +    local_irq_save(flags);
> +
> +    start = hpet->hpet_mc;
> +
> +    do {
> +        m = hpet->hpet_mc;
> +        timer->hpet_compare = t + m + hpetp->hp_delta;
> +    } while (i++, (m - start) <  count);
> +
> +    local_irq_restore(flags);
> +
> +    return (m - start) / i;
> +}
> +
> +static void __init
> +hpet_init_chrdev (void)
> +{
> +    static int once;
> +
> +    if (!once++ && register_chrdev(HPET_MAJOR, "hpet", &hpet_fops))
> +        panic("unable to to major %d for hpet device", HPET_MAJOR);
> +
> +    return;
> +}
> +
> +static void __init
> +hpet_post_platform (void)
> +{
> +    struct hpets *hpetp;
> +    u32 i, ntimer;
> +    struct hpet_dev    *devp;
> +
> +    hpet_init_chrdev();
> +
> +    for (ntimer = 0, hpetp = hpets; hpetp; hpetp = hpetp->hp_next, 
> ntimer++)
> +        for (i = 0, devp = hpetp->hp_dev;  i < hpetp->hp_ntimer; i++, 
> devp++) {
> +
> +            if (devp->hd_flags & HPET_OPEN)
> +                continue;
> +
> +            sprintf(&hpetname[5], "%d", ntimer);
> +            devfs_mk_cdev(MKDEV(HPET_MAJOR, ntimer),
> +                S_IFCHR|S_IRUSR|S_IWUSR, hpetname);
> +            init_waitqueue_head(&devp->hd_waitqueue);
> +        }
> +
> +    return;
> +}
> +
> +int __init
> +hpet_alloc (struct hpet_data *hdp)
> +{
> +    u64 cap, mcfg;
> +    struct hpet_dev    *devp;
> +    u32 i, ntimer;
> +    struct hpets *hpetp;
> +    size_t siz;
> +    volatile struct hpet *hpet;
> +    static struct hpets *last __initdata = (struct hpets *) 0;
> +
> +    for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +        if (hpetp->hp_hpet == (struct hpet *) (hdp->hd_address))
> +            return 0;
> +
> +    siz = sizeof (struct hpets) + ((hdp->hd_nirqs - 1) *
> +        sizeof (struct hpet_dev));
> +
> +    hpetp = kmalloc(siz, GFP_KERNEL);
> +
> +    if (!hpetp)
> +        return -ENOMEM;
> +
> +    memset(hpetp, 0, siz);
> +
> +    hpetp->hp_which = hpet_nhpet++;
> +    hpetp->hp_hpet = (struct hpet *) hdp->hd_address;
> +
> +    if (last)
> +        last->hp_next = hpetp;
> +    else
> +        hpets = hpetp;
> +
> +    last = hpetp;
> +
> +    hpetp->hp_ntimer = hdp->hd_nirqs;
> +
> +    for (i = 0; i < hdp->hd_nirqs; i++)
> +        hpetp->hp_dev[i].hd_hdwirq = hdp->hd_irq[i];
> +
> +    hpet = hpetp->hp_hpet;
> +
> +    cap = hpet->hpet_cap;
> +
> +    ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) 
> + 1;
> +
> +    if (!ntimer) {
> +        printk(KERN_WARNING "hpet: no timers in config data\n");
> +        return -ENODEV;
> +    }
> +    else if (hpetp->hp_ntimer != ntimer) {
> +        printk(KERN_WARNING "hpet: number irqs doesn't agree"
> +            " with number of timers\n");
> +        return -ENODEV;
> +    }
> +
> +    hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> +        HPET_COUNTER_CLK_PERIOD_SHIFT;
> +
> +    mcfg = hpet->hpet_config;
> +    if ((mcfg & HPET_ENABLE_CNF_MASK) == 0) {
> +        hpet->hpet_mc = 0L;
> +        mcfg |= HPET_ENABLE_CNF_MASK;
> +        hpet->hpet_config = mcfg;
> +    }
> +
> +    /*
> +     * Create character devices and init wait queue.
> +     * If this is a platform call, then device initialization
> +     * occurs during startup call to hpet_init.
> +     */
> +    if (hdp->hd_flags ^ HPET_DATA_PLATFORM)
> +        hpet_init_chrdev();
> +
> +    for (i = 0, devp = hpetp->hp_dev;  i < hpetp->hp_ntimer; i++, 
> hpet_ntimer++, devp++) {
> +        unsigned long v;
> +        volatile struct hpet_timer *timer;
> +
> +        timer = &hpet->hpet_timers[devp - hpetp->hp_dev];
> +        v = timer->hpet_config;
> +
> +        devp->hd_hpets = hpetp;
> +        devp->hd_hpet = hpet;
> +        devp->hd_timer = timer;
> +
> +        devp->hd_minor = hpet_ntimer;
> +
> +        if (hdp->hd_state & (1 << i)) {
> +            devp->hd_flags = HPET_OPEN;
> +            continue;
> +        }
> +
> +        if (hdp->hd_flags & HPET_DATA_PLATFORM)
> +            continue;
> +
> +        sprintf(&hpetname[5], "%d", hpet_ntimer);
> +        devfs_mk_cdev(MKDEV(HPET_MAJOR, hpet_ntimer),
> +            S_IFCHR|S_IRUSR|S_IWUSR, hpetname);
> +        init_waitqueue_head(&devp->hd_waitqueue);
> +    }
> +
> +    hpetp->hp_delta = hpet_calibrate(hpetp);
> +
> +    return 0;
> +}
> +
> +static acpi_status __init
> +hpet_resources (struct acpi_resource *res, void *data)
> +{
> +    struct hpet_data *hdp;
> +    acpi_status status;
> +    struct acpi_resource_address64 addr;
> +    struct hpets *hpetp;
> +
> +    hdp = data;
> +
> +    status = acpi_resource_to_address64(res, &addr);
> +
> +    if (ACPI_SUCCESS(status)) {
> +        unsigned long size;
> +
> +        size = addr.max_address_range - addr.min_address_range + 1;
> +        hdp->hd_address = (unsigned long) 
> ioremap(addr.min_address_range, size);
> +
> +        for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
> +            if (hpetp->hp_hpet == (struct hpet *) (hdp->hd_address))
> +                return -EBUSY;
> +    }
> +    else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
> +        struct acpi_resource_ext_irq *irqp;
> +        int i;
> +
> +        irqp = &res->data.extended_irq;
> +
> +        if (irqp->number_of_interrupts > 0) {
> +            hdp->hd_nirqs = irqp->number_of_interrupts;
> +
> +            for (i = 0; i < hdp->hd_nirqs; i++)
> +#ifdef    CONFIG_IA64
> +                hdp->hd_irq[i] = acpi_register_irq(irqp->interrupts[i],
> +                            irqp->active_high_low, irqp->edge_level);
> +#else
> +                hdp->hd_irq[i] = irqp->interrupts[i];
> +#endif
> +        }
> +    }
> +
> +    return AE_OK;
> +}
> +
> +static int __init
> +hpet_acpi_add (struct acpi_device *device)
> +{
> +    acpi_status result;
> +    struct hpet_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +
> +    result = acpi_walk_resources(device->handle, METHOD_NAME__CRS, 
> hpet_resources, &data);
> +
> +    if (ACPI_FAILURE(result))
> +        return -ENODEV;
> +
> +    if (!data.hd_address || !data.hd_nirqs) {
> +        printk("%s: no address or irqs in _CRS\n", __FUNCTION__);
> +        return -ENODEV;
> +    }
> +
> +    return hpet_alloc(&data);
> +}
> +
> +static int __init
> +hpet_acpi_remove (struct acpi_device *device, int type)
> +{
> +    return 0;
> +}
> +
> +static struct acpi_driver hpet_acpi_driver __initdata = {
> +    .name    =    "hpet",
> +    .class    =    "",
> +    .ids    =    "PNP0103",
> +    .ops = {
> +        .add    =    hpet_acpi_add,
> +        .remove    =    hpet_acpi_remove,
> +    },
> +};
> +
> +
> +
> +static int __init
> +hpet_init (void)
> +{
> +    struct proc_dir_entry *entry;
> +
> +    if (hpets)
> +        hpet_post_platform();
> +
> +    (void) acpi_bus_register_driver(&hpet_acpi_driver);
> +
> +    if (hpets) {
> +        entry = create_proc_entry("driver/hpet", 0, 0);
> +
> +        if (entry)
> +            entry->proc_fops = &hpet_proc_fops;
> +
> +        sysctl_header = register_sysctl_table(dev_root, 0);
> +
> +#ifdef    CONFIG_TIME_INTERPOLATION
> +        {
> +            volatile struct hpet    *hpet;
> +
> +            hpet = hpets->hp_hpet;
> +            hpet_cycles_per_sec = hpet_time_div(hpets->hp_period);
> +            hpet_interpolator.frequency = hpet_cycles_per_sec;
> +            hpet_interpolator.drift = hpet_cycles_per_sec *
> +                HPET_DRIFT / 1000000;
> +            hpet_nsecs_per_cycle = 1000000000 / hpet_cycles_per_sec;
> +            register_time_interpolator(&hpet_interpolator);
> +        }
> +#endif
> +        return 0;
> +    }
> +    else
> +        return -ENODEV;
> +}
> +
> +static void __exit
> +hpet_exit (void)
> +{
> +    acpi_bus_unregister_driver(&hpet_acpi_driver);
> +
> +    if (hpets) {
> +        unregister_sysctl_table(sysctl_header);
> +        remove_proc_entry("driver/hpet", NULL);
> +    }
> +
> +    return;
> +}

Finally, would prefer sysfs use to procfs.

No major objections though.

	Jeff



