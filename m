Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbVKPDvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVKPDvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVKPDvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:51:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16324 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965229AbVKPDux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:50:53 -0500
To: torvalds@osdl.org
Subject: [PATCH 7/8] isaectomy: lance
Cc: linux-kernel@vger.kernel.org, jgarzik@pobix.com
Message-Id: <E1EcEJw-0007eK-9d@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 16 Nov 2005 03:50:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1132110620 -0500

switch to ioremap()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 drivers/net/lance.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

aadde842b4976445ac101c6ed04986382988d035
diff --git a/drivers/net/lance.c b/drivers/net/lance.c
--- a/drivers/net/lance.c
+++ b/drivers/net/lance.c
@@ -464,20 +464,25 @@ static int __init lance_probe1(struct ne
 	static int did_version;			/* Already printed version info. */
 	unsigned long flags;
 	int err = -ENOMEM;
+	void __iomem *bios;
 
 	/* First we look for special cases.
 	   Check for HP's on-board ethernet by looking for 'HP' in the BIOS.
 	   There are two HP versions, check the BIOS for the configuration port.
 	   This method provided by L. Julliard, Laurent_Julliard@grenoble.hp.com.
 	   */
-	if (isa_readw(0x000f0102) == 0x5048)  {
+	bios = ioremap(0xf00f0, 0x14);
+	if (!bios)
+		return -ENOMEM;
+	if (readw(bios + 0x12) == 0x5048)  {
 		static const short ioaddr_table[] = { 0x300, 0x320, 0x340, 0x360};
-		int hp_port = (isa_readl(0x000f00f1) & 1)  ? 0x499 : 0x99;
+		int hp_port = (readl(bios + 1) & 1)  ? 0x499 : 0x99;
 		/* We can have boards other than the built-in!  Verify this is on-board. */
 		if ((inb(hp_port) & 0xc0) == 0x80
 			&& ioaddr_table[inb(hp_port) & 3] == ioaddr)
 			hp_builtin = hp_port;
 	}
+	iounmap(bios);
 	/* We also recognize the HP Vectra on-board here, but check below. */
 	hpJ2405A = (inb(ioaddr) == 0x08 && inb(ioaddr+1) == 0x00
 				&& inb(ioaddr+2) == 0x09);

