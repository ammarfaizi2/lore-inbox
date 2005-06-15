Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFORP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFORP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFORP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:15:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48302 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261226AbVFORPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:15:18 -0400
Date: Wed, 15 Jun 2005 09:57:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] fix int vs. pm_message_t confusion in airo
Message-ID: <20050615075751.GA2754@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix int vs. pm_message_t confusion in airo. Should change no code.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit f2b14bd02f8d56402661d8dd88cbdf838a7e3b8d
tree 1fb8859524d5919e3445d49cf350acdb9e70896c
parent 985bb2179202a400ac320f1729a657cf4450c009
author <pavel@amd.(none)> Wed, 15 Jun 2005 09:57:13 +0200
committer <pavel@amd.(none)> Wed, 15 Jun 2005 09:57:13 +0200

 drivers/net/wireless/airo.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -1209,7 +1209,7 @@ struct airo_info {
 	unsigned char		__iomem *pciaux;
 	unsigned char		*shared;
 	dma_addr_t		shared_dma;
-	int			power;
+	pm_message_t		power;
 	SsidRid			*SSID;
 	APListRid		*APList;
 #define	PCI_SHARED_LEN		2*MPI_MAX_FIDS*PKTSIZE+RIDSIZE
@@ -5499,9 +5499,9 @@ static int airo_pci_suspend(struct pci_d
 	cmd.cmd=HOSTSLEEP;
 	issuecommand(ai, &cmd, &rsp);
 
-	pci_enable_wake(pdev, state, 1);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), 1);
 	pci_save_state(pdev);
-	return pci_set_power_state(pdev, state);
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int airo_pci_resume(struct pci_dev *pdev)
@@ -5512,7 +5512,7 @@ static int airo_pci_resume(struct pci_de
 
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
-	pci_enable_wake(pdev, ai->power, 0);
+	pci_enable_wake(pdev, pci_choose_state(pdev, ai->power), 0);
 
 	if (ai->power > 1) {
 		reset_card(dev, 0);
@@ -5541,7 +5541,7 @@ static int airo_pci_resume(struct pci_de
 	}
 	writeConfigRid(ai, 0);
 	enable_MAC(ai, &rsp, 0);
-	ai->power = 0;
+	ai->power = PMSG_ON;
 	netif_device_attach(dev);
 	netif_wake_queue(dev);
 	enable_interrupts(ai);
