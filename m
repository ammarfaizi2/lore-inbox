Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSIWWqh>; Mon, 23 Sep 2002 18:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbSIWWqh>; Mon, 23 Sep 2002 18:46:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:30853 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261434AbSIWWq2>; Mon, 23 Sep 2002 18:46:28 -0400
Date: Mon, 23 Sep 2002 17:51:28 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Bob_Tracy <rct@gherkin.frus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38: modular IDE broken
In-Reply-To: <m17takZ-0005khC@gherkin.frus.com>
Message-ID: <Pine.LNX.4.44.0209231749050.13892-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Bob_Tracy wrote:

> This may well have been broken in earlier versions...  The last one I
> tried to compile before 2.5.38 was 2.5.34.  Quick problem summary:
> 
> ide-proc.o doesn't get built if CONFIG_BLK_DEV_IDE isn't "y", so
> depmod complains about unresolved symbols.

Yup, drivers/ide/Makefile should have

===== Makefile 1.5 vs edited =====
--- 1.5/drivers/ide/Makefile	Wed Sep 18 20:11:21 2002
+++ edited/Makefile	Mon Sep 23 17:50:05 2002
@@ -24,7 +24,7 @@
 obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
+ifdef CONFIG_BLK_DEV_IDE
 obj-$(CONFIG_PROC_FS)			+= ide-proc.o
 endif
 
> If I edit linux/drivers/ide/Makefile to force the build, I still end
> up with various depmod errors, some of which would doubtless go away
> if I turned off module versioning.  Anyone got a quick fix that I'm
> too tired to see?  Here's the depmod output with ide-proc.o forced:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.38; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide-disk.o
> depmod:         proc_ide_read_geometry_R50fed6f7
> depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide-floppy.o
> depmod:         proc_ide_read_geometry_R50fed6f7
> depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide-probe.o
> depmod:         do_ide_request
> depmod:         ide_add_generic_settings
> depmod:         create_proc_ide_interfaces_Rab2c600e
> depmod:         ide_bus_type
> depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide.o
> depmod:         proc_ide_create_Ra8e0f104
> depmod:         ide_remove_proc_entries_R5a5a621b
> depmod:         ide_add_proc_entries_Rce569c25
> depmod:         destroy_proc_ide_drives_Ra54f63e5
> depmod:         proc_ide_destroy_R35e1351c
> depmod:         bus_unregister
> depmod:         proc_ide_read_capacity_R46b2a30d
> depmod:         create_proc_ide_interfaces_Rab2c600e
> depmod:         ide_scan_pcibus
> make: *** [_modinst_post] Error 1

Basically, for all symbols which don't end in _R*, an EXPORT_SYMBOL() 
statement is missing. Add as necessary ;)

--Kai


