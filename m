Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVBOArF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVBOArF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVBOArF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:47:05 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:49852 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261441AbVBOAq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:46:26 -0500
Date: Tue, 15 Feb 2005 01:46:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in PCMCIA
Message-ID: <20050215004608.GD5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix part of u32 vs. pm_message_t confusion in
pcmcia. PCMCIA is listed as unmaintained, that's why it goes
directly...

								Pavel

--- clean-mm/drivers/pcmcia/cs.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/pcmcia/cs.c	2005-02-15 01:04:10.000000000 +0100
@@ -140,7 +140,7 @@
 static int socket_resume(struct pcmcia_socket *skt);
 static int socket_suspend(struct pcmcia_socket *skt);
 
-int pcmcia_socket_dev_suspend(struct device *dev, u32 state)
+int pcmcia_socket_dev_suspend(struct device *dev, pm_message_t state)
 {
 	struct pcmcia_socket *socket;
 
--- clean-mm/drivers/pcmcia/i82092.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/pcmcia/i82092.c	2005-02-15 01:04:10.000000000 +0100
@@ -42,7 +42,7 @@
 };
 MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
 
-static int i82092aa_socket_suspend (struct pci_dev *dev, u32 state)
+static int i82092aa_socket_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
--- clean-mm/drivers/pcmcia/i82365.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/pcmcia/i82365.c	2005-02-15 01:04:10.000000000 +0100
@@ -1339,7 +1339,7 @@
 
 /*====================================================================*/
 
-static int i82365_suspend(struct device *dev, u32 state, u32 level)
+static int i82365_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-mm/drivers/pcmcia/pd6729.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/pcmcia/pd6729.c	2005-02-15 01:04:10.000000000 +0100
@@ -833,7 +833,7 @@
 	kfree(socket);
 }
 
-static int pd6729_socket_suspend(struct pci_dev *dev, u32 state)
+static int pd6729_socket_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
--- clean-mm/drivers/pcmcia/tcic.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/pcmcia/tcic.c	2005-02-15 01:04:10.000000000 +0100
@@ -373,7 +373,7 @@
 
 /*====================================================================*/
 
-static int tcic_drv_suspend(struct device *dev, u32 state, u32 level)
+static int tcic_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
--- clean-mm/drivers/pcmcia/yenta_socket.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/pcmcia/yenta_socket.c	2005-02-15 01:04:10.000000000 +0100
@@ -1019,7 +1019,7 @@
 }
 
 
-static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
+static int yenta_dev_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	struct yenta_socket *socket = pci_get_drvdata(dev);
 	int ret;
--- clean-mm/include/pcmcia/ss.h	2005-02-15 00:34:41.000000000 +0100
+++ linux-mm/include/pcmcia/ss.h	2005-02-15 01:04:11.000000000 +0100
@@ -248,7 +248,7 @@
 extern struct class pcmcia_socket_class;
 
 /* socket drivers are expected to use these callbacks in their .drv struct */
-extern int pcmcia_socket_dev_suspend(struct device *dev, u32 state);
+extern int pcmcia_socket_dev_suspend(struct device *dev, pm_message_t state);
 extern int pcmcia_socket_dev_resume(struct device *dev);
 
 #endif /* _LINUX_SS_H */
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
