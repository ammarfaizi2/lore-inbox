Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281381AbRKLMnA>; Mon, 12 Nov 2001 07:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281382AbRKLMmt>; Mon, 12 Nov 2001 07:42:49 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:47886 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S281381AbRKLMml>;
	Mon, 12 Nov 2001 07:42:41 -0500
Message-ID: <20011112155003.A26401@castle.nmd.msu.ru>
Date: Mon, 12 Nov 2001 15:50:03 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
        Andrew Morton <akpm@zip.com.au>
Subject: eepro100 pm fix (fwd)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Could you apply it, please?

	Andrey

----- Forwarded message from Jens Axboe <axboe@suse.de> -----

Date: Mon, 12 Nov 2001 13:24:53 +0100
From: Jens Axboe <axboe@suse.de>
To: saw@saw.sw.com.sg
Subject: eepro100 pm fix
Message-ID: <20011112132453.B786@suse.de>

Hi Andrey,

This patch posted by Andrew Morton makes the eepro100 actually survive a
apm suspend and resume without totally croaking (a problem I reported
probably a year or so ago :-). Any chance you could include it?

-- 
Jens Axboe


--- /opt/kernel/linux-2.4.15-pre3/drivers/net/eepro100.c	Mon Nov 12 13:21:27 2001
+++ linux/drivers/net/eepro100.c	Mon Nov 12 13:20:47 2001
@@ -499,6 +499,9 @@
 	unsigned short phy[2];				/* PHY media interfaces available. */
 	unsigned short advertising;			/* Current PHY advertised caps. */
 	unsigned short partner;				/* Link partner caps. */
+#ifdef CONFIG_PM
+	u32 pm_state[16];
+#endif
 };
 
 /* The parameters for a CmdConfigure operation.
@@ -2193,8 +2196,11 @@
 static int eepro100_suspend(struct pci_dev *pdev, u32 state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	long ioaddr = dev->base_addr;
 
+	pci_save_state(pdev, sp->pm_state);
+
 	if (!netif_running(dev))
 		return 0;
 
@@ -2210,6 +2216,8 @@
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	long ioaddr = dev->base_addr;
+
+	pci_restore_state(pdev, sp->pm_state);
 
 	if (!netif_running(dev))
 		return 0;

