Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263313AbVCDWJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbVCDWJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbVCDWJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:09:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:4514 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263159AbVCDUyc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:32 -0500
Cc: yekkim@pacbell.net
Subject: [PATCH] I2C: Fix some gcc 4.0 compile failures and warnings
In-Reply-To: <11099685962273@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:36 -0800
Message-Id: <11099685961021@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2108, 2005/03/02 15:02:27-08:00, yekkim@pacbell.net

[PATCH] I2C: Fix some gcc 4.0 compile failures and warnings

gcc 4.0.x cvs seems to dislike "include/linux/i2c.h file" and others due
to a current gcc 4.0.x change having to do with array declarations.

Example error msg:   include/linux/i2c.h:{55,194} error: array type has
incomplete element type

A. Daplas has recently done a workaround for this on another header
file. A thread discussing this can be found by following the link below:

http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html

The patch changes the array(struct i2c_msg) declaration used by
*i2c_transfer and *master_xfer from "struct i2c_msg msg[]" format to
"struct i2c_msg *msg".

After some grepping, I came up with about a dozen files that used the
format disliked by gcc4 that're addressed by the attached patch.
Tested on gcc 3.x & gcc 4.x by configuring kernel with all i2c switches
enabled as module, and saw no errors or warnings in i2c.

Signed-off-by: Mickey Stein <yekkim@pacbell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/i2c/writing-clients                 |    2 +-
 drivers/i2c/algos/i2c-algo-ite.c                  |    4 ++--
 drivers/i2c/algos/i2c-algo-pca.c                  |    2 +-
 drivers/i2c/algos/i2c-algo-pcf.c                  |    2 +-
 drivers/i2c/algos/i2c-algo-sgi.c                  |    2 +-
 drivers/i2c/busses/i2c-au1550.c                   |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c                  |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 +-
 drivers/i2c/busses/i2c-keywest.c                  |    2 +-
 drivers/i2c/busses/i2c-mpc.c                      |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c                  |    4 ++--
 drivers/i2c/i2c-core.c                            |    2 +-
 drivers/media/common/saa7146_i2c.c                |    8 ++++----
 drivers/media/dvb/b2c2/skystar2.c                 |    2 +-
 drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c      |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 +-
 drivers/media/video/bttv-i2c.c                    |    2 +-
 drivers/media/video/saa7134/saa7134-i2c.c         |    2 +-
 include/linux/i2c.h                               |    4 ++--
 include/media/saa7146.h                           |    2 +-
 20 files changed, 26 insertions(+), 26 deletions(-)


diff -Nru a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients	2005-03-04 12:23:35 -08:00
+++ b/Documentation/i2c/writing-clients	2005-03-04 12:23:35 -08:00
@@ -638,7 +638,7 @@
 parameter contains the bytes the read/write, the third the length of the
 buffer. Returned is the actual number of bytes read/written.
   
-  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
+  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
                           int num);
 
 This sends a series of messages. Each message can be a read or write,
diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/algos/i2c-algo-ite.c	2005-03-04 12:23:35 -08:00
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
diff -Nru a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/algos/i2c-algo-pca.c	2005-03-04 12:23:35 -08:00
@@ -178,7 +178,7 @@
 }
 
 static int pca_xfer(struct i2c_adapter *i2c_adap,
-                    struct i2c_msg msgs[],
+                    struct i2c_msg *msgs,
                     int num)
 {
         struct i2c_algo_pca_data *adap = i2c_adap->algo_data;
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	2005-03-04 12:23:35 -08:00
@@ -332,7 +332,7 @@
 }
 
 static int pcf_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
+		    struct i2c_msg *msgs, 
 		    int num)
 {
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
diff -Nru a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
--- a/drivers/i2c/algos/i2c-algo-sgi.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/algos/i2c-algo-sgi.c	2005-03-04 12:23:35 -08:00
@@ -131,7 +131,7 @@
 	return 0;
 }
 
-static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
+static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		    int num)
 {
 	struct i2c_algo_sgi_data *adap = i2c_adap->algo_data;
diff -Nru a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
--- a/drivers/i2c/busses/i2c-au1550.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/busses/i2c-au1550.c	2005-03-04 12:23:35 -08:00
@@ -253,7 +253,7 @@
 }
 
 static int
-au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_au1550_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *p;
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	2005-03-04 12:23:35 -08:00
@@ -549,7 +549,7 @@
  * Generic master transfer entrypoint. 
  * Returns the number of processed messages or error (<0)
  */
-static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
     	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/busses/i2c-iop3xx.c	2005-03-04 12:23:35 -08:00
@@ -361,7 +361,7 @@
  * master_xfer() - main read/write entry
  */
 static int 
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], 
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, 
 				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/busses/i2c-keywest.c	2005-03-04 12:23:35 -08:00
@@ -399,7 +399,7 @@
  */
 static int
 keywest_xfer(	struct i2c_adapter *adap,
-		struct i2c_msg msgs[], 
+		struct i2c_msg *msgs, 
 		int num)
 {
 	struct keywest_chan* chan = i2c_get_adapdata(adap);
diff -Nru a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/busses/i2c-mpc.c	2005-03-04 12:23:35 -08:00
@@ -233,7 +233,7 @@
 	return length;
 }
 
-static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
 	int i;
diff -Nru a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2005-03-04 12:23:35 -08:00
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
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-03-04 12:23:35 -08:00
@@ -582,7 +582,7 @@
  * ----------------------------------------------------
  */
 
-int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
+int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
 {
 	int ret;
 
diff -Nru a/drivers/media/common/saa7146_i2c.c b/drivers/media/common/saa7146_i2c.c
--- a/drivers/media/common/saa7146_i2c.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/media/common/saa7146_i2c.c	2005-03-04 12:23:35 -08:00
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
 	
diff -Nru a/drivers/media/dvb/b2c2/skystar2.c b/drivers/media/dvb/b2c2/skystar2.c
--- a/drivers/media/dvb/b2c2/skystar2.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/media/dvb/b2c2/skystar2.c	2005-03-04 12:23:35 -08:00
@@ -293,7 +293,7 @@
 	return buf - start;
 }
 
-static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg msgs[], int num)
+static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg *msgs, int num)
 {
 	struct adapter *tmp = i2c_get_adapdata(adapter);
 	int i, ret = 0;
diff -Nru a/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c b/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
--- a/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-04 12:23:35 -08:00
@@ -38,7 +38,7 @@
 /*
  * I2C master xfer function
  */
-static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)
+static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg *msg,int num)
 {
 	struct usb_dibusb *dib = i2c_get_adapdata(adap);
 	int i;
diff -Nru a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-04 12:23:35 -08:00
@@ -252,7 +252,7 @@
 	return rcv_len;
 }
 
-static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg msg[], int num)
+static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg *msg, int num)
 {
 	struct ttusb *ttusb = i2c_get_adapdata(adapter);
 	int i = 0;
diff -Nru a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
--- a/drivers/media/video/bttv-i2c.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/media/video/bttv-i2c.c	2005-03-04 12:23:35 -08:00
@@ -245,7 +245,7 @@
        	return retval;
 }
 
-static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct bttv *btv = i2c_get_adapdata(i2c_adap);
 	int retval = 0;
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	2005-03-04 12:23:35 -08:00
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	2005-03-04 12:23:35 -08:00
@@ -236,7 +236,7 @@
 }
 
 static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
-			    struct i2c_msg msgs[], int num)
+			    struct i2c_msg *msgs, int num)
 {
 	struct saa7134_dev *dev = i2c_adap->algo_data;
 	enum i2c_status status;
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:23:35 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:23:35 -08:00
@@ -55,7 +55,7 @@
 
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int num);
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 
 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
@@ -191,7 +191,7 @@
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[], 
+	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
 	                   unsigned short flags, char read_write,
diff -Nru a/include/media/saa7146.h b/include/media/saa7146.h
--- a/include/media/saa7146.h	2005-03-04 12:23:35 -08:00
+++ b/include/media/saa7146.h	2005-03-04 12:23:35 -08:00
@@ -157,7 +157,7 @@
 
 /* from saa7146_i2c.c */
 int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate);
-int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct i2c_msg msgs[], int num,  int retries);
+int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct *i2c_msg msgs, int num,  int retries);
 
 /* from saa7146_core.c */
 extern struct list_head saa7146_devices;

