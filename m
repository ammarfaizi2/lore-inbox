Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTE3Umu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTE3Ums
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:42:48 -0400
Received: from uk134.internetdsl.tpnet.pl ([80.55.140.134]:37892 "EHLO
	cyborg.podlas36.one.pl") by vger.kernel.org with ESMTP
	id S263987AbTE3Umm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:42:42 -0400
From: Krzysiek Taraszka <dzimi@pld.org.pl>
To: Santiago Garcia Mantinan <manty@manty.net>,
       Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.21-rc3
Date: Fri, 30 May 2003 22:55:58 +0200
User-Agent: KMail/1.5.1
Cc: kernel list <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200305261400.h4QE00JF009630@green.mif.pg.gda.pl> <20030526175354.GA4051@man.beta.es>
In-Reply-To: <20030526175354.GA4051@man.beta.es>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eV81+bjMwZSBwlQ"
Message-Id: <200305302255.58353.dzimi@pld.org.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_eV81+bjMwZSBwlQ
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dnia pon 26. maja 2003 19:53, Santiago Garcia Mantinan napisa=B3:
> The patch Andrzej sent only solves part of the problem, I can still see
> this:
>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-probe.o
> depmod:         do_ide_request
> depmod:         ide_add_generic_settings
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-proc.o
> depmod:         ide_find_setting_by_name
> depmod:         ide_modules
> depmod:         ide_read_setting
> depmod:         generic_subdriver_entries
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide.o
> depmod:         ide_release_dma
> depmod:         pnpide_init
> depmod:         ide_scan_pcibus

> Hope this helps fixing ide modules compiling before 2.4.21 is released.

Yes, my patch should fix it (I test it :))
So, Marcelo, Alan, please apply my patch.

=2D-=20
Krzysiek Taraszka			(dzimi@pld.org.pl)
http://cyborg.kernel.pl/~dzimi/

--Boundary-00=_eV81+bjMwZSBwlQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ide-symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ide-symbols.patch"

diff -urN linux-2.4.20-rc6.orig/drivers/ide/Makefile linux-2.4.20-rc6/drivers/ide/Makefile
--- linux-2.4.20-rc6.orig/drivers/ide/Makefile	Fri May 30 22:52:30 2003
+++ linux-2.4.20-rc6/drivers/ide/Makefile	Fri May 30 22:17:16 2003
@@ -43,9 +43,8 @@
 endif
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
+ifeq ($(CONFIG_PROC_FS),y)
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-proc.o
 endif
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
diff -urN linux-2.4.20-rc6.orig/drivers/ide/ide-io.c linux-2.4.20-rc6/drivers/ide/ide-io.c
--- linux-2.4.20-rc6.orig/drivers/ide/ide-io.c	Fri May 30 22:52:30 2003
+++ linux-2.4.20-rc6/drivers/ide/ide-io.c	Fri May 30 22:25:30 2003
@@ -896,6 +896,8 @@
 	ide_do_request(q->queuedata, IDE_NO_IRQ);
 }
 
+EXPORT_SYMBOL(do_ide_request);
+
 /*
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
  * retry the current request in pio mode instead of risking tossing it
diff -urN linux-2.4.20-rc6.orig/drivers/ide/ide.c linux-2.4.20-rc6/drivers/ide/ide.c
--- linux-2.4.20-rc6.orig/drivers/ide/ide.c	Fri May 30 22:52:31 2003
+++ linux-2.4.20-rc6/drivers/ide/ide.c	Fri May 30 22:47:00 2003
@@ -190,6 +190,8 @@
 ide_module_t *ide_modules;
 ide_module_t *ide_probe;
 
+EXPORT_SYMBOL(ide_modules);
+
 /*
  * This is declared extern in ide.h, for access by other IDE modules:
  */
@@ -597,6 +599,9 @@
 	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
+
+EXPORT_SYMBOL(generic_subdriver_entries);
+
 #endif
 
 
@@ -1181,6 +1186,8 @@
 	return setting;
 }
 
+EXPORT_SYMBOL(ide_find_setting_by_name);
+
 /**
  *	auto_remove_settings	-	remove driver specific settings
  *	@drive: drive
@@ -1241,6 +1248,8 @@
 	return val;
 }
 
+EXPORT_SYMBOL(ide_read_setting);
+
 int ide_spin_wait_hwgroup (ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
@@ -1414,6 +1423,8 @@
 #endif		
 }
 
+EXPORT_SYMBOL(ide_add_generic_settings);
+
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
  * until the next tick occurs, we wait an extra tick to be safe.
@@ -2820,6 +2831,8 @@
 	devfs_unregister (ide_devfs_handle);
 }
 
+EXPORT_SYMBOL(ide_release_dma);
+
 #else /* !MODULE */
 
 __setup("", ide_setup);
diff -urN linux-2.4.20-rc6.orig/drivers/ide/setup-pci.c linux-2.4.20-rc6/drivers/ide/setup-pci.c
--- linux-2.4.20-rc6.orig/drivers/ide/setup-pci.c	Fri May 30 22:52:31 2003
+++ linux-2.4.20-rc6/drivers/ide/setup-pci.c	Fri May 30 22:49:02 2003
@@ -830,3 +830,5 @@
 		pci_register_driver(d);
 	}
 }
+
+EXPORT_SYMBOL(ide_scan_pcibus);
\ No newline at end of file

--Boundary-00=_eV81+bjMwZSBwlQ--

