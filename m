Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266576AbUBDVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUBDVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:54:16 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13794 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266557AbUBDVyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:54:01 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] rc3-mm1 - /proc/ide/HWIF for modular IDE
Date: Wed, 4 Feb 2004 22:55:33 +0100
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040203194840.GD3249@localhost.localdomain> <200402032139.24487.bzolnier@elka.pw.edu.pl> <20040204194449.GB3968@localhost.localdomain>
In-Reply-To: <20040204194449.GB3968@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402042255.33476.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 of February 2004 20:44, Andrey Borzenkov wrote:
> On Tue, Feb 03, 2004 at 09:39:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 03 of February 2004 20:48, Andrey Borzenkov wrote:
> > > currently /proc/ide/HWIF are created in one shot during initialization
> > > or in ide-generic meaning that for modular IDE you must include
> > > ide-generic.
> > >
> > > this adds per-hwif registration currently for PCI only (that is what I
> > > can test); if this is OK I will make create_proc_ide_interfaces static
> > > and replace it with create_proc_ide_interface where appropriate.
> > >
> > > this also makes /proc/ide entries for PCI chipset be correctly created
> > >
> > > -andrey
> >
> > @@ -801,6 +805,12 @@ void ide_pci_register_host_proc (ide_pci
> >  		tmp->next = p;
> >  	} else
> >  		ide_pci_host_proc_list = p;
> > +
> > +	if (proc_ide_root) {
> > +		p->parent = proc_ide_root;
> > +		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
> > +		p->set = 2;
> > +	}
> >  }
> >
> > You should add p->get_info only _after_ all hwifs of a host are probed,
> > just like non-modular code does it.  Otherwise you are opening new races.

My previous comment is (probably) wrong :-).
I've just checked all PCI drivers and don't see anything preventing this.

> > @@ -659,6 +659,10 @@ bypass_legacy_dma:
> >  			 */
> >  			d->init_hwif(hwif);
> >
> > +#ifdef CONFIG_PROC_FS
> > +		create_proc_ide_interface(hwif);
> > +#endif
> > +
> >  		mate = hwif;
> >  		at_least_one_hwif_enabled = 1;
> >  	}
> >
> > Same problem as above.
>
> oh :( is it possible to do it in probe_hwif_init? it would be most
> logical place.

It is not logical place - you got 1 <chipset> /proc entry per PCI device(s).
ide_pci_register_host_proc() (as done in first patch) is more logical.

> > ide_setup_pci_device()+ide_setup_pci_devices() are correct places
> > to add registering of /proc/ide/<chipset> and /proc/ide/<hwif>.
>
> this patch does it for <hwif>
>
> > Even better - you may fix every PCI driver to add these entries
> > itself and remove these silly ide_pci_host_proc_t-s :-).
>
> I'll see. what are those races and are they inherently unfixable?

ie. if <hwif> entry is registered before second (serialized) port is probed,
see proc_ide_write_config() for details.

Thanks,
--bart

