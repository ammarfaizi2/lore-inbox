Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266629AbUBEVB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUBEVB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:01:27 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:24849 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266629AbUBEVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:01:22 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Thu, 5 Feb 2004 23:41:04 +0300
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rc3-mm1 - /proc/ide/HWIF for modular IDE
Message-ID: <20040205204104.GA8692@localhost.localdomain>
References: <20040203194840.GD3249@localhost.localdomain> <200402032139.24487.bzolnier@elka.pw.edu.pl> <20040204194449.GB3968@localhost.localdomain> <200402042255.33476.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <200402042255.33476.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2004 at 10:55:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > You should add p->get_info only _after_ all hwifs of a host are probed,
> > > just like non-modular code does it.  Otherwise you are opening new races.
> 
> My previous comment is (probably) wrong :-).
> I've just checked all PCI drivers and don't see anything preventing this.
> 
> > > @@ -659,6 +659,10 @@ bypass_legacy_dma:
> > >  			 */
> > >  			d->init_hwif(hwif);
> > >
> > > +#ifdef CONFIG_PROC_FS
> > > +		create_proc_ide_interface(hwif);
> > > +#endif
> > > +
> > >  		mate = hwif;
> > >  		at_least_one_hwif_enabled = 1;
> > >  	}
> > >
> > > Same problem as above.
> >
> > oh :( is it possible to do it in probe_hwif_init? it would be most
> > logical place.
> 
> It is not logical place - you got 1 <chipset> /proc entry per PCI device(s).
> ide_pci_register_host_proc() (as done in first patch) is more logical.
> 

I actually meant  hwif no chipset  but if you say it is racy anyway ...

so what about this version? it gives me both hwif and chipset and does
not require messing with all pci drivers.

thank you

-andrey

> > > ide_setup_pci_device()+ide_setup_pci_devices() are correct places
> > > to add registering of /proc/ide/<chipset> and /proc/ide/<hwif>.
> >
> > this patch does it for <hwif>
> >
> > > Even better - you may fix every PCI driver to add these entries
> > > itself and remove these silly ide_pci_host_proc_t-s :-).
> >
> > I'll see. what are those races and are they inherently unfixable?
> 
> ie. if <hwif> entry is registered before second (serialized) port is probed,
> see proc_ide_write_config() for details.
> 
> Thanks,
> --bart
> 

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.2-mm1-modular_proc_ide.patch"

--- linux-2.6.2-mm1/drivers/ide/ide-proc.c.modular	2004-02-04 23:30:42.000000000 +0300
+++ linux-2.6.2-mm1/drivers/ide/ide-proc.c	2004-02-05 23:02:54.000000000 +0300
@@ -801,6 +801,13 @@ void ide_pci_register_host_proc (ide_pci
 		tmp->next = p;
 	} else
 		ide_pci_host_proc_list = p;
+
+	if (proc_ide_root) {
+		p->parent = proc_ide_root;
+		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
+		p->set = 2;
+	}
+
 }
 
 EXPORT_SYMBOL(ide_pci_register_host_proc);
--- linux-2.6.2-mm1/drivers/ide/setup-pci.c.modular	2004-02-05 22:59:48.000000000 +0300
+++ linux-2.6.2-mm1/drivers/ide/setup-pci.c	2004-02-05 22:59:54.000000000 +0300
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

--M9NhX3UHpAaciwkO--
