Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVCBPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVCBPVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVCBPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:21:44 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:9691 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262310AbVCBPVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:21:11 -0500
Message-ID: <4225D9E0.40005@pacbell.net>
Date: Wed, 02 Mar 2005 07:21:04 -0800
From: Mickey Stein <yekkim@pacbell.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, Greg KH <greg@kroah.com>
Subject: [Patch] gcc 4 errors out on i2c.h (2.6.11)
Content-Type: multipart/mixed;
 boundary="------------040600030200000100030009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600030200000100030009
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

I've noticed no problems with today's new 2.6.11 in the i2c realm on 
gcc3.x, but the last couple of weeks of gcc 4.x cvs give this:

Error msgs building i2c modules on 2.6.11 using gcc 4:
------------
In file included from drivers/i2c/i2c-core.c:29:
include/linux/i2c.h:58: error: array type has incomplete element type
include/linux/i2c.h:197: error: array type has incomplete element type
drivers/i2c/i2c-core.c: In function ‘i2c_transfer’:
drivers/i2c/i2c-core.c:594: error: type of formal parameter 2 is incomplete
drivers/i2c/i2c-core.c: In function ‘i2c_master_send’:
drivers/i2c/i2c-core.c:620: error: type of formal parameter 2 is incomplete
drivers/i2c/i2c-core.c: In function ‘i2c_master_recv’:
drivers/i2c/i2c-core.c:649: error: type of formal parameter 2 is incomplete
make[2]: *** [drivers/i2c/i2c-core.o] Error 1
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2
-------------

I'm not clear on whether the mainstream kernel is "supposed" to compile 
error-free with the current state of
gcc 4 cvs. If not, then disregard. I tested this patch applied against 
today's 2.6.11 with gcc 3.x & 4.x
by enabling all i2c module switches and building.

A thread discussing this can be found by following the link below:

http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html

The patch changes declarations from "struct i2c_msg msg[]" format to 
"struct i2c_msg *msg".

I've run this by Greg K-H and fixed a typo akpm noticed. The patch 
touches on several other
files using *i2c_transfer and *master_xfer that give warnings.

Signed-off-by: Mickey Stein <yekkim@pacbell.net>



--------------040600030200000100030009
Content-Type: text/plain;
 name="i2c_xfer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_xfer.patch"

--- ./include/linux/i2c.h.sav	2005-02-23 10:35:36.000000000 -0800
+++ ./include/linux/i2c.h	2005-02-23 10:46:23.000000000 -0800
@@ -55,7 +55,7 @@
 
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int num);
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 
 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
@@ -194,7 +194,7 @@
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[], 
+	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
 	                   unsigned short flags, char read_write,
--- ./drivers/i2c/busses/i2c-iop3xx.c.sav	2005-02-23 10:36:21.000000000 -0800
+++ ./drivers/i2c/busses/i2c-iop3xx.c	2005-02-23 10:47:36.000000000 -0800
@@ -361,7 +361,7 @@
  * master_xfer() - main read/write entry
  */
 static int 
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], 
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, 
 				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
--- ./drivers/i2c/i2c-core.c.sav	2005-02-23 10:34:59.000000000 -0800
+++ ./drivers/i2c/i2c-core.c	2005-02-23 10:49:18.000000000 -0800
@@ -583,7 +583,7 @@
  * ----------------------------------------------------
  */
 
-int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
+int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
 {
 	int ret;
 
--- ./drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c.sav	2005-02-23 10:39:53.000000000 -0800
+++ ./drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-02-23 10:50:07.000000000 -0800
@@ -252,7 +252,7 @@
 	return rcv_len;
 }
 
-static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg msg[], int num)
+static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg *msg, int num)
 {
 	struct ttusb *ttusb = i2c_get_adapdata(adapter);
 	int i = 0;
--- ./drivers/media/dvb/b2c2/skystar2.c.sav	2005-02-23 10:40:33.000000000 -0800
+++ ./drivers/media/dvb/b2c2/skystar2.c	2005-02-23 10:50:42.000000000 -0800
@@ -293,7 +293,7 @@
 	return buf - start;
 }
 
-static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg msgs[], int num)
+static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg *msgs, int num)
 {
 	struct adapter *tmp = i2c_get_adapdata(adapter);
 	int i, ret = 0;
--- ./Documentation/i2c/writing-clients.sav	2005-02-23 10:42:00.000000000 -0800
+++ ./Documentation/i2c/writing-clients	2005-02-23 10:42:30.000000000 -0800
@@ -642,7 +642,7 @@
 parameter contains the bytes the read/write, the third the length of the
 buffer. Returned is the actual number of bytes read/written.
   
-  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
+  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
                           int num);
 
 This sends a series of messages. Each message can be a read or write,
--- ./include/media/saa7146.h.sav	2005-02-23 12:01:51.000000000 -0800
+++ ./include/media/saa7146.h	2005-02-23 12:19:38.000000000 -0800
@@ -157,7 +157,7 @@
 
 /* from saa7146_i2c.c */
 int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate);
-int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct i2c_msg msgs[], int num,  int retries);
+int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct i2c_msg *msgs, int num,  int retries);
 
 /* from saa7146_core.c */
 extern struct list_head saa7146_devices;
--- ./drivers/i2c/busses/i2c-s3c2410.c.sav	2005-02-23 12:03:29.000000000 -0800
+++ ./drivers/i2c/busses/i2c-s3c2410.c	2005-02-23 12:20:31.000000000 -0800
@@ -483,7 +483,7 @@
  * this starts an i2c transfer
 */
 
-static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c, struct i2c_msg msgs[], int num)
+static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c, struct i2c_msg *msgs, int num)
 {
 	unsigned long timeout;
 	int ret;
@@ -534,7 +534,7 @@
 */
 
 static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
-			struct i2c_msg msgs[], int num)
+			struct i2c_msg *msgs, int num)
 {
 	struct s3c24xx_i2c *i2c = (struct s3c24xx_i2c *)adap->algo_data;
 	int retry;
--- ./drivers/i2c/busses/i2c-mpc.c.sav	2005-02-23 12:04:11.000000000 -0800
+++ ./drivers/i2c/busses/i2c-mpc.c	2005-02-23 12:17:28.000000000 -0800
@@ -233,7 +233,7 @@
 	return length;
 }
 
-static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
 	int i;
--- ./drivers/i2c/busses/i2c-ibm_iic.c.sav	2005-02-23 12:04:42.000000000 -0800
+++ ./drivers/i2c/busses/i2c-ibm_iic.c	2005-02-23 12:21:08.000000000 -0800
@@ -549,7 +549,7 @@
  * Generic master transfer entrypoint. 
  * Returns the number of processed messages or error (<0)
  */
-static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
     	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
--- ./drivers/i2c/busses/i2c-keywest.c.sav	2005-02-23 12:05:10.000000000 -0800
+++ ./drivers/i2c/busses/i2c-keywest.c	2005-02-23 12:26:47.000000000 -0800
@@ -399,7 +399,7 @@
  */
 static int
 keywest_xfer(	struct i2c_adapter *adap,
-		struct i2c_msg msgs[], 
+		struct i2c_msg *msgs, 
 		int num)
 {
 	struct keywest_chan* chan = i2c_get_adapdata(adap);
--- ./drivers/i2c/busses/i2c-au1550.c.sav	2005-02-23 12:06:00.000000000 -0800
+++ ./drivers/i2c/busses/i2c-au1550.c	2005-02-23 12:27:39.000000000 -0800
@@ -253,7 +253,7 @@
 }
 
 static int
-au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_au1550_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *p;
--- ./drivers/i2c/algos/i2c-algo-pca.c.sav	2005-02-23 12:06:21.000000000 -0800
+++ ./drivers/i2c/algos/i2c-algo-pca.c	2005-02-23 12:28:09.000000000 -0800
@@ -178,7 +178,7 @@
 }
 
 static int pca_xfer(struct i2c_adapter *i2c_adap,
-                    struct i2c_msg msgs[],
+                    struct i2c_msg *msgs,
                     int num)
 {
         struct i2c_algo_pca_data *adap = i2c_adap->algo_data;
--- ./drivers/i2c/algos/i2c-algo-pcf.c.sav	2005-02-23 12:07:04.000000000 -0800
+++ ./drivers/i2c/algos/i2c-algo-pcf.c	2005-02-23 12:28:49.000000000 -0800
@@ -332,7 +332,7 @@
 }
 
 static int pcf_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
+		    struct i2c_msg *msgs, 
 		    int num)
 {
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
--- ./drivers/i2c/algos/i2c-algo-ite.c.sav	2005-02-23 12:07:17.000000000 -0800
+++ ./drivers/i2c/algos/i2c-algo-ite.c	2005-02-23 12:29:31.000000000 -0800
@@ -490,7 +490,7 @@
  * condition.
  */
 #if 0
-static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num) 
+static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num) 
 {
    int i;
    struct i2c_msg *pmsg;
@@ -600,7 +600,7 @@
  * verify that the bus is not busy or in some unknown state.
  */
 static int iic_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
+		    struct i2c_msg *msgs, 
 		    int num)
 {
 	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
--- ./drivers/i2c/algos/i2c-algo-sgi.c.sav	2005-02-23 12:07:40.000000000 -0800
+++ ./drivers/i2c/algos/i2c-algo-sgi.c	2005-02-23 12:29:58.000000000 -0800
@@ -131,7 +131,7 @@
 	return 0;
 }
 
-static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
+static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		    int num)
 {
 	struct i2c_algo_sgi_data *adap = i2c_adap->algo_data;
--- ./drivers/media/video/saa7134/saa7134-i2c.c.sav	2005-02-23 12:08:12.000000000 -0800
+++ ./drivers/media/video/saa7134/saa7134-i2c.c	2005-02-23 12:30:20.000000000 -0800
@@ -236,7 +236,7 @@
 }
 
 static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
-			    struct i2c_msg msgs[], int num)
+			    struct i2c_msg *msgs, int num)
 {
 	struct saa7134_dev *dev = i2c_adap->algo_data;
 	enum i2c_status status;
--- ./drivers/media/video/bttv-i2c.c.sav	2005-02-23 12:08:29.000000000 -0800
+++ ./drivers/media/video/bttv-i2c.c	2005-02-23 12:30:56.000000000 -0800
@@ -245,7 +245,7 @@
        	return retval;
 }
 
-static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct bttv *btv = i2c_get_adapdata(i2c_adap);
 	int retval = 0;
--- ./drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c.sav	2005-02-23 12:09:43.000000000 -0800
+++ ./drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-02-23 12:31:38.000000000 -0800
@@ -38,7 +38,7 @@
 /*
  * I2C master xfer function
  */
-static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)
+static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg *msg,int num)
 {
 	struct usb_dibusb *dib = i2c_get_adapdata(adap);
 	int i;
--- ./drivers/media/common/saa7146_i2c.c.sav	2005-02-23 12:10:06.000000000 -0800
+++ ./drivers/media/common/saa7146_i2c.c	2005-02-23 12:32:45.000000000 -0800
@@ -25,7 +25,7 @@
    sent through the saa7146. have a look at the specifications p. 122 ff 
    to understand this. it returns the number of u32s to send, or -1
    in case of an error. */
-static int saa7146_i2c_msg_prepare(const struct i2c_msg m[], int num, u32 *op)
+static int saa7146_i2c_msg_prepare(const struct i2c_msg *m, int num, u32 *op)
 {
 	int h1, h2;
 	int i, j, addr;
@@ -89,7 +89,7 @@
    which bytes were read through the adapter and write them back to the corresponding
    i2c-message. but instead, we simply write back all bytes.
    fixme: this could be improved. */
-static int saa7146_i2c_msg_cleanup(const struct i2c_msg m[], int num, u32 *op)
+static int saa7146_i2c_msg_cleanup(const struct i2c_msg *m, int num, u32 *op)
 {
 	int i, j;
 	int op_count = 0;
@@ -272,7 +272,7 @@
 	return 0;
 }
 
-int saa7146_i2c_transfer(struct saa7146_dev *dev, const struct i2c_msg msgs[], int num, int retries)
+int saa7146_i2c_transfer(struct saa7146_dev *dev, const struct i2c_msg *msgs, int num, int retries)
 {
 	int i = 0, count = 0;
 	u32* buffer = dev->d_i2c.cpu_addr;
@@ -372,7 +372,7 @@
 }
 
 /* utility functions */
-static int saa7146_i2c_xfer(struct i2c_adapter* adapter, struct i2c_msg msg[], int num)
+static int saa7146_i2c_xfer(struct i2c_adapter* adapter, struct i2c_msg *msg, int num)
 {
 	struct saa7146_dev* dev = i2c_get_adapdata(adapter);
 	

--------------040600030200000100030009--
