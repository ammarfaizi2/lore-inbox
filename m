Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbULER0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbULER0B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbULERWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:22:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55562 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261326AbULERFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:05:48 -0500
Date: Sun, 5 Dec 2004 18:05:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulsch@us.ibm.com, sullivam@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mwave/ : misc cleanups
Message-ID: <20041205170545.GS2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes:
- make some needlessly global functions static
- remove / #if 0 the following unused global functions:
  - 3780i.c: dsp3780I_ReadGenCfg
  - smapi.c: SmapiQuerySystemID

Please review whether is patch is correct or whether it might conflict 
with pending patches.


diffstat output:
 drivers/char/mwave/3780i.c |   29 +----------------------------
 drivers/char/mwave/3780i.h |    5 -----
 drivers/char/mwave/smapi.c |   16 ++++++++--------
 3 files changed, 9 insertions(+), 41 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.c.old	2004-11-07 00:29:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.c	2004-11-07 01:46:23.000000000 +0100
@@ -107,7 +107,7 @@
 	spin_unlock_irqrestore(&dsp_lock, flags);
 }
 
-void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
+static void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
                           unsigned char ucValue)
 {
 	DSP_ISA_SLAVE_CONTROL rSlaveControl;
@@ -141,33 +141,6 @@
 
 }
 
-unsigned char dsp3780I_ReadGenCfg(unsigned short usDspBaseIO,
-                                  unsigned uIndex)
-{
-	DSP_ISA_SLAVE_CONTROL rSlaveControl;
-	DSP_ISA_SLAVE_CONTROL rSlaveControl_Save;
-	unsigned char ucValue;
-
-
-	PRINTK_3(TRACE_3780I,
-		"3780i::dsp3780i_ReadGenCfg entry usDspBaseIO %x uIndex %x\n",
-		usDspBaseIO, uIndex);
-
-	MKBYTE(rSlaveControl) = InByteDsp(DSP_IsaSlaveControl);
-	rSlaveControl_Save = rSlaveControl;
-	rSlaveControl.ConfigMode = TRUE;
-	OutByteDsp(DSP_IsaSlaveControl, MKBYTE(rSlaveControl));
-	OutByteDsp(DSP_ConfigAddress, (unsigned char) uIndex);
-	ucValue = InByteDsp(DSP_ConfigData);
-	OutByteDsp(DSP_IsaSlaveControl, MKBYTE(rSlaveControl_Save));
-
-	PRINTK_2(TRACE_3780I,
-		"3780i::dsp3780i_ReadGenCfg exit ucValue %x\n", ucValue);
-
-
-	return ucValue;
-}
-
 int dsp3780I_EnableDSP(DSP_3780I_CONFIG_SETTINGS * pSettings,
                        unsigned short *pIrqMap,
                        unsigned short *pDmaMap)
--- linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.h.old	2004-11-07 01:43:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mwave/3780i.h	2004-11-07 01:46:15.000000000 +0100
@@ -338,10 +338,6 @@
                                    unsigned long ulMsaAddr);
 void dsp3780I_WriteMsaCfg(unsigned short usDspBaseIO,
                           unsigned long ulMsaAddr, unsigned short usValue);
-void dsp3780I_WriteGenCfg(unsigned short usDspBaseIO, unsigned uIndex,
-                          unsigned char ucValue);
-unsigned char dsp3780I_ReadGenCfg(unsigned short usDspBaseIO,
-                                  unsigned uIndex);
 int dsp3780I_GetIPCSource(unsigned short usDspBaseIO,
                           unsigned short *pusIPCSource);
 
@@ -352,7 +348,6 @@
 #define WriteMsaCfg(addr,value) dsp3780I_WriteMsaCfg(usDspBaseIO,addr,value)
 #define ReadMsaCfg(addr) dsp3780I_ReadMsaCfg(usDspBaseIO,addr)
 #define WriteGenCfg(index,value) dsp3780I_WriteGenCfg(usDspBaseIO,index,value)
-#define ReadGenCfg(index) dsp3780I_ReadGenCfg(usDspBaseIO,index)
 
 #define InWordDsp(index)          inw(usDspBaseIO+index)
 #define InByteDsp(index)          inb(usDspBaseIO+index)
--- linux-2.6.10-rc1-mm3-full/drivers/char/mwave/smapi.c.old	2004-11-07 00:30:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mwave/smapi.c	2004-11-07 00:32:07.000000000 +0100
@@ -54,11 +54,11 @@
 static unsigned short g_usSmapiPort = 0;
 
 
-int smapi_request(unsigned short inBX, unsigned short inCX,
-                  unsigned short inDI, unsigned short inSI,
-                  unsigned short *outAX, unsigned short *outBX,
-                  unsigned short *outCX, unsigned short *outDX,
-                  unsigned short *outDI, unsigned short *outSI)
+static int smapi_request(unsigned short inBX, unsigned short inCX,
+                         unsigned short inDI, unsigned short inSI,
+                         unsigned short *outAX, unsigned short *outBX,
+                         unsigned short *outCX, unsigned short *outDX,
+                         unsigned short *outDI, unsigned short *outSI)
 {
 	unsigned short myoutAX = 2, *pmyoutAX = &myoutAX;
 	unsigned short myoutBX = 3, *pmyoutBX = &myoutBX;
@@ -511,8 +511,8 @@
 	return bRC;
 }
 
-
-int SmapiQuerySystemID(void)
+#if 0
+static int SmapiQuerySystemID(void)
 {
 	int bRC = -EIO;
 	unsigned short usAX = 0xffff, usBX = 0xffff, usCX = 0xffff,
@@ -531,7 +531,7 @@
 
 	return bRC;
 }
-
+#endif  /*  0  */
 
 int smapi_init(void)
 {

