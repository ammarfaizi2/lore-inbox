Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318744AbSIKMU3>; Wed, 11 Sep 2002 08:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSIKMU3>; Wed, 11 Sep 2002 08:20:29 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:63407 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318744AbSIKMU1>; Wed, 11 Sep 2002 08:20:27 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 11 Sep 2002 14:20:48 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Mares <mj@ucw.cz>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ignore pci devices?
Message-ID: <20020911122048.GA6863@bytesex.org>
References: <20020910134708.GA7836@bytesex.org> <20020910163023.GA3862@ucw.cz> <1031683362.1537.104.camel@irongate.swansea.linux.org.uk> <20020910184128.GA5627@ucw.cz> <1031688912.31787.129.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031688912.31787.129.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 09:15:12PM +0100, Alan Cox wrote:
> On Tue, 2002-09-10 at 19:41, Martin Mares wrote:
> > > pci_driver has no implicit ordering.
> > 
> > Agreed, but I meant inserting it as a module before the other
> > modules.
> 
> Which breaks the moment it meets a hotplug system

Neverless this works fine in the non-hotplugging modular driver case,
i.e. it can be used to fix that particular bt878 card issue.  Might also
be useful for testing ressource allocation error paths of PCI drivers.

  Gerd

==============================[ cut here ]==============================
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/kernel.h>

MODULE_DESCRIPTION("reserve pci card ressources to make device drivers *not* touch the card");
MODULE_AUTHOR("Gerd Knorr");
MODULE_LICENSE("GPL");

static char *ignore = "none";
MODULE_PARM(ignore,"s");
static int bus = -1, slot = -1,function = -1;

static void remove(struct pci_dev *dev)
{
	int i;
	
	printk("reserve: remove device %02x:%02x.%x\n",
	       dev->bus->number,PCI_SLOT(dev->devfn),PCI_FUNC(dev->devfn));
	for (i = 0;; i++) {
		if (0 == pci_resource_start(dev,i))
			break;
		if (pci_resource_start(dev,i) < 0x10000) {
			release_region(pci_resource_start(dev,i),
				       pci_resource_len(dev,i));
		} else {
			release_mem_region(pci_resource_start(dev,i),
					   pci_resource_len(dev,i));
		}
	}
        return;
}

static int __devinit probe(struct pci_dev *dev,
			   const struct pci_device_id *id)
{
	struct resource *res;
	int i;

	if (bus      != dev->bus->number     ||
	    slot     != PCI_SLOT(dev->devfn) ||
	    function != PCI_FUNC(dev->devfn))
		return -EBUSY;

	printk("reserve: probe device %02x:%02x.%x\n",
	       dev->bus->number,PCI_SLOT(dev->devfn),PCI_FUNC(dev->devfn));
	for (i = 0;; i++) {
		if (0 == pci_resource_start(dev,i))
			break;
		if (pci_resource_start(dev,i) < 0x10000) {
			res = request_region(pci_resource_start(dev,i),
					     pci_resource_len(dev,i),
					     "reserve");
			printk("reserve: ... io  at %lx size %lx [%s]\n",
			       pci_resource_start(dev,i),
			       pci_resource_len(dev,i),
			       res ? "ok" : "failed");
			if (!res)
				goto busy;
		} else {
			res = request_mem_region(pci_resource_start(dev,i),
						 pci_resource_len(dev,i),
						 "reserve");
			printk("reserve: ... mem at %lx size %lx [%s]\n",
			       pci_resource_start(dev,i),
			       pci_resource_len(dev,i),
			       res ? "ok" : "failed");
			if (!res)
				goto busy;
		}
	}
	return 0;

 busy:
	i--;
	while (i >= 0) {
		if (pci_resource_start(dev,i) < 0x10000) {
			release_region(pci_resource_start(dev,i),
				       pci_resource_len(dev,i));
		} else {
			release_mem_region(pci_resource_start(dev,i),
					   pci_resource_len(dev,i));
		}
	}
        return -EBUSY;
}

static struct pci_device_id pci_tbl[] __devinitdata = {
        {
		.vendor    = PCI_ANY_ID,
		.device    = PCI_ANY_ID,
		.subvendor = PCI_ANY_ID,
		.subdevice = PCI_ANY_ID,
	},
	{ /* end of list */}
};

MODULE_DEVICE_TABLE(pci, pci_tbl);

static struct pci_driver pci_driver = {
        name:     "reserve",
        id_table: pci_tbl,
        probe:    probe,
        remove:   remove,
};

static int do_init(void)
{
	if (3 == sscanf(ignore,"%x:%x.%x",&bus,&slot,&function)) {
		/* nothing */;
	} else if (2 == sscanf(ignore,"%x.%x",&slot,&function)) {
		bus = 0;
	} else if (2 == sscanf(ignore,"%x:%x",&bus,&slot)) {
		function = 0;
	} else if (1 == sscanf(ignore,"%x",&slot)) {
		bus = 0;
		function = 0;
	} else {
		printk("reserve: can't parse ignore=<device> insmod option\n");
		return -EINVAL;
	}
	printk("reserve: ignore=\"%s\"  ->  using device %02x:%02x.%x\n",
	       ignore,bus,slot,function);
	return pci_module_init(&pci_driver);
}

static void do_fini(void)
{
	pci_unregister_driver(&pci_driver);
}

module_init(do_init);
module_exit(do_fini);

/*
 * Local variables:
 * c-basic-offset: 8
 * End:
 */

