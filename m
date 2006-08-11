Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWHKWib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWHKWib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWHKWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:38:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2651 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751227AbWHKWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:38:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=nD57yI2HOxUCGVCk3uNSughfylNhYowks+GM1FLu22c4OoB36TrvwqR0wnZ5mwCfhqohxrKsLEIrOm7/0I/5Hx7yOeAD679Pq3c+VGuHfeK0GIRA7k3uDrgKhJkmHa50mqeT5xjdn+TFUmiA412jjicMX4y+E+NZaY3TnRCIk7w=
Date: Sat, 12 Aug 2006 02:38:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PM=n slim: sound/oss/cs46xx.c
Message-ID: <20060811223829.GJ6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Make suspend/resume registration look like the rest of drivers:
  #ifdef CONFIG_PM in struct pci_driver, prototypes, actual hooks.
* Drop CS46XX_ACPI_SUPPORT. It logically duplicated CONFIG_PM. It was
  hardcoded to 1 approx forever (ALSA merge just moved driver to
  sound/oss/).
* After previous point, sound/oss/cs46xxpm-24.h removed as being useless.
* As side effect selling (unused) static inline functions as suspend/resume
  hooks funkiness removed too.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/oss/cs46xx.c      |   12 ++++++++----
 sound/oss/cs46xxpm-24.h |   48 ------------------------------------------------
 2 files changed, 8 insertions(+), 52 deletions(-)

--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -96,7 +96,7 @@ #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/uaccess.h>
 
-#include "cs46xxpm-24.h"
+#include "cs46xxpm.h"
 #include "cs46xx_wrapper-24.h"
 #include "cs461x.h"
 
@@ -389,8 +389,10 @@ static int cs_hardware_init(struct cs_ca
 static int cs46xx_powerup(struct cs_card *card, unsigned int type);
 static int cs461x_powerdown(struct cs_card *card, unsigned int type, int suspendflag);
 static void cs461x_clear_serial_FIFOs(struct cs_card *card, int type);
+#ifdef CONFIG_PM
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
+#endif
 
 #if CSDEBUG
 
@@ -5389,8 +5391,10 @@ static struct pci_driver cs46xx_pci_driv
 	.id_table = cs46xx_pci_tbl,
 	.probe	  = cs46xx_probe,
 	.remove	  = __devexit_p(cs46xx_remove),
-	.suspend  = CS46XX_SUSPEND_TBL,
-	.resume	  = CS46XX_RESUME_TBL,
+#ifdef CONFIG_PM
+	.suspend  = cs46xx_suspend_tbl,
+	.resume	  = cs46xx_resume_tbl,
+#endif
 };
 
 static int __init cs46xx_init_module(void)
@@ -5420,7 +5424,7 @@ static void __exit cs46xx_cleanup_module
 module_init(cs46xx_init_module);
 module_exit(cs46xx_cleanup_module);
 
-#if CS46XX_ACPI_SUPPORT
+#ifdef CONFIG_PM
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state)
 {
 	struct cs_card *s = PCI_GET_DRIVER_DATA(pcidev);
deleted file mode 100644
--- a/sound/oss/cs46xxpm-24.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*******************************************************************************
-*
-*      "cs46xxpm-24.h" --  Cirrus Logic-Crystal CS46XX linux audio driver.
-*
-*      Copyright (C) 2000,2001  Cirrus Logic Corp.  
-*            -- tom woller (twoller@crystal.cirrus.com) or
-*               (pcaudio@crystal.cirrus.com).
-*
-*      This program is free software; you can redistribute it and/or modify
-*      it under the terms of the GNU General Public License as published by
-*      the Free Software Foundation; either version 2 of the License, or
-*      (at your option) any later version.
-*
-*      This program is distributed in the hope that it will be useful,
-*      but WITHOUT ANY WARRANTY; without even the implied warranty of
-*      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-*      GNU General Public License for more details.
-*
-*      You should have received a copy of the GNU General Public License
-*      along with this program; if not, write to the Free Software
-*      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*
-* 12/22/00 trw - new file. 
-*
-*******************************************************************************/
-#ifndef __CS46XXPM24_H
-#define __CS46XXPM24_H
-
-#include <linux/pm.h>
-#include "cs46xxpm.h"
-
-
-#define CS46XX_ACPI_SUPPORT 1
-#ifdef CS46XX_ACPI_SUPPORT
-/* 
-* for now (12/22/00) only enable the pm_register PM support.
-* allow these table entries to be null.
-*/
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
-static int cs46xx_resume_tbl(struct pci_dev *pcidev);
-#define CS46XX_SUSPEND_TBL cs46xx_suspend_tbl
-#define CS46XX_RESUME_TBL cs46xx_resume_tbl
-#else
-#define CS46XX_SUSPEND_TBL cs46xx_null
-#define CS46XX_RESUME_TBL cs46xx_null
-#endif
-
-#endif

