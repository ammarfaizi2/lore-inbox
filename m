Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUKODvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUKODvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKOCYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:24:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261435AbUKOCVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:21:41 -0500
Date: Mon, 15 Nov 2004 03:09:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI initio.c: some cleanups
Message-ID: <20041115020949.GN2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups:
- make some needlessly global code static
- remove the unused global function tul_pop_pend_scb

Please review and apply if it's correct.


diffstat output:
 drivers/scsi/initio.c |   79 +++++++++++++++---------------------------
 drivers/scsi/initio.h |   18 ---------
 2 files changed, 30 insertions(+), 67 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/initio.h.old	2004-11-13 21:52:20.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/initio.h	2004-11-13 22:00:34.000000000 +0100
@@ -719,21 +719,3 @@
 #define SCSI_RESET_HOST_RESET 0x200
 #define SCSI_RESET_ACTION   0xff
 
-extern void init_i91uAdapter_table(void);
-extern int Addi91u_into_Adapter_table(WORD, WORD, BYTE, BYTE, BYTE);
-extern int tul_ReturnNumberOfAdapters(void);
-extern void get_tulipPCIConfig(HCS * pHCB, int iChannel_index);
-extern int init_tulip(HCS * pHCB, SCB * pSCB, int tul_num_scb, BYTE * pbBiosAdr, int reset_time);
-extern SCB *tul_alloc_scb(HCS * pHCB);
-extern int tul_abort_srb(HCS * pHCB, struct scsi_cmnd * pSRB);
-extern void tul_exec_scb(HCS * pHCB, SCB * pSCB);
-extern void tul_release_scb(HCS * pHCB, SCB * pSCB);
-extern void tul_stop_bm(HCS * pHCB);
-extern int tul_reset_scsi(HCS * pCurHcb, int seconds);
-extern int tul_isr(HCS * pHCB);
-extern int tul_reset(HCS * pHCB, struct scsi_cmnd * pSRB, unsigned char target);
-extern int tul_reset_scsi_bus(HCS * pCurHcb);
-extern int tul_device_reset(HCS * pCurHcb, struct scsi_cmnd *pSrb,
-		unsigned int target, unsigned int ResetFlags);
-				/* ---- EXTERNAL VARIABLES ---- */
-extern HCS tul_hcs[];
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/initio.c.old	2004-11-13 21:52:33.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/initio.c	2004-11-13 22:01:19.000000000 +0100
@@ -223,7 +223,7 @@
 static void tul_select_atn3(HCS * pCurHcb, SCB * pCurScb);
 static void tul_select_atn_stop(HCS * pCurHcb, SCB * pCurScb);
 static int int_tul_busfree(HCS * pCurHcb);
-int int_tul_scsi_rst(HCS * pCurHcb);
+static int int_tul_scsi_rst(HCS * pCurHcb);
 static int int_tul_bad_seq(HCS * pCurHcb);
 static int int_tul_resel(HCS * pCurHcb);
 static int tul_sync_done(HCS * pCurHcb);
@@ -240,9 +240,7 @@
 static void tul_se2_update_all(WORD CurBase);	/* setup default pattern */
 static void tul_read_eeprom(WORD CurBase);
 
-				/* ---- EXTERNAL VARIABLES ---- */
-HCS tul_hcs[MAX_SUPPORTED_ADAPTERS];
-				/* ---- INTERNAL VARIABLES ---- */
+static HCS tul_hcs[MAX_SUPPORTED_ADAPTERS];
 static INI_ADPT_STRUCT i91u_adpt[MAX_SUPPORTED_ADAPTERS];
 
 /*NVRAM nvram, *nvramp = &nvram; */
@@ -381,7 +379,7 @@
 
 
 ******************************************************************/
-void tul_se2_instr(WORD CurBase, UCHAR instr)
+static void tul_se2_instr(WORD CurBase, UCHAR instr)
 {
 	int i;
 	UCHAR b;
@@ -437,7 +435,7 @@
 	Input  :address of Serial E2PROM
 	Output :value stored in  Serial E2PROM
 *******************************************************************/
-USHORT tul_se2_rd(WORD CurBase, ULONG adr)
+static USHORT tul_se2_rd(WORD CurBase, ULONG adr)
 {
 	UCHAR instr, readByte;
 	USHORT readWord;
@@ -468,7 +466,7 @@
 /******************************************************************
  Input: new value in  Serial E2PROM, address of Serial E2PROM
 *******************************************************************/
-void tul_se2_wr(WORD CurBase, UCHAR adr, USHORT writeWord)
+static void tul_se2_wr(WORD CurBase, UCHAR adr, USHORT writeWord)
 {
 	UCHAR readByte;
 	UCHAR instr;
@@ -584,8 +582,8 @@
 	TUL_WR(CurBase + TUL_GCTRL, gctrl & ~TUL_GCTRL_EEPROM_BIT);
 }				/* read_eeprom */
 
-int Addi91u_into_Adapter_table(WORD wBIOS, WORD wBASE, BYTE bInterrupt,
-			       BYTE bBus, BYTE bDevice)
+static int Addi91u_into_Adapter_table(WORD wBIOS, WORD wBASE, BYTE bInterrupt,
+				      BYTE bBus, BYTE bDevice)
 {
 	int i, j;
 
@@ -616,7 +614,7 @@
 	return 1;
 }
 
-void init_i91uAdapter_table(void)
+static void init_i91uAdapter_table(void)
 {
 	int i;
 
@@ -630,7 +628,7 @@
 	return;
 }
 
-void tul_stop_bm(HCS * pCurHcb)
+static void tul_stop_bm(HCS * pCurHcb)
 {
 
 	if (TUL_RD(pCurHcb->HCS_Base, TUL_XStatus) & XPEND) {	/* if DMA xfer is pending, abort DMA xfer */
@@ -642,7 +640,7 @@
 }
 
 /***************************************************************************/
-void get_tulipPCIConfig(HCS * pCurHcb, int ch_idx)
+static void get_tulipPCIConfig(HCS * pCurHcb, int ch_idx)
 {
 	pCurHcb->HCS_Base = i91u_adpt[ch_idx].ADPT_BASE;	/* Supply base address  */
 	pCurHcb->HCS_BIOS = i91u_adpt[ch_idx].ADPT_BIOS;	/* Supply BIOS address  */
@@ -651,7 +649,7 @@
 }
 
 /***************************************************************************/
-int tul_reset_scsi(HCS * pCurHcb, int seconds)
+static int tul_reset_scsi(HCS * pCurHcb, int seconds)
 {
 	TUL_WR(pCurHcb->HCS_Base + TUL_SCtrl0, TSC_RST_BUS);
 
@@ -670,7 +668,7 @@
 }
 
 /***************************************************************************/
-int init_tulip(HCS * pCurHcb, SCB * scbp, int tul_num_scb, BYTE * pbBiosAdr, int seconds)
+static int init_tulip(HCS * pCurHcb, SCB * scbp, int tul_num_scb, BYTE * pbBiosAdr, int seconds)
 {
 	int i;
 	BYTE *pwFlags;
@@ -788,7 +786,7 @@
 }
 
 /***************************************************************************/
-SCB *tul_alloc_scb(HCS * hcsp)
+static SCB *tul_alloc_scb(HCS * hcsp)
 {
 	SCB *pTmpScb;
 	ULONG flags;
@@ -807,7 +805,7 @@
 }
 
 /***************************************************************************/
-void tul_release_scb(HCS * hcsp, SCB * scbp)
+static void tul_release_scb(HCS * hcsp, SCB * scbp)
 {
 	ULONG flags;
 
@@ -829,7 +827,7 @@
 }
 
 /***************************************************************************/
-void tul_append_pend_scb(HCS * pCurHcb, SCB * scbp)
+static void tul_append_pend_scb(HCS * pCurHcb, SCB * scbp)
 {
 
 #if DEBUG_QUEUE
@@ -847,7 +845,7 @@
 }
 
 /***************************************************************************/
-void tul_push_pend_scb(HCS * pCurHcb, SCB * scbp)
+static void tul_push_pend_scb(HCS * pCurHcb, SCB * scbp)
 {
 
 #if DEBUG_QUEUE
@@ -863,7 +861,7 @@
 }
 
 /***************************************************************************/
-SCB *tul_find_first_pend_scb(HCS * pCurHcb)
+static SCB *tul_find_first_pend_scb(HCS * pCurHcb)
 {
 	SCB *pFirstPend;
 
@@ -894,24 +892,7 @@
 	return (pFirstPend);
 }
 /***************************************************************************/
-SCB *tul_pop_pend_scb(HCS * pCurHcb)
-{
-	SCB *pTmpScb;
-
-	if ((pTmpScb = pCurHcb->HCS_FirstPend) != NULL) {
-		if ((pCurHcb->HCS_FirstPend = pTmpScb->SCB_NxtScb) == NULL)
-			pCurHcb->HCS_LastPend = NULL;
-		pTmpScb->SCB_NxtScb = NULL;
-	}
-#if DEBUG_QUEUE
-	printk("Pop pend SCB %lx; ", (ULONG) pTmpScb);
-#endif
-	return (pTmpScb);
-}
-
-
-/***************************************************************************/
-void tul_unlink_pend_scb(HCS * pCurHcb, SCB * pCurScb)
+static void tul_unlink_pend_scb(HCS * pCurHcb, SCB * pCurScb)
 {
 	SCB *pTmpScb, *pPrevScb;
 
@@ -939,7 +920,7 @@
 	return;
 }
 /***************************************************************************/
-void tul_append_busy_scb(HCS * pCurHcb, SCB * scbp)
+static void tul_append_busy_scb(HCS * pCurHcb, SCB * scbp)
 {
 
 #if DEBUG_QUEUE
@@ -961,7 +942,7 @@
 }
 
 /***************************************************************************/
-SCB *tul_pop_busy_scb(HCS * pCurHcb)
+static SCB *tul_pop_busy_scb(HCS * pCurHcb)
 {
 	SCB *pTmpScb;
 
@@ -982,7 +963,7 @@
 }
 
 /***************************************************************************/
-void tul_unlink_busy_scb(HCS * pCurHcb, SCB * pCurScb)
+static void tul_unlink_busy_scb(HCS * pCurHcb, SCB * pCurScb)
 {
 	SCB *pTmpScb, *pPrevScb;
 
@@ -1037,7 +1018,7 @@
 }
 
 /***************************************************************************/
-void tul_append_done_scb(HCS * pCurHcb, SCB * scbp)
+static void tul_append_done_scb(HCS * pCurHcb, SCB * scbp)
 {
 
 #if DEBUG_QUEUE
@@ -1073,7 +1054,7 @@
 }
 
 /***************************************************************************/
-int tul_abort_srb(HCS * pCurHcb, struct scsi_cmnd *srbp)
+static int tul_abort_srb(HCS * pCurHcb, struct scsi_cmnd *srbp)
 {
 	ULONG flags;
 	SCB *pTmpScb, *pPrevScb;
@@ -1163,7 +1144,7 @@
 }
 
 /***************************************************************************/
-int tul_bad_seq(HCS * pCurHcb)
+static int tul_bad_seq(HCS * pCurHcb)
 {
 	SCB *pCurScb;
 
@@ -1183,8 +1164,8 @@
 }
 
 /************************************************************************/
-int tul_device_reset(HCS * pCurHcb, struct scsi_cmnd *pSrb,
-		unsigned int target, unsigned int ResetFlags)
+static int tul_device_reset(HCS * pCurHcb, struct scsi_cmnd *pSrb,
+			    unsigned int target, unsigned int ResetFlags)
 {
 	ULONG flags;
 	SCB *pScb;
@@ -1255,7 +1236,7 @@
 	return SCSI_RESET_PENDING;
 }
 
-int tul_reset_scsi_bus(HCS * pCurHcb)
+static int tul_reset_scsi_bus(HCS * pCurHcb)
 {
 	ULONG flags;
 
@@ -1285,7 +1266,7 @@
 }
 
 /************************************************************************/
-void tul_exec_scb(HCS * pCurHcb, SCB * pCurScb)
+static void tul_exec_scb(HCS * pCurHcb, SCB * pCurScb)
 {
 	ULONG flags;
 
@@ -1318,7 +1299,7 @@
 }
 
 /***************************************************************************/
-int tul_isr(HCS * pCurHcb)
+static int tul_isr(HCS * pCurHcb)
 {
 	/* Enter critical section       */
 
@@ -2108,7 +2089,7 @@
 
 /***************************************************************************/
 /* scsi bus reset */
-int int_tul_scsi_rst(HCS * pCurHcb)
+static int int_tul_scsi_rst(HCS * pCurHcb)
 {
 	SCB *pCurScb;
 	int i;

