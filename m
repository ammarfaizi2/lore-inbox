Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbTD0OQO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 10:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbTD0OQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 10:16:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58049 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264668AbTD0OQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 10:16:12 -0400
Date: Sun, 27 Apr 2003 16:28:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Toni Viemero <toni.viemero@iki.fi>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] Re: 2.4.21-rc1 compile fails on serveraid
Message-ID: <20030427142821.GM10256@fs.tum.de>
References: <20030426085614.GA13428@extra.mediatraffic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426085614.GA13428@extra.mediatraffic.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 11:56:14AM +0300, Toni Viemero wrote:
> [..snip..]
> drivers/scsi/scsidrv.o: In function `ips_insert_device':
> drivers/scsi/scsidrv.o(.text.init+0x352): undefined reference to `local
> symbols in discarded section .text.exit'
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory `/usr/src/linux'
> make: *** [stamp-build] Error 2
> 
> 
> And running http://kernelnewbies.org/scripts/reference_discarded.pl
> 
> north:/usr/src/linux# perl /root/reference_discarded.pl
> Finding objects, 401 objects, ignoring 0 module(s)
> Finding conglomerates, ignoring 32 conglomerate(s)
> Scanning objects
> Error: ./drivers/scsi/ips.o .text.init refers to 000000a2 R_386_PC32
> .text.exit
> Done

__devinit ips_insert_device calls __devexit ips_remove_device. The patch 
below fixes it be removing the __devexit from ips_remove_device.

I've tested the compilation with 2.4.21-rc1.

cu
Adrian

--- linux-2.4.21-pre6-full-nohotplug/drivers/scsi/ips.c.old	2003-03-27 22:25:49.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/scsi/ips.c	2003-03-27 22:28:51.000000000 +0100
@@ -246,9 +246,6 @@
     #define IPS_SG_ADDRESS(sg)       ((sg)->address)
     #define IPS_LOCK_SAVE(lock,flags) spin_lock_irqsave(&io_request_lock,flags)
     #define IPS_UNLOCK_RESTORE(lock,flags) spin_unlock_irqrestore(&io_request_lock,flags)
-    #ifndef __devexit_p
-        #define __devexit_p(x) x
-    #endif
 #else
     #define IPS_SG_ADDRESS(sg)      (page_address((sg)->page) ? \
                                      page_address((sg)->page)+(sg)->offset : 0)
@@ -338,48 +335,48 @@
    static char ips_hot_plug_name[] = "ips";
    
    static int __devinit  ips_insert_device(struct pci_dev *pci_dev, const struct pci_device_id *ent);
-   static void __devexit ips_remove_device(struct pci_dev *pci_dev);
+   static void ips_remove_device(struct pci_dev *pci_dev);
    
    struct pci_driver ips_pci_driver = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    }; 
            
    struct pci_driver ips_pci_driver_anaconda = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_anaconda,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    }; 
 
    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
            
    struct pci_driver ips_pci_driver_6i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_6i,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
 
    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
 
    struct pci_driver ips_pci_driver_adaptec = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_adaptec,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
 
 #endif
@@ -7346,7 +7343,7 @@
 /*   Routine Description:                                                    */
 /*     Remove one Adapter ( Hot Plugging )                                   */
 /*---------------------------------------------------------------------------*/
-static void __devexit ips_remove_device(struct pci_dev *pci_dev)
+static void ips_remove_device(struct pci_dev *pci_dev)
 {
    int    i;
    struct Scsi_Host *sh;
