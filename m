Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130349AbRARJUM>; Thu, 18 Jan 2001 04:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130880AbRARJUB>; Thu, 18 Jan 2001 04:20:01 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:43538 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130349AbRARJT5>;
	Thu, 18 Jan 2001 04:19:57 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pete Toscano <pete@research.netsol.com>
Date: Thu, 18 Jan 2001 10:18:50 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VIA chipset discussion
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <12E94AD3749E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 01 at 17:40, Pete Toscano wrote:
> according to the linux-usb maintainers, it's a pci irq routing problem.
> i've asked jeff garzik and martin mares if they'll look into it, but
> they're pretty busy and i haven't heard anything back from them (not
> that'd i'd expect to for quite a while, considering their load).  i've
> asked on the list too, but i've only heard back from people with the
> same problem, not anyone who can fix the problem.

I'm using kernel module below. Find which device your USB is. If it is
0:07.2 and 0:07.3, take 7*8 + 2 = 58 (resp. 59). Then try

for irq in 16 17 18 19; do
  insmod setpci devfn=58 irq=$irq
  insmod setpci devfn=59 irq=$irq
  modprobe <your usb ohci/uhci/alt-uhci>
  does it work -> stop
done

After you'll find correct IRQ, you are done ;-) Put this into your
initscript before usb loading (you must compile USB as module), or
you can insert your devfn/irq pair somewhere into pirq_get_info()...

My BIOS (Apollo Pro 133x) returns incorrect routing table when LPT is
not in ECP mode. When it is in ECP, reported routing table is correct
(and my USB is on IRQ19, if that matters).

/*
# Based on Makefile for the Linux video drivers.
# 5 Aug 1999, James Simmons, <mailto:jsimmons@edgeglobal.com>
# Rewritten to use lists instead of if-statements.

default:
    (cd /usr/src/linux; make SUBDIRS=/usr/src/linus/pci modules)

O_TARGET := setp.o

# All of the (potential) objects that export symbols.
# This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.

# Each configuration option enables a list of files.

obj-m += setpci.o

ifdef TOPDIR
include $(TOPDIR)/Rules.make
endif

clean:
    rm -f core *.o *.a *.s
*/

#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/pci.h>

static unsigned int devfn = -1;
static unsigned int irq   = -1;
MODULE_PARM(devfn, "i");
MODULE_PARM(irq, "i");

static int loadme(void) {
    struct pci_dev* dev;
    
    pci_for_each_dev(dev) {
        printk(KERN_DEBUG "%p: %04X: %04X:%04X -> %d\n",
            dev, dev->devfn, dev->vendor, dev->device, dev->irq);
        if (dev->devfn == devfn)
            dev->irq = irq;
    }
    return -EBUSY;
}

module_init(loadme);
 

                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
