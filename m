Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTI3Wsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTI3Wrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:47:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:35547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261823AbTI3WrW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:22 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10649613503148@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <1064961349577@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:50 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1346, 2003/09/26 16:34:55-07:00, mochel@osdl.org

[PATCH] Remove ->save_state() in sc1200.c

This removes the uncalled and unneeded method struct
pci_driver::save_state(). The contents of ->save_state() were folded into
->suspend(), though the semantics don't seem exactly right - the hwifs
should not be iterated over there; the driver core should take care of
that. But, that code will never get executed as is, since neither function
should ever be called with (state == 0).


 drivers/ide/pci/sc1200.c |   61 +++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 31 deletions(-)


diff -Nru a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c	Tue Sep 30 15:20:43 2003
+++ b/drivers/ide/pci/sc1200.c	Tue Sep 30 15:20:43 2003
@@ -396,44 +396,44 @@
 	__u32		regs[4];
 } sc1200_saved_state_t;
 
-static int sc1200_save_state (struct pci_dev *dev, u32 state)
+
+static int sc1200_suspend (struct pci_dev *dev, u32 state)
 {
 	ide_hwif_t		*hwif = NULL;
 
-printk("SC1200: save_state(%u)\n", state);
-	if (state != 0)
-		return 0;	// we only save state when going from full power to less
-	//
-	// Loop over all interfaces that are part of this PCI device:
-	//
-	while ((hwif = lookup_pci_dev(hwif, dev)) != NULL) {
-		sc1200_saved_state_t	*ss;
-		unsigned int		basereg, r;
-		//
-		// allocate a permanent save area, if not already allocated
-		//
-		ss = (sc1200_saved_state_t *)hwif->config_data;
-		if (ss == NULL) {
-			ss = kmalloc(sizeof(sc1200_saved_state_t), GFP_KERNEL);
-			if (ss == NULL)
-				return -ENOMEM;
-			(sc1200_saved_state_t *)hwif->config_data = ss;
-		}
-		ss = (sc1200_saved_state_t *)hwif->config_data;
+	printk("SC1200: suspend(%u)\n", state);
+
+	if (state == 0) {
+		// we only save state when going from full power to less
+
 		//
-		// Save timing registers:  this may be unnecessary if BIOS also does it
+		// Loop over all interfaces that are part of this PCI device:
 		//
-		basereg = hwif->channel ? 0x50 : 0x40;
-		for (r = 0; r < 4; ++r) {
-			pci_read_config_dword (hwif->pci_dev, basereg + (r<<2), &ss->regs[r]);
+		while ((hwif = lookup_pci_dev(hwif, dev)) != NULL) {
+			sc1200_saved_state_t	*ss;
+			unsigned int		basereg, r;
+			//
+			// allocate a permanent save area, if not already allocated
+			//
+			ss = (sc1200_saved_state_t *)hwif->config_data;
+			if (ss == NULL) {
+				ss = kmalloc(sizeof(sc1200_saved_state_t), GFP_KERNEL);
+				if (ss == NULL)
+					return -ENOMEM;
+				(sc1200_saved_state_t *)hwif->config_data = ss;
+			}
+			ss = (sc1200_saved_state_t *)hwif->config_data;
+			//
+			// Save timing registers:  this may be unnecessary if 
+			// BIOS also does it
+			//
+			basereg = hwif->channel ? 0x50 : 0x40;
+			for (r = 0; r < 4; ++r) {
+				pci_read_config_dword (hwif->pci_dev, basereg + (r<<2), &ss->regs[r]);
+			}
 		}
 	}
-	return 0;
-}
 
-static int sc1200_suspend (struct pci_dev *dev, u32 state)
-{
-	printk("SC1200: suspend(%u)\n", state);
 	/* You don't need to iterate over disks -- sysfs should have done that for you already */ 
 
 	pci_disable_device(dev);
@@ -572,7 +572,6 @@
 	.name		= "SC1200 IDE",
 	.id_table	= sc1200_pci_tbl,
 	.probe		= sc1200_init_one,
-	.save_state	= sc1200_save_state,
 	.suspend	= sc1200_suspend,
 	.resume		= sc1200_resume,
 };

