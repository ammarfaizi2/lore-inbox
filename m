Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWHQIDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWHQIDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWHQIDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:03:10 -0400
Received: from msr41.hinet.net ([168.95.4.141]:53655 "EHLO msr41.hinet.net")
	by vger.kernel.org with ESMTP id S932257AbWHQIDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:03:05 -0400
Subject: [PATCH 7/7] ip1000: For compatible at PCI 66MHz issue
From: Jesse Huang <jesse@icplus.com.tw>
To: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:50:05 -0400
Message-Id: <1155844205.5006.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

IP1000A on some motherboard when running at PCI 66MHz will cause transmit
hold. I had change three functions to solve this problem. Sorry for lot of
modify.

Change Logs:
      For compatible at 66MHz issue
      rewrite init_tfdlist()
      rewrite ipg_nic_hard_start_xmit()
      rewrite ipg_nic_txfree()

      in ipg.h add:
      long LastTFDHoldAddr;
      int  LastTFDHoldCnt;
      int ResetCurrentTFD;

---

 drivers/net/ipg.c |   40 +++++++++++++++++++++++++++++++---------
 drivers/net/ipg.h |    4 +++-
 2 files changed, 34 insertions(+), 10 deletions(-)

152a32c3d36ec4ce1eee72429aa5956274bb0e6a
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index ae22fa8..8127f2c 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -886,10 +886,7 @@ static int init_tfdlist(struct net_devic
 	IPG_DEBUG_MSG("_init_tfdlist\n");
 
 	for (i = 0; i < IPG_TFDLIST_LENGTH; i++) {
-		sp->TFDList[i].TFDNextPtr = cpu_to_le64(sp->TFDListDMAhandle +
-							((sizeof(struct TFD)) *
-							 ((i + 1) %
-							  IPG_TFDLIST_LENGTH)));
+		sp->TFDList[i].TFDNextPtr = 0;
 
 		sp->TFDList[i].TFC = cpu_to_le64(IPG_TFC_TFDDONE);
 		if (sp->TxBuff[i] != NULL)
@@ -907,6 +904,7 @@ static int init_tfdlist(struct net_devic
 	iowrite32((u32) (sp->TFDListDMAhandle), ioaddr + TFD_LIST_PTR_0);
 	iowrite32(0x00000000, ioaddr + TFD_LIST_PTR_1);
 
+	sp->ResetCurrentTFD=1;
 	return 0;
 }
 
@@ -919,6 +917,7 @@ static void ipg_nic_txfree(struct net_de
 	struct ipg_nic_private *sp = netdev_priv(dev);
 	int NextToFree;
 	int maxtfdcount;
+	long CurrentTxTFDPtr=(ioread32(ipg_ioaddr(dev)+TFD_LIST_PTR_0)-(long)sp->TFDListDMAhandle)/(long)sizeof(struct TFD);
 
 	IPG_DEBUG_MSG("_nic_txfree\n");
 
@@ -941,8 +940,10 @@ static void ipg_nic_txfree(struct net_de
 		 * If the TFDDone bit is set, free the associated
 		 * buffer.
 		 */
-		if ((le64_to_cpu(sp->TFDList[NextToFree].TFC) &
-		     IPG_TFC_TFDDONE) && (NextToFree != sp->CurrentTFD)) {
+		if((NextToFree != sp->CurrentTFD)&&(NextToFree!=CurrentTxTFDPtr))
+		{
+			//JesseAdd: setup TFDDONE for compatible issue.
+			sp->TFDList[NextToFree].TFC = cpu_to_le64(sp->TFDList[NextToFree].TFC|IPG_TFC_TFDDONE);
 			/* Free the transmit buffer. */
 			if (sp->TxBuff[NextToFree] != NULL) {
 				pci_unmap_single(sp->pdev,
@@ -965,6 +966,15 @@ static void ipg_nic_txfree(struct net_de
 		maxtfdcount--;
 
 	} while (maxtfdcount != 0);
+	if(sp->LastTFDHoldCnt>1000) {
+		sp->LastTFDHoldCnt=0;
+		ipg_reset(dev, IPG_AC_TX_RESET | IPG_AC_DMA | IPG_AC_NETWORK | IPG_AC_FIFO);
+		// Re-configure after DMA reset. 
+		if ((ipg_io_config(dev) < 0) ||(init_tfdlist(dev) < 0)) {
+			printk(KERN_INFO"%s: Error during re-configuration.\n",dev->name);
+		}
+		iowrite32(IPG_MC_RSVD_MASK & (ioread32(ipg_ioaddr(dev) + MAC_CTRL) | IPG_MC_TX_ENABLE),ipg_ioaddr(dev) + MAC_CTRL);
+	}	
 }
 
 /*
@@ -2041,10 +2051,17 @@ static int ipg_nic_hard_start_xmit(struc
 	 * counter, modulus the length of the TFDList.
 	 */
 	NextTFD = (sp->CurrentTFD + 1) % IPG_TFDLIST_LENGTH;
+	if(sp->ResetCurrentTFD!=0)
+	{
+		sp->ResetCurrentTFD=0;
+		NextTFD=0;	
+	}
+	/* Check for availability of next TFD. Reserve 1 for not become ring*/
+	if (NextTFD == sp->LastFreedTxBuff) {
+		
+		if(sp->LastTFDHoldAddr==sp->CurrentTFD) sp->LastTFDHoldCnt++;
+		else {sp->LastTFDHoldAddr=sp->CurrentTFD;sp->LastTFDHoldCnt=0;}
 
-	/* Check for availability of next TFD. */
-	if (!(le64_to_cpu(sp->TFDList[NextTFD].TFC) &
-	      IPG_TFC_TFDDONE) || (NextTFD == sp->LastFreedTxBuff)) {
 		IPG_DEBUG_MSG("Next TFD not available.\n");
 
 		/* Attempt to free any used TFDs. */
@@ -2058,8 +2075,11 @@ #ifdef IPG_DEBUG
 		sp->TFDunavailCount++;
 #endif
 
+		iowrite32(IPG_DC_RSVD_MASK & (IPG_DC_TX_DMA_POLL_NOW),ioaddr + DMA_CTRL);
 		return -ENOMEM;
 	}
+	
+	sp->TFDList[NextTFD].TFDNextPtr=0;
 
 	sp->TxBuffDMAhandle[NextTFD].len = skb->len;
 	sp->TxBuffDMAhandle[NextTFD].dmahandle =
@@ -2151,6 +2171,8 @@ #endif
 	 * for transfer to the IPG.
 	 */
 	sp->TFDList[NextTFD].TFC &= cpu_to_le64(~IPG_TFC_TFDDONE);
+	sp->TFDList[sp->CurrentTFD].TFDNextPtr=cpu_to_le64(sp->TFDListDMAhandle+
+sizeof(struct TFD)*NextTFD);
 
 	/* Record frame transmit start time (jiffies = Linux
 	 * kernel current time stamp).
diff --git a/drivers/net/ipg.h b/drivers/net/ipg.h
index 818a677..9688483 100644
--- a/drivers/net/ipg.h
+++ b/drivers/net/ipg.h
@@ -834,7 +834,9 @@ #endif
 
 	struct mutex		mii_mutex;
 	struct mii_if_info	mii_if;
-
+	long LastTFDHoldAddr;
+	int  LastTFDHoldCnt;
+	int ResetCurrentTFD;
 #ifdef IPG_DEBUG
 	int TFDunavailCount;
 	int RFDlistendCount;
-- 
1.3.GIT



