Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUI2Qau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUI2Qau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUI2Qat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:30:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268700AbUI2Qam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:30:42 -0400
Date: Wed, 29 Sep 2004 12:30:23 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: PATCH: 3c59x 00:00:00:00:00:00 MAC failure
Message-ID: <20040929163023.GA17899@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 3com EEPROM has a checksum but unfortunately it seems that a zapped
EEPROM returning all zero values passes the checksum test fine and we try
and use it. 


--- drivers/net/3c59x.c~	2004-09-29 17:23:42.964453264 +0100
+++ drivers/net/3c59x.c	2004-09-29 17:28:40.358242536 +0100
@@ -1295,6 +1295,13 @@
 		for (i = 0; i < 6; i++)
 			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
 	}
+	/* Unfortunately an all zero eeprom passes the checksum and this
+	   gets found in the wild in failure cases. Crypto is hard 8) */
+	if (memcmp(dev->dev_addr, "\0\0\0\0\0", 6) == 0) {
+		retval = -EINVAL;
+		printk(KERN_ERR "*** EEPROM MAC address is invalid.\n");
+		goto free_ring;	/* With every pack */
+	}
 	EL3WINDOW(2);
 	for (i = 0; i < 6; i++)
 		outb(dev->dev_addr[i], ioaddr + i);
