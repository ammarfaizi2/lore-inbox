Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTKLDEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTKLDEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:04:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:28902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261476AbTKLDEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:04:22 -0500
Date: Tue, 11 Nov 2003 19:04:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Craig <dancraig@internode.on.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
In-Reply-To: <1201.192.168.0.5.1068605203.squirrel@stingray.homelinux.org>
Message-ID: <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Nov 2003, Daniel Craig wrote:
>
> Does anyone have any idea what might be going wrong...?

Yes. The ALI driver has some really strange code to avoid tweaking non-ALI 
southbridges. 

But the thing is, it breaks even _with_ ALI southbridges, if we just don't 
find the ALI bridge we expect.

Does this patch fix it?

		Linus

---
--- 1.15/drivers/ide/pci/alim15x3.c	Sun Aug 24 15:33:30 2003
+++ edited/drivers/ide/pci/alim15x3.c	Tue Nov 11 19:03:21 2003
@@ -578,7 +578,6 @@
 {
 	unsigned long flags;
 	u8 tmpbyte;
-	struct pci_dev *north = pci_find_slot(0, PCI_DEVFN(0,0));
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &m5229_revision);
 
@@ -625,11 +624,9 @@
 
 	/*
 	 * We should only tune the 1533 enable if we are using an ALi
-	 * North bridge. We might have no north found on some zany
-	 * box without a device at 0:0.0. The ALi bridge will be at
-	 * 0:0.0 so if we didn't find one we know what is cooking.
+	 * south bridge.
 	 */
-	if (north && north->vendor != PCI_VENDOR_ID_AL) {
+	if (!isa_dev) {
 		local_irq_restore(flags);
 	        return 0;
 	}

