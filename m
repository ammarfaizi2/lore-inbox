Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTJNCCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 22:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTJNCCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 22:02:10 -0400
Received: from [65.248.4.67] ([65.248.4.67]:28367 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S262153AbTJNCCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 22:02:01 -0400
Message-ID: <001201c391f7$23c887c0$06dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Basic idea to write a net pci device driver
Date: Mon, 13 Oct 2003 23:01:52 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01C391DD.FD905380"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C391DD.FD905380
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I am studing how to write a net pci device driver. I´d like some help with
my code. I know that it´s need much more code , but i´d like to know if i am
in right way.

thanks

Breno

------=_NextPart_000_000F_01C391DD.FD905380
Content-Type: application/octet-stream;
	name="ethercard.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ethercard.c"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/errno.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/ethtool.h>
#include <asm/system.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include "8390.h"

#define ETHERNAME "ethercard"

static struct pci_device_id ethercard_id_table[] __devinitdata =3D {
    {0x10ec, 0x8029, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
};

static int ethercard_open(struct net_device *dev)
{
    /*need code*/
    return 0;
}

static int ethercard_stop(struct net_device *dev)
{
    free_irq(dev->irq,dev);
    return 0;
}

/* here some functions for packets */

static int __devinit ethercard_probe(struct pci_dev *c_dev, const struct =
pci_device_id *idp)
{
    int card,irq;
    struct net_device *dev;
    unsigned long ioaddr,rflag;
   =20
    card =3D pci_enable_device(c_dev);
   =20
    if(card)
    {
	printk(KERN_CRIT"PCI Driver found\n");
	return card;
    }
   =20
    ioaddr =3D pci_resource_start(c_dev,0);
   =20
    irq =3D c_dev->irq;
   =20
    rflag =3D pci_resource_flags(c_dev,0);
   =20
    if(!ioaddr || ((rflag & IORESOURCE_IO) =3D=3D 0))
    return -1;
   =20
    if((request_region(ioaddr,0x30,ETHERNAME) =3D=3D NULL))
    return -1;
   =20
    dev =3D alloc_etherdev(0);
   =20
    if(!dev)
    return -1;
   =20
    c_dev->driver_data =3D dev;
   =20
    dev->irq =3D irq;
    dev->base_addr =3D ioaddr;
    dev->open =3D &ethercard_open;
    dev->stop =3D &ethercard_stop;
   =20
    return 0;
}

static void __devexit ethercard_remove(struct pci_dev *c_dev)
{
}   =20

static struct pci_driver pci_struct =3D {
    name:	ETHERNAME,
    probe:	ethercard_probe,
    remove:	__devexit_p(ethercard_remove),
    id_table:	ethercard_id_table,
};

static int __init ethercard_init(void)
{
    printk(KERN_CRIT"Loading ether driver\n");
   =20
    return pci_module_init(&pci_struct);
}

static void __exit ethercard_exit(void)
{
    printk(KERN_CRIT"Unloading ether driver\n");
   =20
    return pci_unregister_driver(&pci_struct);
}

module_init(ethercard_init)
module_exit(ethercard_exit)    
------=_NextPart_000_000F_01C391DD.FD905380--

