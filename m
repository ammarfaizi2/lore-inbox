Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264554AbUEMW3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbUEMW3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbUEMW3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:29:34 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:60676 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264554AbUEMW2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:28:18 -0400
Message-ID: <40A3F805.5090804@hp.com>
Date: Thu, 13 May 2004 18:34:45 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] HPET driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

The driver supports the High Precision Event Timer.  The driver has 
adopted a similar API to the Real Time Clock driver.  It can support any 
number of HPET devices and the maximum number of timers per HPET device.
For further information look at the documentation in the patch.

Thanks to Venki at Intel for testing the driver on X86 hardware with HPET.

thanks,

Bob

diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/arch/i386/Kconfig linux-2.6.6-hpet/arch/i386/Kconfig
--- linux-2.6.6-orig/arch/i386/Kconfig	2004-05-09 22:32:01.000000000 -0400
+++ linux-2.6.6-hpet/arch/i386/Kconfig	2004-05-10 13:03:56.000000000 -0400
@@ -435,6 +435,7 @@
 
 config HPET_EMULATE_RTC
 	def_bool HPET_TIMER && RTC=y
+	depends on !HPET_RTC_IRQ
 
 config SMP
 	bool "Symmetric multi-processing support"
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/arch/i386/kernel/time_hpet.c linux-2.6.6-hpet/arch/i386/kernel/time_hpet.c
--- linux-2.6.6-orig/arch/i386/kernel/time_hpet.c	2004-05-09 22:32:02.000000000 -0400
+++ linux-2.6.6-hpet/arch/i386/kernel/time_hpet.c	2004-05-10 13:03:56.000000000 -0400
@@ -21,6 +21,7 @@
 #include <linux/config.h>
 
 #include <asm/hpet.h>
+#include <linux/hpet.h>
 
 unsigned long hpet_period;	/* fsecs / HPET clock */
 unsigned long hpet_tick;	/* hpet clks count per tick */
@@ -135,6 +136,51 @@
 	hpet_writel(cfg, HPET_CFG);
 
 	use_hpet = 1;
+
+#ifdef	CONFIG_HPET
+	{
+		struct hpet_data	hd;
+		unsigned int 		ntimer;
+	
+		memset(&hd, 0, sizeof (hd));
+
+		ntimer = hpet_readl(HPET_ID);
+		ntimer = (ntimer & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT;
+		ntimer++;
+
+		/*
+		 * Register with driver.  
+		 * Timer0 and Timer1 is used by platform.
+		 */
+		hd.hd_address = hpet_virt_address;
+		hd.hd_nirqs = ntimer;
+		hd.hd_flags = HPET_DATA_PLATFORM;
+#ifndef	CONFIG_HPET_EMULATE_RTC
+		hd.hd_state = 0x1;
+#else
+		hd.hd_state = 0x3;
+#endif
+		hd.hd_irq[0] = HPET_LEGACY_8254;
+		hd.hd_irq[1] = HPET_LEGACY_RTC;
+		if (ntimer > 2) {	
+			struct hpet		*hpet;
+			struct hpet_timer	*timer;
+			int			i;
+
+			hpet = (struct hpet *) hpet_virt_address;
+
+			for (i = 2, timer = &hpet->hpet_timers[2]; i < ntimer;
+				timer++, i++) 
+				hd.hd_irq[i] = (timer->hpet_config &
+					Tn_INT_ROUTE_CNF_MASK) >>
+					Tn_INT_ROUTE_CNF_SHIFT;
+			
+		}
+
+		hpet_alloc(&hd);
+	}
+#endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	wait_timer_tick = wait_hpet_tick;
 #endif
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/Documentation/hpet.txt linux-2.6.6-hpet/Documentation/hpet.txt
--- linux-2.6.6-orig/Documentation/hpet.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.6-hpet/Documentation/hpet.txt	2004-05-10 13:03:56.000000000 -0400
@@ -0,0 +1,298 @@
+		High Precision Event Timer Driver for Linux
+
+The High Precision Event Timer (HPET) hardware is the future replacement for the 8254 and Real
+Time Clock (RTC) periodic timer functionality.  Each HPET can have up two 32 timers.  It is possible
+to configure the first two timers as legacy replacements for 8254 and RTC periodic.  A specification
+done by INTEL and Microsoft can be found at http://www.intel.com/labs/platcomp/hpet/hpetspec.htm.
+
+The driver supports detection of HPET driver allocation and initialization of the HPET before the
+driver module_init routine is called.  This enables platform code which uses timer 0 or 1 as the 
+main timer to intercept HPET initialization.  An example of this initialization can be found in 
+arch/i386/kernel/time_hpet.c.
+
+The driver provides two APIs which are very similar to the API found in the rtc.c driver.
+There is a user space API and a kernel space API.  An example user space program is provided
+below.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <memory.h>
+#include <malloc.h>
+#include <time.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <linux/hpet.h>
+
+
+extern void hpet_open_close(int, const char **);
+extern void hpet_info(int, const char **);
+extern void hpet_poll(int, const char **);
+extern void hpet_fasync(int, const char **);
+extern void hpet_read(int, const char **);
+
+#include <sys/poll.h>
+#include <sys/ioctl.h>
+#include <signal.h>
+
+struct hpet_command {
+	char		*command;
+	void		(*func)(int argc, const char ** argv);
+} hpet_command[] = {
+	{
+		"open-close",	
+		hpet_open_close		
+	},
+	{
+		"info",	
+		hpet_info
+	},
+	{
+		"poll",
+		hpet_poll
+	},
+	{
+		"fasync",
+		hpet_fasync
+	},
+};
+	
+int 
+main(int argc, const char ** argv)
+{
+	int	i;
+
+	argc--;
+	argv++;
+
+	if (!argc) {
+		fprintf(stderr, "-hpet: requires command\n");
+		return -1;
+	}
+
+
+	for (i = 0; i < (sizeof (hpet_command) / sizeof (hpet_command[0])); i++)
+		if (!strcmp(argv[0], hpet_command[i].command)) {
+			argc--;
+			argv++;
+			fprintf(stderr, "-hpet: executing %s\n",
+				hpet_command[i].command);
+			hpet_command[i].func(argc, argv);
+			return 0;
+		}
+
+	fprintf(stderr, "do_hpet: command %s not implemented\n", argv[0]);
+
+	return -1;
+}
+
+void 
+hpet_open_close(int argc, const char **argv)
+{
+	int	fd;
+
+	if (argc != 1) {
+		fprintf(stderr, "hpet_open_close: device-name\n");
+		return;
+	}
+
+	fd = open(argv[0], O_RDWR);
+	if (fd < 0)
+		fprintf(stderr, "hpet_open_close: open failed\n");
+	else
+		close(fd);
+
+	return;
+}
+
+void 
+hpet_info(int argc, const char **argv)
+{
+}
+
+void 
+hpet_poll(int argc, const char **argv)
+{
+	unsigned long		freq;
+	int			iterations, i, fd;
+	struct pollfd		pfd;
+	struct hpet_info	info;
+	struct timeval		stv, etv;
+	struct timezone		tz;
+	long			usec;
+
+	if (argc != 3) {
+		fprintf(stderr, "hpet_poll: device-name freq iterations\n");
+		return;
+	}
+
+	freq = atoi(argv[1]);
+	iterations = atoi(argv[2]);
+
+	fd = open(argv[0], O_RDWR);
+
+	if (fd < 0) {
+		fprintf(stderr, "hpet_poll: open of %s failed\n", argv[0]);
+		return;
+	}
+
+	if (ioctl(fd, HPET_IRQFREQ, freq) < 0) {
+		fprintf(stderr, "hpet_poll: HPET_IRQFREQ failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_INFO, &info) < 0) {
+		fprintf(stderr, "hpet_poll: failed to get info\n");
+		goto out;
+	}
+
+	fprintf(stderr, "hpet_poll: info.hi_flags 0x%lx\n", info.hi_flags);
+
+	if (info.hi_flags && (ioctl(fd, HPET_EPI, 0) < 0)) {
+		fprintf(stderr, "hpet_poll: HPET_EPI failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_IE_ON, 0) < 0) {
+		fprintf(stderr, "hpet_poll, HPET_IE_ON failed\n");
+		goto out;
+	}
+
+	pfd.fd = fd;
+	pfd.events = POLLIN;
+
+	for (i = 0; i < iterations; i++) {
+		pfd.revents = 0;
+		gettimeofday(&stv, &tz);
+		if (poll(&pfd, 1, -1) < 0)
+			fprintf(stderr, "hpet_poll: poll failed\n");
+		else {
+			long 	data;
+
+			gettimeofday(&etv, &tz);
+			usec = stv.tv_sec * 1000000 + stv.tv_usec;
+			usec = (etv.tv_sec * 1000000 + etv.tv_usec) - usec;
+
+			fprintf(stderr, 
+				"hpet_poll: expired time = 0x%lx\n", usec);
+
+			fprintf(stderr, "hpet_poll: revents = 0x%x\n",
+				pfd.revents);
+
+			if (read(fd, &data, sizeof(data)) != sizeof(data)) {
+				fprintf(stderr, "hpet_poll: read failed\n");
+			}
+			else
+				fprintf(stderr, "hpet_poll: data 0x%lx\n",
+					data);
+		}
+	}
+
+out:
+	close(fd);
+	return;
+} 
+
+static int hpet_sigio_count;
+
+static void
+hpet_sigio(int val)
+{
+	fprintf(stderr, "hpet_sigio: called\n");
+	hpet_sigio_count++;
+}
+
+void
+hpet_fasync(int argc, const char **argv)
+{
+	unsigned long		freq;
+	int			iterations, i, fd, value;
+	sig_t			oldsig;
+	struct hpet_info	info;
+
+	hpet_sigio_count = 0;
+	fd = -1;
+
+	if ((oldsig = signal(SIGIO, hpet_sigio)) == SIG_ERR) {
+		fprintf(stderr, "hpet_fasync: failed to set signal handler\n");
+		return;
+	}
+
+	if (argc != 3) {
+		fprintf(stderr, "hpet_fasync: device-name freq iterations\n");
+		goto out;
+	}
+
+	fd = open(argv[0], O_RDWR);
+
+	if (fd < 0) {
+		fprintf(stderr, "hpet_fasync: failed to open %s\n", argv[0]);
+		return;
+	}
+
+	
+	if ((fcntl(fd, F_SETOWN, getpid()) == 1) ||
+		((value = fcntl(fd, F_GETFL)) == 1) || 
+		(fcntl(fd, F_SETFL, value | O_ASYNC) == 1)) {
+		fprintf(stderr, "hpet_fasync: fcntl failed\n");
+		goto out;
+	} 
+
+	freq = atoi(argv[1]);
+	iterations = atoi(argv[2]);
+
+	if (ioctl(fd, HPET_IRQFREQ, freq) < 0) {
+		fprintf(stderr, "hpet_fasync: HPET_IRQFREQ failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_INFO, &info) < 0) {
+		fprintf(stderr, "hpet_fasync: failed to get info\n");
+		goto out;
+	}
+
+	fprintf(stderr, "hpet_fasync: info.hi_flags 0x%lx\n", info.hi_flags);
+
+	if (info.hi_flags && (ioctl(fd, HPET_EPI, 0) < 0)) {
+		fprintf(stderr, "hpet_fasync: HPET_EPI failed\n");
+		goto out;
+	}
+
+	if (ioctl(fd, HPET_IE_ON, 0) < 0) {
+		fprintf(stderr, "hpet_fasync, HPET_IE_ON failed\n");
+		goto out;
+	}
+
+	for (i = 0; i < iterations; i++) {
+		(void) pause();
+		fprintf(stderr, "hpet_fasync: count = %d\n", hpet_sigio_count);
+	}
+
+out:
+	signal(SIGIO, oldsig);
+
+	if (fd >= 0)
+		close(fd);
+
+	return;
+}
+
+The kernel API has three interfaces exported from the driver: 
+
+	hpet_register(struct hpet_task *tp, int periodic)
+	hpet_unregister(struct hpet_task *tp)
+	hpet_control(struct hpet_task *tp, unsigned int cmd, unsigned long arg)
+
+The kernel module using this interface fills in the ht_func and ht_data members of the
+hpet_task structure before calling hpet_register.  hpet_control simply vectors to the hpet_ioctl
+routine and has the same commands and respective arguments as the user API.  hpet_unregister
+is used to terminate usage of the HPET timer reserved by hpet_register. 
+	
+
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/drivers/char/hpet.c linux-2.6.6-hpet/drivers/char/hpet.c
--- linux-2.6.6-orig/drivers/char/hpet.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.6-hpet/drivers/char/hpet.c	2004-05-10 15:43:48.000000000 -0400
@@ -0,0 +1,1116 @@
+/*
+ * Intel & MS High Precision Event Timer Implementation.
+ * Contributors:
+ *	Venki Pallipadi
+ * 	Bob Picco
+ */
+
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/major.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+#include <linux/sysctl.h>
+#include <linux/wait.h>
+#include <linux/bcd.h>
+#include <linux/seq_file.h>
+
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/bitops.h>
+#include <asm/div64.h>
+
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+#include <linux/hpet.h>
+
+/*
+ * The High Precision Event Timer driver.
+ * This driver is closely modelled after the rtc.c driver.
+ * http://www.intel.com/labs/platcomp/hpet/hpetspec.htm
+ */
+#define	HPET_USER_FREQ	(64)
+#define	HPET_DRIFT	(500)
+
+static u32 hpet_ntimer, hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
+static char hpetname[] = "hpet/XX";
+
+/* A lock for concurrent access by app and isr hpet activity. */
+static spinlock_t hpet_lock = SPIN_LOCK_UNLOCKED;
+/* A lock for concurrent intermodule access to hpet and isr hpet activity. */
+static spinlock_t hpet_task_lock = SPIN_LOCK_UNLOCKED;
+
+struct hpet_dev {
+	struct hpets		*hd_hpets;
+	volatile struct hpet	*hd_hpet;
+	volatile struct hpet_timer
+				*hd_timer;
+	unsigned long		hd_ireqfreq;
+	unsigned long		hd_irqdata;
+	wait_queue_head_t	hd_waitqueue;
+	struct fasync_struct	*hd_async_queue;
+	struct hpet_task	*hd_task;
+	unsigned int		hd_flags;
+	unsigned int		hd_irq;
+	unsigned int		hd_hdwirq;
+	int			hd_minor;
+};
+
+struct hpets {
+	struct hpets		*hp_next;
+	volatile struct hpet	*hp_hpet;
+	unsigned long		hp_period;
+	unsigned long		hp_delta;
+	unsigned int		hp_ntimer;
+	unsigned int		hp_which;
+	struct hpet_dev		hp_dev[1];
+};
+
+static struct hpets *hpets;
+
+#define	HPET_OPEN		0x0001
+#define	HPET_IE			0x0002			/* interrupt enabled */
+#define	HPET_PERIODIC		0x0004
+
+static irqreturn_t
+hpet_interrupt (int irq, void *data, struct pt_regs *regs)
+{
+	struct hpet_dev *devp;
+	unsigned long isr;
+
+	devp = data;
+
+	spin_lock(&hpet_lock);
+	devp->hd_irqdata++;
+
+	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
+		unsigned long m, t;
+
+		t = devp->hd_ireqfreq;
+		m = devp->hd_hpet->hpet_mc;
+		devp->hd_timer->hpet_compare = t + m + devp->hd_hpets->hp_delta;
+	}
+
+	isr = (1 << (devp - devp->hd_hpets->hp_dev));
+	devp->hd_hpet->hpet_isr = isr;
+	spin_unlock(&hpet_lock);
+
+	spin_lock(&hpet_task_lock);
+	if (devp->hd_task)
+		devp->hd_task->ht_func(devp->hd_task->ht_data);
+	spin_unlock(&hpet_task_lock);
+
+	wake_up_interruptible(&devp->hd_waitqueue);
+
+	kill_fasync(&devp->hd_async_queue, SIGIO, POLL_IN);
+
+	return IRQ_HANDLED;
+}
+
+static struct hpet_dev *
+hpet_minor_to_dev (int minor)
+{
+	struct hpets *hpetp;
+	int i;
+
+	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+		for (i = 0; i <  hpetp->hp_ntimer; i++)
+			if (hpetp->hp_dev[i].hd_minor == minor)
+				return &hpetp->hp_dev[i];
+	return 0;
+}
+
+static int
+hpet_open (struct inode *inode, struct file *file)
+{
+	struct hpet_dev *devp;
+
+	devp = hpet_minor_to_dev(MINOR(inode->i_rdev));
+
+	if (!devp)
+		return -ENODEV;
+
+	spin_lock_irq(&hpet_lock);
+	if (devp->hd_flags &  HPET_OPEN || devp->hd_task) {
+		spin_unlock_irq(&hpet_lock);
+		return -EBUSY;
+	}
+
+	file->private_data = devp;
+	devp->hd_irqdata = 0;
+	devp->hd_flags |= HPET_OPEN;
+	spin_unlock_irq(&hpet_lock);
+
+	return 0;
+}
+
+static ssize_t
+hpet_read (struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait,current);
+	unsigned long data;
+	ssize_t	retval;
+	struct hpet_dev	*devp;
+
+	devp = file->private_data;
+	if (!devp->hd_ireqfreq)
+		return -EIO;
+
+	if (count < sizeof (unsigned long))
+		return -EINVAL;
+
+	add_wait_queue(&devp->hd_waitqueue, &wait);
+
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irq(&hpet_lock);
+		data = devp->hd_irqdata;
+		devp->hd_irqdata = 0;
+		spin_unlock_irq(&hpet_lock);
+
+		if (data)
+			break;
+		else if (file->f_flags & O_NONBLOCK) {
+			retval = -EAGAIN;
+			goto out;
+		} else if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			goto out;
+		}
+
+		schedule();
+
+	} while(1);
+
+	retval = put_user(data, (unsigned long *) buf);
+	if (!retval)
+		retval = sizeof (unsigned long);
+out:
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&devp->hd_waitqueue, &wait);
+
+	return retval;
+}
+
+static unsigned int
+hpet_poll (struct file *file, poll_table *wait)
+{
+	unsigned long v;
+	struct hpet_dev	*devp;
+
+	devp = file->private_data;
+
+	if (!devp->hd_ireqfreq)
+		return 0;
+
+	poll_wait(file, &devp->hd_waitqueue, wait);
+
+	spin_lock_irq(&hpet_lock);
+	v = devp->hd_irqdata;
+	spin_unlock_irq(&hpet_lock);
+
+	if (v != 0)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static int
+hpet_mmap (struct file *file, struct vm_area_struct *vma)
+{
+#ifdef	CONFIG_HPET_NOMMAP
+	return -ENOSYS;
+#else
+	struct hpet_dev	*devp;
+	unsigned long addr;
+
+	if (((vma->vm_end - vma->vm_start) != PAGE_SIZE) || vma->vm_pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	devp = file->private_data;
+	addr = (unsigned long) devp->hd_hpet;
+
+	if (addr & (PAGE_SIZE - 1))
+		return -ENOSYS;
+
+	vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	addr = __pa(addr);
+
+	if (remap_page_range(vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
+		printk(KERN_ERR "remap_page_range failed in hpet.c\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+#endif
+}
+
+static int
+hpet_fasync (int fd, struct file *file, int on)
+{
+	struct hpet_dev	*devp;
+
+	devp = file->private_data;
+
+	if (fasync_helper(fd, file, on, &devp->hd_async_queue) >= 0)
+		return 0;
+	else
+		return -EIO;
+}
+
+static int
+hpet_release (struct inode *inode, struct file *file)
+{
+	struct hpet_dev	*devp;
+	volatile struct hpet_timer *timer;
+
+	devp = file->private_data;
+	timer = devp->hd_timer;
+
+	spin_lock_irq(&hpet_lock);
+
+	timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;
+
+	if (devp->hd_irq) {
+		free_irq(devp->hd_irq, devp);
+		devp->hd_irq = 0;
+	}
+
+	devp->hd_ireqfreq = 0;
+
+	if (devp->hd_flags & HPET_PERIODIC && timer->hpet_config & Tn_TYPE_CNF_MASK) {
+		unsigned long v;
+
+		v = timer->hpet_config;
+		v ^= Tn_TYPE_CNF_MASK;
+		timer->hpet_config = v;
+	}
+
+	devp->hd_flags &= ~(HPET_OPEN | HPET_IE | HPET_PERIODIC);
+	spin_unlock_irq(&hpet_lock);
+
+	if (file->f_flags & FASYNC)
+		hpet_fasync(-1, file, 0);
+
+	file->private_data = 0;
+	return 0;
+}
+
+static int hpet_ioctl_common(struct hpet_dev *, int, unsigned long, int);
+
+static int
+hpet_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct hpet_dev	*devp;
+
+	devp = file->private_data;
+	return hpet_ioctl_common(devp, cmd, arg, 0);
+}
+
+static int
+hpet_ioctl_ieon (struct hpet_dev *devp)
+{
+	volatile struct hpet_timer *timer;
+	volatile struct hpet *hpet;
+	struct hpets *hpetp;
+	int irq;
+	unsigned long g, v, t, m;
+	unsigned long flags, isr;
+
+	timer = devp->hd_timer;
+	hpet = devp->hd_hpet;
+	hpetp = devp->hd_hpets;
+
+	v = timer->hpet_config;
+	spin_lock_irq(&hpet_lock);
+
+	if (devp->hd_flags & HPET_IE) {
+		spin_unlock_irq(&hpet_lock);
+		return -EBUSY;
+	}
+
+	devp->hd_flags |= HPET_IE;
+	spin_unlock_irq(&hpet_lock);
+
+	t = timer->hpet_config;
+	irq = devp->hd_hdwirq;
+
+	if (irq) {
+		char name[7];
+
+		sprintf(name, "hpet%d", (int) (devp - hpetp->hp_dev));
+
+		if (request_irq(irq, hpet_interrupt, SA_INTERRUPT, name, (void *) devp)) {
+			printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
+			irq = 0;
+		}
+	}
+
+	if (irq == 0) {
+		spin_lock_irq(&hpet_lock);
+		devp->hd_flags ^= HPET_IE;
+		spin_unlock_irq(&hpet_lock);
+		return -EIO;
+	}
+
+	devp->hd_irq = irq;
+	t = devp->hd_ireqfreq;
+	v = timer->hpet_config;
+	g = v | Tn_INT_ENB_CNF_MASK;
+
+	if (devp->hd_flags & HPET_PERIODIC) {
+		timer->hpet_compare = t;
+		g |= Tn_TYPE_CNF_MASK;
+		v |= Tn_TYPE_CNF_MASK;
+		timer->hpet_config = v;
+		v |= Tn_VAL_SET_CNF_MASK;
+		timer->hpet_config = v;
+		local_irq_save(flags);
+		m = hpet->hpet_mc;
+		timer->hpet_compare = t + m + hpetp->hp_delta;
+	} else {
+		local_irq_save(flags);
+		m = hpet->hpet_mc;
+		timer->hpet_compare = t + m + hpetp->hp_delta;
+	}
+
+	isr = (1 << (devp - hpets->hp_dev));
+	hpet->hpet_isr = isr;
+	timer->hpet_config = g;
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static inline unsigned long
+hpet_time_div (unsigned long dis)
+{
+	unsigned long long m = 1000000000000000ULL;
+
+	do_div(m, dis);
+
+	return (unsigned long) m;
+}
+
+static int
+hpet_ioctl_common (struct hpet_dev *devp, int cmd, unsigned long arg, int kernel)
+{
+	volatile struct hpet_timer *timer;
+	volatile struct hpet *hpet;
+	struct hpets *hpetp;
+	int err;
+	unsigned long v;
+
+	switch (cmd) {
+	case HPET_IE_OFF:
+	case HPET_INFO:
+	case HPET_EPI:
+	case HPET_DPI:
+	case HPET_IRQFREQ:
+		timer = devp->hd_timer;
+		hpet = devp->hd_hpet;
+		hpetp = devp->hd_hpets;
+		break;
+	case HPET_IE_ON:
+		return hpet_ioctl_ieon(devp);
+	default:
+		return -EINVAL;
+	}
+
+	err = 0;
+
+	switch (cmd) {
+	case HPET_IE_OFF:
+		if ((devp->hd_flags & HPET_IE) == 0)
+			break;
+		v = timer->hpet_config;
+		v &= ~Tn_INT_ENB_CNF_MASK;
+		timer->hpet_config = v;
+		if (devp->hd_irq) {
+			free_irq(devp->hd_irq, devp);
+			devp->hd_irq = 0;
+		}
+		devp->hd_flags ^= HPET_IE;
+		break;
+	case HPET_INFO:
+	{
+		struct hpet_info		info;
+
+		info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
+			devp->hd_ireqfreq);
+		info.hi_flags = timer->hpet_config & Tn_PER_INT_CAP_MASK;
+		if (copy_to_user((void *) arg, &info , sizeof (info)))
+			err = -EFAULT;
+		break;
+	}
+	case HPET_EPI:
+		v = timer->hpet_config;
+		if ((v & Tn_PER_INT_CAP_MASK) == 0) {
+			err = -ENXIO;
+			break;
+		}
+		devp->hd_flags |= HPET_PERIODIC;
+		break;
+	case HPET_DPI:
+		v = timer->hpet_config;
+		if ((v & Tn_PER_INT_CAP_MASK) == 0) {
+			err = -ENXIO;
+			break;
+		}
+		if (devp->hd_flags & HPET_PERIODIC &&
+			timer->hpet_config & Tn_TYPE_CNF_MASK) {
+			v = timer->hpet_config;
+			v ^= Tn_TYPE_CNF_MASK;
+			timer->hpet_config = v;
+		}
+		devp->hd_flags &= ~HPET_PERIODIC;
+		break;
+	case HPET_IRQFREQ:
+		if (!kernel && (arg > hpet_max_freq) &&
+			!capable(CAP_SYS_RESOURCE)) {
+			err = -EACCES;
+			break;
+		}
+
+		if (arg & (arg - 1)) {
+			err = -EINVAL;
+			break;
+		}
+
+		devp->hd_ireqfreq = hpet_time_div(hpetp->hp_period * arg);
+	}
+
+	return err;
+}
+
+static struct file_operations hpet_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= hpet_read,
+	.poll		= hpet_poll,
+	.ioctl		= hpet_ioctl,
+	.open		= hpet_open,
+	.release	= hpet_release,
+	.fasync		= hpet_fasync,
+	.mmap		= hpet_mmap,
+};
+
+EXPORT_SYMBOL(hpet_alloc);
+EXPORT_SYMBOL(hpet_register);
+EXPORT_SYMBOL(hpet_unregister);
+EXPORT_SYMBOL(hpet_control);
+
+int
+hpet_register (struct hpet_task *tp, int periodic)
+{
+	unsigned int i;
+	u64 mask;
+	volatile struct hpet_timer *timer;
+	struct hpet_dev *devp;
+	struct hpets *hpetp;
+
+	switch (periodic) {
+	case 1:
+		mask = Tn_PER_INT_CAP_MASK;
+		break;
+	case 0:
+		mask = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irq(&hpet_task_lock);
+	spin_lock(&hpet_lock);
+
+	for (devp = 0, hpetp = hpets; hpetp && !devp; hpetp = hpetp->hp_next)
+	for (timer = hpetp->hp_hpet->hpet_timers, i = 0; i < hpetp->hp_ntimer; i++, timer++) {
+		if ((timer->hpet_config & Tn_PER_INT_CAP_MASK) != mask)
+			continue;
+
+		devp = &hpetp->hp_dev[i];
+
+		if (devp->hd_flags & HPET_OPEN || devp->hd_task) {
+			devp = 0;
+			continue;
+		}
+
+		tp->ht_opaque = devp;
+		devp->hd_task = tp;
+		break;
+	}
+
+	spin_unlock(&hpet_lock);
+	spin_unlock_irq(&hpet_task_lock);
+
+	if (tp->ht_opaque)
+		return 0;
+	else
+		return -EBUSY;
+}
+
+static inline int
+hpet_tpcheck (struct hpet_task *tp)
+{
+	struct hpet_dev	*devp;
+	struct hpets *hpetp;
+
+	devp = tp->ht_opaque;
+
+	if (!devp)
+		return -ENXIO;
+
+	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+		if (devp >= hpetp->hp_dev && devp < (hpetp->hp_dev + hpetp->hp_ntimer) &&
+			devp->hd_hpet == hpetp->hp_hpet)
+			return 0;
+
+	return -ENXIO;
+}
+
+
+int
+hpet_unregister (struct hpet_task *tp)
+{
+	struct hpet_dev	*devp;
+	volatile struct hpet_timer *timer;
+	int err;
+
+	if ((err = hpet_tpcheck(tp)))
+		return err;
+
+	spin_lock_irq(&hpet_task_lock);
+	spin_lock(&hpet_lock);
+
+	devp = tp->ht_opaque;
+	if (devp->hd_task != tp) {
+		spin_unlock(&hpet_lock);
+		spin_unlock_irq(&hpet_task_lock);
+		return -ENXIO;
+	}
+
+	timer = devp->hd_timer;
+	timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;
+	devp->hd_flags &= ~( HPET_IE | HPET_PERIODIC);
+	devp->hd_task = 0;
+	spin_unlock(&hpet_lock);
+	spin_unlock_irq(&hpet_task_lock);
+
+	return 0;
+}
+
+int
+hpet_control (struct hpet_task *tp, unsigned int cmd, unsigned long arg)
+{
+	struct hpet_dev	*devp;
+	int err;
+
+	if ((err = hpet_tpcheck(tp)))
+		return err;
+
+	spin_lock_irq(&hpet_lock);
+	devp = tp->ht_opaque;
+	if (devp->hd_task != tp) {
+		spin_unlock_irq(&hpet_lock);
+		return -ENXIO;
+	}
+	spin_unlock_irq(&hpet_lock);
+	return hpet_ioctl_common(devp, cmd, arg, 1);
+}
+
+
+
+#ifdef	CONFIG_TIME_INTERPOLATION
+
+static unsigned long hpet_offset, last_wall_hpet;
+static long hpet_nsecs_per_cycle, hpet_cycles_per_sec;
+
+static unsigned long
+hpet_getoffset (void)
+{
+	return hpet_offset + (hpets->hp_hpet->hpet_mc - last_wall_hpet) * hpet_nsecs_per_cycle;
+}
+
+static void
+hpet_update (long delta)
+{
+	unsigned long mc;
+	unsigned long offset;
+	volatile struct hpet *hpet;
+
+	hpet = hpets->hp_hpet;
+	mc = hpet->hpet_mc;
+	offset = hpet_offset + (mc - last_wall_hpet) * hpet_nsecs_per_cycle;
+
+	if (delta < 0 || (unsigned long) delta < offset)
+		hpet_offset = offset - delta;
+	else
+		hpet_offset = 0;
+	last_wall_hpet = mc;
+}
+
+static void
+hpet_reset (void)
+{
+	volatile struct hpet *hpet;
+
+	hpet = hpets->hp_hpet;
+	hpet_offset = 0;
+	last_wall_hpet = hpet->hpet_mc;
+}
+
+static struct time_interpolator hpet_interpolator = {
+	.get_offset	=	hpet_getoffset,
+	.update		=	hpet_update,
+	.reset		=	hpet_reset
+};
+
+#endif
+
+static ctl_table hpet_table[] = {
+	{
+		.ctl_name	= 1,
+		.procname	= "max-user-freq",
+		.data		= &hpet_max_freq,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
+};
+
+static ctl_table hpet_root[] = {
+	{
+		.ctl_name	= 1,
+		.procname	= "hpet",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= hpet_table,
+	},
+	{ .ctl_name = 0 }
+};
+
+static ctl_table dev_root[] = {
+	{
+		.ctl_name	= CTL_DEV,
+		.procname	= "dev",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= hpet_root,
+	},
+	{ .ctl_name = 0 }
+};
+
+static struct ctl_table_header *sysctl_header;
+
+static void *
+hpet_start (struct seq_file *s, loff_t *pos)
+{
+	struct hpets *hpetp;
+	loff_t n;
+
+	for (n = *pos, hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+		if (!n--)
+			return hpetp;
+
+	return 0;
+}
+
+static void *
+hpet_next (struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hpets *hpetp;
+
+	hpetp = v;
+	++*pos;
+	return hpetp->hp_next;
+}
+
+static void
+hpet_stop (struct seq_file *s, void *v)
+{
+	return;
+}
+
+static int
+hpet_show (struct seq_file *s, void *v)
+{
+	struct hpets *hpetp;
+	volatile struct hpet *hpet;
+	u64 cap, vendor, period;
+
+	hpetp = v;
+	hpet = hpetp->hp_hpet;
+
+	cap = hpet->hpet_cap;
+	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
+		HPET_COUNTER_CLK_PERIOD_SHIFT;
+	vendor = (cap & HPET_VENDOR_ID_MASK) >> HPET_VENDOR_ID_SHIFT;
+
+	seq_printf(s, "HPET%d period = %d 10**-15  vendor = 0x%x number timer = %d\n",
+		hpetp->hp_which, (u32) period, (u32) vendor, hpetp->hp_ntimer);
+
+	return 0;
+}
+
+static struct seq_operations hpet_seq_ops = {
+	.start	=	hpet_start,
+	.next	=	hpet_next,
+	.stop	=	hpet_stop,
+	.show	=	hpet_show
+};
+
+static int
+hpet_proc_open (struct inode *inode, struct file *file)
+{
+	return seq_open(file, &hpet_seq_ops);
+}
+
+static struct file_operations hpet_proc_fops = {
+	.open		=	hpet_proc_open,
+	.read		=	seq_read,
+	.llseek		=	seq_lseek,
+	.release	=	seq_release
+};
+
+
+/*
+ * Adjustment for when arming the timer with
+ * initial conditions.  That is, main counter
+ * ticks expired before interrupts are enabled.
+ */
+#define	TICK_CALIBRATE	(1000UL)
+
+static unsigned long __init
+hpet_calibrate (struct hpets *hpetp)
+{
+	volatile struct hpet_timer *timer;
+	unsigned long t, m, count, i, flags, start;
+	struct hpet_dev *devp;
+	int j;
+	volatile struct hpet *hpet;
+
+	for (timer = 0, j = 0, devp = hpetp->hp_dev;  j < hpetp->hp_ntimer; j++, devp++)
+		if ((devp->hd_flags & HPET_OPEN) == 0) {
+			timer = devp->hd_timer;
+			break;
+		}
+
+	if (!timer)
+		return 0;
+
+	hpet = hpets->hp_hpet;
+	t = timer->hpet_compare;
+
+	i = 0;
+	count = hpet_time_div(hpetp->hp_period * TICK_CALIBRATE);
+
+	local_irq_save(flags);
+
+	start = hpet->hpet_mc;
+
+	do {
+		m = hpet->hpet_mc;
+		timer->hpet_compare = t + m + hpetp->hp_delta;
+	} while (i++, (m - start) <  count);
+
+	local_irq_restore(flags);
+
+	return (m - start) / i;
+}
+
+static void __init
+hpet_init_chrdev (void)
+{
+	static int once;
+
+	if (!once++ && register_chrdev(HPET_MAJOR, "hpet", &hpet_fops))
+		panic("unable to to major %d for hpet device", HPET_MAJOR);
+
+	return;
+}
+
+static void __init
+hpet_post_platform (void)
+{
+	struct hpets *hpetp;
+	u32 i, ntimer;
+	struct hpet_dev	*devp;
+
+	hpet_init_chrdev();
+
+	for (ntimer = 0, hpetp = hpets; hpetp; hpetp = hpetp->hp_next, ntimer++)
+		for (i = 0, devp = hpetp->hp_dev;  i < hpetp->hp_ntimer; i++, devp++) {
+
+			if (devp->hd_flags & HPET_OPEN)
+				continue;
+
+			sprintf(&hpetname[5], "%d", ntimer);
+			devfs_mk_cdev(MKDEV(HPET_MAJOR, ntimer),
+				S_IFCHR|S_IRUSR|S_IWUSR, hpetname);
+			init_waitqueue_head(&devp->hd_waitqueue);
+		}
+
+	return;
+}
+
+int __init
+hpet_alloc (struct hpet_data *hdp)
+{
+	u64 cap, mcfg;
+	struct hpet_dev	*devp;
+	u32 i, ntimer;
+	struct hpets *hpetp;
+	size_t siz;
+	volatile struct hpet *hpet;
+	static struct hpets *last __initdata = (struct hpets *) 0;
+
+	for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+		if (hpetp->hp_hpet == (struct hpet *) (hdp->hd_address))
+			return 0;
+
+	siz = sizeof (struct hpets) + ((hdp->hd_nirqs - 1) *
+		sizeof (struct hpet_dev));
+
+	hpetp = kmalloc(siz, GFP_KERNEL);
+
+	if (!hpetp)
+		return -ENOMEM;
+
+	memset(hpetp, 0, siz);
+
+	hpetp->hp_which = hpet_nhpet++;
+	hpetp->hp_hpet = (struct hpet *) hdp->hd_address;
+
+	if (last)
+		last->hp_next = hpetp;
+	else
+		hpets = hpetp;
+
+	last = hpetp;
+
+	hpetp->hp_ntimer = hdp->hd_nirqs;
+
+	for (i = 0; i < hdp->hd_nirqs; i++)
+		hpetp->hp_dev[i].hd_hdwirq = hdp->hd_irq[i];
+
+	hpet = hpetp->hp_hpet;
+
+	cap = hpet->hpet_cap;
+
+	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
+
+	if (!ntimer) {
+		printk(KERN_WARNING "hpet: no timers in config data\n");
+		return -ENODEV;
+	}
+	else if (hpetp->hp_ntimer != ntimer) {
+		printk(KERN_WARNING "hpet: number irqs doesn't agree"
+			" with number of timers\n");
+		return -ENODEV;
+	}
+
+	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
+		HPET_COUNTER_CLK_PERIOD_SHIFT;
+
+	mcfg = hpet->hpet_config;
+	if ((mcfg & HPET_ENABLE_CNF_MASK) == 0) {
+		hpet->hpet_mc = 0L;
+		mcfg |= HPET_ENABLE_CNF_MASK;
+		hpet->hpet_config = mcfg;
+	}
+
+	/*
+	 * Create character devices and init wait queue.
+	 * If this is a platform call, then device initialization
+	 * occurs during startup call to hpet_init.
+	 */
+	if (hdp->hd_flags ^ HPET_DATA_PLATFORM)
+		hpet_init_chrdev();
+
+	for (i = 0, devp = hpetp->hp_dev;  i < hpetp->hp_ntimer; i++, hpet_ntimer++, devp++) {
+		unsigned long v;
+		volatile struct hpet_timer *timer;
+
+		timer = &hpet->hpet_timers[devp - hpetp->hp_dev];
+		v = timer->hpet_config;
+
+		devp->hd_hpets = hpetp;
+		devp->hd_hpet = hpet;
+		devp->hd_timer = timer;
+
+		devp->hd_minor = hpet_ntimer;
+
+		if (hdp->hd_state & (1 << i)) {
+			devp->hd_flags = HPET_OPEN;
+			continue;
+		}
+
+		if (hdp->hd_flags & HPET_DATA_PLATFORM)
+			continue;
+
+		sprintf(&hpetname[5], "%d", hpet_ntimer);
+		devfs_mk_cdev(MKDEV(HPET_MAJOR, hpet_ntimer),
+			S_IFCHR|S_IRUSR|S_IWUSR, hpetname);
+		init_waitqueue_head(&devp->hd_waitqueue);
+	}
+
+	hpetp->hp_delta = hpet_calibrate(hpetp);
+
+	return 0;
+}
+
+static acpi_status __init
+hpet_resources (struct acpi_resource *res, void *data)
+{
+	struct hpet_data *hdp;
+	acpi_status status;
+	struct acpi_resource_address64 addr;
+	struct hpets *hpetp;
+
+	hdp = data;
+
+	status = acpi_resource_to_address64(res, &addr);
+
+	if (ACPI_SUCCESS(status)) {
+		unsigned long size;
+
+		size = addr.max_address_range - addr.min_address_range + 1;
+		hdp->hd_address = (unsigned long) ioremap(addr.min_address_range, size);
+
+		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
+			if (hpetp->hp_hpet == (struct hpet *) (hdp->hd_address))
+				return -EBUSY;
+	}
+	else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+		struct acpi_resource_ext_irq *irqp;
+		int i;
+
+		irqp = &res->data.extended_irq;
+
+		if (irqp->number_of_interrupts > 0) {
+			hdp->hd_nirqs = irqp->number_of_interrupts;
+
+			for (i = 0; i < hdp->hd_nirqs; i++)
+#ifdef	CONFIG_IA64
+				hdp->hd_irq[i] = acpi_register_irq(irqp->interrupts[i],
+							irqp->active_high_low, irqp->edge_level);
+#else
+				hdp->hd_irq[i] = irqp->interrupts[i];
+#endif
+		}
+	}
+
+	return AE_OK;
+}
+
+static int __init
+hpet_acpi_add (struct acpi_device *device)
+{
+	acpi_status result;
+	struct hpet_data data;
+
+	memset(&data, 0, sizeof(data));
+
+	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS, hpet_resources, &data);
+
+	if (ACPI_FAILURE(result))
+		return -ENODEV;
+
+	if (!data.hd_address || !data.hd_nirqs) {
+		printk("%s: no address or irqs in _CRS\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	return hpet_alloc(&data);
+}
+
+static int __init
+hpet_acpi_remove (struct acpi_device *device, int type)
+{
+	return 0;
+}
+
+static struct acpi_driver hpet_acpi_driver __initdata = {
+	.name	=	"hpet",
+	.class	=	"",
+	.ids	=	"PNP0103",
+	.ops = {
+		.add	=	hpet_acpi_add,
+		.remove	=	hpet_acpi_remove,
+	},
+};
+
+
+
+static int __init
+hpet_init (void)
+{
+	struct proc_dir_entry *entry;
+
+	if (hpets)
+		hpet_post_platform();
+
+	(void) acpi_bus_register_driver(&hpet_acpi_driver);
+
+	if (hpets) {
+		entry = create_proc_entry("driver/hpet", 0, 0);
+
+		if (entry)
+			entry->proc_fops = &hpet_proc_fops;
+
+		sysctl_header = register_sysctl_table(dev_root, 0);
+
+#ifdef	CONFIG_TIME_INTERPOLATION
+		{
+			volatile struct hpet	*hpet;
+
+			hpet = hpets->hp_hpet;
+			hpet_cycles_per_sec = hpet_time_div(hpets->hp_period);
+			hpet_interpolator.frequency = hpet_cycles_per_sec;
+			hpet_interpolator.drift = hpet_cycles_per_sec *
+				HPET_DRIFT / 1000000;
+			hpet_nsecs_per_cycle = 1000000000 / hpet_cycles_per_sec;
+			register_time_interpolator(&hpet_interpolator);
+		}
+#endif
+		return 0;
+	}
+	else
+		return -ENODEV;
+}
+
+static void __exit
+hpet_exit (void)
+{
+	acpi_bus_unregister_driver(&hpet_acpi_driver);
+
+	if (hpets) {
+		unregister_sysctl_table(sysctl_header);
+		remove_proc_entry("driver/hpet", NULL);
+	}
+
+	return;
+}
+
+
+module_init(hpet_init);
+module_exit(hpet_exit);
+MODULE_AUTHOR("Bob Picco <Robert.Picco@hp.com>");
+MODULE_LICENSE("GPL");
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/drivers/char/Kconfig linux-2.6.6-hpet/drivers/char/Kconfig
--- linux-2.6.6-orig/drivers/char/Kconfig	2004-05-09 22:31:59.000000000 -0400
+++ linux-2.6.6-hpet/drivers/char/Kconfig	2004-05-10 13:03:56.000000000 -0400
@@ -959,6 +959,32 @@
           kernels.  Applications should simply open the device (eg /dev/hda1)
           with the O_DIRECT flag.
 
+config HPET
+	bool "HPET - High Precision Event Timer"
+	default n
+	help
+	  If you say Y here, you will have a device named "/dev/hpet/XX" for
+	  each timer supported by the HPET.  The timers are 
+	  non-periodioc and/or periodic. 
+
+config HPET_RTC_IRQ
+	bool "HPET Control RTC IRQ"
+	default n
+	depends on HPET
+	help
+	  If you say Y here, you will disable RTC_IRQ in drivers/char/rtc.c. It
+	  is assumed the platform called hpet_alloc with the RTC IRQ values for
+	  the HPET timers.
+
+config HPET_NOMMAP
+	bool "HPET - Control mmap capability."
+	default n
+	depends on HPET
+	help
+	  If you say Y here, then the mmap interface for the HPET driver returns ENOSYS.
+	  Some hardware implementations might not want all the memory in the page the
+	  HPET control registers reside to be exposed.
+
 config MAX_RAW_DEVS
 	int "Maximum number of RAW devices to support (1-8192)"
 	depends on RAW_DRIVER
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/drivers/char/Makefile linux-2.6.6-hpet/drivers/char/Makefile
--- linux-2.6.6-orig/drivers/char/Makefile	2004-05-09 22:33:20.000000000 -0400
+++ linux-2.6.6-hpet/drivers/char/Makefile	2004-05-10 13:03:56.000000000 -0400
@@ -55,6 +55,7 @@
 obj-$(CONFIG_APPLICOM) += applicom.o
 obj-$(CONFIG_SONYPI) += sonypi.o
 obj-$(CONFIG_RTC) += rtc.o
+obj-$(CONFIG_HPET) += hpet.o
 obj-$(CONFIG_GEN_RTC) += genrtc.o
 obj-$(CONFIG_EFI_RTC) += efirtc.o
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/drivers/char/rtc.c linux-2.6.6-hpet/drivers/char/rtc.c
--- linux-2.6.6-orig/drivers/char/rtc.c	2004-05-09 22:33:22.000000000 -0400
+++ linux-2.6.6-hpet/drivers/char/rtc.c	2004-05-10 13:03:56.000000000 -0400
@@ -97,6 +97,11 @@
 static int rtc_irq = PCI_IRQ_NONE;
 #endif
 
+#ifdef	CONFIG_HPET_RTC_IRQ
+#undef	RTC_IRQ
+#define	RTC_IRQ	0
+#endif
+
 #if RTC_IRQ
 static int rtc_has_irq = 1;
 #endif
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/include/asm-i386/hpet.h linux-2.6.6-hpet/include/asm-i386/hpet.h
--- linux-2.6.6-orig/include/asm-i386/hpet.h	2004-05-09 22:32:38.000000000 -0400
+++ linux-2.6.6-hpet/include/asm-i386/hpet.h	2004-05-10 13:03:56.000000000 -0400
@@ -57,9 +57,12 @@
 #define HPET_ID_LEGSUP	0x00008000
 #define HPET_ID_NUMBER	0x00001f00
 #define HPET_ID_REV	0x000000ff
+#define	HPET_ID_NUMBER_SHIFT	8
 
 #define HPET_CFG_ENABLE	0x001
 #define HPET_CFG_LEGACY	0x002
+#define	HPET_LEGACY_8254	2
+#define	HPET_LEGACY_RTC		8
 
 #define HPET_TN_ENABLE		0x004
 #define HPET_TN_PERIODIC	0x008
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/include/linux/hpet.h linux-2.6.6-hpet/include/linux/hpet.h
--- linux-2.6.6-orig/include/linux/hpet.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.6-hpet/include/linux/hpet.h	2004-05-10 13:03:56.000000000 -0400
@@ -0,0 +1,140 @@
+#ifndef	__HPET__
+#define	__HPET__ 1
+
+/*
+ * Offsets into HPET Registers
+ */
+
+struct hpet {
+	u64	hpet_cap;		/* capabilities */
+	u64	res0;			/* reserved */
+	u64	hpet_config;		/* configuration */
+	u64	res1;			/* reserved */
+	u64	hpet_isr;		/* interrupt status reg */
+	u64	res2[25];		/* reserved */
+	union {				/* main counter */
+		u64		_hpet_mc64;
+		u32		_hpet_mc32;
+		unsigned long 	_hpet_mc;
+	} _u0;
+	u64	res3;			/* reserved */
+	struct hpet_timer {
+		u64	hpet_config;	/* configuration/cap */
+		union {			/* timer compare register */
+			u64		_hpet_hc64;
+			u32		_hpet_hc32;
+			unsigned long	_hpet_compare;	
+		} _u1;
+		u64	hpet_fsb[2];	/* FSB route */
+	} hpet_timers[1];
+};
+
+#define	hpet_mc		_u0._hpet_mc
+#define	hpet_compare	_u1._hpet_compare
+
+#define	HPET_MAX_TIMERS	(32)
+
+/*
+ * HPET general capabilities register
+ */
+
+#define	HPET_COUNTER_CLK_PERIOD_MASK	(0xffffffff00000000ULL)
+#define	HPET_COUNTER_CLK_PERIOD_SHIFT	(32UL)
+#define	HPET_VENDOR_ID_MASK		(0x00000000ffff0000ULL)
+#define	HPET_VENDOR_ID_SHIFT		(16ULL)
+#define	HPET_LEG_RT_CAP_MASK		(0x8000)
+#define	HPET_COUNTER_SIZE_MASK		(0x2000)
+#define	HPET_NUM_TIM_CAP_MASK		(0x1f00)
+#define	HPET_NUM_TIM_CAP_SHIFT		(8ULL)
+
+
+/*
+ * HPET general configuration register
+ */
+
+
+#define	HPET_LEG_RT_CNF_MASK		(2UL)
+#define	HPET_ENABLE_CNF_MASK		(1UL)
+
+/*
+ * HPET interrupt status register
+ */
+
+#define	HPET_ISR_CLEAR(HPET, TIMER)				\
+		(HPET)->hpet_isr |= (1UL << TIMER)
+
+
+
+
+/*
+ * Timer configuration register
+ */
+
+#define	Tn_INT_ROUTE_CAP_MASK		(0xffffffff00000000ULL)
+#define	Tn_INI_ROUTE_CAP_SHIFT		(32UL)
+#define	Tn_FSB_INT_DELCAP_MASK		(0x8000UL)
+#define	Tn_FSB_INT_DELCAP_SHIFT		(15)
+#define	Tn_FSB_EN_CNF_MASK		(0x4000UL)
+#define	Tn_FSB_EN_CNF_SHIFT		(14)
+#define	Tn_INT_ROUTE_CNF_MASK		(0x3e00UL)
+#define	Tn_INT_ROUTE_CNF_SHIFT		(9)
+#define	Tn_32MODE_CNF_MASK		(0x0100UL)
+#define	Tn_VAL_SET_CNF_MASK		(0x0040UL)
+#define	Tn_SIZE_CAP_MASK		(0x0020UL)
+#define	Tn_PER_INT_CAP_MASK		(0x0010UL)
+#define	Tn_TYPE_CNF_MASK		(0x0008UL)
+#define	Tn_INT_ENB_CNF_MASK		(0x0004UL)
+#define	Tn_INT_TYPE_CNF_MASK		(0x0002UL)
+
+/*
+ * Timer FSB Interrupt Route Register
+ */
+
+#define	Tn_FSB_INT_ADDR_MASK		(0xffffffff00000000ULL)
+#define	Tn_FSB_INT_ADDR_SHIFT		(32UL)
+#define	Tn_FSB_INT_VAL_MASK		(0x00000000ffffffffULL)
+				
+struct hpet_info {
+		unsigned long 	hi_ireqfreq;	/* Hz */
+		unsigned long	hi_flags;	/* information */
+};
+
+#define	HPET_INFO_PERIODIC	0x0001		/* timer is periodic */
+
+
+#define	HPET_IE_ON	_IO('h', 0x01)			/* interrupt on */
+#define	HPET_IE_OFF	_IO('h', 0x02)			/* interrupt off */
+#define	HPET_INFO	_IOR('h', 0x03, struct hpet_info)
+#define	HPET_EPI	_IO('h', 0x04)			/* enable periodic */
+#define	HPET_DPI	_IO('h', 0x05)			/* disable periodic */
+#define	HPET_IRQFREQ	_IOW('h', 0x6, unsigned long)	/* IRQFREQ usec */
+
+
+
+/*
+ * exported interfaces
+ */
+
+struct hpet_task {
+	void	(*ht_func)(void *);
+	void	*ht_data;
+	void	*ht_opaque;
+};
+
+struct hpet_data {
+	unsigned long	hd_address;
+	unsigned short	hd_nirqs;
+	unsigned short	hd_flags;
+	unsigned int	hd_state;	/* timer allocated */
+	unsigned int	hd_irq[HPET_MAX_TIMERS];
+};
+
+#define	HPET_DATA_PLATFORM	0x0001	/* platform call to hpet_alloc */
+
+int hpet_alloc(struct hpet_data *);
+int hpet_register(struct hpet_task *, int);
+int hpet_unregister(struct hpet_task *);
+int hpet_control(struct hpet_task *, unsigned int, unsigned long);
+
+
+#endif	/* !__HPET__ */
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.6-orig/include/linux/major.h linux-2.6.6-hpet/include/linux/major.h
--- linux-2.6.6-orig/include/linux/major.h	2004-05-09 22:32:26.000000000 -0400
+++ linux-2.6.6-hpet/include/linux/major.h	2004-05-10 13:03:56.000000000 -0400
@@ -165,4 +165,6 @@
 
 #define VIOTAPE_MAJOR		230
 
+#define HPET_MAJOR		229	/* High Precision Event Timer */
+
 #endif




