Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbTBUPk4>; Fri, 21 Feb 2003 10:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTBUPk4>; Fri, 21 Feb 2003 10:40:56 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:25563 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267530AbTBUPku>; Fri, 21 Feb 2003 10:40:50 -0500
Date: Fri, 21 Feb 2003 16:50:51 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.21-pre4-bk] meye suspend/resume capabilities
Message-ID: <20030221165051.L12004@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch adds suspend/resume capabilities
to the meye driver.

Marcelo, Alan, please apply.

Thanks.

Stelian.


===== Documentation/video4linux/meye.txt 1.5 vs edited =====
--- 1.5/Documentation/video4linux/meye.txt	Fri Nov  8 16:31:04 2002
+++ edited/Documentation/video4linux/meye.txt	Tue Feb 18 11:32:22 2003
@@ -1,6 +1,6 @@
 Vaio Picturebook Motion Eye Camera Driver Readme
 ------------------------------------------------
-	Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
 	Copyright (C) 2001-2002 Alcôve <www.alcove.com>
 	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
 
===== include/linux/meye.h 1.2 vs edited =====
--- 1.2/include/linux/meye.h	Fri Nov  8 16:27:56 2002
+++ edited/include/linux/meye.h	Tue Feb 18 11:31:33 2003
@@ -1,7 +1,7 @@
 /* 
  * Motion Eye video4linux driver for Sony Vaio PictureBook
  *
- * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
===== drivers/media/video/meye.h 1.6 vs edited =====
--- 1.6/drivers/media/video/meye.h	Mon Dec  2 10:55:04 2002
+++ edited/drivers/media/video/meye.h	Fri Feb 21 10:24:07 2003
@@ -1,7 +1,7 @@
 /* 
  * Motion Eye video4linux driver for Sony Vaio PictureBook
  *
- * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
@@ -31,7 +31,13 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	5
+#define MEYE_DRIVER_MINORVERSION	6
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/sonypi.h>
+#include <linux/meye.h>
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
@@ -309,6 +315,10 @@
 	struct video_device video_dev;	/* video device parameters */
 	struct video_picture picture;	/* video picture parameters */
 	struct meye_params params;	/* additional parameters */
+#ifdef CONFIG_PM
+	u32 pm_state[16];		/* PCI configuration space */
+	u8 pm_mchip_mode;		/* old mchip mode */
+#endif
 };
 
 #endif
===== drivers/media/video/meye.c 1.12 vs edited =====
--- 1.12/drivers/media/video/meye.c	Fri Nov 15 18:43:00 2002
+++ edited/drivers/media/video/meye.c	Tue Feb 18 11:31:10 2003
@@ -1,7 +1,7 @@
 /* 
  * Motion Eye video4linux driver for Sony Vaio PictureBook
  *
- * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
@@ -1225,6 +1225,42 @@
 	.fops		= &meye_fops,
 };
 
+#ifdef CONFIG_PM
+static int meye_suspend(struct pci_dev *pdev, u32 state)
+{
+	pci_save_state(pdev, meye.pm_state);
+	meye.pm_mchip_mode = meye.mchip_mode;
+	mchip_hic_stop();
+	mchip_set(MCHIP_MM_INTA, 0x0);
+	return 0;
+}
+
+static int meye_resume(struct pci_dev *pdev)
+{
+	pci_restore_state(pdev, meye.pm_state);
+	pci_write_config_word(meye.mchip_dev, MCHIP_PCI_SOFTRESET_SET, 1);
+
+	mchip_delay(MCHIP_HIC_CMD, 0);
+	mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE);
+	wait_ms(1);
+	mchip_set(MCHIP_VRJ_SOFT_RESET, 1);
+	wait_ms(1);
+	mchip_set(MCHIP_MM_PCI_MODE, 5);
+	wait_ms(1);
+	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
+
+	switch (meye.pm_mchip_mode) {
+	case MCHIP_HIC_MODE_CONT_OUT:
+		mchip_continuous_start();
+		break;
+	case MCHIP_HIC_MODE_CONT_COMP:
+		mchip_cont_compression_start();
+		break;
+	}
+	return 0;
+}
+#endif
+
 static int __devinit meye_probe(struct pci_dev *pcidev, 
 		                const struct pci_device_id *ent) {
 	int ret;
@@ -1391,6 +1427,10 @@
 	.id_table	= meye_pci_tbl,
 	.probe		= meye_probe,
 	.remove		= __devexit_p(meye_remove),
+#ifdef CONFIG_PM
+	.suspend	= meye_suspend,
+	.resume		= meye_resume,
+#endif
 };
 
 static int __init meye_init_module(void) {
-- 
Stelian Pop <stelian@popies.net>
