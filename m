Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSIJWQq>; Tue, 10 Sep 2002 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSIJWQq>; Tue, 10 Sep 2002 18:16:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17659 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318184AbSIJWQp> convert rfc822-to-8bit;
	Tue, 10 Sep 2002 18:16:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Buglet in 2.4.19's arch/i386/kernel/pci-pc.c
Date: Tue, 10 Sep 2002 15:20:42 -0700
User-Agent: KMail/1.4.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209101520.42333.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Despite the comment, the return from direct check function was overwriting the 
value found by the BIOS check, assuming both are enabled.  Oddly, this was 
keeping my 2.4.20-pre-ac Summit backport from booting.

Please apply.


--- 2.4.19/arch/i386/kernel/pci-pc.c	Fri Aug  2 17:39:42 2002
+++ acx/arch/i386/kernel/pci-pc.c	Tue Sep 10 15:14:55 2002
@@ -1276,6 +1276,8 @@
 
 void __devinit pcibios_config_init(void)
 {
+	struct pci_ops *pcip;
+
 	/*
 	 * Try all known PCI access methods. Note that we support using 
 	 * both PCI BIOS and direct access, with a preference for direct.
@@ -1293,7 +1295,8 @@
 
 #ifdef CONFIG_PCI_DIRECT
 	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
-		&& (pci_root_ops = pci_check_direct())) {
+		&& (pcip = pci_check_direct())) {
+		pci_root_ops = pcip;
 		if (pci_root_ops == &pci_direct_conf1) {
 			pci_config_read = pci_conf1_read;
 			pci_config_write = pci_conf1_write;


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

