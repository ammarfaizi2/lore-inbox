Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUILLc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUILLc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUILLbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:31:13 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34300 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268690AbUILL1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:27:01 -0400
Date: Sun, 12 Sep 2004 13:26:38 +0200 (MEST)
Message-Id: <200409121126.i8CBQcoY015202@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: kai.germaschewski@gmx.de, kkeil@suse.de, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] ISDN drivers gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's ISDN drivers. With the exception of eicon_idi.c, which
doesn't seem to be in the 2.6 kernel, the changes are all backports
from the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/drivers/isdn/eicon/eicon_idi.c.~1~	2001-12-21 23:19:55.000000000 +0100
+++ linux-2.4.28-pre3/drivers/isdn/eicon/eicon_idi.c	2004-09-12 01:56:20.000000000 +0200
@@ -2054,7 +2054,8 @@
 				OutBuf.Len++;
 			} else {
 				*OutBuf.Next++ = 0;
-				*((__u16 *) OutBuf.Next)++ = (__u16) LineBuf.Len;
+				*(__u16 *) OutBuf.Next = (__u16) LineBuf.Len;
+				OutBuf.Next += sizeof(__u16);
 				OutBuf.Len += 3;
 			}
 			memcpy(OutBuf.Next, LineBuf.Data, LineBuf.Len);
--- linux-2.4.28-pre3/drivers/isdn/hisax/avm_pci.c.~1~	2002-11-30 17:12:25.000000000 +0100
+++ linux-2.4.28-pre3/drivers/isdn/hisax/avm_pci.c	2004-09-12 01:56:20.000000000 +0200
@@ -291,7 +291,8 @@
 			debugl1(cs, "hdlc_empty_fifo: incoming packet too large");
 		return;
 	}
-	ptr = (u_int *) p = bcs->hw.hdlc.rcvbuf + bcs->hw.hdlc.rcvidx;
+	p = bcs->hw.hdlc.rcvbuf + bcs->hw.hdlc.rcvidx;
+	ptr = (u_int *)p;
 	bcs->hw.hdlc.rcvidx += count;
 	if (cs->subtyp == AVM_FRITZ_PCI) {
 		outl(idx, cs->hw.avm.cfg_reg + 4);
@@ -352,7 +353,8 @@
 	}
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
 		debugl1(cs, "hdlc_fill_fifo %d/%ld", count, bcs->tx_skb->len);
-	ptr = (u_int *) p = bcs->tx_skb->data;
+	p = bcs->tx_skb->data;
+	ptr = (u_int *)p;
 	skb_pull(bcs->tx_skb, count);
 	bcs->tx_cnt -= count;
 	bcs->hw.hdlc.count += count;
--- linux-2.4.28-pre3/drivers/isdn/hisax/hfc_pci.c.~1~	2003-06-14 13:30:22.000000000 +0200
+++ linux-2.4.28-pre3/drivers/isdn/hisax/hfc_pci.c	2004-09-12 01:56:20.000000000 +0200
@@ -1746,7 +1746,7 @@
 			printk(KERN_WARNING "HFC-PCI: Error allocating memory for FIFO!\n");
 			return 0;
 		}
-		(ulong) cs->hw.hfcpci.fifos =
+		cs->hw.hfcpci.fifos = (void *)
 		    (((ulong) cs->hw.hfcpci.share_start) & ~0x7FFF) + 0x8000;
 		pcibios_write_config_dword(cs->hw.hfcpci.pci_bus,
 				       cs->hw.hfcpci.pci_device_fn, 0x80,
--- linux-2.4.28-pre3/drivers/isdn/hysdn/hysdn_proclog.c.~1~	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre3/drivers/isdn/hysdn/hysdn_proclog.c	2004-09-12 01:56:20.000000000 +0200
@@ -235,7 +235,7 @@
 		return (0);
 
 	inf->usage_cnt--;	/* new usage count */
-	(struct log_data **) file->private_data = &inf->next;	/* next structure */
+	file->private_data = &inf->next;	/* next structure */
 	if ((len = strlen(inf->log_start)) <= count) {
 		if (copy_to_user(buf, inf->log_start, len))
 			return -EFAULT;
@@ -278,9 +278,9 @@
 		cli();
 		pd->if_used++;
 		if (pd->log_head)
-			(struct log_data **) filep->private_data = &(pd->log_tail->next);
+			filep->private_data = &(pd->log_tail->next);
 		else
-			(struct log_data **) filep->private_data = &(pd->log_head);
+			filep->private_data = &(pd->log_head);
 		restore_flags(flags);
 	} else {		/* simultaneous read/write access forbidden ! */
 		unlock_kernel();
