Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTEFQZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTEFQZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:25:21 -0400
Received: from mail.convergence.de ([212.84.236.4]:7369 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263932AbTEFQN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:59 -0400
Message-ID: <3EB7DED5.9050000@convergence.de>
Date: Tue, 06 May 2003 18:12:05 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][5-11] update dvb frontend drivers 
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030009090806090104090509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030009090806090104090509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch updates the following dvb frontend drivers:

- alps_bsrv2.c
- alps_tdmb7.c
- at76c651.c
- grundig_29504-401.c
- grundig_29504-491.c
- nxt6000.c
- ves1820.c

Really improved has been the following driver:
- stv0299.c

Please review and apply.

Thanks
Michael Hunold.







--------------030009090806090104090509
Content-Type: text/plain;
 name="05-dvb-frontend-patches.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-dvb-frontend-patches.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/Kconfig linux-2.5.69.patch/drivers/media/dvb/frontends/Kconfig
--- linux-2.5.69/drivers/media/dvb/frontends/Kconfig	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/Kconfig	2003-04-20 10:15:32.000000000 +0200
@@ -5,10 +5,9 @@
 	tristate "STV0299 based DVB-S frontend (QPSK)"
 	depends on DVB_CORE
 	help
-	  A DVB-S tuner module. 
-
-	  Say Y when you want to support frontend based on this 
-	  demodulator.
+	  The stv0299 by ST is used in many DVB-S tuner modules, 
+	  say Y when you want to support frontends based on this 
+	  DVB-S demodulator.
 
 	  Some examples are the Alps BSRU6, the Philips SU1278 and
 	  the LG TDQB-S00x.
@@ -63,6 +62,17 @@
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
 
+config DVB_CX24110
+	tristate "Frontends with Connexant CX24110 demodulator (QPSK)"
+	depends on DVB_CORE
+	help
+	  The CX24110 Demodulator is used in some DVB-S frontends. 
+	  Say Y if you want support for this chip in your kernel.
+
+	  If you don't know what tuner module is soldered on your 
+	  DVB adapter simply enable all supported frontends, the 
+	  right one will get autodetected.
+
 config DVB_GRUNDIG_29504_491
 	tristate "Grundig 29504-491 (QPSK)"
 	depends on DVB_CORE
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/Makefile linux-2.5.69.patch/drivers/media/dvb/frontends/Makefile
--- linux-2.5.69/drivers/media/dvb/frontends/Makefile	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/Makefile	2003-04-20 10:15:32.000000000 +0200
@@ -9,6 +9,7 @@
 obj-$(CONFIG_DVB_ALPS_TDLB7) += alps_tdlb7.o
 obj-$(CONFIG_DVB_ALPS_TDMB7) += alps_tdmb7.o
 obj-$(CONFIG_DVB_ATMEL_AT76C651) += at76c651.o
+obj-$(CONFIG_DVB_CX24110) += cx24110.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_491) += grundig_29504-491.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_401) += grundig_29504-401.o
 obj-$(CONFIG_DVB_VES1820) += ves1820.o
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/alps_bsrv2.c linux-2.5.69.patch/drivers/media/dvb/frontends/alps_bsrv2.c
--- linux-2.5.69/drivers/media/dvb/frontends/alps_bsrv2.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/alps_bsrv2.c	2003-04-17 19:19:27.000000000 +0200
@@ -20,8 +20,12 @@
 
 */    
 
+#include <asm/errno.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 
 #include "dvb_frontend.h"
 
@@ -211,7 +215,7 @@
 	u32 BDRI;
 	u32 tmp;
 
-	dprintk("%s: srate == %d\n", __FUNCTION__, srate);
+	dprintk("%s: srate == %ud\n", __FUNCTION__, (unsigned int) srate);
 
 	if (srate > 90100000UL/2)
 		srate = 90100000UL/2;
@@ -257,9 +261,9 @@
 	BDRI = ( ((FIN << 8) / ((srate << (FNR >> 1)) >> 2)) + 1) >> 1;
 
         dprintk("FNR= %d\n", FNR);
-        dprintk("ratio= %08x\n", ratio);
-        dprintk("BDR= %08x\n", BDR);
-        dprintk("BDRI= %02x\n", BDRI);
+        dprintk("ratio= %08x\n", (unsigned int) ratio);
+        dprintk("BDR= %08x\n", (unsigned int) BDR);
+        dprintk("BDRI= %02x\n", (unsigned int) BDRI);
 
 	if (BDRI > 0xff)
 		BDRI = 0xff;
@@ -387,12 +391,12 @@
 	case FE_GET_FRONTEND:
 	{
 		struct dvb_frontend_parameters *p = arg;
-		s32 afc;
+		int afc;
 
 		afc = ((int)((char)(ves1893_readreg (i2c, 0x0a) << 1)))/2;
-		afc = (afc * (int)(p->u.qpsk.symbol_rate/8))/16;
+		afc = (afc * (int)(p->u.qpsk.symbol_rate/1000/8))/16;
 
-		p->frequency += afc;
+		p->frequency -= afc;
 		p->inversion = (ves1893_readreg (i2c, 0x0f) & 2) ? 
 					INVERSION_ON : INVERSION_OFF;
 		p->u.qpsk.fec_inner = ves1893_get_fec (i2c);
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.5.69.patch/drivers/media/dvb/frontends/alps_tdmb7.c
--- linux-2.5.69/drivers/media/dvb/frontends/alps_tdmb7.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/alps_tdmb7.c	2003-04-30 12:02:38.000000000 +0200
@@ -20,10 +20,15 @@
 
 */    
 
+#include <asm/errno.h>
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
 
 
 static int debug = 0;
@@ -52,14 +57,6 @@
 
 
 static
-inline void ddelay (int timeout)
-{
-	current->state=TASK_INTERRUPTIBLE;
-	schedule_timeout(timeout);
-}
-
-
-static
 u8 init_tab [] = {
 	0x04, 0x10,
 	0x05, 0x09,
@@ -154,7 +151,7 @@
 		       freq < 470000000 ? 0x42 : freq < 862000000 ? 0x41 : 0x81 };
 #endif
 
-	dprintk ("%s: freq == %i, div == %i\n", __FUNCTION__, freq, div);
+	dprintk ("%s: freq == %i, div == %i\n", __FUNCTION__, (int) freq, (int) div);
 
 	return pll_write (i2c, buf);
 }
@@ -170,7 +167,7 @@
 	cx22700_writereg (i2c, 0x00, 0x02);   /*  soft reset */
 	cx22700_writereg (i2c, 0x00, 0x00);
 
-	ddelay (HZ/100);
+	dvb_delay (HZ/100);
 	
 	for (i=0; i<sizeof(init_tab); i+=2)
 		cx22700_writereg (i2c, init_tab[i], init_tab[i+1]);
@@ -355,7 +352,7 @@
 	}
 
         case FE_READ_BER:
-		*((uint32_t*) arg) = cx22700_readreg (i2c, 0x0c) & 0x7f;
+		*((u32*) arg) = cx22700_readreg (i2c, 0x0c) & 0x7f;
 		cx22700_writereg (i2c, 0x0c, 0x00);
 		break;
 
@@ -363,18 +360,18 @@
 	{
 		u16 rs_ber = (cx22700_readreg (i2c, 0x0d) << 9)
 			   | (cx22700_readreg (i2c, 0x0e) << 1);
-		*((uint16_t*) arg) = ~rs_ber;
+		*((u16*) arg) = ~rs_ber;
 		break;
 	}
         case FE_READ_SNR:
 	{
 		u16 rs_ber = (cx22700_readreg (i2c, 0x0d) << 9)
 			   | (cx22700_readreg (i2c, 0x0e) << 1);
-		*((uint16_t*) arg) = ~rs_ber;
+		*((u16*) arg) = ~rs_ber;
 		break;
 	}
 	case FE_READ_UNCORRECTED_BLOCKS: 
-		*((uint32_t*) arg) = cx22700_readreg (i2c, 0x0f);
+		*((u32*) arg) = cx22700_readreg (i2c, 0x0f);
 		cx22700_writereg (i2c, 0x0f, 0x00);
 		break;
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/at76c651.c linux-2.5.69.patch/drivers/media/dvb/frontends/at76c651.c
--- linux-2.5.69/drivers/media/dvb/frontends/at76c651.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/at76c651.c	2003-04-30 12:03:26.000000000 +0200
@@ -22,11 +22,12 @@
  *
  */
 
-#include <linux/module.h>
+#include <asm/errno.h>
 #include <linux/init.h>
-#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
 
 #if defined(__powerpc__)
 #include <asm/bitops.h>
@@ -34,6 +35,7 @@
 
 #include "dvb_frontend.h"
 #include "dvb_i2c.h"
+#include "dvb_functions.h"
 
 static int debug = 0;
 
@@ -67,8 +69,8 @@
 	    FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 |
 	    FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO |
 	    FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 | FE_CAN_QAM_128 |
-	    FE_CAN_QAM_256,
-	/* FE_CAN_QAM_512 | FE_CAN_QAM_1024 |  */
+	    FE_CAN_QAM_256 /* | FE_CAN_QAM_512 | FE_CAN_QAM_1024 */ |
+	    FE_CAN_RECOVER | FE_CAN_CLEAN_SETUP | FE_CAN_MUTE_TS
 
 };
 
@@ -103,7 +105,7 @@
 			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
 			__FUNCTION__, reg, data, ret);
 
-	mdelay(10);
+	dvb_delay(10);
 
 	return (ret != 1) ? -EREMOTEIO : 0;
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.5.69.patch/drivers/media/dvb/frontends/grundig_29504-401.c
--- linux-2.5.69/drivers/media/dvb/frontends/grundig_29504-401.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/grundig_29504-401.c	2003-04-30 12:02:33.000000000 +0200
@@ -22,10 +22,15 @@
 
 */    
 
-#include <linux/module.h>
+#include <asm/errno.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
 
 static int debug = 0;
 
@@ -97,22 +102,27 @@
 /**
  *   set up the downconverter frequency divisor for a
  *   reference clock comparision frequency of 166666 Hz.
- *   frequency offset is 36000000 Hz.
+ *   frequency offset is 36125000 Hz.
  */
 static
 int tsa5060_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
 {
 	u32 div;
 	u8 buf [4];
-	u8 cfg;
+	u8 cfg, cpump, band_select;
 
-	div = (36000000 + freq) / 166666;
+	div = (36125000 + freq) / 166666;
 	cfg = 0x88;
 
+	cpump = div < 175000000 ? 2 : div < 390000000 ? 1 :
+		div < 470000000 ? 2 : div < 750000000 ? 1 : 3;
+
+	band_select = div < 175000000 ? 0x0e : div < 470000000 ? 0x05 : 0x03;
+
 	buf [0] = (div >> 8) & 0x7f;
 	buf [1] = div & 0xff;
 	buf [2] = ((div >> 10) & 0x60) | cfg;
-	buf [3] = 0xc0;
+	buf [3] = cpump | band_select;
 
 	return tsa5060_write (i2c, buf);
 }
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/grundig_29504-491.c linux-2.5.69.patch/drivers/media/dvb/frontends/grundig_29504-491.c
--- linux-2.5.69/drivers/media/dvb/frontends/grundig_29504-491.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/grundig_29504-491.c	2003-04-30 12:03:38.000000000 +0200
@@ -24,10 +24,15 @@
 
 */    
 
+#include <asm/errno.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
 
 static int debug = 0;
 #define dprintk	if (debug) printk
@@ -222,7 +227,7 @@
 	tmp = (tmp % srate) << 8;
 	ratio = (ratio << 8) + tmp / srate;
 	
-	dprintk("tda8083: ratio == %08x\n", ratio);
+	dprintk("tda8083: ratio == %08x\n", (unsigned int) ratio);
 
 	tda8083_writereg (i2c, 0x05, filter);
 	tda8083_writereg (i2c, 0x02, (ratio >> 16) & 0xff);
@@ -244,8 +249,7 @@
 	while (jiffies - start < timeout &&
                !(tda8083_readreg(i2c, 0x02) & 0x80))
 	{
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout (5);
+		dvb_delay(50);
 	};
 }
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/nxt6000.c linux-2.5.69.patch/drivers/media/dvb/frontends/nxt6000.c
--- linux-2.5.69/drivers/media/dvb/frontends/nxt6000.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/nxt6000.c	2003-03-22 12:43:15.000000000 +0100
@@ -25,13 +25,12 @@
 
 */    
 
-#include <linux/module.h>
+#include <asm/errno.h>
 #include <linux/init.h>
-#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/poll.h>
-#include <asm/io.h>
-#include <linux/i2c.h>
 
 #include "dvb_frontend.h"
 #include "nxt6000.h"
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/stv0299.c linux-2.5.69.patch/drivers/media/dvb/frontends/stv0299.c
--- linux-2.5.69/drivers/media/dvb/frontends/stv0299.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/stv0299.c	2003-05-06 10:59:58.000000000 +0200
@@ -35,19 +35,28 @@
 
 */    
 
+#include <asm/errno.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
+
+#if 0
+#define dprintk(x...) printk(x)
+#else
+#define dprintk(x...)
+#endif
 
-static int debug = 0;
-#define dprintk	if (debug) printk
 
 /* frontend types */
 #define UNKNOWN_FRONTEND  -1
 #define PHILIPS_SU1278SH   0
 #define ALPS_BSRU6         1
 #define LG_TDQF_S001F      2
+#define PHILIPS_SU1278     3
 
 /* Master Clock = 88 MHz */
 #define M_CLK (88000000UL) 
@@ -74,11 +83,6 @@
 
 static
 u8 init_tab [] = {
-        /* clock registers */
-        0x01, 0x15,   /* K = 0, DIRCLK = 0, M = 0x15                  */
-	0x02, 0x30,   /* STDBY = 0, VCO = 0 (ON), SERCLK = 0, P = 0   */
-                      /* f_VCO = 4MHz * 4 * (M+1) / (K+1) = 352 MHz   */
-	0x03, 0x00,   /* auxiliary clock not used                     */
 	0x04, 0x7d,   /* F22FR = 0x7d                                 */
 		      /* F22 = f_VCO / 128 / 0x7d = 22 kHz            */
 
@@ -90,7 +94,7 @@
 	0x07, 0x00,   /* DAC LSB                                      */
 
 	/* DiSEqC registers */
-	0x08, 0x40,   /* DiSEqC off                                   */
+	0x08, 0x40,   /* DiSEqC off, LNB power on OP2/LOCK pin on     */
 	0x09, 0x00,   /* FIFO                                         */
 
         /* Input/Output configuration register */
@@ -105,34 +109,27 @@
 	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3                  */
 
 	0x10, 0x3f,   // AGC2  0x3d
+
 	0x11, 0x84,
 	0x12, 0xb5,   // Lock detect: -64  Carrier freq detect:on
-	0x13, 0xb6,   // alpha_car b:4 a:0  noise est:256ks  derot:on
-	0x14, 0x93,   // beat carc:0 d:0 e:0xf  phase detect algo: 1
+
 	0x15, 0xc9,   // lock detector threshold
 
-	0x16, 0x1d,   /* AGC1 integrator value                        */
+	0x16, 0x00,
 	0x17, 0x00,
-	0x18, 0x14,
-	0x19, 0xf2,
-
-	0x1a, 0x11,
+	0x18, 0x00,
+	0x19, 0x00,
+	0x1a, 0x00,
 
-	0x1b, 0x9c,
-	0x1c, 0x00,
-	0x1d, 0x00,
-	0x1e, 0x0b,
 	0x1f, 0x50,
 
 	0x20, 0x00,
 	0x21, 0x00,
 	0x22, 0x00,
 	0x23, 0x00,
-	0x24, 0xff,
-	0x25, 0xff,
-	0x26, 0xff,
 
 	0x28, 0x00,  // out imp: normal  out type: parallel FEC mode:0
+
 	0x29, 0x1e,  // 1/2 threshold
 	0x2a, 0x14,  // 2/3 threshold
 	0x2b, 0x0f,  // 3/4 threshold
@@ -145,38 +142,6 @@
 	0x32, 0x19,  // viterbi and synchro search
 	0x33, 0xfc,  // rs control
 	0x34, 0x93,  // error control
-
-	0x0b, 0x00,
-	0x27, 0x00,
-	0x2f, 0x00,
-	0x30, 0x00,
-	0x35, 0x00,
-	0x36, 0x00,
-	0x37, 0x00,
-	0x38, 0x00,
-	0x39, 0x00,
-	0x3a, 0x00,
-	0x3b, 0x00,
-	0x3c, 0x00,
-	0x3d, 0x00,
-	0x3e, 0x00,
-	0x3f, 0x00,
-	0x40, 0x00,
-	0x41, 0x00,
-	0x42, 0x00,
-	0x43, 0x00,
-	0x44, 0x00,
-	0x45, 0x00,
-	0x46, 0x00,
-	0x47, 0x00,
-	0x48, 0x00,
-	0x49, 0x00,
-	0x4a, 0x00,
-	0x4b, 0x00,
-	0x4c, 0x00,
-	0x4d, 0x00,
-	0x4e, 0x00,
-	0x4f, 0x00
 };
 
 
@@ -187,13 +152,11 @@
 	u8 buf [] = { reg, data };
 	struct i2c_msg msg = { addr: 0x68, flags: 0, buf: buf, len: 2 };
 
-	dprintk ("%s\n", __FUNCTION__);
-
 	ret = i2c->xfer (i2c, &msg, 1);
 
 	if (ret != 1) 
-		dprintk("%s: writereg error (reg == 0x%02x, val == 0x%02x, ret == %i)\n",
-			__FUNCTION__, reg, data, ret);
+		dprintk("%s: writereg error (reg == 0x%02x, val == 0x%02x, "
+			"ret == %i)\n", __FUNCTION__, reg, data, ret);
 
 	return (ret != 1) ? -1 : 0;
 }
@@ -208,8 +171,6 @@
 	struct i2c_msg msg [] = { { addr: 0x68, flags: 0, buf: b0, len: 1 },
 			   { addr: 0x68, flags: I2C_M_RD, buf: b1, len: 1 } };
 
-	dprintk ("%s\n", __FUNCTION__);
-
 	ret = i2c->xfer (i2c, msg, 2);
         
 	if (ret != 2) 
@@ -226,41 +187,31 @@
         struct i2c_msg msg [] = { { addr: 0x68, flags: 0, buf: &reg1, len: 1 },
                            { addr: 0x68, flags: I2C_M_RD, buf: b, len: len } };
 
-	dprintk ("%s\n", __FUNCTION__);
-
         ret = i2c->xfer (i2c, msg, 2);
 
         if (ret != 2)
                 dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
 
-        return ret == 2 ? 0 : -1;
+        return ret == 2 ? 0 : ret;
 }
 
 
 static
-int pll_write (struct dvb_i2c_bus *i2c, u8 data [4], int ftype)
+int pll_write (struct dvb_i2c_bus *i2c, u8 addr, u8 *data, int len)
 {
 	int ret;
 	u8 rpt1 [] = { 0x05, 0xb5 };  /*  enable i2c repeater on stv0299  */
-	/* TSA5059 i2c-bus address */
-	u8 addr = (ftype == PHILIPS_SU1278SH) ? 0x60 : 0x61;
+	u8 rpt2 [] = { 0x05, 0x35 };  /*  disable i2c repeater on stv0299  */
 	struct i2c_msg msg [] = {{ addr: 0x68, flags: 0, buf: rpt1, len: 2 },
-			         { addr: addr, flags: 0, buf: data, len: 4 }};
+			         { addr: addr, flags: 0, buf: data, len: len },
+				 { addr: 0x68, flags: 0, buf: rpt2, len: 2 }};
 
-	dprintk ("%s\n", __FUNCTION__);
+	ret = i2c->xfer (i2c, msg, 3);
 
-	if (ftype == LG_TDQF_S001F || ftype == ALPS_BSRU6) {
-		ret  = i2c->xfer (i2c, &msg[0], 1);
-		ret += i2c->xfer (i2c, &msg[1], 1);
-	}
-	else {
-		ret = i2c->xfer (i2c, msg, 2);
-	}
-
-	if (ret != 2)
-		dprintk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
+	if (ret != 3)
+		printk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
 
-	return (ret != 2) ? -1 : 0;
+	return (ret != 3) ? ret : 0;
 }
 
 
@@ -288,7 +239,7 @@
 	else
 		buf[3] = 0x00;
 
-	return pll_write (i2c, buf, ftype);
+	return pll_write (i2c, 0x61, buf, sizeof(buf));
 }
 
 /**
@@ -298,10 +249,12 @@
 static
 int tsa5059_set_tv_freq	(struct dvb_i2c_bus *i2c, u32 freq, int ftype)
 {
+	u8 addr = (ftype == PHILIPS_SU1278SH) ? 0x60 : 0x61;
         u32 div = freq / 125;
-
 	u8 buf[4] = { (div >> 8) & 0x7f, div & 0xff, 0x84 };
 
+	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
+
 	if (ftype == PHILIPS_SU1278SH)
 		/* activate f_xtal/f_comp signal output */
 		/* charge pump current C0/C1 = 00 */
@@ -309,16 +262,144 @@
 	else
 		buf[3] = freq > 1530000 ? 0xc0 : 0xc4;
 
-	dprintk ("%s\n", __FUNCTION__);
+	return pll_write (i2c, addr, buf, sizeof(buf));
+}
+
 
-	return pll_write (i2c, buf, ftype);
+
+#define ABS(x) ((x) < 0 ? -(x) : (x))
+#define MIN2(a,b) ((a) < (b) ? (a) : (b))
+#define MIN3(a,b,c) MIN2(MIN2(a,b),c)
+
+static
+int tua6100_set_tv_freq	(struct dvb_i2c_bus *i2c, u32 freq,
+			 int ftype, int srate)
+{
+	u8 reg0 [2] = { 0x00, 0x00 };
+	u8 reg1 [4] = { 0x01, 0x00, 0x00, 0x00 };
+	u8 reg2 [3] = { 0x02, 0x00, 0x00 };
+	int _fband;
+	int first_ZF;
+	int R, A, N, P, M;
+	int err;
+
+	first_ZF = (freq) / 1000;
+
+	if (ABS(MIN2(ABS(first_ZF-1190),ABS(first_ZF-1790))) <
+	    ABS(MIN3(ABS(first_ZF-1202),ABS(first_ZF-1542),ABS(first_ZF-1890))))
+		_fband = 2;
+	else
+		_fband = 3;
+
+	if (_fband == 2) {
+		if (((first_ZF >= 950) && (first_ZF < 1350)) ||
+		    ((first_ZF >= 1430) && (first_ZF < 1950)))
+			reg0[1] = 0x07;
+		else if (((first_ZF >= 1350) && (first_ZF < 1430)) ||
+			    ((first_ZF >= 1950) && (first_ZF < 2150)))
+			reg0[1] = 0x0B;
+	}
+
+	if(_fband == 3) {
+		if (((first_ZF >= 950) && (first_ZF < 1350)) ||
+		     ((first_ZF >= 1455) && (first_ZF < 1950)))
+			reg0[1] = 0x07;
+		else if (((first_ZF >= 1350) && (first_ZF < 1420)) ||
+			 ((first_ZF >= 1950) && (first_ZF < 2150)))
+			reg0[1] = 0x0B;
+		else if ((first_ZF >= 1420) && (first_ZF < 1455))
+			reg0[1] = 0x0F;
+	}
+
+	if (first_ZF > 1525)
+		reg1[1] |= 0x80;
+	else
+		reg1[1] &= 0x7F;
+
+	if (_fband == 2) {
+	        if (first_ZF > 1430) { /* 1430MHZ */
+	                reg1[1] &= 0xCF; /* N2 */
+			reg2[1] &= 0xCF; /* R2 */
+			reg2[1] |= 0x10;
+	        } else {
+        		reg1[1] &= 0xCF; /* N2 */
+			reg1[1] |= 0x20;
+			reg2[1] &= 0xCF; /* R2 */
+			reg2[1] |= 0x10;
+		}
 }
 
+	if (_fband == 3) {
+        	if ((first_ZF >= 1455) &&
+		    (first_ZF < 1630)) {
+			reg1[1] &= 0xCF; /* N2 */
+			reg1[1] |= 0x20;
+			reg2[1] &= 0xCF; /* R2 */
+	        } else {
+			if (first_ZF < 1455) {
+	                        reg1[1] &= 0xCF; /* N2 */
+				reg1[1] |= 0x20;
+                	        reg2[1] &= 0xCF; /* R2 */
+                        	reg2[1] |= 0x10;
+	                } else {
+	                        if (first_ZF >= 1630) {
+        	                        reg1[1] &= 0xCF; /* N2 */
+                        	        reg2[1] &= 0xCF; /* R2 */
+                                	reg2[1] |= 0x10;
+	                        }
+        	        }
+	        }
+	}
+
+        /* set ports, enable P0 for symbol rates > 4Ms/s */
+	if (srate >= 4000000)
+		reg1[1] |= 0x0c;
+	else
+		reg1[1] |= 0x04;
+
+	reg2[1] |= 0x0c;
+
+	R = 64;
+	A = 64;
+	P = 64;  //32
+
+	M = (freq * R) / 4;		/* in Mhz */
+	N = (M - A * 1000) / (P * 1000);
+
+	reg1[1] |= (N >> 9) & 0x03;
+	reg1[2]  = (N >> 1) & 0xff;
+	reg1[3]  = (N << 7) & 0x80;
+
+	reg2[1] |= (R >> 8) & 0x03;
+	reg2[2]  = R & 0xFF;	/* R */
+
+	reg1[3] |= A & 0x7f;	/* A */
+
+	if (P == 64)
+		reg1[1] |= 0x40; /* Prescaler 64/65 */
+
+	reg0[1] |= 0x03;
+
+	if ((err = pll_write(i2c, 0x60, reg0, sizeof(reg0))))
+		return err;
+
+	if ((err = pll_write(i2c, 0x60, reg1, sizeof(reg1))))
+		return err;
+
+	if ((err = pll_write(i2c, 0x60, reg2, sizeof(reg2))))
+		return err;
+
+	return 0;
+}
+
+
 static
-int pll_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, int ftype)
+int pll_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, int ftype, int srate)
 {
 	if (ftype == LG_TDQF_S001F)
 		return sl1935_set_tv_freq(i2c, freq, ftype);
+	else if (ftype == PHILIPS_SU1278)
+		return tua6100_set_tv_freq(i2c, freq, ftype, srate);
 	else
 		return tsa5059_set_tv_freq(i2c, freq, ftype);
 }
@@ -353,12 +434,18 @@
 
 	dprintk("stv0299: init chip\n");
 
+	stv0299_writereg (i2c, 0x01, 0x15);
+	stv0299_writereg (i2c, 0x02, ftype == PHILIPS_SU1278 ? 0x00 : 0x30);
+	stv0299_writereg (i2c, 0x03, 0x00);
+
 	for (i=0; i<sizeof(init_tab); i+=2)
 		stv0299_writereg (i2c, init_tab[i], init_tab[i+1]);
 
         /* AGC1 reference register setup */
 	if (ftype == PHILIPS_SU1278SH)
 	  stv0299_writereg (i2c, 0x0f, 0xd2);  /* Iagc = Inverse, m1 = 18 */
+	else if (ftype == PHILIPS_SU1278)
+	  stv0299_writereg (i2c, 0x0f, 0x94);  /* Iagc = Inverse, m1 = 18 */
 	else
 	  stv0299_writereg (i2c, 0x0f, 0x52);  /* Iagc = Normal,  m1 = 18 */
 
@@ -372,9 +459,12 @@
 	dprintk ("%s\n", __FUNCTION__);
 
 	if ((stv0299_readreg (i2c, 0x1b) & 0x98) != 0x98) {
+		dvb_delay(30);
+		if ((stv0299_readreg (i2c, 0x1b) & 0x98) != 0x98) {
 		u8 val = stv0299_readreg (i2c, 0x0c);
 		return stv0299_writereg (i2c, 0x0c, val ^ 0x01);
 	}
+	}
 
 	return 0;
 }
@@ -435,8 +525,7 @@
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout (1);
+		dvb_delay(10);
 	};
 
 	return 0;
@@ -455,8 +544,7 @@
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout (1);
+		dvb_delay(10);
 	};
 
 	return 0;
@@ -528,7 +616,9 @@
 {
 	u8 val;
 
-	dprintk ("%s\n", __FUNCTION__);
+	dprintk("%s: %s\n", __FUNCTION__,
+		tone == SEC_TONE_ON ? "SEC_TONE_ON" : 
+		tone == SEC_TONE_OFF ? "SEC_TONE_OFF" : "??");
 
 	if (stv0299_wait_diseqc_idle (i2c, 100) < 0)
 		return -ETIMEDOUT;
@@ -549,19 +639,25 @@
 static
 int stv0299_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage)
 {
-	u8 val;
+	u8 reg0x0c;
 
-	dprintk ("%s\n", __FUNCTION__);
+	dprintk("%s: %s\n", __FUNCTION__,
+		voltage == SEC_VOLTAGE_13 ? "SEC_VOLTAGE_13" : 
+		voltage == SEC_VOLTAGE_18 ? "SEC_VOLTAGE_18" : "??");
 
-	val = stv0299_readreg (i2c, 0x0c);
-	val &= 0x0f;
-	val |= 0x40;   /* LNB power on */
+	reg0x0c = stv0299_readreg (i2c, 0x0c);
+
+	/**
+	 *  H/V switching over OP0, OP1 is LNB power on
+	 */
+	reg0x0c &= 0x0f;
+	reg0x0c |= 0x40;   /* LNB power on */
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
-		return stv0299_writereg (i2c, 0x0c, val);
+		return stv0299_writereg (i2c, 0x0c, reg0x0c);
 	case SEC_VOLTAGE_18:
-		return stv0299_writereg (i2c, 0x0c, val | 0x10);
+		return stv0299_writereg (i2c, 0x0c, reg0x0c | 0x10);
 	default:
 		return -EINVAL;
 	};
@@ -645,8 +741,6 @@
         int tuner_type = (int)fe->data;
 	struct dvb_i2c_bus *i2c = fe->i2c;
 
-	dprintk ("%s\n", __FUNCTION__);
-
 	switch (cmd) {
 	case FE_GET_INFO:
 		memcpy (arg, &uni0299_info, sizeof(struct dvb_frontend_info));
@@ -692,7 +786,7 @@
 
 		dprintk ("AGC2I: 0x%02x%02x, signal=0x%04x\n",
 			 stv0299_readreg (i2c, 0x18),
-			 stv0299_readreg (i2c, 0x19), signal);
+			 stv0299_readreg (i2c, 0x19), (int) signal);
 
 		signal = signal * 5 / 4;
 		*((u16*) arg) = (signal > 0xffff) ? 0xffff :
@@ -716,15 +810,16 @@
         {
 		struct dvb_frontend_parameters *p = arg;
 
-		pll_set_tv_freq (i2c, p->frequency, tuner_type);
+		pll_set_tv_freq (i2c, p->frequency, tuner_type,
+				 p->u.qpsk.symbol_rate);
+
                 stv0299_set_FEC (i2c, p->u.qpsk.fec_inner);
                 stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate);
-		stv0299_check_inversion (i2c);
-		/* pll_set_tv_freq (i2c, p->frequency, tuner_type); */
 		stv0299_writereg (i2c, 0x22, 0x00);
 		stv0299_writereg (i2c, 0x23, 0x00);
 		stv0299_readreg (i2c, 0x23);
 		stv0299_writereg (i2c, 0x12, 0xb9);
+		stv0299_check_inversion (i2c);
 
 		/* printk ("%s: tsa5059 status: %x\n", __FUNCTION__, tsa5059_read_status(i2c)); */
                 break;
@@ -752,19 +847,13 @@
 
         case FE_SLEEP:
 		stv0299_writereg (i2c, 0x0c, 0x00);  /*  LNB power off! */
+		stv0299_writereg (i2c, 0x08, 0x00); /*  LNB power off! */
 		stv0299_writereg (i2c, 0x02, 0x80);
 		break;
 
         case FE_INIT:
 		return stv0299_init (i2c, tuner_type);
 
-        case FE_RESET:
-		stv0299_writereg (i2c, 0x22, 0x00);
-		stv0299_writereg (i2c, 0x23, 0x00);
-		stv0299_readreg (i2c, 0x23);
-		stv0299_writereg (i2c, 0x12, 0xb9);
-                break;
-
 	case FE_DISEQC_SEND_MASTER_CMD:
 		return stv0299_send_diseqc_msg (i2c, arg);
 
@@ -787,35 +876,53 @@
 static
 int probe_tuner (struct dvb_i2c_bus *i2c)
 {
-	int type;
-
         /* read the status register of TSA5059 */
 	u8 rpt[] = { 0x05, 0xb5 };
         u8 stat [] = { 0 };
+	int ret;
 	struct i2c_msg msg1 [] = {{ addr: 0x68, flags: 0, buf: rpt,  len: 2 },
                            { addr: 0x60, flags: I2C_M_RD, buf: stat, len: 1 }};
 	struct i2c_msg msg2 [] = {{ addr: 0x68, flags: 0, buf: rpt,  len: 2 },
                            { addr: 0x61, flags: I2C_M_RD, buf: stat, len: 1 }};
+	struct i2c_msg msg3 [] = {{ addr: 0x68, flags: 0, buf: rpt,  len: 2 },
+				  { addr: 0x60, flags: 0, buf: stat, len: 1 }};
+
+	stv0299_writereg (i2c, 0x01, 0x15);
+	stv0299_writereg (i2c, 0x02, 0x30);
+	stv0299_writereg (i2c, 0x03, 0x00);
 
-	if (i2c->xfer(i2c, msg1, 2) == 2) {
-		type = PHILIPS_SU1278SH;
+	if ((ret = i2c->xfer(i2c, msg1, 2)) == 2) {
 		printk ("%s: setup for tuner SU1278/SH\n", __FILE__);
-	} else if (i2c->xfer(i2c, msg2, 2) == 2) {
-if (0) { //		if ((stat[0] & 0x3f) == 0) {
-			type = LG_TDQF_S001F;
-			printk ("%s: setup for tuner TDQF-S001F\n", __FILE__);
-		}
-		else {
-			type = ALPS_BSRU6;
-			printk ("%s: setup for tuner BSRU6, TDQB-S00x\n", __FILE__);
+		return PHILIPS_SU1278SH;
 		}
+
+	if ((ret = i2c->xfer(i2c, msg2, 2)) == 2) {
+		//if ((stat[0] & 0x3f) == 0) {
+		if (0) {	
+			printk ("%s: setup for tuner TDQF-S001F\n", __FILE__);
+			return LG_TDQF_S001F;
 	} else {
-		type = UNKNOWN_FRONTEND;
-		printk ("%s: unknown PLL synthesizer, "
-			"please report to <linuxdvb@linuxtv.org>!!\n",
+			printk ("%s: setup for tuner BSRU6, TDQB-S00x\n",
 			__FILE__);
+			return ALPS_BSRU6;
+		}
 	}
-	return type;
+
+	/**
+	 *  setup i2c timing for SU1278...
+	 */
+	stv0299_writereg (i2c, 0x02, 0x00);
+
+	if ((ret = i2c->xfer(i2c, msg3, 2)) == 2) {
+		printk ("%s: setup for tuner Philips SU1278\n", __FILE__);
+		return PHILIPS_SU1278;
+	}
+
+	printk ("%s: unknown PLL synthesizer (ret == %i), "
+		"please report to <linuxdvb@linuxtv.org>!!\n",
+		__FILE__, ret);
+
+	return UNKNOWN_FRONTEND;
 }
 
 
@@ -825,7 +932,7 @@
         int tuner_type;
 	u8 id = stv0299_readreg (i2c, 0x00);
 
-	dprintk ("%s\n", __FUNCTION__);
+	dprintk ("%s: id == 0x%02x\n", __FUNCTION__, id);
 
 	/* register 0x00 contains 0xa1 for STV0299 and STV0299B */
 	/* register 0x00 might contain 0x80 when returning from standby */
@@ -855,8 +961,7 @@
 int __init init_uni0299 (void)
 {
 	dprintk ("%s\n", __FUNCTION__);
-
-	return dvb_register_i2c_device (THIS_MODULE, uni0299_attach, uni0299_detach);
+	return dvb_register_i2c_device (NULL, uni0299_attach, uni0299_detach);
 }
 
 
@@ -871,9 +975,6 @@
 module_init (init_uni0299);
 module_exit (exit_uni0299);
 
-MODULE_PARM(debug,"i");
-MODULE_PARM_DESC(debug, "enable verbose debug messages");
-
 MODULE_DESCRIPTION("Universal STV0299/TSA5059/SL1935 DVB Frontend driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter");
 MODULE_LICENSE("GPL");
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/frontends/ves1820.c linux-2.5.69.patch/drivers/media/dvb/frontends/ves1820.c
--- linux-2.5.69/drivers/media/dvb/frontends/ves1820.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/frontends/ves1820.c	2003-04-30 12:02:46.000000000 +0200
@@ -19,11 +19,15 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */    
 
+#include <asm/errno.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
 
 
 #if 0
@@ -63,13 +67,9 @@
 #define GET_TUNER(data) ((u8) (((int) data >> 16) & 0xff))
 #define GET_DEMOD_ADDR(data) ((u8) (((int) data >> 24) & 0xff))
 
+#define XIN 57840000UL
+#define FIN (XIN >> 4)
 
-static inline
-void ddelay (int ms)
-{
-	current->state=TASK_INTERRUPTIBLE;
-	schedule_timeout((HZ*ms)/1000);
-}
 
 
 static
@@ -79,8 +79,8 @@
 	.frequency_stepsize = 62500,
 	.frequency_min = 51000000,
 	.frequency_max = 858000000,
-	.symbol_rate_min = (57840000/2)/64,     /* SACLK/64 == (XIN/2)/64 */
-	.symbol_rate_max = (57840000/2)/4,      /* SACLK/4 */
+	.symbol_rate_min = (XIN/2)/64,     /* SACLK/64 == (XIN/2)/64 */
+	.symbol_rate_max = (XIN/2)/4,      /* SACLK/4 */
 #if 0
 	frequency_tolerance: ???,
 	symbol_rate_tolerance: ???,  /* ppm */  /* == 8% (spec p. 5) */
@@ -123,7 +123,7 @@
 			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
 			__FUNCTION__, reg, data, ret);
 
-	mdelay(10);
+	dvb_delay(10);
 	return (ret != 1) ? -EREMOTEIO : 0;
 }
 
@@ -209,7 +209,7 @@
 	 *  check lock and toggle inversion bit if required...
 	 */
 	if (!(ves1820_readreg (fe, 0x11) & 0x08)) {
-		ddelay(1);
+		dvb_delay(10);
 		if (!(ves1820_readreg (fe, 0x11) & 0x08)) {
 			reg0 ^= 0x20;
 			ves1820_writereg (fe, 0x00, reg0 & 0xfe);
@@ -250,9 +250,6 @@
         u16 NDEC = 0;
         u32 tmp, ratio;
 
-#define XIN 57840000UL
-#define FIN (XIN >> 4)
-
         if (symbolrate > XIN/2) 
                 symbolrate = XIN/2;
 

--------------030009090806090104090509--


