Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWEJC6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWEJC6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWEJC5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:25 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:9022 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932447AbWEJC4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:52 -0400
Date: Tue, 9 May 2006 19:55:58 -0700
Message-Id: <200605100255.k4A2twlF031676@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] isdn hisax gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings,

drivers/isdn/hisax/config.c: In function 'HiSax_readstatus':
drivers/isdn/hisax/config.c:635: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c:646: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c: At top level:
drivers/isdn/hisax/config.c:1879: warning: 'hisax_pci_tbl' defined but not used

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/isdn/hisax/config.c
===================================================================
--- linux-2.6.16.orig/drivers/isdn/hisax/config.c
+++ linux-2.6.16/drivers/isdn/hisax/config.c
@@ -632,7 +632,8 @@ static int HiSax_readstatus(u_char __use
 		count = cs->status_end - cs->status_read + 1;
 		if (count >= len)
 			count = len;
-		copy_to_user(p, cs->status_read, count);
+		if (copy_to_user(p, cs->status_read, count))
+			return -EFAULT;
 		cs->status_read += count;
 		if (cs->status_read > cs->status_end)
 			cs->status_read = cs->status_buf;
@@ -643,7 +644,8 @@ static int HiSax_readstatus(u_char __use
 				cnt = HISAX_STATUS_BUFSIZE;
 			else
 				cnt = count;
-			copy_to_user(p, cs->status_read, cnt);
+			if (copy_to_user(p, cs->status_read, cnt))
+				return -EFAULT;
 			p += cnt;
 			cs->status_read += cnt % HISAX_STATUS_BUFSIZE;
 			count -= cnt;
@@ -1873,7 +1875,7 @@ static void EChannel_proc_rcv(struct his
 	}
 }
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) && defined(MODULE)
 #include <linux/pci.h>
 
 static struct pci_device_id hisax_pci_tbl[] __initdata = {
@@ -1945,7 +1947,7 @@ static struct pci_device_id hisax_pci_tb
 };
 
 MODULE_DEVICE_TABLE(pci, hisax_pci_tbl);
-#endif /* CONFIG_PCI */
+#endif /* CONFIG_PCI && MODULE */
 
 module_init(HiSax_init);
 module_exit(HiSax_exit);
