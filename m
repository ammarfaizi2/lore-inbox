Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268862AbRHKWLQ>; Sat, 11 Aug 2001 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRHKWK4>; Sat, 11 Aug 2001 18:10:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5643 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268862AbRHKWKo>; Sat, 11 Aug 2001 18:10:44 -0400
Subject: PCI power management problem
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Aug 2001 23:13:15 +0100 (BST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vh0N-0003SD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having read the PCI power management spec it appears that at least part of
the 'something weird happend to me on the way to D0' problems are caused by
us failing to enforce the delays the spec requires.

It states that accessing the io/mm spaces during the transition times
is undefined..


--- linux.vanilla/drivers/pci/pci.c	Mon Jul 23 22:28:24 2001
+++ linux.ac/drivers/pci/pci.c	Sat Aug 11 22:55:04 2001
@@ -290,6 +290,15 @@
 	/* enter specified state */
 	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
 
+	/* Mandatory power management transition delays */
+	/* see PCI PM 1.1 5.6.1 table 18 */
+	if(state == 3 || dev->current_state == 3)
+	{
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/100);
+	}
+	else if(state == 2 || dev->current_state == 2)
+		udelay(200);
 	dev->current_state = state;
 
 	return 0;
