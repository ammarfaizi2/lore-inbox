Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291452AbSBUJ7r>; Thu, 21 Feb 2002 04:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291565AbSBUJ7l>; Thu, 21 Feb 2002 04:59:41 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:2710 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S291452AbSBUJ7U>; Thu, 21 Feb 2002 04:59:20 -0500
Date: Thu, 21 Feb 2002 11:48:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <3C74C05A.900A30FE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:
> > #include <asm/system.h>
> > #include <linux/notifier.h>
> > #include <linux/reboot.h>
> > #include <linux/init.h>
> 
> try deleting all includes and rebuild this list from scratch... I'll bet
> it can be made smaller.

Will do.

> > static int sc1200wdt_release(struct inode *inode, struct file *file)
> > {
> >         lock_kernel();
> > 
> >         /* Disable it on the way out */
> >         sc1200wdt_write_data(WDTO, 0);
> >         up(&open_sem);
> > 
> >         unlock_kernel();
> > 
> >         printk(KERN_INFO PFX "Watchdog disabled\n");
> >         MOD_DEC_USE_COUNT;
> > 
> >         return 0;
> > }
> 
> are you certain we need lock_kernel(), unlock_kernel() here?
> especially with a semaphore...

I'll remove the lock/unlock_kernel from there and shuffle the semaphore 
around.

> > static struct file_operations sc1200wdt_fops =
> > {
> >         owner:          THIS_MODULE,
> >         write:          sc1200wdt_write,
> >         ioctl:          sc1200wdt_ioctl,
> >         open:           sc1200wdt_open,
> >         release:        sc1200wdt_release,
> > };
> 
> I noticed wdt_pci.c implements ->read, too, why not here as well?

Hmm i see wdt_pci uses its read call for getting temperature status, the 
only thing i can report back is the status of the watchdog, and that i 
currently send back via an ioctl call (WDIOC_GETSTATUS). The chip i have a 
datasheet for doesn't have temperature reporting via watchdog, but there 
are bits (supported by lmsensors) which can do that.

> Look at how i810_rng does its PCI probe.  [I'm guessing]  Surely this
> SC1200 hardware has _some_ sort of identifier, like a list of commonly
> found PCI host bridges, that is better than the simple request_region()
> provided.

Its an ISAPNP device so we can probe like that (logical device 8), this 
particular module doesn't have PnP support (i was gonna add it later), i 
was wondering wether there was a possible non PnP probe we could do.

> Overall, looks good... nice, clean driver.

Thanks, but i think i wasted my time on this one, there is a driver for 
most of the SC1200 bits (including watchdog) at http://www.nano-system.com/scx200

Cheers,
	Zwane Mwaikambo



