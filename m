Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290816AbSBUJkE>; Thu, 21 Feb 2002 04:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290926AbSBUJjy>; Thu, 21 Feb 2002 04:39:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290816AbSBUJjm>;
	Thu, 21 Feb 2002 04:39:42 -0500
Message-ID: <3C74C05A.900A30FE@mandrakesoft.com>
Date: Thu, 21 Feb 2002 04:39:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202210752080.7649-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /*
>  *      National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
>  *      (c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>,
>  *                      All Rights Reserved.
>  *      Based on wdt.c and wdt977.c by Alan Cox and Woody Suwalski respectively.


whee, nice and clean driver....


> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/version.h>
> #include <linux/types.h>
> #include <linux/errno.h>
> #include <linux/kernel.h>
> #include <linux/sched.h>
> #include <linux/smp_lock.h>
> #include <linux/miscdevice.h>
> #include <linux/watchdog.h>
> #include <linux/slab.h>
> #include <linux/ioport.h>
> #include <linux/fcntl.h>
> #include <asm/semaphore.h>
> #include <asm/io.h>
> #include <asm/uaccess.h>
> #include <asm/system.h>
> #include <linux/notifier.h>
> #include <linux/reboot.h>
> #include <linux/init.h>

try deleting all includes and rebuild this list from scratch... I'll bet
it can be made smaller.



> static int sc1200wdt_status(void)

why not make this 'static inline' too, it's pretty small, and
sc1200wdt_read_data is likewise static inline.

> static int sc1200wdt_open(struct inode *inode, struct file *file)
> {
>         unsigned char reg;
> 
>         /* allow one at a time */
>         if (down_trylock(&open_sem))
>                 return -EBUSY;
> 
>         MOD_INC_USE_COUNT;

No need for MOD_INC_USE_COUNT when you initialize "owner: THIS_MODULE".

Maybe this is a cleanup you copied from another driver, and this change
needs to be propagated to other drivers too?

>         if (timeout > 255)
>                 timeout = 255;

IMHO use a constant here instead of magic number 255.  maybe use max()
or max_t(), too.


>                 case WDIOC_SETTIMEOUT:
>                         if (get_user(new_timeout, (int *)arg))
>                                 return -EFAULT;
>                         if (new_timeout < 0 || new_timeout > 255)
>                                 return -EINVAL;

likewise


> static int sc1200wdt_release(struct inode *inode, struct file *file)
> {
>         lock_kernel();
> 
>         /* Disable it on the way out */
>         sc1200wdt_write_data(WDTO, 0);
>         up(&open_sem);
> 
>         unlock_kernel();
> 
>         printk(KERN_INFO PFX "Watchdog disabled\n");
>         MOD_DEC_USE_COUNT;
> 
>         return 0;
> }

are you certain we need lock_kernel(), unlock_kernel() here?
especially with a semaphore...


> static struct file_operations sc1200wdt_fops =
> {
>         owner:          THIS_MODULE,
>         write:          sc1200wdt_write,
>         ioctl:          sc1200wdt_ioctl,
>         open:           sc1200wdt_open,
>         release:        sc1200wdt_release,
> };

I noticed wdt_pci.c implements ->read, too, why not here as well?


> static int __init sc1200wdt_probe(int base_io)
> {
>         /* How can we probe for this thing? */
>         return 0;
> }
> 
> static int __init sc1200wdt_init(void)

Look at how i810_rng does its PCI probe.  [I'm guessing]  Surely this
SC1200 hardware has _some_ sort of identifier, like a list of commonly
found PCI host bridges, that is better than the simple request_region()
provided.

Overall, looks good... nice, clean driver.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
