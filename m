Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUBCUfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUBCUfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:35:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26255 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266094AbUBCUfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:35:42 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] rc3-mm1 - /proc/ide/HWIF for modular IDE
Date: Tue, 3 Feb 2004 21:39:24 +0100
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040203194840.GD3249@localhost.localdomain>
In-Reply-To: <20040203194840.GD3249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402032139.24487.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 of February 2004 20:48, Andrey Borzenkov wrote:
> currently /proc/ide/HWIF are created in one shot during initialization
> or in ide-generic meaning that for modular IDE you must include
> ide-generic.
>
> this adds per-hwif registration currently for PCI only (that is what I
> can test); if this is OK I will make create_proc_ide_interfaces static
> and replace it with create_proc_ide_interface where appropriate.
>
> this also makes /proc/ide entries for PCI chipset be correctly created
>
> -andrey

@@ -801,6 +805,12 @@ void ide_pci_register_host_proc (ide_pci
 		tmp->next = p;
 	} else
 		ide_pci_host_proc_list = p;
+
+	if (proc_ide_root) {
+		p->parent = proc_ide_root;
+		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
+		p->set = 2;
+	}
 }
 
You should add p->get_info only _after_ all hwifs of a host are probed,
just like non-modular code does it.  Otherwise you are opening new races.

@@ -659,6 +659,10 @@ bypass_legacy_dma:
 			 */
 			d->init_hwif(hwif);
 
+#ifdef CONFIG_PROC_FS
+		create_proc_ide_interface(hwif);
+#endif
+
 		mate = hwif;
 		at_least_one_hwif_enabled = 1;
 	}

Same problem as above.

ide_setup_pci_device()+ide_setup_pci_devices() are correct places
to add registering of /proc/ide/<chipset> and /proc/ide/<hwif>.

Even better - you may fix every PCI driver to add these entries
itself and remove these silly ide_pci_host_proc_t-s :-).

--bart

