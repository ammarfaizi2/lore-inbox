Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266412AbUBDU3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUBDU3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:29:05 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:12301 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266568AbUBDU0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:26:40 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Wed, 4 Feb 2004 22:44:49 +0300
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rc3-mm1 - /proc/ide/HWIF for modular IDE
Message-ID: <20040204194449.GB3968@localhost.localdomain>
References: <20040203194840.GD3249@localhost.localdomain> <200402032139.24487.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <200402032139.24487.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2004 at 09:39:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 03 of February 2004 20:48, Andrey Borzenkov wrote:
> > currently /proc/ide/HWIF are created in one shot during initialization
> > or in ide-generic meaning that for modular IDE you must include
> > ide-generic.
> >
> > this adds per-hwif registration currently for PCI only (that is what I
> > can test); if this is OK I will make create_proc_ide_interfaces static
> > and replace it with create_proc_ide_interface where appropriate.
> >
> > this also makes /proc/ide entries for PCI chipset be correctly created
> >
> > -andrey
> 
> @@ -801,6 +805,12 @@ void ide_pci_register_host_proc (ide_pci
>  		tmp->next = p;
>  	} else
>  		ide_pci_host_proc_list = p;
> +
> +	if (proc_ide_root) {
> +		p->parent = proc_ide_root;
> +		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
> +		p->set = 2;
> +	}
>  }
>  
> You should add p->get_info only _after_ all hwifs of a host are probed,
> just like non-modular code does it.  Otherwise you are opening new races.
> 
> @@ -659,6 +659,10 @@ bypass_legacy_dma:
>  			 */
>  			d->init_hwif(hwif);
>  
> +#ifdef CONFIG_PROC_FS
> +		create_proc_ide_interface(hwif);
> +#endif
> +
>  		mate = hwif;
>  		at_least_one_hwif_enabled = 1;
>  	}
> 
> Same problem as above.
> 

oh :( is it possible to do it in probe_hwif_init? it would be most
logical place.

> ide_setup_pci_device()+ide_setup_pci_devices() are correct places
> to add registering of /proc/ide/<chipset> and /proc/ide/<hwif>.
> 

this patch does it for <hwif>

> Even better - you may fix every PCI driver to add these entries
> itself and remove these silly ide_pci_host_proc_t-s :-).
> 

I'll see. what are those races and are they inherently unfixable?

thank you

-andrey

> --bart
> 

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.2-rc3-mm1-modular_proc_ide.patch"

--- linux-2.6.2-rc3-mm1/drivers/ide/setup-pci.c.modular	2004-02-04 22:14:43.000000000 +0300
+++ linux-2.6.2-rc3-mm1/drivers/ide/setup-pci.c	2004-02-04 22:23:24.000000000 +0300
@@ -746,6 +746,10 @@ void ide_setup_pci_device (struct pci_de
 		probe_hwif_init(&ide_hwifs[index_list.b.low]);
 	if ((index_list.b.high & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index_list.b.high]);
+
+#ifdef CONFIG_PROC_FS
+	create_proc_ide_interfaces();
+#endif
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_device);
@@ -763,6 +767,10 @@ void ide_setup_pci_devices (struct pci_d
 		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
 	if ((index_list2.b.high & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
+
+#ifdef CONFIG_PROC_FS
+	create_proc_ide_interfaces();
+#endif
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);

--FkmkrVfFsRoUs1wW--
