Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVAVSCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVAVSCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVAVSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:02:39 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:9170 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262402AbVAVRdC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:33:02 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:27 +0100
Message-Id: <11064152671939@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 2/9] support pinnacle pctv-sat, clean-ups
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dvb-bt8xx: add support for pinnacle pctv-sat, patch by Peter Hettkamp and Adam Szalkowski
- [DVB] dvb-bt8xx: minor code cleanups, patch by Arne Ahrend
- [DVB] dvb-bt8xx: make sure to compile all necessary frontend modules, remove misleading comment

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.11-rc2-dvb/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- linux-2.6.11-rc2/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-01-20 19:56:37.000000000 +0100
@@ -181,6 +181,70 @@
 	.pll_set = thomson_dtt7579_pll_set,
 };
 
+static int cx24108_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+   u32 freq = params->frequency;
+   
+   int i, a, n, pump; 
+   u32 band, pll;
+   
+   
+   u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
+               1576000,1718000,1856000,2036000,2150000};
+   u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
+               0x00102000,0x00104000,0x00108000,0x00110000,
+               0x00120000,0x00140000};
+   
+#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
+        printk("cx24108 debug: entering SetTunerFreq, freq=%d\n",freq);
+        
+        /* This is really the bit driving the tuner chip cx24108 */
+        
+        if(freq<950000) freq=950000; /* kHz */
+        if(freq>2150000) freq=2150000; /* satellite IF is 950..2150MHz */
+        
+        /* decide which VCO to use for the input frequency */
+        for(i=1;(i<sizeof(osci)/sizeof(osci[0]))&&(osci[i]<freq);i++);
+        printk("cx24108 debug: select vco #%d (f=%d)\n",i,freq);
+        band=bandsel[i];
+        /* the gain values must be set by SetSymbolrate */
+        /* compute the pll divider needed, from Conexant data sheet,
+           resolved for (n*32+a), remember f(vco) is f(receive) *2 or *4,
+           depending on the divider bit. It is set to /4 on the 2 lowest 
+           bands  */
+        n=((i<=2?2:1)*freq*10L)/(XTAL/100);
+        a=n%32; n/=32; if(a==0) n--;
+        pump=(freq<(osci[i-1]+osci[i])/2);
+        pll=0xf8000000|
+            ((pump?1:2)<<(14+11))|
+            ((n&0x1ff)<<(5+11))|
+            ((a&0x1f)<<11);
+        /* everything is shifted left 11 bits to left-align the bits in the
+           32bit word. Output to the tuner goes MSB-aligned, after all */
+        printk("cx24108 debug: pump=%d, n=%d, a=%d\n",pump,n,a);
+        cx24110_pll_write(fe,band);
+        /* set vga and vca to their widest-band settings, as a precaution.
+           SetSymbolrate might not be called to set this up */
+        cx24110_pll_write(fe,0x500c0000);
+        cx24110_pll_write(fe,0x83f1f800);
+        cx24110_pll_write(fe,pll);
+/*        writereg(client,0x56,0x7f);*/
+
+	return 0;
+}
+
+static int pinnsat_pll_init(struct dvb_frontend* fe)
+{
+   return 0;
+}
+
+
+static struct cx24110_config pctvsat_config = {
+
+	.demod_address = 0x55,
+	.pll_init = pinnsat_pll_init,
+	.pll_set = cx24108_pll_set,
+};
 
 
 static int microtune_mt7202dtf_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
@@ -220,7 +284,7 @@
 	return request_firmware(fw, name, &bt->bt->dev->dev);
 }
 
-struct sp887x_config microtune_mt7202dtf_config = {
+static struct sp887x_config microtune_mt7202dtf_config = {
 
 	.demod_address = 0x70,
 	.pll_set = microtune_mt7202dtf_pll_set,
@@ -387,6 +451,13 @@
 			break;
 		}
 		break;
+	
+	case BTTV_PINNACLESAT:
+		card->fe = cx24110_attach(&pctvsat_config, card->i2c_adapter);
+		if (card->fe != NULL) {
+			break;
+		}
+		break;
 	}
 
 	if (card->fe == NULL) {
@@ -510,7 +581,14 @@
 
 	switch(sub->core->type)
 	{
-/*	case BTTV_PINNACLESAT: UNDEFINED HARDWARE */
+	case BTTV_PINNACLESAT:
+		card->gpio_mode = 0x0400c060;
+		/* should be: BT878_A_GAIN=0,BT878_A_PWRDN,BT878_DA_DPM,BT878_DA_SBR,
+		              BT878_DA_IOM=1,BT878_DA_APP to enable serial highspeed mode. */
+		card->op_sync_orin = 0;
+		card->irq_err_ignore = 0;
+		break;
+		
 #ifdef BTTV_DVICO_DVBT_LITE
 	case BTTV_DVICO_DVBT_LITE:
 #endif
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/bt8xx/dvb-bt8xx.h linux-2.6.11-rc2-dvb/drivers/media/dvb/bt8xx/dvb-bt8xx.h
--- linux-2.6.11-rc2/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-01-20 19:56:37.000000000 +0100
@@ -22,6 +22,9 @@
  *
  */
 
+#ifndef DVB_BT8XX_H
+#define DVB_BT8XX_H
+
 #include <linux/i2c.h>
 #include "dvbdev.h"
 #include "dvb_net.h"
@@ -30,6 +33,7 @@
 #include "sp887x.h"
 #include "dst.h"
 #include "nxt6000.h"
+#include "cx24110.h"
 
 struct dvb_bt8xx_card {
 	struct semaphore lock;
@@ -50,3 +54,5 @@
 				
 	struct dvb_frontend* fe;
 };
+
+#endif /* DVB_BT8XX_H */
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/bt8xx/Kconfig linux-2.6.11-rc2-dvb/drivers/media/dvb/bt8xx/Kconfig
--- linux-2.6.11-rc2/drivers/media/dvb/bt8xx/Kconfig	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/bt8xx/Kconfig	2005-01-20 19:56:37.000000000 +0100
@@ -3,6 +3,8 @@
 	depends on DVB_CORE && PCI && VIDEO_BT848
 	select DVB_MT352
 	select DVB_SP887X
+	select DVB_NXT6000
+	select DVB_CX24110
 	help
 	  Support for PCI cards based on the Bt8xx PCI bridge. Examples are
 	  the Nebula cards, the Pinnacle PCTV cards and Twinhan DST cards.
@@ -11,8 +13,5 @@
 	  only compressed MPEG data over the PCI bus, so you need
 	  an external software decoder to watch TV on your computer.
 
-	  If you have a Twinhan card, don't forget to select
-	  "Twinhan DST based DVB-S/-T frontend".
-
 	  Say Y if you own such a device and want to use it.
 

