Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTE3XkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbTE3XkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:40:08 -0400
Received: from dp.samba.org ([66.70.73.150]:15778 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264060AbTE3XkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:40:05 -0400
Date: Sat, 31 May 2003 09:52:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Vasquez <praka@san.rr.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b3).
Message-ID: <20030530235234.GA31401@krispykreme>
References: <20030530160040.GA11238@praka.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530160040.GA11238@praka.local.home>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> A new version of the 8.x series driver for Linux 2.5.x kernels has
> been uploaded to SourceForge:
> 
> 	http://sourceforge.net/projects/linux-qla2xxx/

A few suggestions:

- Use pci_set_mwi since it will set the cacheline size if necessary.
- Dont set/clear IO/MEMORY/MASTER, it should be handled in
  pci_enable_device/pci_set_master.

Anton

--- qla_init.c~	2003-05-31 09:18:31.000000000 +1000
+++ qla_init.c	2003-05-31 09:21:16.000000000 +1000
@@ -521,6 +521,7 @@
 	 * default.
 	 */
 	pci_set_master(ha->pdev);
+	pci_set_mwi(ha->pdev);
 	pci_read_config_word(ha->pdev, PCI_REVISION_ID, &ha->revision);
 
 	if (!ha->iobase)
@@ -532,18 +533,7 @@
 	 * interest to us are properly set in command register.
 	 */
 	pci_read_config_word(ha->pdev, PCI_COMMAND, &w);
-	w |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | 
-	    PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
-
-#if MEMORY_MAPPED_IO
-	DEBUG(printk("scsi(%ld): I/O SPACE and MEMORY MAPPED I/O enabled.\n",
-	    ha->host_no));
-#else
-	DEBUG(printk("scsi(%ld): I/O SPACE enabled and MEMORY MAPPED I/O "
-	    "disabled.\n", ha->host_no));
-
-	w &= ~PCI_COMMAND_MEMORY;
-#endif
+	w |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
 
 #if defined(ISP2300)
 	/* PCI Specification Revision 2.3 changes */
