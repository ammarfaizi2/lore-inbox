Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWKBGPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWKBGPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 01:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWKBGPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 01:15:41 -0500
Received: from xenotime.net ([66.160.160.81]:49073 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751842AbWKBGPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 01:15:40 -0500
Date: Wed, 1 Nov 2006 22:11:25 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Thomas Koeller <thomas@koeller.dyndns.org>,
       Ralf Baechle <ralf@linux-mips.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-Id: <20061101221125.73505baa.rdunlap@xenotime.net>
In-Reply-To: <20061101184633.GA7056@infomag.infomag.iguana.be>
References: <20061101184633.GA7056@infomag.infomag.iguana.be>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 19:46:33 +0100 Wim Van Sebroeck wrote:

> /* Function prototypes */
> static int __init wdt_gpi_probe(struct device *);
> static int __exit wdt_gpi_remove(struct device *);
> static void wdt_gpi_start(void);
> static void wdt_gpi_stop(void);
> static void wdt_gpi_set_timeout(unsigned int);
> static int wdt_gpi_open(struct inode *, struct file *);
> static int wdt_gpi_release(struct inode *, struct file *);
> static ssize_t wdt_gpi_write(struct file *, const char __user *, size_t, loff_t *);
> static long wdt_gpi_ioctl(struct file *, unsigned int, unsigned long);
> static const struct resource *wdt_gpi_get_resource(struct platform_device *, const char *, unsigned int);

Some lines too long (stay <= 80 columns).

> static int wdt_gpi_notify(struct notifier_block *, unsigned long, void *);
> static irqreturn_t wdt_gpi_irqhdl(int, void *, struct pt_regs *);
> 
> 
> 
> 
> static const char wdt_gpi_name[] = "wdt_gpi";
> static atomic_t opencnt;
> static int expect_close;
> static int locked = 0;

Don't need to init to 0.

> /* Module arguments */
> static int timeout = MAX_TIMEOUT_SECONDS;
> module_param(timeout, int, 0444);
> static unsigned long resetaddr = 0xbffdc200;
> module_param(resetaddr, ulong, 0444);
> static unsigned long flagaddr = 0xbffdc104;
> module_param(flagaddr, ulong, 0444);
> static int powercycle = 0;

no need to init to 0.

> module_param(powercycle, bool, 0444);
> 
> static int nowayout = WATCHDOG_NOWAYOUT;
> module_param(nowayout, bool, 0444);
> 
> 
> 
> /* No hotplugging on the platform bus - use __init */
> static int __init wdt_gpi_probe(struct device *dev)
> {
> 	int res;
> 	struct platform_device * const pdv = to_platform_device(dev);
> 	const struct resource
> 		* const rr = wdt_gpi_get_resource(pdv, WDT_RESOURCE_REGS,
> 						  IORESOURCE_MEM),
> 		* const ri = wdt_gpi_get_resource(pdv, WDT_RESOURCE_IRQ,
> 						  IORESOURCE_IRQ),
> 		* const rc = wdt_gpi_get_resource(pdv, WDT_RESOURCE_COUNTER,
> 						  0);
> 
> 	if (unlikely(!rr || !ri || !rc))
> 		return -ENXIO;
> 
> 	wd_regs = ioremap_nocache(rr->start, rr->end + 1 - rr->start);
> 	if (unlikely(!wd_regs))
> 		return -ENOMEM;

There's no way to return the resources on failure?

> 	wd_irq = ri->start;
> 	wd_ctr = rc->start;
> 	res = misc_register(&miscdev);
> 	if (res)
> 		iounmap(wd_regs);
> 	else
> 		register_reboot_notifier(&wdt_gpi_shutdown);
> 	return res;
> }
> 
> 
> 
> static int wdt_gpi_open(struct inode *inode, struct file *file)
> {
> 	int res;
> 
> 	if (unlikely(0 > atomic_dec_if_positive(&opencnt)))

Style: Instead of
		if (constant op function_or_variable)
we prefer
		if (function_or_variable op constant)


> 		return -EBUSY;
> 
> 	expect_close = 0;
> 	if (locked) {
> 		module_put(THIS_MODULE);
> 		free_irq(wd_irq, &miscdev);
> 		locked = 0;
> 	}
> 
> 	res = request_irq(wd_irq, wdt_gpi_irqhdl, SA_SHIRQ | SA_INTERRUPT,
> 			  wdt_gpi_name, &miscdev);
> 	if (unlikely(res))
> 		return res;
> 
> 	wdt_gpi_set_timeout(timeout);
> 	wdt_gpi_start();
> 
> 	printk(KERN_INFO "%s: watchdog started, timeout = %u seconds\n",
> 		wdt_gpi_name, timeout);
> 	return nonseekable_open(inode, file);
> }
> 
> 
> 
> 
> static long
> wdt_gpi_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> {
> 	long res = -ENOTTY;
> 	const long size = _IOC_SIZE(cmd);
> 	int stat;
> 	static struct watchdog_info wdinfo = {
> 		.identity               = "RM9xxx/GPI watchdog",
> 		.firmware_version       = 0,
> 		.options                = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
> 	};
> 
> 	if (unlikely(_IOC_TYPE(cmd) != WATCHDOG_IOCTL_BASE))
> 		return -ENOTTY;
> 
> 	if ((_IOC_DIR(cmd) & _IOC_READ)
> 	    && !access_ok(VERIFY_WRITE, arg, size))
> 		return -EFAULT;
> 
> 	if ((_IOC_DIR(cmd) & _IOC_WRITE)
> 	    && !access_ok(VERIFY_READ, arg, size))
> 		return -EFAULT;
> 
> 	expect_close = 0;
> 
> 	switch (cmd) {
> 	case WDIOC_GETSUPPORT:
> 		wdinfo.options = nowayout ?
> 			WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING :
> 			WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
> 		res = __copy_to_user((void __user *)arg, &wdinfo, size) ?
> 			-EFAULT : size;
> 		break;
> 
> 	case WDIOC_GETSTATUS:
> 		break;
> 
> 	case WDIOC_GETBOOTSTATUS:
> 		stat = (*(volatile char *) flagaddr & 0x01)
> 			? WDIOF_CARDRESET : 0;
> 		res = __copy_to_user((void __user *)arg, &stat, size) ?
> 			-EFAULT : size;
> 		break;
> 
> 	case WDIOC_SETOPTIONS:
> 		break;
> 
> 	case WDIOC_KEEPALIVE:
> 		wdt_gpi_set_timeout(timeout);
> 		res = size;
> 		break;
> 
> 	case WDIOC_SETTIMEOUT:
> 		{
> 			int val;
> 			if (unlikely(__copy_from_user(&val, (const void __user *) arg,
> 					size))) {
> 				res = -EFAULT;
> 				break;
> 			}
> 
> 			if (val > 32)
> 				val = 32;

There's a #defined constant for that "32".
Please use it.

> 			timeout = val;
> 			wdt_gpi_set_timeout(val);
> 			res = size;
> 			printk("%s: timeout set to %u seconds\n",
> 				wdt_gpi_name, timeout);
> 		}
> 		break;
> 
> 	case WDIOC_GETTIMEOUT:
> 		res = __copy_to_user((void __user *) arg, &timeout, size) ?
> 			-EFAULT : size;
> 		break;
> 	}
> 
> 	return res;
> }
> 
> 
> 
> 
> static irqreturn_t wdt_gpi_irqhdl(int irq, void *ctxt, struct pt_regs *regs)
> {
> 	if (!unlikely(__raw_readl(wd_regs + 0x0008) & 0x1))
> 		return IRQ_NONE;
> 	__raw_writel(0x1, wd_regs + 0x0008);
> 
> 
> 	printk(KERN_WARNING "%s: watchdog expired - resetting system\n",
> 		wdt_gpi_name);

I would expect a KERN_ALERT or KERN_EMERG or KERN_CRIT there...

> 
> 	*(volatile char *) flagaddr |= 0x01;
> 	*(volatile char *) resetaddr = powercycle ? 0x01 : 0x2;
> 	iob();
> 	while (1)
> 		cpu_relax();
> }
> 
> 
> 
> static int
> wdt_gpi_notify(struct notifier_block *this, unsigned long code, void *unused)
> {
> 	if(code == SYS_DOWN || code == SYS_HALT) {

Space between if and (.

> 		wdt_gpi_stop();
> 	}

No braces around one-statement blocks.

> 	return NOTIFY_DONE;
> }

---
~Randy
