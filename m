Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSIXOI1>; Tue, 24 Sep 2002 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbSIXOI1>; Tue, 24 Sep 2002 10:08:27 -0400
Received: from gherkin.frus.com ([192.158.254.49]:923 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S261683AbSIXOI0>;
	Tue, 24 Sep 2002 10:08:26 -0400
Message-Id: <m17tqRL-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: 2.5.38: modular IDE broken
In-Reply-To: <Pine.LNX.4.44.0209231749050.13892-100000@chaos.physics.uiowa.edu>
 "from Kai Germaschewski at Sep 23, 2002 05:51:28 pm"
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Date: Tue, 24 Sep 2002 09:13:27 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> ===== Makefile 1.5 vs edited =====
> --- 1.5/drivers/ide/Makefile	Wed Sep 18 20:11:21 2002
> +++ edited/Makefile	Mon Sep 23 17:50:05 2002
> @@ -24,7 +24,7 @@
>  obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
>  obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
>  
> -ifeq ($(CONFIG_BLK_DEV_IDE),y)
> +ifdef CONFIG_BLK_DEV_IDE
>  obj-$(CONFIG_PROC_FS)			+= ide-proc.o
>  endif

I neglected to mention that the above patch (exactly the same, as it
turns out :-)) is how I forced the ide-proc.o build.  The brokenness
extends deeper.

Specific example: proc_ide_read_geometry has the requisite EXPORT_SYMBOL()
wrapper in ide-proc.c, yet, I still end up with proc_ide_read_geometry_R*
unresolved at depmod time.  In case anyone is wondering, I *did* do a
"make clean", manually cleaned out linux/include/modules to make *sure*
there wasn't any old cruft lying about, then ran "make dep && make bzImage &&
make modules && make modules_install".  The depmod output quoted below is
the result of all that.

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

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
