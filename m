Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293049AbSBWAAK>; Fri, 22 Feb 2002 19:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSBWAAB>; Fri, 22 Feb 2002 19:00:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293046AbSBVX7n>;
	Fri, 22 Feb 2002 18:59:43 -0500
Message-ID: <3C76DB6D.118A98C8@mandrakesoft.com>
Date: Fri, 22 Feb 2002 18:59:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Greg KH <greg@kroah.com>,
        "=?iso-8859-1?Q?G=E9rard?= Roudier" <groudier@free.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> The problem is how do you deal with multiple HOSTs given there drivers are
> not (have not checked lately) capable of discrete HOST addition and
> removal.
> 
> SCSI/ATA share the same problem IIRC, the host/chipset drivers load all
> the device hosts who match that driver code.
> 
> What am I missing?

Nothing, I think --

The PCI API is just a different way of doing the same thing:  discrete
HOST addition and removal.  That is --exactly-- what the PCI API is.

Let me give an example of a very simple PCI API IDE driver:
(WARNING WARNING, no error checking!)

struct pci_driver jgarzik_ide_driver = {
	probe:	jg_host_add,
	remove: jg_host_remove,
};

static int __devinit jg_host_add(struct pci_dev *host_pci, ...)
{
	ide_hwif_t *host_ata = kmalloc(sizeof(*host_ata), GFP_KERNEL);
	pci_set_drvdata(host_pci, host_ata);
	ide_setup_ports(&host_ata->hw, ...);
	return ide_register_hw(&host_ata->hw, &host_ata);
}

static void __devexit jg_host_remove(struct pci_dev *host_pci)
{
	ide_hwif_t *host_ata = pci_get_drvdata(host_pci);
	ide_unregister_hw(&host_ata->hw, &host_ata);
	kfree(host_ata);
	pci_set_drvdata(host_pci, NULL);
}

static int __init jg_driver_init(void)
{
	return pci_module_init(&jgarzik_ide_driver);
}

static void __exit jg_driver_exit(void)
{
	pci_unregister_driver(&jgarzik_ide_driver);
}
module_init(jg_driver_init);
module_exit(jg_driver_exit);

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
