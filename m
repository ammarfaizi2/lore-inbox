Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTEJWQb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 18:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTEJWQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 18:16:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36848 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264519AbTEJWQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 18:16:29 -0400
Date: Sun, 11 May 2003 00:29:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, ipslinux@adaptec.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.21-rc2: fix ips.c .text.exit error
Message-ID: <20030510222902.GU1107@fs.tum.de>
References: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ips_remove_device in drivers/scsi/ips.c is __devexit but it's called 
from the __devinit ips_insert_device resulting in a compile error when 
cmpiled statically into a kernel without CONFIG_HOTPLUG enables.

The patch below solves this by removing the __devexit from 
ips_remove_device.

Please apply for -rc3
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
