Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUEQWjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUEQWjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUEQWjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:39:10 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:42504 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262874AbUEQWdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:33:06 -0400
Message-ID: <40A93DA5.4020701@hp.com>
Date: Mon, 17 May 2004 18:33:09 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com>
In-Reply-To: <40A40204.1060509@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All issues hopefully addressed below.  Another patch with diffs against 
-mm3.

>
> run this through Lindent... non-standard indentation 

Done. 
...

>
> kill the 'volatile', it's preferred to put barriers and such in the 
> code where they are needed. 

O.K.  Did this but had to add a writeq and readq for i386.
...

>
>>
>> +static int
>> +hpet_open (struct inode *inode, struct file *file)
>> +{
>> +    struct hpet_dev *devp;
>> +
>> +    devp = hpet_minor_to_dev(MINOR(inode->i_rdev));
>
>
> locking of hpets? 

Not sure what you are getting at here.  hpets can't really change in 
number after boot initialization.

>
>
>
>> +    vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
>> +    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +    addr = __pa(addr);
>
>
> where did these flags come from?  don't you just want VM_RESERVED? 

Changed to just VM_IO.

>
>
>
>> +    if (remap_page_range(vma, vma->vm_start, addr, PAGE_SIZE, 
>> vma->vm_page_prot)) {
>> +        printk(KERN_ERR "remap_page_range failed in hpet.c\n");
>> +        return -EAGAIN;
>> +    }
>
>
> why not ->nopage like in sound/oss/via82cxxx_audio.c? 

I just modelled after what is done by other drivers in kernel. 
...

>
>>
>> +        devp->hd_flags ^= HPET_IE;
>> +        break;
>
>
> do you really want to be freeing the irq outside of the open-close 
> model?  


Well it seemed complete to allocate the irq and free it when it is no 
longer required.  I can't see how it would be dangerous.  Perhaps I'm 
missing the point.
....

>
> Finally, would prefer sysfs use to procfs. 

I can look to changing it over to sysfs in future.  For now I'd like to 
keep procfs. 

>
>
> No major objections though.
>
>     Jeff 

The drivers/char/Kconfig changes will fix the x86_64 build problem with 
-mm3.  Should this patch be acceptable,
then I really need to ask Venki to test once more on his i386/HPET 
hardware to be sure nothing is broken there.

thanks,

Bob

diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-mm3/Documentation/filesystems/proc.txt linux-2.6.6-mm3-hpet/Documentation/filesystems/proc.txt
--- linux-2.6.6-mm3/Documentation/filesystems/proc.txt	2004-05-17 10:32:24.000000000 -0400
+++ linux-2.6.6-mm3-hpet/Documentation/filesystems/proc.txt	2004-05-17 14:23:26.000000000 -0400
@@ -201,7 +201,7 @@
  devices     Available devices (block and character)           
  dma         Used DMS channels                                 
  filesystems Supported filesystems                             
- driver	     Various drivers grouped here, currently rtc	(2.4)
+ driver	     Various drivers grouped here, currently rtc (2.4) and hpet (2.6)
  execdomains Execdomains, related to security			(2.4)
  fb	     Frame Buffer devices				(2.4)
  fs	     File system parameters, currently nfs/exports	(2.4)
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-mm3/drivers/char/hpet.c linux-2.6.6-mm3-hpet/drivers/char/hpet.c
--- linux-2.6.6-mm3/drivers/char/hpet.c	2004-05-17 10:32:25.000000000 -0400
+++ linux-2.6.6-mm3-hpet/drivers/char/hpet.c	2004-05-17 14:08:35.000000000 -0400
@@ -52,39 +52,60 @@
 static spinlock_t hpet_task_lock = SPIN_LOCK_UNLOCKED;
 
 struct hpet_dev {
-	struct hpets		*hd_hpets;
-	volatile struct hpet	*hd_hpet;
-	volatile struct hpet_timer
-				*hd_timer;
-	unsigned long		hd_ireqfreq;
-	unsigned long		hd_irqdata;
-	wait_queue_head_t	hd_waitqueue;
-	struct fasync_struct	*hd_async_queue;
-	struct hpet_task	*hd_task;
-	unsigned int		hd_flags;
-	unsigned int		hd_irq;
-	unsigned int		hd_hdwirq;
-	int			hd_minor;
+	struct hpets *hd_hpets;
+	struct hpet *hd_hpet;
+	struct hpet_timer *hd_timer;
+	unsigned long hd_ireqfreq;
+	unsigned long hd_irqdata;
+	wait_queue_head_t hd_waitqueue;
+	struct fasync_struct *hd_async_queue;
+	struct hpet_task *hd_task;
+	unsigned int hd_flags;
+	unsigned int hd_irq;
+	unsigned int hd_hdwirq;
+	int hd_minor;
 };
 
 struct hpets {
-	struct hpets		*hp_next;
-	volatile struct hpet	*hp_hpet;
-	unsigned long		hp_period;
-	unsigned long		hp_delta;
-	unsigned int		hp_ntimer;
-	unsigned int		hp_which;
-	struct hpet_dev		hp_dev[1];
+	struct hpets *hp_next;
+	struct hpet *hp_hpet;
+	unsigned long hp_period;
+	unsigned long hp_delta;
+	unsigned int hp_ntimer;
+	unsigned int hp_which;
+	struct hpet_dev hp_dev[1];
 };
 
 static struct hpets *hpets;
 
 #define	HPET_OPEN		0x0001
-#define	HPET_IE			0x0002			/* interrupt enabled */
+#define	HPET_IE			0x0002	/* interrupt enabled */
 #define	HPET_PERIODIC		0x0004
 
-static irqreturn_t
-hpet_interrupt (int irq, void *data, struct pt_regs *regs)
+#if BITS_PER_LONG == 64
+#define	write_counter(V, MC)	writeq(V, MC)
+#define	read_counter(MC)	readq(MC)
+#else
+#define	write_counter(V, MC) 	writel(V, MC)
+#define	read_counter(MC)	readl(MC)
+#endif
+
+#ifndef readq
+static unsigned long long __inline readq(void *addr)
+{
+	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
+}
+#endif
+
+#ifndef writeq
+static void __inline writeq(unsigned long long v, void *addr)
+{
+	writel(v & 0xffffffff, addr);
+	writel(v >> 32, addr + 4);
+}
+#endif
+
+static irqreturn_t hpet_interrupt(int irq, void *data, struct pt_regs *regs)
 {
 	struct hpet_dev *devp;
 	unsigned long isr;
@@ -94,16 +115,21 @@
 	spin_lock(&hpet_lock);
 	devp->hd_irqdata++;
 
+	/*
+	 * For non-periodic timers, increment the accumulator.
+	 * This has the effect of treating non-periodic like periodic.
+	 */
 	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
 		unsigned long m, t;
 
 		t = devp->hd_ireqfreq;
-		m = devp->hd_hpet->hpet_mc;
-		devp->hd_timer->hpet_compare = t + m + devp->hd_hpets->hp_delta;
+		m = read_counter(&devp->hd_hpet->hpet_mc);
+		write_counter(t + m + devp->hd_hpets->hp_delta,
+			      &devp->hd_timer->hpet_compare);
 	}
 
 	isr = (1 << (devp - devp->hd_hpets->hp_dev));
-	devp->hd_hpet->hpet_isr = isr;
+	writeq(isr, &devp->hd_hpet->hpet_isr);
 	spin_unlock(&hpet_lock);
 
 	spin_lock(&hpet_task_lock);
@@ -118,21 +144,19 @@
 	return IRQ_HANDLED;
 }
 
-static struct hpet_dev *
-hpet_minor_to_dev (int minor)
+static struct hpet_dev *hpet_minor_to_dev(int minor)
 {
 	struct hpets *hpetp;
 	int i;
 
 	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-		for (i = 0; i <  hpetp->hp_ntimer; i++)
+		for (i = 0; i < hpetp->hp_ntimer; i++)
 			if (hpetp->hp_dev[i].hd_minor == minor)
 				return &hpetp->hp_dev[i];
 	return 0;
 }
 
-static int
-hpet_open (struct inode *inode, struct file *file)
+static int hpet_open(struct inode *inode, struct file *file)
 {
 	struct hpet_dev *devp;
 
@@ -142,7 +166,7 @@
 		return -ENODEV;
 
 	spin_lock_irq(&hpet_lock);
-	if (devp->hd_flags &  HPET_OPEN || devp->hd_task) {
+	if (devp->hd_flags & HPET_OPEN || devp->hd_task) {
 		spin_unlock_irq(&hpet_lock);
 		return -EBUSY;
 	}
@@ -156,18 +180,18 @@
 }
 
 static ssize_t
-hpet_read (struct file *file, char *buf, size_t count, loff_t *ppos)
+hpet_read(struct file *file, char *buf, size_t count, loff_t * ppos)
 {
-	DECLARE_WAITQUEUE(wait,current);
+	DECLARE_WAITQUEUE(wait, current);
 	unsigned long data;
-	ssize_t	retval;
-	struct hpet_dev	*devp;
+	ssize_t retval;
+	struct hpet_dev *devp;
 
 	devp = file->private_data;
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
-	if (count < sizeof (unsigned long))
+	if (count < sizeof(unsigned long))
 		return -EINVAL;
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
@@ -192,23 +216,22 @@
 
 		schedule();
 
-	} while(1);
+	} while (1);
 
-	retval = put_user(data, (unsigned long *) buf);
+	retval = put_user(data, (unsigned long *)buf);
 	if (!retval)
-		retval = sizeof (unsigned long);
-out:
+		retval = sizeof(unsigned long);
+      out:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
 
 	return retval;
 }
 
-static unsigned int
-hpet_poll (struct file *file, poll_table *wait)
+static unsigned int hpet_poll(struct file *file, poll_table * wait)
 {
 	unsigned long v;
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 
 	devp = file->private_data;
 
@@ -227,13 +250,12 @@
 	return 0;
 }
 
-static int
-hpet_mmap (struct file *file, struct vm_area_struct *vma)
+static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
 {
 #ifdef	CONFIG_HPET_NOMMAP
 	return -ENOSYS;
 #else
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 	unsigned long addr;
 
 	if (((vma->vm_end - vma->vm_start) != PAGE_SIZE) || vma->vm_pgoff)
@@ -243,16 +265,17 @@
 		return -EPERM;
 
 	devp = file->private_data;
-	addr = (unsigned long) devp->hd_hpet;
+	addr = (unsigned long)devp->hd_hpet;
 
 	if (addr & (PAGE_SIZE - 1))
 		return -ENOSYS;
 
-	vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	addr = __pa(addr);
 
-	if (remap_page_range(vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
+	if (remap_page_range
+	    (vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
 		printk(KERN_ERR "remap_page_range failed in hpet.c\n");
 		return -EAGAIN;
 	}
@@ -261,10 +284,9 @@
 #endif
 }
 
-static int
-hpet_fasync (int fd, struct file *file, int on)
+static int hpet_fasync(int fd, struct file *file, int on)
 {
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 
 	devp = file->private_data;
 
@@ -274,18 +296,18 @@
 		return -EIO;
 }
 
-static int
-hpet_release (struct inode *inode, struct file *file)
+static int hpet_release(struct inode *inode, struct file *file)
 {
-	struct hpet_dev	*devp;
-	volatile struct hpet_timer *timer;
+	struct hpet_dev *devp;
+	struct hpet_timer *timer;
 
 	devp = file->private_data;
 	timer = devp->hd_timer;
 
 	spin_lock_irq(&hpet_lock);
 
-	timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;
+	writeq((readq(&timer->hpet_config) & ~Tn_INT_ENB_CNF_MASK),
+	       &timer->hpet_config);
 
 	if (devp->hd_irq) {
 		free_irq(devp->hd_irq, devp);
@@ -294,12 +316,13 @@
 
 	devp->hd_ireqfreq = 0;
 
-	if (devp->hd_flags & HPET_PERIODIC && timer->hpet_config & Tn_TYPE_CNF_MASK) {
+	if (devp->hd_flags & HPET_PERIODIC
+	    && readq(&timer->hpet_config) & Tn_TYPE_CNF_MASK) {
 		unsigned long v;
 
-		v = timer->hpet_config;
+		v = readq(&timer->hpet_config);
 		v ^= Tn_TYPE_CNF_MASK;
-		timer->hpet_config = v;
+		writeq(v, &timer->hpet_config);
 	}
 
 	devp->hd_flags &= ~(HPET_OPEN | HPET_IE | HPET_PERIODIC);
@@ -315,19 +338,19 @@
 static int hpet_ioctl_common(struct hpet_dev *, int, unsigned long, int);
 
 static int
-hpet_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+hpet_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	   unsigned long arg)
 {
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 
 	devp = file->private_data;
 	return hpet_ioctl_common(devp, cmd, arg, 0);
 }
 
-static int
-hpet_ioctl_ieon (struct hpet_dev *devp)
+static int hpet_ioctl_ieon(struct hpet_dev *devp)
 {
-	volatile struct hpet_timer *timer;
-	volatile struct hpet *hpet;
+	struct hpet_timer *timer;
+	struct hpet *hpet;
 	struct hpets *hpetp;
 	int irq;
 	unsigned long g, v, t, m;
@@ -337,7 +360,7 @@
 	hpet = devp->hd_hpet;
 	hpetp = devp->hd_hpets;
 
-	v = timer->hpet_config;
+	v = readq(&timer->hpet_config);
 	spin_lock_irq(&hpet_lock);
 
 	if (devp->hd_flags & HPET_IE) {
@@ -348,15 +371,16 @@
 	devp->hd_flags |= HPET_IE;
 	spin_unlock_irq(&hpet_lock);
 
-	t = timer->hpet_config;
+	t = readq(&timer->hpet_config);
 	irq = devp->hd_hdwirq;
 
 	if (irq) {
 		char name[7];
 
-		sprintf(name, "hpet%d", (int) (devp - hpetp->hp_dev));
+		sprintf(name, "hpet%d", (int)(devp - hpetp->hp_dev));
 
-		if (request_irq(irq, hpet_interrupt, SA_INTERRUPT, name, (void *) devp)) {
+		if (request_irq
+		    (irq, hpet_interrupt, SA_INTERRUPT, name, (void *)devp)) {
 			printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
 			irq = 0;
 		}
@@ -371,48 +395,47 @@
 
 	devp->hd_irq = irq;
 	t = devp->hd_ireqfreq;
-	v = timer->hpet_config;
+	v = readq(&timer->hpet_config);
 	g = v | Tn_INT_ENB_CNF_MASK;
 
 	if (devp->hd_flags & HPET_PERIODIC) {
-		timer->hpet_compare = t;
+		write_counter(t, &timer->hpet_compare);
 		g |= Tn_TYPE_CNF_MASK;
 		v |= Tn_TYPE_CNF_MASK;
-		timer->hpet_config = v;
+		writeq(v, &timer->hpet_config);
 		v |= Tn_VAL_SET_CNF_MASK;
-		timer->hpet_config = v;
+		writeq(v, &timer->hpet_config);
 		local_irq_save(flags);
-		m = hpet->hpet_mc;
-		timer->hpet_compare = t + m + hpetp->hp_delta;
+		m = read_counter(&hpet->hpet_mc);
+		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
 	} else {
 		local_irq_save(flags);
-		m = hpet->hpet_mc;
-		timer->hpet_compare = t + m + hpetp->hp_delta;
+		m = read_counter(&hpet->hpet_mc);
+		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
 	}
 
 	isr = (1 << (devp - hpets->hp_dev));
-	hpet->hpet_isr = isr;
-	timer->hpet_config = g;
+	writeq(isr, &hpet->hpet_isr);
+	writeq(g, &timer->hpet_config);
 	local_irq_restore(flags);
 
 	return 0;
 }
 
-static inline unsigned long
-hpet_time_div (unsigned long dis)
+static inline unsigned long hpet_time_div(unsigned long dis)
 {
 	unsigned long long m = 1000000000000000ULL;
 
 	do_div(m, dis);
 
-	return (unsigned long) m;
+	return (unsigned long)m;
 }
 
 static int
-hpet_ioctl_common (struct hpet_dev *devp, int cmd, unsigned long arg, int kernel)
+hpet_ioctl_common(struct hpet_dev *devp, int cmd, unsigned long arg, int kernel)
 {
-	volatile struct hpet_timer *timer;
-	volatile struct hpet *hpet;
+	struct hpet_timer *timer;
+	struct hpet *hpet;
 	struct hpets *hpetp;
 	int err;
 	unsigned long v;
@@ -439,9 +462,9 @@
 	case HPET_IE_OFF:
 		if ((devp->hd_flags & HPET_IE) == 0)
 			break;
-		v = timer->hpet_config;
+		v = readq(&timer->hpet_config);
 		v &= ~Tn_INT_ENB_CNF_MASK;
-		timer->hpet_config = v;
+		writeq(v, &timer->hpet_config);
 		if (devp->hd_irq) {
 			free_irq(devp->hd_irq, devp);
 			devp->hd_irq = 0;
@@ -449,18 +472,19 @@
 		devp->hd_flags ^= HPET_IE;
 		break;
 	case HPET_INFO:
-	{
-		struct hpet_info		info;
+		{
+			struct hpet_info info;
 
-		info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
-			devp->hd_ireqfreq);
-		info.hi_flags = timer->hpet_config & Tn_PER_INT_CAP_MASK;
-		if (copy_to_user((void *) arg, &info , sizeof (info)))
-			err = -EFAULT;
-		break;
-	}
+			info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
+							 devp->hd_ireqfreq);
+			info.hi_flags =
+			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
+			if (copy_to_user((void *)arg, &info, sizeof(info)))
+				err = -EFAULT;
+			break;
+		}
 	case HPET_EPI:
-		v = timer->hpet_config;
+		v = readq(&timer->hpet_config);
 		if ((v & Tn_PER_INT_CAP_MASK) == 0) {
 			err = -ENXIO;
 			break;
@@ -468,22 +492,22 @@
 		devp->hd_flags |= HPET_PERIODIC;
 		break;
 	case HPET_DPI:
-		v = timer->hpet_config;
+		v = readq(&timer->hpet_config);
 		if ((v & Tn_PER_INT_CAP_MASK) == 0) {
 			err = -ENXIO;
 			break;
 		}
 		if (devp->hd_flags & HPET_PERIODIC &&
-			timer->hpet_config & Tn_TYPE_CNF_MASK) {
-			v = timer->hpet_config;
+		    readq(&timer->hpet_config) & Tn_TYPE_CNF_MASK) {
+			v = readq(&timer->hpet_config);
 			v ^= Tn_TYPE_CNF_MASK;
-			timer->hpet_config = v;
+			writeq(v, &timer->hpet_config);
 		}
 		devp->hd_flags &= ~HPET_PERIODIC;
 		break;
 	case HPET_IRQFREQ:
 		if (!kernel && (arg > hpet_max_freq) &&
-			!capable(CAP_SYS_RESOURCE)) {
+		    !capable(CAP_SYS_RESOURCE)) {
 			err = -EACCES;
 			break;
 		}
@@ -500,15 +524,15 @@
 }
 
 static struct file_operations hpet_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.read		= hpet_read,
-	.poll		= hpet_poll,
-	.ioctl		= hpet_ioctl,
-	.open		= hpet_open,
-	.release	= hpet_release,
-	.fasync		= hpet_fasync,
-	.mmap		= hpet_mmap,
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = hpet_read,
+	.poll = hpet_poll,
+	.ioctl = hpet_ioctl,
+	.open = hpet_open,
+	.release = hpet_release,
+	.fasync = hpet_fasync,
+	.mmap = hpet_mmap,
 };
 
 EXPORT_SYMBOL(hpet_alloc);
@@ -516,12 +540,11 @@
 EXPORT_SYMBOL(hpet_unregister);
 EXPORT_SYMBOL(hpet_control);
 
-int
-hpet_register (struct hpet_task *tp, int periodic)
+int hpet_register(struct hpet_task *tp, int periodic)
 {
 	unsigned int i;
 	u64 mask;
-	volatile struct hpet_timer *timer;
+	struct hpet_timer *timer;
 	struct hpet_dev *devp;
 	struct hpets *hpetp;
 
@@ -540,21 +563,23 @@
 	spin_lock(&hpet_lock);
 
 	for (devp = 0, hpetp = hpets; hpetp && !devp; hpetp = hpetp->hp_next)
-	for (timer = hpetp->hp_hpet->hpet_timers, i = 0; i < hpetp->hp_ntimer; i++, timer++) {
-		if ((timer->hpet_config & Tn_PER_INT_CAP_MASK) != mask)
-			continue;
+		for (timer = hpetp->hp_hpet->hpet_timers, i = 0;
+		     i < hpetp->hp_ntimer; i++, timer++) {
+			if ((readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK)
+			    != mask)
+				continue;
 
-		devp = &hpetp->hp_dev[i];
+			devp = &hpetp->hp_dev[i];
 
-		if (devp->hd_flags & HPET_OPEN || devp->hd_task) {
-			devp = 0;
-			continue;
-		}
+			if (devp->hd_flags & HPET_OPEN || devp->hd_task) {
+				devp = 0;
+				continue;
+			}
 
-		tp->ht_opaque = devp;
-		devp->hd_task = tp;
-		break;
-	}
+			tp->ht_opaque = devp;
+			devp->hd_task = tp;
+			break;
+		}
 
 	spin_unlock(&hpet_lock);
 	spin_unlock_irq(&hpet_task_lock);
@@ -565,10 +590,9 @@
 		return -EBUSY;
 }
 
-static inline int
-hpet_tpcheck (struct hpet_task *tp)
+static inline int hpet_tpcheck(struct hpet_task *tp)
 {
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 	struct hpets *hpetp;
 
 	devp = tp->ht_opaque;
@@ -577,19 +601,18 @@
 		return -ENXIO;
 
 	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-		if (devp >= hpetp->hp_dev && devp < (hpetp->hp_dev + hpetp->hp_ntimer) &&
-			devp->hd_hpet == hpetp->hp_hpet)
+		if (devp >= hpetp->hp_dev
+		    && devp < (hpetp->hp_dev + hpetp->hp_ntimer)
+		    && devp->hd_hpet == hpetp->hp_hpet)
 			return 0;
 
 	return -ENXIO;
 }
 
-
-int
-hpet_unregister (struct hpet_task *tp)
+int hpet_unregister(struct hpet_task *tp)
 {
-	struct hpet_dev	*devp;
-	volatile struct hpet_timer *timer;
+	struct hpet_dev *devp;
+	struct hpet_timer *timer;
 	int err;
 
 	if ((err = hpet_tpcheck(tp)))
@@ -606,8 +629,9 @@
 	}
 
 	timer = devp->hd_timer;
-	timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;
-	devp->hd_flags &= ~( HPET_IE | HPET_PERIODIC);
+	writeq((readq(&timer->hpet_config) & ~Tn_INT_ENB_CNF_MASK),
+	       &timer->hpet_config);
+	devp->hd_flags &= ~(HPET_IE | HPET_PERIODIC);
 	devp->hd_task = 0;
 	spin_unlock(&hpet_lock);
 	spin_unlock_irq(&hpet_task_lock);
@@ -615,10 +639,9 @@
 	return 0;
 }
 
-int
-hpet_control (struct hpet_task *tp, unsigned int cmd, unsigned long arg)
+int hpet_control(struct hpet_task *tp, unsigned int cmd, unsigned long arg)
 {
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 	int err;
 
 	if ((err = hpet_tpcheck(tp)))
@@ -634,93 +657,83 @@
 	return hpet_ioctl_common(devp, cmd, arg, 1);
 }
 
-
-
 #ifdef	CONFIG_TIME_INTERPOLATION
 
 static unsigned long hpet_offset, last_wall_hpet;
 static long hpet_nsecs_per_cycle, hpet_cycles_per_sec;
 
-static unsigned long
-hpet_getoffset (void)
+static unsigned long hpet_getoffset(void)
 {
-	return hpet_offset + (hpets->hp_hpet->hpet_mc - last_wall_hpet) * hpet_nsecs_per_cycle;
+	return hpet_offset + (read_counter(&hpets->hp_hpet->hpet_mc) -
+			      last_wall_hpet) * hpet_nsecs_per_cycle;
 }
 
-static void
-hpet_update (long delta)
+static void hpet_update(long delta)
 {
 	unsigned long mc;
 	unsigned long offset;
-	volatile struct hpet *hpet;
 
-	hpet = hpets->hp_hpet;
-	mc = hpet->hpet_mc;
+	mc = read_counter(&hpets->hp_hpet->hpet_mc);
 	offset = hpet_offset + (mc - last_wall_hpet) * hpet_nsecs_per_cycle;
 
-	if (delta < 0 || (unsigned long) delta < offset)
+	if (delta < 0 || (unsigned long)delta < offset)
 		hpet_offset = offset - delta;
 	else
 		hpet_offset = 0;
 	last_wall_hpet = mc;
 }
 
-static void
-hpet_reset (void)
+static void hpet_reset(void)
 {
-	volatile struct hpet *hpet;
-
-	hpet = hpets->hp_hpet;
 	hpet_offset = 0;
-	last_wall_hpet = hpet->hpet_mc;
+	last_wall_hpet = read_counter(&hpets->hp_hpet->hpet_mc);
 }
 
 static struct time_interpolator hpet_interpolator = {
-	.get_offset	=	hpet_getoffset,
-	.update		=	hpet_update,
-	.reset		=	hpet_reset
+	.get_offset = hpet_getoffset,
+	.update = hpet_update,
+	.reset = hpet_reset
 };
 
 #endif
 
 static ctl_table hpet_table[] = {
 	{
-		.ctl_name	= 1,
-		.procname	= "max-user-freq",
-		.data		= &hpet_max_freq,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{ .ctl_name = 0 }
+	 .ctl_name = 1,
+	 .procname = "max-user-freq",
+	 .data = &hpet_max_freq,
+	 .maxlen = sizeof(int),
+	 .mode = 0644,
+	 .proc_handler = &proc_dointvec,
+	 },
+	{.ctl_name = 0}
 };
 
 static ctl_table hpet_root[] = {
 	{
-		.ctl_name	= 1,
-		.procname	= "hpet",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= hpet_table,
-	},
-	{ .ctl_name = 0 }
+	 .ctl_name = 1,
+	 .procname = "hpet",
+	 .maxlen = 0,
+	 .mode = 0555,
+	 .child = hpet_table,
+	 },
+	{.ctl_name = 0}
 };
 
 static ctl_table dev_root[] = {
 	{
-		.ctl_name	= CTL_DEV,
-		.procname	= "dev",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= hpet_root,
-	},
-	{ .ctl_name = 0 }
+	 .ctl_name = CTL_DEV,
+	 .procname = "dev",
+	 .maxlen = 0,
+	 .mode = 0555,
+	 .child = hpet_root,
+	 },
+	{.ctl_name = 0}
 };
 
 static struct ctl_table_header *sysctl_header;
 
-static void *
-hpet_start (struct seq_file *s, loff_t *pos)
+static void *hpet_start(struct seq_file *s, loff_t * pos)
 {
 	struct hpets *hpetp;
 	loff_t n;
@@ -732,8 +745,7 @@
 	return 0;
 }
 
-static void *
-hpet_next (struct seq_file *s, void *v, loff_t *pos)
+static void *hpet_next(struct seq_file *s, void *v, loff_t * pos)
 {
 	struct hpets *hpetp;
 
@@ -742,54 +754,52 @@
 	return hpetp->hp_next;
 }
 
-static void
-hpet_stop (struct seq_file *s, void *v)
+static void hpet_stop(struct seq_file *s, void *v)
 {
 	return;
 }
 
-static int
-hpet_show (struct seq_file *s, void *v)
+static int hpet_show(struct seq_file *s, void *v)
 {
 	struct hpets *hpetp;
-	volatile struct hpet *hpet;
+	struct hpet *hpet;
 	u64 cap, vendor, period;
 
 	hpetp = v;
 	hpet = hpetp->hp_hpet;
 
-	cap = hpet->hpet_cap;
+	cap = readq(&hpet->hpet_cap);
 	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-		HPET_COUNTER_CLK_PERIOD_SHIFT;
+	    HPET_COUNTER_CLK_PERIOD_SHIFT;
 	vendor = (cap & HPET_VENDOR_ID_MASK) >> HPET_VENDOR_ID_SHIFT;
 
-	seq_printf(s, "HPET%d period = %d 10**-15  vendor = 0x%x number timer = %d\n",
-		hpetp->hp_which, (u32) period, (u32) vendor, hpetp->hp_ntimer);
+	seq_printf(s,
+		   "HPET%d period = %d 10**-15  vendor = 0x%x number timer = %d\n",
+		   hpetp->hp_which, (u32) period, (u32) vendor,
+		   hpetp->hp_ntimer);
 
 	return 0;
 }
 
 static struct seq_operations hpet_seq_ops = {
-	.start	=	hpet_start,
-	.next	=	hpet_next,
-	.stop	=	hpet_stop,
-	.show	=	hpet_show
+	.start = hpet_start,
+	.next = hpet_next,
+	.stop = hpet_stop,
+	.show = hpet_show
 };
 
-static int
-hpet_proc_open (struct inode *inode, struct file *file)
+static int hpet_proc_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &hpet_seq_ops);
 }
 
 static struct file_operations hpet_proc_fops = {
-	.open		=	hpet_proc_open,
-	.read		=	seq_read,
-	.llseek		=	seq_lseek,
-	.release	=	seq_release
+	.open = hpet_proc_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release
 };
 
-
 /*
  * Adjustment for when arming the timer with
  * initial conditions.  That is, main counter
@@ -797,16 +807,16 @@
  */
 #define	TICK_CALIBRATE	(1000UL)
 
-static unsigned long __init
-hpet_calibrate (struct hpets *hpetp)
+static unsigned long __init hpet_calibrate(struct hpets *hpetp)
 {
-	volatile struct hpet_timer *timer;
+	struct hpet_timer *timer;
 	unsigned long t, m, count, i, flags, start;
 	struct hpet_dev *devp;
 	int j;
-	volatile struct hpet *hpet;
+	struct hpet *hpet;
 
-	for (timer = 0, j = 0, devp = hpetp->hp_dev;  j < hpetp->hp_ntimer; j++, devp++)
+	for (timer = 0, j = 0, devp = hpetp->hp_dev; j < hpetp->hp_ntimer;
+	     j++, devp++)
 		if ((devp->hd_flags & HPET_OPEN) == 0) {
 			timer = devp->hd_timer;
 			break;
@@ -816,27 +826,26 @@
 		return 0;
 
 	hpet = hpets->hp_hpet;
-	t = timer->hpet_compare;
+	t = read_counter(&timer->hpet_compare);
 
 	i = 0;
 	count = hpet_time_div(hpetp->hp_period * TICK_CALIBRATE);
 
 	local_irq_save(flags);
 
-	start = hpet->hpet_mc;
+	start = read_counter(&hpet->hpet_mc);
 
 	do {
-		m = hpet->hpet_mc;
-		timer->hpet_compare = t + m + hpetp->hp_delta;
-	} while (i++, (m - start) <  count);
+		m = read_counter(&hpet->hpet_mc);
+		write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
+	} while (i++, (m - start) < count);
 
 	local_irq_restore(flags);
 
 	return (m - start) / i;
 }
 
-static void __init
-hpet_init_chrdev (void)
+static void __init hpet_init_chrdev(void)
 {
 	static int once;
 
@@ -846,47 +855,51 @@
 	return;
 }
 
-static void __init
-hpet_post_platform (void)
+static void __init hpet_post_platform(void)
 {
 	struct hpets *hpetp;
 	u32 i, ntimer;
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 
 	hpet_init_chrdev();
 
 	for (ntimer = 0, hpetp = hpets; hpetp; hpetp = hpetp->hp_next, ntimer++)
-		for (i = 0, devp = hpetp->hp_dev;  i < hpetp->hp_ntimer; i++, devp++) {
+		for (i = 0, devp = hpetp->hp_dev; i < hpetp->hp_ntimer;
+		     i++, devp++) {
 
 			if (devp->hd_flags & HPET_OPEN)
 				continue;
 
 			sprintf(&hpetname[5], "%d", ntimer);
 			devfs_mk_cdev(MKDEV(HPET_MAJOR, ntimer),
-				S_IFCHR|S_IRUSR|S_IWUSR, hpetname);
+				      S_IFCHR | S_IRUSR | S_IWUSR, hpetname);
 			init_waitqueue_head(&devp->hd_waitqueue);
 		}
 
 	return;
 }
 
-int __init
-hpet_alloc (struct hpet_data *hdp)
+int __init hpet_alloc(struct hpet_data *hdp)
 {
 	u64 cap, mcfg;
-	struct hpet_dev	*devp;
+	struct hpet_dev *devp;
 	u32 i, ntimer;
 	struct hpets *hpetp;
 	size_t siz;
-	volatile struct hpet *hpet;
-	static struct hpets *last __initdata = (struct hpets *) 0;
+	struct hpet *hpet;
+	static struct hpets *last __initdata = (struct hpets *)0;
 
+	/*
+	 * hpet_alloc can be called by platform dependent code.
+	 * if platform dependent code has allocated the hpet
+	 * ACPI also reports hpet, then we catch it here.
+	 */
 	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-		if (hpetp->hp_hpet == (struct hpet *) (hdp->hd_address))
+		if (hpetp->hp_hpet == (struct hpet *)(hdp->hd_address))
 			return 0;
 
-	siz = sizeof (struct hpets) + ((hdp->hd_nirqs - 1) *
-		sizeof (struct hpet_dev));
+	siz = sizeof(struct hpets) + ((hdp->hd_nirqs - 1) *
+				      sizeof(struct hpet_dev));
 
 	hpetp = kmalloc(siz, GFP_KERNEL);
 
@@ -896,14 +909,7 @@
 	memset(hpetp, 0, siz);
 
 	hpetp->hp_which = hpet_nhpet++;
-	hpetp->hp_hpet = (struct hpet *) hdp->hd_address;
-
-	if (last)
-		last->hp_next = hpetp;
-	else
-		hpets = hpetp;
-
-	last = hpetp;
+	hpetp->hp_hpet = (struct hpet *)hdp->hd_address;
 
 	hpetp->hp_ntimer = hdp->hd_nirqs;
 
@@ -912,28 +918,32 @@
 
 	hpet = hpetp->hp_hpet;
 
-	cap = hpet->hpet_cap;
+	cap = readq(&hpet->hpet_cap);
 
 	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
 
-	if (!ntimer) {
-		printk(KERN_WARNING "hpet: no timers in config data\n");
-		return -ENODEV;
-	}
-	else if (hpetp->hp_ntimer != ntimer) {
+	if (hpetp->hp_ntimer != ntimer) {
 		printk(KERN_WARNING "hpet: number irqs doesn't agree"
-			" with number of timers\n");
+		       " with number of timers\n");
+		kfree(hpetp);
 		return -ENODEV;
 	}
 
+	if (last)
+		last->hp_next = hpetp;
+	else
+		hpets = hpetp;
+
+	last = hpetp;
+
 	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-		HPET_COUNTER_CLK_PERIOD_SHIFT;
+	    HPET_COUNTER_CLK_PERIOD_SHIFT;
 
-	mcfg = hpet->hpet_config;
+	mcfg = readq(&hpet->hpet_config);
 	if ((mcfg & HPET_ENABLE_CNF_MASK) == 0) {
-		hpet->hpet_mc = 0L;
+		write_counter(0L, &hpet->hpet_mc);
 		mcfg |= HPET_ENABLE_CNF_MASK;
-		hpet->hpet_config = mcfg;
+		writeq(mcfg, &hpet->hpet_config);
 	}
 
 	/*
@@ -944,12 +954,13 @@
 	if (hdp->hd_flags ^ HPET_DATA_PLATFORM)
 		hpet_init_chrdev();
 
-	for (i = 0, devp = hpetp->hp_dev;  i < hpetp->hp_ntimer; i++, hpet_ntimer++, devp++) {
+	for (i = 0, devp = hpetp->hp_dev; i < hpetp->hp_ntimer;
+	     i++, hpet_ntimer++, devp++) {
 		unsigned long v;
-		volatile struct hpet_timer *timer;
+		struct hpet_timer *timer;
 
 		timer = &hpet->hpet_timers[devp - hpetp->hp_dev];
-		v = timer->hpet_config;
+		v = readq(&timer->hpet_config);
 
 		devp->hd_hpets = hpetp;
 		devp->hd_hpet = hpet;
@@ -957,6 +968,10 @@
 
 		devp->hd_minor = hpet_ntimer;
 
+		/*
+		 * If the timer was reserved by platform code,
+		 * then make timer unavailable for opens.
+		 */
 		if (hdp->hd_state & (1 << i)) {
 			devp->hd_flags = HPET_OPEN;
 			continue;
@@ -967,7 +982,7 @@
 
 		sprintf(&hpetname[5], "%d", hpet_ntimer);
 		devfs_mk_cdev(MKDEV(HPET_MAJOR, hpet_ntimer),
-			S_IFCHR|S_IRUSR|S_IWUSR, hpetname);
+			      S_IFCHR | S_IRUSR | S_IWUSR, hpetname);
 		init_waitqueue_head(&devp->hd_waitqueue);
 	}
 
@@ -976,8 +991,7 @@
 	return 0;
 }
 
-static acpi_status __init
-hpet_resources (struct acpi_resource *res, void *data)
+static acpi_status __init hpet_resources(struct acpi_resource *res, void *data)
 {
 	struct hpet_data *hdp;
 	acpi_status status;
@@ -992,13 +1006,13 @@
 		unsigned long size;
 
 		size = addr.max_address_range - addr.min_address_range + 1;
-		hdp->hd_address = (unsigned long) ioremap(addr.min_address_range, size);
+		hdp->hd_address =
+		    (unsigned long)ioremap(addr.min_address_range, size);
 
 		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
-			if (hpetp->hp_hpet == (struct hpet *) (hdp->hd_address))
+			if (hpetp->hp_hpet == (struct hpet *)(hdp->hd_address))
 				return -EBUSY;
-	}
-	else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
 		struct acpi_resource_ext_irq *irqp;
 		int i;
 
@@ -1009,8 +1023,10 @@
 
 			for (i = 0; i < hdp->hd_nirqs; i++)
 #ifdef	CONFIG_IA64
-				hdp->hd_irq[i] = acpi_register_irq(irqp->interrupts[i],
-							irqp->active_high_low, irqp->edge_level);
+				hdp->hd_irq[i] =
+				    acpi_register_irq(irqp->interrupts[i],
+						      irqp->active_high_low,
+						      irqp->edge_level);
 #else
 				hdp->hd_irq[i] = irqp->interrupts[i];
 #endif
@@ -1020,15 +1036,16 @@
 	return AE_OK;
 }
 
-static int __init
-hpet_acpi_add (struct acpi_device *device)
+static int __init hpet_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
 	struct hpet_data data;
 
 	memset(&data, 0, sizeof(data));
 
-	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS, hpet_resources, &data);
+	result =
+	    acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				hpet_resources, &data);
 
 	if (ACPI_FAILURE(result))
 		return -ENODEV;
@@ -1041,33 +1058,34 @@
 	return hpet_alloc(&data);
 }
 
-static int __init
-hpet_acpi_remove (struct acpi_device *device, int type)
+static int __init hpet_acpi_remove(struct acpi_device *device, int type)
 {
 	return 0;
 }
 
 static struct acpi_driver hpet_acpi_driver __initdata = {
-	.name	=	"hpet",
-	.class	=	"",
-	.ids	=	"PNP0103",
+	.name = "hpet",
+	.class = "",
+	.ids = "PNP0103",
 	.ops = {
-		.add	=	hpet_acpi_add,
-		.remove	=	hpet_acpi_remove,
-	},
+		.add = hpet_acpi_add,
+		.remove = hpet_acpi_remove,
+		},
 };
 
-
-
-static int __init
-hpet_init (void)
+static int __init hpet_init(void)
 {
 	struct proc_dir_entry *entry;
 
+	/*
+	 * If platform dependent code allocated hpet,
+	 * then do the rest of post boot initialization
+	 * of these hpets.
+	 */
 	if (hpets)
 		hpet_post_platform();
 
-	(void) acpi_bus_register_driver(&hpet_acpi_driver);
+	(void)acpi_bus_register_driver(&hpet_acpi_driver);
 
 	if (hpets) {
 		entry = create_proc_entry("driver/hpet", 0, 0);
@@ -1079,25 +1097,23 @@
 
 #ifdef	CONFIG_TIME_INTERPOLATION
 		{
-			volatile struct hpet	*hpet;
+			struct hpet *hpet;
 
 			hpet = hpets->hp_hpet;
 			hpet_cycles_per_sec = hpet_time_div(hpets->hp_period);
 			hpet_interpolator.frequency = hpet_cycles_per_sec;
 			hpet_interpolator.drift = hpet_cycles_per_sec *
-				HPET_DRIFT / 1000000;
+			    HPET_DRIFT / 1000000;
 			hpet_nsecs_per_cycle = 1000000000 / hpet_cycles_per_sec;
 			register_time_interpolator(&hpet_interpolator);
 		}
 #endif
 		return 0;
-	}
-	else
+	} else
 		return -ENODEV;
 }
 
-static void __exit
-hpet_exit (void)
+static void __exit hpet_exit(void)
 {
 	acpi_bus_unregister_driver(&hpet_acpi_driver);
 
@@ -1109,7 +1125,6 @@
 	return;
 }
 
-
 module_init(hpet_init);
 module_exit(hpet_exit);
 MODULE_AUTHOR("Bob Picco <Robert.Picco@hp.com>");
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-mm3/drivers/char/Kconfig linux-2.6.6-mm3-hpet/drivers/char/Kconfig
--- linux-2.6.6-mm3/drivers/char/Kconfig	2004-05-17 10:32:25.000000000 -0400
+++ linux-2.6.6-mm3-hpet/drivers/char/Kconfig	2004-05-17 12:15:05.000000000 -0400
@@ -938,15 +938,16 @@
           with the O_DIRECT flag.
 
 config HPET
-	bool "HPET - High Precision Event Timer"
+	bool "HPET - High Precision Event Timer" if (X86 || IA64)
 	default n
+	depends on ACPI
 	help
 	  If you say Y here, you will have a device named "/dev/hpet/XX" for
-	  each timer supported by the HPET.  The timers are
-	  non-periodioc and/or periodic.
+	  each timer supported by the HPET.  The timers are 
+	  non-periodioc and/or periodic. 
 
 config HPET_RTC_IRQ
-	bool "HPET Control RTC IRQ"
+	bool "HPET Control RTC IRQ" if !HPET_EMULATE_RTC
 	default n
 	depends on HPET
 	help
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-mm3/include/linux/hpet.h linux-2.6.6-mm3-hpet/include/linux/hpet.h
--- linux-2.6.6-mm3/include/linux/hpet.h	2004-05-17 10:32:31.000000000 -0400
+++ linux-2.6.6-mm3-hpet/include/linux/hpet.h	2004-05-17 12:11:24.000000000 -0400
@@ -6,26 +6,26 @@
  */
 
 struct hpet {
-	u64	hpet_cap;		/* capabilities */
-	u64	res0;			/* reserved */
-	u64	hpet_config;		/* configuration */
-	u64	res1;			/* reserved */
-	u64	hpet_isr;		/* interrupt status reg */
-	u64	res2[25];		/* reserved */
-	union {				/* main counter */
-		u64		_hpet_mc64;
-		u32		_hpet_mc32;
-		unsigned long 	_hpet_mc;
+	u64 hpet_cap;		/* capabilities */
+	u64 res0;		/* reserved */
+	u64 hpet_config;	/* configuration */
+	u64 res1;		/* reserved */
+	u64 hpet_isr;		/* interrupt status reg */
+	u64 res2[25];		/* reserved */
+	union {			/* main counter */
+		u64 _hpet_mc64;
+		u32 _hpet_mc32;
+		unsigned long _hpet_mc;
 	} _u0;
-	u64	res3;			/* reserved */
+	u64 res3;		/* reserved */
 	struct hpet_timer {
-		u64	hpet_config;	/* configuration/cap */
-		union {			/* timer compare register */
-			u64		_hpet_hc64;
-			u32		_hpet_hc32;
-			unsigned long	_hpet_compare;
+		u64 hpet_config;	/* configuration/cap */
+		union {		/* timer compare register */
+			u64 _hpet_hc64;
+			u32 _hpet_hc32;
+			unsigned long _hpet_compare;
 		} _u1;
-		u64	hpet_fsb[2];	/* FSB route */
+		u64 hpet_fsb[2];	/* FSB route */
 	} hpet_timers[1];
 };
 
@@ -47,12 +47,10 @@
 #define	HPET_NUM_TIM_CAP_MASK		(0x1f00)
 #define	HPET_NUM_TIM_CAP_SHIFT		(8ULL)
 
-
 /*
  * HPET general configuration register
  */
 
-
 #define	HPET_LEG_RT_CNF_MASK		(2UL)
 #define	HPET_ENABLE_CNF_MASK		(1UL)
 
@@ -63,9 +61,6 @@
 #define	HPET_ISR_CLEAR(HPET, TIMER)				\
 		(HPET)->hpet_isr |= (1UL << TIMER)
 
-
-
-
 /*
  * Timer configuration register
  */
@@ -95,38 +90,35 @@
 #define	Tn_FSB_INT_VAL_MASK		(0x00000000ffffffffULL)
 
 struct hpet_info {
-		unsigned long 	hi_ireqfreq;	/* Hz */
-		unsigned long	hi_flags;	/* information */
+	unsigned long hi_ireqfreq;	/* Hz */
+	unsigned long hi_flags;	/* information */
 };
 
-#define	HPET_INFO_PERIODIC	0x0001		/* timer is periodic */
+#define	HPET_INFO_PERIODIC	0x0001	/* timer is periodic */
 
-
-#define	HPET_IE_ON	_IO('h', 0x01)			/* interrupt on */
-#define	HPET_IE_OFF	_IO('h', 0x02)			/* interrupt off */
+#define	HPET_IE_ON	_IO('h', 0x01)	/* interrupt on */
+#define	HPET_IE_OFF	_IO('h', 0x02)	/* interrupt off */
 #define	HPET_INFO	_IOR('h', 0x03, struct hpet_info)
-#define	HPET_EPI	_IO('h', 0x04)			/* enable periodic */
-#define	HPET_DPI	_IO('h', 0x05)			/* disable periodic */
+#define	HPET_EPI	_IO('h', 0x04)	/* enable periodic */
+#define	HPET_DPI	_IO('h', 0x05)	/* disable periodic */
 #define	HPET_IRQFREQ	_IOW('h', 0x6, unsigned long)	/* IRQFREQ usec */
 
-
-
 /*
  * exported interfaces
  */
 
 struct hpet_task {
-	void	(*ht_func)(void *);
-	void	*ht_data;
-	void	*ht_opaque;
+	void (*ht_func) (void *);
+	void *ht_data;
+	void *ht_opaque;
 };
 
 struct hpet_data {
-	unsigned long	hd_address;
-	unsigned short	hd_nirqs;
-	unsigned short	hd_flags;
-	unsigned int	hd_state;	/* timer allocated */
-	unsigned int	hd_irq[HPET_MAX_TIMERS];
+	unsigned long hd_address;
+	unsigned short hd_nirqs;
+	unsigned short hd_flags;
+	unsigned int hd_state;	/* timer allocated */
+	unsigned int hd_irq[HPET_MAX_TIMERS];
 };
 
 #define	HPET_DATA_PLATFORM	0x0001	/* platform call to hpet_alloc */
@@ -136,5 +128,4 @@
 int hpet_unregister(struct hpet_task *);
 int hpet_control(struct hpet_task *, unsigned int, unsigned long);
 
-
-#endif	/* !__HPET__ */
+#endif				/* !__HPET__ */





