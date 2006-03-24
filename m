Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422772AbWCXHyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbWCXHyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWCXHyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:54:22 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:26057 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422775AbWCXHyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:54:19 -0500
Message-ID: <4423A522.4050902@jp.fujitsu.com>
Date: Fri, 24 Mar 2006 16:52:02 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 6/6] PCIERR : interfaces for synchronous I/O error detection
 on driver (sample: Fusion MPT)
References: <44210D1B.7010806@jp.fujitsu.com> <20060322210157.GH12335@kroah.com>
In-Reply-To: <20060322210157.GH12335@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sample of how to use.

This patch includes following changes:
1:
   Change CHIPREG_READ32 & CHIPREG_WRITE32 to take three args,
   pointer to adapter, and two memory addresses. And change
   them to return the result of memory access.
2:
   Set proper args to every CHIPREG_{READ,WRITE}32 call, and
   also put error code that returns if the access failed.
3:
   Declare a task that resets adapter. Schedule it if an error
   is detected and reset is required. Using CHIPREG_*HR call is
   convenient to require such reset on an error.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

-----
  drivers/message/fusion/mptbase.c |  477 +++++++++++++++++++++++++++++----------
  1 files changed, 359 insertions(+), 118 deletions(-)

Index: linux-2.6.16_WORK/drivers/message/fusion/mptbase.c
===================================================================
--- linux-2.6.16_WORK.orig/drivers/message/fusion/mptbase.c
+++ linux-2.6.16_WORK/drivers/message/fusion/mptbase.c
@@ -181,16 +181,124 @@
  static void	mpt_spi_log_info(MPT_ADAPTER *ioc, u32 log_info);
  static void	mpt_sas_log_info(MPT_ADAPTER *ioc, u32 log_info);

+#ifdef CONFIG_PCIERR_CHECK
+static void	mptbase_schedule_reset(void *ioc);
+static struct work_struct	mptbase_rstTask;
+#endif
+
  /* module entry point */
  static int  __init    fusion_init  (void);
  static void __exit    fusion_exit  (void);

-#define CHIPREG_READ32(addr) 		readl_relaxed(addr)
-#define CHIPREG_READ32_dmasync(addr)	readl(addr)
-#define CHIPREG_WRITE32(addr,val) 	writel(val, addr)
+#define CHIPREG_READ32HR(ioc,addr,val)	pciras_readl(ioc,val,addr,1)
+#define CHIPREG_WRITE32HR(ioc,addr,val)	pciras_writel(ioc,val,addr,1)
+#define CHIPREG_READ32(ioc,addr,val)	pciras_readl(ioc,val,addr,0)
+#define CHIPREG_WRITE32(ioc,addr,val)	pciras_writel(ioc,val,addr,0)
  #define CHIPREG_PIO_WRITE32(addr,val)	outl(val, (unsigned long)addr)
  #define CHIPREG_PIO_READ32(addr) 	inl((unsigned long)addr)

+#ifdef CONFIG_PCIERR_CHECK
+#define PCI_ERR_RETRIES			2
+int
+pciras_readl(MPT_ADAPTER *ioc, u32 *regval, u32 *addr, int hres)
+{
+	u32 val;
+	u16 status;
+	iocookie cookie;
+	int retries = PCI_ERR_RETRIES;
+
+	do {
+		pcierr_clear(&cookie, ioc->pcidev);
+		val = ioread32(addr);
+		status = pcierr_read(&cookie);
+		if ((status) && (retries == PCI_ERR_RETRIES))
+			printk(MYIOC_s_WARN_FMT  "pciras_readl(), "
+			"detects pci parity error, do retry.\n", ioc->name);
+	} while(status && (--retries > 0));
+
+	if (status) {
+		printk(MYIOC_s_WARN_FMT  "pciras_readl(), detects pci parity "
+			"error, retries exhausted.\n", ioc->name);
+		if (hres)
+			schedule_work(&mptbase_rstTask);
+		return 1; /* Error */
+	}
+
+	if (regval)
+		*regval = val;
+	return 0; /* Success */
+}
+
+int
+pciras_writel(MPT_ADAPTER *ioc, u32 regval, u32 *addr, int hres)
+{
+	u16 status;
+	u16 perror;
+	int retries = PCI_ERR_RETRIES;
+
+	do {
+		perror = 0;
+		writel(regval, addr);
+		pci_read_config_word(ioc->pcidev, PCI_STATUS, &status);
+		if (status == 0xffff) {
+			if (retries == PCI_ERR_RETRIES)
+				printk(MYIOC_s_WARN_FMT  "pciras_writel(), "
+				"couldn't read pci register.\n", ioc->name);
+		} else if (status & PCI_STATUS_DETECTED_PARITY) {
+			if (retries == PCI_ERR_RETRIES)
+				printk(MYIOC_s_WARN_FMT  "pciras_writel(), "
+					"detects pci parity error, do retry.\n",
+					ioc->name);
+			perror = 1;
+		}
+		pci_write_config_word(ioc->pcidev, PCI_STATUS, status);
+	} while (perror && (--retries > 0));
+
+	if (perror) {
+		printk(MYIOC_s_WARN_FMT  "pciras_writel(), detects pci "
+			"parity error, retries exhausted.\n", ioc->name);
+
+		if (hres)
+			schedule_work(&mptbase_rstTask);
+		return 1; /* Error */
+	}
+
+	return 0; /* Success */
+}
+
+static void
+mptbase_schedule_reset(void *arg)
+{
+        MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
+
+	mpt_HardResetHandler(ioc, CAN_SLEEP);
+
+	return;
+}
+
+#else /* CONFIG_PCIERR_CHECK */
+
+static inline int
+pciras_readl(MPT_ADAPTER *ioc, u32 *regval, u32 *addr, int hres)
+{
+	u32 val;
+
+	val = ioread32(addr);
+	if (regval)
+		*regval = val;
+	return 0; /* Success */
+}
+
+static inline int
+pciras_writel(MPT_ADAPTER *ioc, u32 regval, u32 *addr, int hres)
+{
+	writel(regval, addr);
+
+	return 0; /* Success */
+}
+
+#endif
+
  static void
  pci_disable_io_access(struct pci_dev *pdev)
  {
@@ -342,7 +450,7 @@

   out:
  	/*  Flush (non-TURBO) reply with a WRITE!  */
-	CHIPREG_WRITE32(&ioc->chip->ReplyFifo, pa);
+	CHIPREG_WRITE32HR(ioc, &ioc->chip->ReplyFifo, pa);

  	if (freeme)
  		mpt_free_msg_frame(ioc, mf);
@@ -373,12 +481,27 @@
  	MPT_ADAPTER *ioc = bus_id;
  	u32 pa;

+#ifdef CONFIG_PCIERR_CHECK
+	{
+		u16 status;
+
+		/* read status register to check whether DMA transfer was failed. */
+		pci_read_config_word(ioc->pcidev, PCI_STATUS, &status);
+		if (status & (PCI_STATUS_DETECTED_PARITY | PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT)) {
+			printk(MYIOC_s_WARN_FMT "mpt_interrupt(), detects pci parity error.\n", ioc->name);
+			pci_write_config_word(ioc->pcidev, PCI_STATUS, status);
+			schedule_work(&mptbase_rstTask);
+			return IRQ_HANDLED;
+		}
+	}
+#endif
  	/*
  	 *  Drain the reply FIFO!
  	 */
  	while (1) {
-		pa = CHIPREG_READ32_dmasync(&ioc->chip->ReplyFifo);
-		if (pa == 0xFFFFFFFF)
+		u16 status;
+		status = CHIPREG_READ32HR(ioc, &ioc->chip->ReplyFifo, &pa);
+		if (status || (pa == 0xFFFFFFFF))
  			return IRQ_HANDLED;
  		else if (pa & MPI_ADDRESS_REPLY_A_BIT)
  			mpt_reply(ioc, pa);
@@ -833,7 +956,7 @@

  	mf_dma_addr = (ioc->req_frames_low_dma + req_offset) | ioc->RequestNB[req_idx];
  	dsgprintk((MYIOC_s_INFO_FMT "mf_dma_addr=%x req_idx=%d RequestNB=%x\n", ioc->name, mf_dma_addr, req_idx, 
ioc->RequestNB[req_idx]));
-	CHIPREG_WRITE32(&ioc->chip->RequestFifo, mf_dma_addr);
+	CHIPREG_WRITE32HR(ioc, &ioc->chip->RequestFifo, mf_dma_addr);
  }

  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
@@ -933,11 +1056,11 @@
  	}

  	/* Make sure there are no doorbells */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
-
-	CHIPREG_WRITE32(&ioc->chip->Doorbell,
-			((MPI_FUNCTION_HANDSHAKE<<MPI_DOORBELL_FUNCTION_SHIFT) |
-			 ((reqBytes/4)<<MPI_DOORBELL_ADD_DWORDS_SHIFT)));
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->Doorbell,
+		       ((MPI_FUNCTION_HANDSHAKE<<MPI_DOORBELL_FUNCTION_SHIFT) |
+			((reqBytes/4)<<MPI_DOORBELL_ADD_DWORDS_SHIFT))))
+		return -6;

  	/* Wait for IOC doorbell int */
  	if ((ii = WaitForDoorbellInt(ioc, 5, sleepFlag)) < 0) {
@@ -945,13 +1068,18 @@
  	}

  	/* Read doorbell and check for active bit */
-	if (!(CHIPREG_READ32(&ioc->chip->Doorbell) & MPI_DOORBELL_ACTIVE))
-		return -5;
-
+	{
+		u32 pa;
+		u16 status;
+		status = CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa);
+		if (status || !(pa & MPI_DOORBELL_ACTIVE))
+			 return -5;
+	}
  	dhsprintk((KERN_INFO MYNAM ": %s: mpt_send_handshake_request start, WaitCnt=%d\n",
  		ioc->name, ii));

-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -8;

  	if ((r = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0) {
  		return -2;
@@ -966,7 +1094,8 @@
  			(req_as_bytes[(ii*4) + 1] <<  8) |
  			(req_as_bytes[(ii*4) + 2] << 16) |
  			(req_as_bytes[(ii*4) + 3] << 24));
-		CHIPREG_WRITE32(&ioc->chip->Doorbell, word);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->Doorbell, word))
+			return -9;
  		if ((r = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0) {
  			r = -3;
  			break;
@@ -979,7 +1108,8 @@
  		r = -4;

  	/* Make sure there are no doorbells */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -10;

  	return r;
  }
@@ -1006,16 +1136,20 @@
  	int	 r = 0;

  	/* return if in use */
-	if (CHIPREG_READ32(&ioc->chip->Doorbell)
-	    & MPI_DOORBELL_ACTIVE)
-	    return -1;
-
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	{
+		u32 pa;
+		u16 status;
+		status = CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa);
+		if (status || (pa & MPI_DOORBELL_ACTIVE))
+			return -1;
+	}

-	CHIPREG_WRITE32(&ioc->chip->Doorbell,
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0) ||
+		CHIPREG_WRITE32(ioc, &ioc->chip->Doorbell,
  		((MPI_FUNCTION_HOST_PAGEBUF_ACCESS_CONTROL
  		 <<MPI_DOORBELL_FUNCTION_SHIFT) |
-		 (access_control_value<<12)));
+		 (access_control_value<<12))))
+			return -3;

  	/* Wait for IOC to clear Doorbell Status bit */
  	if ((r = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0) {
@@ -1209,6 +1343,9 @@
  	int		 r = -ENODEV;
  	u8		 revision;
  	u8		 pcixcmd;
+#ifdef CONFIG_PCIERR_CHECK
+	u16		 pcicmd;
+#endif
  	static int	 mpt_ids = 0;
  #ifdef CONFIG_PROC_FS
  	struct proc_dir_entry *dent, *ent;
@@ -1329,6 +1466,10 @@
  		ioc->pio_chip = (SYSIF_REGS __iomem *)pmem;
  	}

+#ifdef CONFIG_PCIERR_CHECK
+	INIT_WORK(&mptbase_rstTask, mptbase_schedule_reset, (void *)ioc);
+#endif
+
  	if (pdev->device == MPI_MANUFACTPAGE_DEVICEID_FC909) {
  		ioc->prod_name = "LSIFC909";
  		ioc->bus_type = FC;
@@ -1397,6 +1538,17 @@
  			pcixcmd &= 0x8F;
  			pci_write_config_byte(pdev, 0x6a, pcixcmd);
  		}
+#ifdef CONFIG_PCIERR_CHECK
+		/* set PER(0040) and SERR_EN(0100) for PCI command register */
+                /* set DPER(0001) for PCI-X command register */
+		pci_read_config_word(pdev, PCI_COMMAND, &pcicmd);
+		pcicmd |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+		pci_write_config_word(pdev, PCI_COMMAND, pcicmd);
+
+		pci_read_config_byte(pdev, 0x6a, &pcixcmd);
+		pcixcmd |= 0x0001; /* set DPER */
+		pci_write_config_byte(pdev, 0x6a, pcixcmd);
+#endif
  	}
  	else if (pdev->device == MPI_MANUFACTPAGE_DEVID_1030_53C1035) {
  		ioc->prod_name = "LSI53C1035";
@@ -1438,9 +1590,11 @@
  	spin_lock_init(&ioc->FreeQlock);

  	/* Disable all! */
-	CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, 0xFFFFFFFF))
+		return -EIO;
  	ioc->active = 0;
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -EIO;

  	/* Set lookup ptr. */
  	list_add_tail(&ioc->list, &ioc_list);
@@ -1559,19 +1713,23 @@
  	}

  	/* Disable interrupts! */
-	CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, 0xFFFFFFFF))
+		return;

  	ioc->active = 0;
  	synchronize_irq(pdev->irq);

  	/* Clear any lingering interrupt */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return;

-	CHIPREG_READ32(&ioc->chip->IntStatus);
+	if (CHIPREG_READ32(ioc, &ioc->chip->IntStatus, NULL))
+		return;

  	mpt_adapter_dispose(ioc);

  	pci_set_drvdata(pdev, NULL);
+
  }

  /**************************************************************************
@@ -1605,11 +1763,13 @@
  	}

  	/* disable interrupts */
-	CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, 0xFFFFFFFF))
+		return -EIO;
  	ioc->active = 0;

  	/* Clear any lingering interrupt */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -EIO;

  	pci_disable_device(pdev);
  	pci_set_power_state(pdev, device_state);
@@ -1630,6 +1790,7 @@
  	u32 device_state = pdev->current_state;
  	int recovery_state;
  	int ii;
+	u32 pa;

  	printk(MYIOC_s_INFO_FMT
  	"pci-resume: pdev=0x%p, slot=%s, Previous operating state [D%d]\n",
@@ -1640,11 +1801,16 @@
  	pci_enable_device(pdev);

  	/* enable interrupts */
-	CHIPREG_WRITE32(&ioc->chip->IntMask, MPI_HIM_DIM);
+	CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, MPI_HIM_DIM);
  	ioc->active = 1;

  	/* F/W not running */
-	if(!CHIPREG_READ32(&ioc->chip->Doorbell)) {
+	{
+		u16 status;
+		pa = 0;
+		status = CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa);
+	}
+	if (!pa) {
  		/* enable domain validation flags */
  		for (ii=0; ii < MPT_MAX_SCSI_DEVICES; ii++) {
  			ioc->spi_data.dvStatus[ii] |= MPT_SCSICFG_NEED_DV;
@@ -1655,7 +1821,7 @@
  		"pci-resume: ioc-state=0x%x,doorbell=0x%x\n",
  		ioc->name,
  		(mpt_GetIocState(ioc, 1) >> MPI_IOC_STATE_SHIFT),
-		CHIPREG_READ32(&ioc->chip->Doorbell));
+		pa);

  	/* bring ioc to operational state */
  	if ((recovery_state = mpt_do_ioc_recovery(ioc,
@@ -1708,7 +1874,8 @@
  			ioc->name, reason==MPT_HOSTEVENT_IOC_BRINGUP ? "bringup" : "recovery");

  	/* Disable reply interrupts (also blocks FreeQ) */
-	CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, 0xFFFFFFFF))
+		return -5;
  	ioc->active = 0;

  	if (ioc->alt_ioc) {
@@ -1716,7 +1883,9 @@
  			reset_alt_ioc_active = 1;

  		/* Disable alt-IOC's reply interrupts (and FreeQ) for a bit ... */
-		CHIPREG_WRITE32(&ioc->alt_ioc->chip->IntMask, 0xFFFFFFFF);
+		if (CHIPREG_WRITE32(ioc->alt_ioc, &ioc->alt_ioc->chip->IntMask, 0xFFFFFFFF))
+			ret = -6;
+
  		ioc->alt_ioc->active = 0;
  	}

@@ -1733,7 +1902,9 @@
  				/* (re)Enable alt-IOC! (reply interrupt, FreeQ) */
  				dprintk((KERN_INFO MYNAM ": alt-%s reply irq re-enabled\n",
  						ioc->alt_ioc->name));
-				CHIPREG_WRITE32(&ioc->alt_ioc->chip->IntMask, MPI_HIM_DIM);
+				if (CHIPREG_WRITE32(ioc->alt_ioc, &ioc->alt_ioc->chip->IntMask, MPI_HIM_DIM))
+					ret = -7;
+
  				ioc->alt_ioc->active = 1;
  			}

@@ -1849,7 +2020,8 @@

  	if (ret == 0) {
  		/* Enable! (reply interrupt) */
-		CHIPREG_WRITE32(&ioc->chip->IntMask, MPI_HIM_DIM);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, MPI_HIM_DIM))
+			ret = -8;
  		ioc->active = 1;
  	}

@@ -1857,7 +2029,8 @@
  		/* (re)Enable alt-IOC! (reply interrupt) */
  		dinitprintk((KERN_INFO MYNAM ": alt-%s reply irq re-enabled\n",
  				ioc->alt_ioc->name));
-		CHIPREG_WRITE32(&ioc->alt_ioc->chip->IntMask, MPI_HIM_DIM);
+		if (CHIPREG_WRITE32(ioc->alt_ioc, &ioc->alt_ioc->chip->IntMask, MPI_HIM_DIM))
+			ret = -9;
  		ioc->alt_ioc->active = 1;
  	}

@@ -2042,10 +2215,12 @@
  	}

  	/* Disable adapter interrupts! */
-	CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntMask, 0xFFFFFFFF))
+		return;
  	ioc->active = 0;
  	/* Clear any lingering interrupt */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return;

  	if (ioc->alloc != NULL) {
  		sz = ioc->alloc_sz;
@@ -2371,7 +2546,8 @@
  	u32 s, sc;

  	/*  Get!  */
-	s = CHIPREG_READ32(&ioc->chip->Doorbell);
+	CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &s);
+
  //	dprintk((MYIOC_s_INFO_FMT "raw state = %08x\n", ioc->name, s));
  	sc = s & MPI_IOC_STATE_MASK;

@@ -2968,15 +3144,14 @@

  	ddlprintk((MYIOC_s_INFO_FMT "downloadboot: fw size 0x%x (%d), FW Ptr %p\n",
  				ioc->name, pFwHeader->ImageSize, pFwHeader->ImageSize, pFwHeader));
-
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE);
-
-	CHIPREG_WRITE32(&ioc->chip->Diagnostic, (MPI_DIAG_PREVENT_IOC_BOOT | MPI_DIAG_DISABLE_ARM));
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, 0xFF)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, (MPI_DIAG_PREVENT_IOC_BOOT | MPI_DIAG_DISABLE_ARM)))
+		return EFAULT;

  	/* wait 1 msec */
  	if (sleepFlag == CAN_SLEEP) {
@@ -2985,11 +3160,15 @@
  		mdelay (1);
  	}

-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
-	CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val | MPI_DIAG_RESET_ADAPTER);
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -EFAULT;
+
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, diag0val | MPI_DIAG_RESET_ADAPTER))
+		return -EFAULT;

  	for (count = 0; count < 30; count ++) {
-		diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+		if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+			return -EFAULT;
  		if (!(diag0val & MPI_DIAG_RESET_ADAPTER)) {
  			ddlprintk((MYIOC_s_INFO_FMT "RESET_ADAPTER cleared, count=%d\n",
  				ioc->name, count));
@@ -3010,15 +3189,17 @@
  		return -3;
  	}

-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE);
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE);
+	if(CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, 0xFF)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE))
+		return -EFAULT;

  	/* Set the DiagRwEn and Disable ARM bits */
-	CHIPREG_WRITE32(&ioc->chip->Diagnostic, (MPI_DIAG_RW_ENABLE | MPI_DIAG_DISABLE_ARM));
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, (MPI_DIAG_RW_ENABLE | MPI_DIAG_DISABLE_ARM)))
+		return -EFAULT;

  	fwSize = (pFwHeader->ImageSize + 3)/4;
  	ptrFw = (u32 *) pFwHeader;
@@ -3081,10 +3262,10 @@
  		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, diagRwData);

  	} else /* if((ioc->bus_type == SAS) || (ioc->bus_type == FC)) */ {
-		diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
-		CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val |
-		    MPI_DIAG_CLEAR_FLASH_BAD_SIG);
-
+		if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val)
+			|| CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic,
+				 diag0val | MPI_DIAG_CLEAR_FLASH_BAD_SIG))
+			return -EFAULT;
  		/* wait 1 msec */
  		if (sleepFlag == CAN_SLEEP) {
  			msleep_interruptible (1);
@@ -3096,17 +3277,20 @@
  	if (ioc->errata_flag_1064)
  		pci_disable_io_access(ioc->pcidev);

-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -EFAULT;
  	ddlprintk((MYIOC_s_INFO_FMT "downloadboot diag0val=%x, "
  		"turning off PREVENT_IOC_BOOT, DISABLE_ARM, RW_ENABLE\n",
  		ioc->name, diag0val));
  	diag0val &= ~(MPI_DIAG_PREVENT_IOC_BOOT | MPI_DIAG_DISABLE_ARM | MPI_DIAG_RW_ENABLE);
  	ddlprintk((MYIOC_s_INFO_FMT "downloadboot now diag0val=%x\n",
  		ioc->name, diag0val));
-	CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, diag0val))
+		return -EFAULT;

  	/* Write 0xFF to reset the sequencer */
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, 0xFF))
+		return -EFAULT;

  	if (ioc->bus_type == SAS) {
  		ioc_state = mpt_GetIocState(ioc, 0);
@@ -3250,14 +3434,17 @@
  #endif

  	/* Clear any existing interrupts */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -1;

  	/* Use "Diagnostic reset" method! (only thing available!) */
-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -1;

  #ifdef MPT_DEBUG
  	if (ioc->alt_ioc)
-		diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+		if (CHIPREG_READ32(ioc->alt_ioc, &ioc->alt_ioc->chip->Diagnostic, &diag1val))
+			return -1;
  	dprintk((MYIOC_s_INFO_FMT "DbG1: diag0=%08x, diag1=%08x\n",
  			ioc->name, diag0val, diag1val));
  #endif
@@ -3270,12 +3457,13 @@
  			/* Write magic sequence to WriteSequence register
  			 * Loop until in diagnostic mode
  			 */
-			CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
-			CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
-			CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE);
-			CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE);
-			CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE);
-			CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE);
+			if (CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, 0xFF)
+				|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE)
+				|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE)
+				|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE)
+				|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE)
+				|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE))
+				return -1;

  			/* wait 100 msec */
  			if (sleepFlag == CAN_SLEEP) {
@@ -3292,7 +3480,8 @@

  			}

-			diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+			if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+				return -1;

  			dprintk((MYIOC_s_INFO_FMT "Wrote magic DiagWriteEn sequence (%x)\n",
  					ioc->name, diag0val));
@@ -3300,7 +3489,8 @@

  #ifdef MPT_DEBUG
  		if (ioc->alt_ioc)
-			diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+			if (CHIPREG_READ32(ioc->alt_ioc, &ioc->alt_ioc->chip->Diagnostic, &diag1val))
+				return -1;
  		dprintk((MYIOC_s_INFO_FMT "DbG2: diag0=%08x, diag1=%08x\n",
  				ioc->name, diag0val, diag1val));
  #endif
@@ -3308,14 +3498,16 @@
  		 * Disable the ARM (Bug fix)
  		 *
  		 */
-		CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val | MPI_DIAG_DISABLE_ARM);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, diag0val | MPI_DIAG_DISABLE_ARM))
+			return -1;
  		mdelay(1);

  		/*
  		 * Now hit the reset bit in the Diagnostic register
  		 * (THE BIG HAMMER!) (Clears DRWE bit).
  		 */
-		CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val | MPI_DIAG_RESET_ADAPTER);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, diag0val | MPI_DIAG_RESET_ADAPTER))
+			return -1;
  		hard_reset_done = 1;
  		dprintk((MYIOC_s_INFO_FMT "Diagnostic reset performed\n",
  				ioc->name));
@@ -3351,7 +3543,8 @@
  			 * case.  _diag_reset will return < 0
  			 */
  			for (count = 0; count < 30; count ++) {
-				diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+				if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+					return -1;
  				if (!(diag0val & MPI_DIAG_RESET_ADAPTER)) {
  					break;
  				}
@@ -3377,7 +3570,8 @@
  			 * with calling program.
  			 */
  			for (count = 0; count < 60; count ++) {
-				doorbell = CHIPREG_READ32(&ioc->chip->Doorbell);
+			  if (CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &doorbell))
+					return -1;
  				doorbell &= MPI_IOC_STATE_MASK;

  				if (doorbell == MPI_IOC_STATE_READY) {
@@ -3394,10 +3588,12 @@
  		}
  	}

-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -1;
  #ifdef MPT_DEBUG
  	if (ioc->alt_ioc)
-		diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+		if (CHIPREG_READ32(ioc->alt_ioc, &ioc->alt_ioc->chip->Diagnostic, &diag1val))
+			return -1;
  	dprintk((MYIOC_s_INFO_FMT "DbG3: diag0=%08x, diag1=%08x\n",
  		ioc->name, diag0val, diag1val));
  #endif
@@ -3405,18 +3601,20 @@
  	/* Clear RESET_HISTORY bit!  Place board in the
  	 * diagnostic mode to update the diag register.
  	 */
-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -1;
  	count = 0;
  	while ((diag0val & MPI_DIAG_DRWE) == 0) {
  		/* Write magic sequence to WriteSequence register
  		 * Loop until in diagnostic mode
  		 */
-		CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
-		CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
-		CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE);
-		CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE);
-		CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE);
-		CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, 0xFF)
+			|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE)
+			|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE)
+			|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE)
+			|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE)
+			|| CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE))
+			return -1;

  		/* wait 100 msec */
  		if (sleepFlag == CAN_SLEEP) {
@@ -3431,11 +3629,15 @@
  					ioc->name, diag0val);
  			break;
  		}
-		diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+		if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+			return -1;
  	}
  	diag0val &= ~MPI_DIAG_RESET_HISTORY;
-	CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val);
-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->Diagnostic, diag0val))
+		return -1;
+
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -1;
  	if (diag0val & MPI_DIAG_RESET_HISTORY) {
  		printk(MYIOC_s_WARN_FMT "ResetHistory bit failed to clear!\n",
  				ioc->name);
@@ -3443,11 +3645,13 @@

  	/* Disable Diagnostic Mode
  	 */
-	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFFFFFFFF);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->WriteSequence, 0xFFFFFFFF))
+		return -1;

  	/* Check FW reload status flags.
  	 */
-	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+	if (CHIPREG_READ32(ioc, &ioc->chip->Diagnostic, &diag0val))
+		return -1;
  	if (diag0val & (MPI_DIAG_FLASH_BAD_SIG | MPI_DIAG_RESET_ADAPTER | MPI_DIAG_DISABLE_ARM)) {
  		printk(MYIOC_s_ERR_FMT "Diagnostic reset FAILED! (%02xh)\n",
  				ioc->name, diag0val);
@@ -3456,7 +3660,8 @@

  #ifdef MPT_DEBUG
  	if (ioc->alt_ioc)
-		diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+		if (CHIPREG_READ32(ioc->alt_ioc, &ioc->alt_ioc->chip->Diagnostic, &diag1val))
+			return -1;
  	dprintk((MYIOC_s_INFO_FMT "DbG4: diag0=%08x, diag1=%08x\n",
  			ioc->name, diag0val, diag1val));
  #endif
@@ -3492,7 +3697,8 @@

  	drsprintk((KERN_INFO MYNAM ": %s: Sending IOC reset(0x%02x)!\n",
  			ioc->name, reset_type));
-	CHIPREG_WRITE32(&ioc->chip->Doorbell, reset_type<<MPI_DOORBELL_FUNCTION_SHIFT);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->Doorbell, reset_type<<MPI_DOORBELL_FUNCTION_SHIFT))
+		return -EFAULT;
  	if ((r = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0)
  		return r;

@@ -3789,7 +3995,9 @@

  	for (i = 0; i < ioc->reply_depth; i++) {
  		/*  Write each address to the IOC!  */
-		CHIPREG_WRITE32(&ioc->chip->ReplyFifo, alloc_dma);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->ReplyFifo, alloc_dma))
+			goto out_fail;
+
  		alloc_dma += ioc->reply_sz;
  	}

@@ -3854,10 +4062,11 @@
  	 * then tell IOC that we want to handshake a request of N words.
  	 * (WRITE u32val to Doorbell reg).
  	 */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
-	CHIPREG_WRITE32(&ioc->chip->Doorbell,
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0)
+		|| CHIPREG_WRITE32(ioc, &ioc->chip->Doorbell,
  			((MPI_FUNCTION_HANDSHAKE<<MPI_DOORBELL_FUNCTION_SHIFT) |
-			 ((reqBytes/4)<<MPI_DOORBELL_ADD_DWORDS_SHIFT)));
+			((reqBytes/4)<<MPI_DOORBELL_ADD_DWORDS_SHIFT))))
+		return -1;

  	/*
  	 * Wait for IOC's doorbell handshake int
@@ -3869,15 +4078,21 @@
  			ioc->name, reqBytes, t, failcnt ? " - MISSING DOORBELL HANDSHAKE!" : ""));

  	/* Read doorbell and check for active bit */
-	if (!(CHIPREG_READ32(&ioc->chip->Doorbell) & MPI_DOORBELL_ACTIVE))
+	{
+		u32 pa;
+		u16 status;
+		status = CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa);
+		if (status || !(pa & MPI_DOORBELL_ACTIVE))
  			return -1;
+	}

  	/*
  	 * Clear doorbell int (WRITE 0 to IntStatus reg),
  	 * then wait for IOC to ACKnowledge that it's ready for
  	 * our handshake request.
  	 */
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -1;
  	if (!failcnt && (t = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0)
  		failcnt++;

@@ -3895,7 +4110,8 @@
  				    (req_as_bytes[(ii*4) + 2] << 16) |
  				    (req_as_bytes[(ii*4) + 3] << 24));

-			CHIPREG_WRITE32(&ioc->chip->Doorbell, word);
+			if (CHIPREG_WRITE32(ioc, &ioc->chip->Doorbell, word))
+				return -1;
  			if ((t = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0)
  				failcnt++;
  		}
@@ -3951,7 +4167,8 @@

  	if (sleepFlag == CAN_SLEEP) {
  		while (--cntdn) {
-			intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+			if (CHIPREG_READ32(ioc, &ioc->chip->IntStatus, &intstat))
+				return -1;
  			if (! (intstat & MPI_HIS_IOP_DOORBELL_STATUS))
  				break;
  			msleep_interruptible (1);
@@ -3959,7 +4176,8 @@
  		}
  	} else {
  		while (--cntdn) {
-			intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+			if (CHIPREG_READ32(ioc, &ioc->chip->IntStatus, &intstat))
+				return -1;
  			if (! (intstat & MPI_HIS_IOP_DOORBELL_STATUS))
  				break;
  			mdelay (1);
@@ -4000,7 +4218,8 @@
  	cntdn = 1000 * howlong;
  	if (sleepFlag == CAN_SLEEP) {
  		while (--cntdn) {
-			intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+			if (CHIPREG_READ32(ioc, &ioc->chip->IntStatus, &intstat))
+				return -1;
  			if (intstat & MPI_HIS_DOORBELL_INTERRUPT)
  				break;
  			msleep_interruptible(1);
@@ -4008,7 +4227,8 @@
  		}
  	} else {
  		while (--cntdn) {
-			intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+			if (CHIPREG_READ32(ioc, &ioc->chip->IntStatus, &intstat))
+				return -1;
  			if (intstat & MPI_HIS_DOORBELL_INTERRUPT)
  				break;
  			mdelay(1);
@@ -4059,13 +4279,27 @@
  	if ((t = WaitForDoorbellInt(ioc, howlong, sleepFlag)) < 0) {
  		failcnt++;
  	} else {
-		hs_reply[u16cnt++] = le16_to_cpu(CHIPREG_READ32(&ioc->chip->Doorbell) & 0x0000FFFF);
-		CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+		{
+			u32 pa;
+			if (CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa))
+				return -1;
+			hs_reply[u16cnt++] = le16_to_cpu(pa & 0x0000FFFF);
+		}
+
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+			return -1;
  		if ((t = WaitForDoorbellInt(ioc, 5, sleepFlag)) < 0)
  			failcnt++;
  		else {
-			hs_reply[u16cnt++] = le16_to_cpu(CHIPREG_READ32(&ioc->chip->Doorbell) & 0x0000FFFF);
-			CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+			{
+				u32 pa;
+				if (CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa))
+					return -1;
+				hs_reply[u16cnt++] = le16_to_cpu(pa & 0x0000FFFF);
+			}
+
+			if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+				return -1;
  		}
  	}

@@ -4080,16 +4314,23 @@
  	for (u16cnt=2; !failcnt && u16cnt < (2 * mptReply->MsgLength); u16cnt++) {
  		if ((t = WaitForDoorbellInt(ioc, 5, sleepFlag)) < 0)
  			failcnt++;
-		hword = le16_to_cpu(CHIPREG_READ32(&ioc->chip->Doorbell) & 0x0000FFFF);
+		{
+			u32 pa;
+			if (CHIPREG_READ32(ioc, &ioc->chip->Doorbell, &pa))
+				return -1;
+			hword = le16_to_cpu(pa & 0x0000FFFF);
+		}
  		/* don't overflow our IOC hs_reply[] buffer! */
  		if (u16cnt < sizeof(ioc->hs_reply) / sizeof(ioc->hs_reply[0]))
  			hs_reply[u16cnt] = hword;
-		CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+		if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+			return -1;
  	}

  	if (!failcnt && (t = WaitForDoorbellInt(ioc, 5, sleepFlag)) < 0)
  		failcnt++;
-	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
+	if (CHIPREG_WRITE32(ioc, &ioc->chip->IntStatus, 0))
+		return -1;

  	if (failcnt) {
  		printk(MYIOC_s_ERR_FMT "Handshake reply failure!\n",


