Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWCaNOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWCaNOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWCaNOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:14:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20688 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932115AbWCaNOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:14:49 -0500
Message-Id: <200603311313.AA05688@fukuchi.jp.fujitsu.com>
From: Masao Fukuchi <fukuchi.masao@jp.fujitsu.com>
Date: Fri, 31 Mar 2006 22:13:12 +0900
To: linux-kernel@vger.kernel.org
Cc: Eric.Moore@lsil.com
Subject: [patch 2.6.16-mm2] Make fusion MPT driver legacy I/O port free
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made a patch for Fusion MPT driver to make PCI legacy I/O
port free.

The way to make PCI legacy I/O port free function is based on 
Kaneshige-san's patch which was uploaded several weeks ago and
is already merged into kernel 2.6.16-mm2.

Fusion MPT driver basically doesn't use PCI legacy I/O port.
But some PCI card/controller still use PCI legacy I/O port for
download boot operation.
So this driver needs to set I/O port at download boot operation.

I'm not a member of this mailing list, please cc to my e-mail 
address.

Thanks,
Masao Fukuchi

Signed-off-by: Masao Fukuchi <masao.fukuchi@jp.fujitsu.com>

-----------------------------------------------------------
diff -uarN linux-2.6.16-mm2.org/drivers/message/fusion/mptbase.c linux-2.6.16-
mm2/drivers/message/fusion/mptbase.c
--- linux-2.6.16-mm2.org/drivers/message/fusion/mptbase.c	2006-03-31 16:41:47.000000000 
+0900
+++ linux-2.6.16-mm2/drivers/message/fusion/mptbase.c	2006-03-31 21:16:12.000000000 +0900
@@ -1155,8 +1155,8 @@
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *dent, *ent;
 #endif
-
-	if (pci_enable_device(pdev))
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (pci_enable_device_bars(pdev, bars))
 		return r;
 
 	dinitprintk((KERN_WARNING MYNAM ": mpt_adapter_install\n"));
@@ -1572,6 +1572,7 @@
 	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
 	u32 device_state = pdev->current_state;
 	int recovery_state;
+	int bars;
 
 	printk(MYIOC_s_INFO_FMT
 	"pci-resume: pdev=0x%p, slot=%s, Previous operating state [D%d]\n",
@@ -1579,7 +1580,9 @@
 
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (pci_enable_device_bars(pdev, bars))
+		return -ENODEV;
 
 	/* enable interrupts */
 	CHIPREG_WRITE32(&ioc->chip->IntMask, MPI_HIM_DIM);
@@ -2575,6 +2578,7 @@
 	int			 r;
 	int			 count;
 	int			 cntdn;
+	int			 bars;
 
 	memset(&ioc_init, 0, sizeof(ioc_init));
 	memset(&init_reply, 0, sizeof(init_reply));
@@ -2587,7 +2591,13 @@
 	 * Set this flag if cached_fw set for either IOC.
 	 */
 	if (ioc->facts.Flags & MPI_IOCFACTS_FLAGS_FW_DOWNLOAD_BOOT)
+	{
 		ioc->upload_fw = 1;
+		bars = pci_select_bars(ioc->pcidev, IORESOURCE_MEM | IORESOURCE_IO);
+		if (pci_enable_device_bars(ioc->pcidev, bars))
+			return -ENODEV;
+	}
+
 	else
 		ioc->upload_fw = 0;
 	ddlprintk((MYIOC_s_INFO_FMT "upload_fw %d facts.Flags=%x\n",
