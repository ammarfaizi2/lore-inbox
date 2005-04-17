Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVDQUrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVDQUrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVDQUqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:46:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23315 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261479AbVDQUTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:19:00 -0400
Date: Sun, 17 Apr 2005 22:18:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: support@comtrol.com
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/rocket.c: cleanups
Message-ID: <20050417201858.GQ3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- remove the TRUE/FALSE macros

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/rocket.c     |  226 ++++++++++++++++++++------------------
 drivers/char/rocket_int.h |   40 ------
 2 files changed, 119 insertions(+), 147 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/char/rocket_int.h.old	2005-04-17 18:21:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/rocket_int.h	2005-04-17 18:26:53.000000000 +0200
@@ -1130,46 +1130,6 @@
 */
 #define sWriteTxByte(IO,DATA) sOutB(IO,DATA)
 
-int sInitController(CONTROLLER_T * CtlP,
-		    int CtlNum,
-		    ByteIO_t MudbacIO,
-		    ByteIO_t * AiopIOList,
-		    int AiopIOListSize,
-		    int IRQNum, Byte_t Frequency, int PeriodicOnly);
-
-int sPCIInitController(CONTROLLER_T * CtlP,
-		       int CtlNum,
-		       ByteIO_t * AiopIOList,
-		       int AiopIOListSize,
-		       WordIO_t ConfigIO,
-		       int IRQNum,
-		       Byte_t Frequency,
-		       int PeriodicOnly,
-		       int altChanRingIndicator, int UPCIRingInd);
-
-int sReadAiopID(ByteIO_t io);
-int sReadAiopNumChan(WordIO_t io);
-int sInitChan(CONTROLLER_T * CtlP,
-	      CHANNEL_T * ChP, int AiopNum, int ChanNum);
-Byte_t sGetRxErrStatus(CHANNEL_T * ChP);
-void sStopRxProcessor(CHANNEL_T * ChP);
-void sStopSWInFlowCtl(CHANNEL_T * ChP);
-void sFlushRxFIFO(CHANNEL_T * ChP);
-void sFlushTxFIFO(CHANNEL_T * ChP);
-int sWriteTxPrioByte(CHANNEL_T * ChP, Byte_t Data);
-void sEnInterrupts(CHANNEL_T * ChP, Word_t Flags);
-void sDisInterrupts(CHANNEL_T * ChP, Word_t Flags);
-void sModemReset(CONTROLLER_T * CtlP, int chan, int on);
-void sPCIModemReset(CONTROLLER_T * CtlP, int chan, int on);
-void sSetInterfaceMode(CHANNEL_T * ChP, Byte_t mode);
-
-extern Byte_t R[RDATASIZE];
-extern CONTROLLER_T sController[CTL_SIZE];
-extern Byte_t sIRQMap[16];
-extern Byte_t sBitMapClrTbl[8];
-extern Byte_t sBitMapSetTbl[8];
-extern int sClockPrescale;
-
 /*
  * Begin Linux specific definitions for the Rocketport driver
  *
--- linux-2.6.12-rc2-mm3-full/drivers/char/rocket.c.old	2005-04-17 18:20:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/rocket.c	2005-04-17 18:45:51.000000000 +0200
@@ -161,6 +161,64 @@
 	UPCI_AIOP_INTR_BIT_3
 };
 
+static Byte_t RData[RDATASIZE] = {
+	0x00, 0x09, 0xf6, 0x82,
+	0x02, 0x09, 0x86, 0xfb,
+	0x04, 0x09, 0x00, 0x0a,
+	0x06, 0x09, 0x01, 0x0a,
+	0x08, 0x09, 0x8a, 0x13,
+	0x0a, 0x09, 0xc5, 0x11,
+	0x0c, 0x09, 0x86, 0x85,
+	0x0e, 0x09, 0x20, 0x0a,
+	0x10, 0x09, 0x21, 0x0a,
+	0x12, 0x09, 0x41, 0xff,
+	0x14, 0x09, 0x82, 0x00,
+	0x16, 0x09, 0x82, 0x7b,
+	0x18, 0x09, 0x8a, 0x7d,
+	0x1a, 0x09, 0x88, 0x81,
+	0x1c, 0x09, 0x86, 0x7a,
+	0x1e, 0x09, 0x84, 0x81,
+	0x20, 0x09, 0x82, 0x7c,
+	0x22, 0x09, 0x0a, 0x0a
+};
+
+static Byte_t RRegData[RREGDATASIZE] = {
+	0x00, 0x09, 0xf6, 0x82,	/* 00: Stop Rx processor */
+	0x08, 0x09, 0x8a, 0x13,	/* 04: Tx software flow control */
+	0x0a, 0x09, 0xc5, 0x11,	/* 08: XON char */
+	0x0c, 0x09, 0x86, 0x85,	/* 0c: XANY */
+	0x12, 0x09, 0x41, 0xff,	/* 10: Rx mask char */
+	0x14, 0x09, 0x82, 0x00,	/* 14: Compare/Ignore #0 */
+	0x16, 0x09, 0x82, 0x7b,	/* 18: Compare #1 */
+	0x18, 0x09, 0x8a, 0x7d,	/* 1c: Compare #2 */
+	0x1a, 0x09, 0x88, 0x81,	/* 20: Interrupt #1 */
+	0x1c, 0x09, 0x86, 0x7a,	/* 24: Ignore/Replace #1 */
+	0x1e, 0x09, 0x84, 0x81,	/* 28: Interrupt #2 */
+	0x20, 0x09, 0x82, 0x7c,	/* 2c: Ignore/Replace #2 */
+	0x22, 0x09, 0x0a, 0x0a	/* 30: Rx FIFO Enable */
+};
+
+static CONTROLLER_T sController[CTL_SIZE] = {
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}}
+};
+
+static Byte_t sBitMapClrTbl[8] = {
+	0xfe, 0xfd, 0xfb, 0xf7, 0xef, 0xdf, 0xbf, 0x7f
+};
+
+static Byte_t sBitMapSetTbl[8] = {
+	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
+};
+
+static int sClockPrescale = 0x14;
+
 /*
  *  Line number is the ttySIx number (x), the Minor number.  We 
  *  assign them sequentially, starting at zero.  The following 
@@ -177,6 +235,26 @@
 static unsigned char GetLineNumber(int ctrl, int aiop, int ch);
 static unsigned char SetLineNumber(int ctrl, int aiop, int ch);
 static void rp_start(struct tty_struct *tty);
+static int sInitChan(CONTROLLER_T * CtlP, CHANNEL_T * ChP, int AiopNum,
+		     int ChanNum);
+static void sSetInterfaceMode(CHANNEL_T * ChP, Byte_t mode);
+static void sFlushRxFIFO(CHANNEL_T * ChP);
+static void sFlushTxFIFO(CHANNEL_T * ChP);
+static void sEnInterrupts(CHANNEL_T * ChP, Word_t Flags);
+static void sDisInterrupts(CHANNEL_T * ChP, Word_t Flags);
+static void sModemReset(CONTROLLER_T * CtlP, int chan, int on);
+static void sPCIModemReset(CONTROLLER_T * CtlP, int chan, int on);
+static int sWriteTxPrioByte(CHANNEL_T * ChP, Byte_t Data);
+static int sPCIInitController(CONTROLLER_T * CtlP, int CtlNum,
+			      ByteIO_t * AiopIOList, int AiopIOListSize,
+			      WordIO_t ConfigIO, int IRQNum, Byte_t Frequency,
+			      int PeriodicOnly, int altChanRingIndicator,
+			      int UPCIRingInd);
+static int sInitController(CONTROLLER_T * CtlP, int CtlNum, ByteIO_t MudbacIO,
+			   ByteIO_t * AiopIOList, int AiopIOListSize,
+			   int IRQNum, Byte_t Frequency, int PeriodicOnly);
+static int sReadAiopID(ByteIO_t io);
+static int sReadAiopNumChan(WordIO_t io);
 
 #ifdef MODULE
 MODULE_AUTHOR("Theodore Ts'o");
@@ -1798,7 +1876,7 @@
  *  init's aiopic and serial port hardware.
  *  Inputs:  i is the board number (0-n)
  */
-__init int register_PCI(int i, struct pci_dev *dev)
+static __init int register_PCI(int i, struct pci_dev *dev)
 {
 	int num_aiops, aiop, max_num_aiops, num_chan, chan;
 	unsigned int aiopio[MAX_AIOPS_PER_BOARD];
@@ -2453,72 +2531,6 @@
 }
 #endif
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE
-#define FALSE 0
-#endif
-
-static Byte_t RData[RDATASIZE] = {
-	0x00, 0x09, 0xf6, 0x82,
-	0x02, 0x09, 0x86, 0xfb,
-	0x04, 0x09, 0x00, 0x0a,
-	0x06, 0x09, 0x01, 0x0a,
-	0x08, 0x09, 0x8a, 0x13,
-	0x0a, 0x09, 0xc5, 0x11,
-	0x0c, 0x09, 0x86, 0x85,
-	0x0e, 0x09, 0x20, 0x0a,
-	0x10, 0x09, 0x21, 0x0a,
-	0x12, 0x09, 0x41, 0xff,
-	0x14, 0x09, 0x82, 0x00,
-	0x16, 0x09, 0x82, 0x7b,
-	0x18, 0x09, 0x8a, 0x7d,
-	0x1a, 0x09, 0x88, 0x81,
-	0x1c, 0x09, 0x86, 0x7a,
-	0x1e, 0x09, 0x84, 0x81,
-	0x20, 0x09, 0x82, 0x7c,
-	0x22, 0x09, 0x0a, 0x0a
-};
-
-static Byte_t RRegData[RREGDATASIZE] = {
-	0x00, 0x09, 0xf6, 0x82,	/* 00: Stop Rx processor */
-	0x08, 0x09, 0x8a, 0x13,	/* 04: Tx software flow control */
-	0x0a, 0x09, 0xc5, 0x11,	/* 08: XON char */
-	0x0c, 0x09, 0x86, 0x85,	/* 0c: XANY */
-	0x12, 0x09, 0x41, 0xff,	/* 10: Rx mask char */
-	0x14, 0x09, 0x82, 0x00,	/* 14: Compare/Ignore #0 */
-	0x16, 0x09, 0x82, 0x7b,	/* 18: Compare #1 */
-	0x18, 0x09, 0x8a, 0x7d,	/* 1c: Compare #2 */
-	0x1a, 0x09, 0x88, 0x81,	/* 20: Interrupt #1 */
-	0x1c, 0x09, 0x86, 0x7a,	/* 24: Ignore/Replace #1 */
-	0x1e, 0x09, 0x84, 0x81,	/* 28: Interrupt #2 */
-	0x20, 0x09, 0x82, 0x7c,	/* 2c: Ignore/Replace #2 */
-	0x22, 0x09, 0x0a, 0x0a	/* 30: Rx FIFO Enable */
-};
-
-CONTROLLER_T sController[CTL_SIZE] = {
-	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
-	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
-	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
-	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
-	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
-	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
-	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
-	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}}
-};
-
-Byte_t sBitMapClrTbl[8] = {
-	0xfe, 0xfd, 0xfb, 0xf7, 0xef, 0xdf, 0xbf, 0x7f
-};
-
-Byte_t sBitMapSetTbl[8] = {
-	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
-};
-
-int sClockPrescale = 0x14;
-
 /***************************************************************************
 Function: sInitController
 Purpose:  Initialization of controller global registers and controller
@@ -2554,22 +2566,22 @@
                       FREQ_4HZ - 4 Hertz
                    If IRQNum is set to 0 the Frequency parameter is
                    overidden, it is forced to a value of FREQ_DIS.
-          int PeriodicOnly: TRUE if all interrupts except the periodic
+          int PeriodicOnly: 1 if all interrupts except the periodic
                                interrupt are to be blocked.
-                            FALSE is both the periodic interrupt and
+                            0 is both the periodic interrupt and
                                other channel interrupts are allowed.
                             If IRQNum is set to 0 the PeriodicOnly parameter is
-                               overidden, it is forced to a value of FALSE.
+                               overidden, it is forced to a value of 0.
 Return:   int: Number of AIOPs on the controller, or CTLID_NULL if controller
                initialization failed.
 
 Comments:
           If periodic interrupts are to be disabled but AIOP interrupts
-          are allowed, set Frequency to FREQ_DIS and PeriodicOnly to FALSE.
+          are allowed, set Frequency to FREQ_DIS and PeriodicOnly to 0.
 
           If interrupts are to be completely disabled set IRQNum to 0.
 
-          Setting Frequency to FREQ_DIS and PeriodicOnly to TRUE is an
+          Setting Frequency to FREQ_DIS and PeriodicOnly to 1 is an
           invalid combination.
 
           This function performs initialization of global interrupt modes,
@@ -2589,9 +2601,9 @@
           After this function all AIOPs on the controller are disabled,
           they can be enabled with sEnAiop().
 */
-int sInitController(CONTROLLER_T * CtlP, int CtlNum, ByteIO_t MudbacIO,
-		    ByteIO_t * AiopIOList, int AiopIOListSize, int IRQNum,
-		    Byte_t Frequency, int PeriodicOnly)
+static int sInitController(CONTROLLER_T * CtlP, int CtlNum, ByteIO_t MudbacIO,
+			   ByteIO_t * AiopIOList, int AiopIOListSize,
+			   int IRQNum, Byte_t Frequency, int PeriodicOnly)
 {
 	int i;
 	ByteIO_t io;
@@ -2687,22 +2699,22 @@
                       FREQ_4HZ - 4 Hertz
                    If IRQNum is set to 0 the Frequency parameter is
                    overidden, it is forced to a value of FREQ_DIS.
-          int PeriodicOnly: TRUE if all interrupts except the periodic
+          int PeriodicOnly: 1 if all interrupts except the periodic
                                interrupt are to be blocked.
-                            FALSE is both the periodic interrupt and
+                            0 is both the periodic interrupt and
                                other channel interrupts are allowed.
                             If IRQNum is set to 0 the PeriodicOnly parameter is
-                               overidden, it is forced to a value of FALSE.
+                               overidden, it is forced to a value of 0.
 Return:   int: Number of AIOPs on the controller, or CTLID_NULL if controller
                initialization failed.
 
 Comments:
           If periodic interrupts are to be disabled but AIOP interrupts
-          are allowed, set Frequency to FREQ_DIS and PeriodicOnly to FALSE.
+          are allowed, set Frequency to FREQ_DIS and PeriodicOnly to 0.
 
           If interrupts are to be completely disabled set IRQNum to 0.
 
-          Setting Frequency to FREQ_DIS and PeriodicOnly to TRUE is an
+          Setting Frequency to FREQ_DIS and PeriodicOnly to 1 is an
           invalid combination.
 
           This function performs initialization of global interrupt modes,
@@ -2722,11 +2734,11 @@
           After this function all AIOPs on the controller are disabled,
           they can be enabled with sEnAiop().
 */
-int sPCIInitController(CONTROLLER_T * CtlP, int CtlNum,
-		       ByteIO_t * AiopIOList, int AiopIOListSize,
-		       WordIO_t ConfigIO, int IRQNum, Byte_t Frequency,
-		       int PeriodicOnly, int altChanRingIndicator,
-		       int UPCIRingInd)
+static int sPCIInitController(CONTROLLER_T * CtlP, int CtlNum,
+			      ByteIO_t * AiopIOList, int AiopIOListSize,
+			      WordIO_t ConfigIO, int IRQNum, Byte_t Frequency,
+			      int PeriodicOnly, int altChanRingIndicator,
+			      int UPCIRingInd)
 {
 	int i;
 	ByteIO_t io;
@@ -2784,7 +2796,7 @@
 Warnings: No context switches are allowed while executing this function.
 
 */
-int sReadAiopID(ByteIO_t io)
+static int sReadAiopID(ByteIO_t io)
 {
 	Byte_t AiopID;		/* ID byte from AIOP */
 
@@ -2810,7 +2822,7 @@
           AIOP, otherwise it is an 8 channel.
 Warnings: No context switches are allowed while executing this function.
 */
-int sReadAiopNumChan(WordIO_t io)
+static int sReadAiopNumChan(WordIO_t io)
 {
 	Word_t x;
 	static Byte_t R[4] = { 0x00, 0x00, 0x34, 0x12 };
@@ -2834,15 +2846,15 @@
           CHANNEL_T *ChP; Ptr to channel structure
           int AiopNum; AIOP number within controller
           int ChanNum; Channel number within AIOP
-Return:   int: TRUE if initialization succeeded, FALSE if it fails because channel
+Return:   int: 1 if initialization succeeded, 0 if it fails because channel
                number exceeds number of channels available in AIOP.
 Comments: This function must be called before a channel can be used.
 Warnings: No range checking on any of the parameters is done.
 
           No context switches are allowed while executing this function.
 */
-int sInitChan(CONTROLLER_T * CtlP, CHANNEL_T * ChP, int AiopNum,
-	      int ChanNum)
+static int sInitChan(CONTROLLER_T * CtlP, CHANNEL_T * ChP, int AiopNum,
+		     int ChanNum)
 {
 	int i;
 	WordIO_t AiopIO;
@@ -2853,7 +2865,7 @@
 	int brd9600;
 
 	if (ChanNum >= CtlP->AiopNumChan[AiopNum])
-		return (FALSE);	/* exceeds num chans in AIOP */
+		return 0;	/* exceeds num chans in AIOP */
 
 	/* Channel, AIOP, and controller identifiers */
 	ChP->CtlP = CtlP;
@@ -2968,7 +2980,7 @@
 	ChP->TxPrioBuf = ChOff + _TXP_BUF;
 	sEnRxProcessor(ChP);	/* start the Rx processor */
 
-	return (TRUE);
+	return 1;
 }
 
 /***************************************************************************
@@ -2989,7 +3001,7 @@
           After calling this function a delay of 4 uS is required to ensure
           that the receive processor is no longer processing this channel.
 */
-void sStopRxProcessor(CHANNEL_T * ChP)
+static void sStopRxProcessor(CHANNEL_T * ChP)
 {
 	Byte_t R[4];
 
@@ -3014,18 +3026,18 @@
           this function.
 Warnings: No context switches are allowed while executing this function.
 */
-void sFlushRxFIFO(CHANNEL_T * ChP)
+static void sFlushRxFIFO(CHANNEL_T * ChP)
 {
 	int i;
 	Byte_t Ch;		/* channel number within AIOP */
-	int RxFIFOEnabled;	/* TRUE if Rx FIFO enabled */
+	int RxFIFOEnabled;	/* 1 if Rx FIFO enabled */
 
 	if (sGetRxCnt(ChP) == 0)	/* Rx FIFO empty */
 		return;		/* don't need to flush */
 
-	RxFIFOEnabled = FALSE;
+	RxFIFOEnabled = 0;
 	if (ChP->R[0x32] == 0x08) {	/* Rx FIFO is enabled */
-		RxFIFOEnabled = TRUE;
+		RxFIFOEnabled = 1;
 		sDisRxFIFO(ChP);	/* disable it */
 		for (i = 0; i < 2000 / 200; i++)	/* delay 2 uS to allow proc to disable FIFO */
 			sInB(ChP->IntChan);	/* depends on bus i/o timing */
@@ -3056,18 +3068,18 @@
           this function.
 Warnings: No context switches are allowed while executing this function.
 */
-void sFlushTxFIFO(CHANNEL_T * ChP)
+static void sFlushTxFIFO(CHANNEL_T * ChP)
 {
 	int i;
 	Byte_t Ch;		/* channel number within AIOP */
-	int TxEnabled;		/* TRUE if transmitter enabled */
+	int TxEnabled;		/* 1 if transmitter enabled */
 
 	if (sGetTxCnt(ChP) == 0)	/* Tx FIFO empty */
 		return;		/* don't need to flush */
 
-	TxEnabled = FALSE;
+	TxEnabled = 0;
 	if (ChP->TxControl[3] & TX_ENABLE) {
-		TxEnabled = TRUE;
+		TxEnabled = 1;
 		sDisTransmit(ChP);	/* disable transmitter */
 	}
 	sStopRxProcessor(ChP);	/* stop Rx processor */
@@ -3096,7 +3108,7 @@
 
 Warnings: No context switches are allowed while executing this function.
 */
-int sWriteTxPrioByte(CHANNEL_T * ChP, Byte_t Data)
+static int sWriteTxPrioByte(CHANNEL_T * ChP, Byte_t Data)
 {
 	Byte_t DWBuf[4];	/* buffer for double word writes */
 	Word_t *WordPtr;	/* must be far because Win SS != DS */
@@ -3158,7 +3170,7 @@
           enable channel interrupts.  This would allow the global interrupt
           status register to be used to determine which AIOPs need service.
 */
-void sEnInterrupts(CHANNEL_T * ChP, Word_t Flags)
+static void sEnInterrupts(CHANNEL_T * ChP, Word_t Flags)
 {
 	Byte_t Mask;		/* Interrupt Mask Register */
 
@@ -3202,7 +3214,7 @@
           this channel's bit from being set in the AIOP's Interrupt Channel
           Register.
 */
-void sDisInterrupts(CHANNEL_T * ChP, Word_t Flags)
+static void sDisInterrupts(CHANNEL_T * ChP, Word_t Flags)
 {
 	Byte_t Mask;		/* Interrupt Mask Register */
 
@@ -3218,7 +3230,7 @@
 	}
 }
 
-void sSetInterfaceMode(CHANNEL_T * ChP, Byte_t mode)
+static void sSetInterfaceMode(CHANNEL_T * ChP, Byte_t mode)
 {
 	sOutB(ChP->CtlP->AiopIO[2], (mode & 0x18) | ChP->ChanNum);
 }
@@ -3227,7 +3239,7 @@
  *  Not an official SSCI function, but how to reset RocketModems.
  *  ISA bus version
  */
-void sModemReset(CONTROLLER_T * CtlP, int chan, int on)
+static void sModemReset(CONTROLLER_T * CtlP, int chan, int on)
 {
 	ByteIO_t addr;
 	Byte_t val;
@@ -3252,7 +3264,7 @@
  *  Not an official SSCI function, but how to reset RocketModems.
  *  PCI bus version
  */
-void sPCIModemReset(CONTROLLER_T * CtlP, int chan, int on)
+static void sPCIModemReset(CONTROLLER_T * CtlP, int chan, int on)
 {
 	ByteIO_t addr;
 

