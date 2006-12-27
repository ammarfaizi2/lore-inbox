Return-Path: <linux-kernel-owner+w=401wt.eu-S932994AbWL0RJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbWL0RJx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933001AbWL0RJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:09:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41758 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbWL0RJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:09:29 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/28] V4L/DVB (4960): Removal of unused code from
	usbvision-i2c.c
Date: Wed, 27 Dec 2006 14:57:27 -0200
Message-id: <20061227165727.PS79664500005@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

i2c_adap is almost not used. This patch removes it, cleaning the i2c support,
and improving driver understanding.
Thanks to Thierry Merle for testing it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvision/usbvision-i2c.c |   27 ++++---------------------
 drivers/media/video/usbvision/usbvision.h     |   23 ---------------------
 2 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-i2c.c b/drivers/media/video/usbvision/usbvision-i2c.c
index 9540bd0..efcd25b 100644
--- a/drivers/media/video/usbvision/usbvision-i2c.c
+++ b/drivers/media/video/usbvision/usbvision-i2c.c
@@ -58,7 +58,6 @@ static int usbvision_i2c_read(void *data
 static inline int try_write_address(struct i2c_adapter *i2c_adap,
 				    unsigned char addr, int retries)
 {
-	struct i2c_algo_usb_data *adap = i2c_adap->algo_data;
 	void *data;
 	int i, ret = -1;
 	char buf[4];
@@ -69,10 +68,10 @@ static inline int try_write_address(stru
 		ret = (usbvision_i2c_write(data, addr, buf, 1));
 		if (ret == 1)
 			break;	/* success! */
-		udelay(5 /*adap->udelay */ );
+		udelay(5);
 		if (i == retries)	/* no success */
 			break;
-		udelay(adap->udelay);
+		udelay(10);
 	}
 	if (i) {
 		PDEBUG(DBG_ALGO,"Needed %d retries for address %#2x", i, addr);
@@ -84,7 +83,6 @@ static inline int try_write_address(stru
 static inline int try_read_address(struct i2c_adapter *i2c_adap,
 				   unsigned char addr, int retries)
 {
-	struct i2c_algo_usb_data *adap = i2c_adap->algo_data;
 	void *data;
 	int i, ret = -1;
 	char buf[4];
@@ -94,10 +92,10 @@ static inline int try_read_address(struc
 		ret = (usbvision_i2c_read(data, addr, buf, 1));
 		if (ret == 1)
 			break;	/* success! */
-		udelay(5 /*adap->udelay */ );
+		udelay(5);
 		if (i == retries)	/* no success */
 			break;
-		udelay(adap->udelay);
+		udelay(10);
 	}
 	if (i) {
 		PDEBUG(DBG_ALGO,"Needed %d retries for address %#2x", i, addr);
@@ -248,15 +246,12 @@ int usbvision_i2c_usb_del_bus(struct i2c
 /* usbvision specific I2C functions                                        */
 /* ----------------------------------------------------------------------- */
 static struct i2c_adapter i2c_adap_template;
-static struct i2c_algo_usb_data i2c_algo_template;
 static struct i2c_client i2c_client_template;
 
 int usbvision_init_i2c(struct usb_usbvision *usbvision)
 {
 	memcpy(&usbvision->i2c_adap, &i2c_adap_template,
 	       sizeof(struct i2c_adapter));
-	memcpy(&usbvision->i2c_algo, &i2c_algo_template,
-	       sizeof(struct i2c_algo_usb_data));
 	memcpy(&usbvision->i2c_client, &i2c_client_template,
 	       sizeof(struct i2c_client));
 
@@ -266,9 +261,7 @@ int usbvision_init_i2c(struct usb_usbvis
 
 	i2c_set_adapdata(&usbvision->i2c_adap, usbvision);
 	i2c_set_clientdata(&usbvision->i2c_client, usbvision);
-	i2c_set_algo_usb_data(&usbvision->i2c_algo, usbvision);
 
-	usbvision->i2c_adap.algo_data = &usbvision->i2c_algo;
 	usbvision->i2c_client.adapter = &usbvision->i2c_adap;
 
 	if (usbvision_write_reg(usbvision, USBVISION_SER_MODE, USBVISION_IIC_LRNACK) < 0) {
@@ -297,7 +290,6 @@ #endif
 void call_i2c_clients(struct usb_usbvision *usbvision, unsigned int cmd,
 		      void *arg)
 {
-	BUG_ON(NULL == usbvision->i2c_adap.algo_data);
 	i2c_clients_command(&usbvision->i2c_adap, cmd, arg);
 }
 
@@ -531,21 +523,10 @@ static int usbvision_i2c_read(void *data
 	return rdcount;
 }
 
-static struct i2c_algo_usb_data i2c_algo_template = {
-	.data		= NULL,
-	.inb		= usbvision_i2c_read,
-	.outb		= usbvision_i2c_write,
-	.udelay		= 10,
-	.mdelay		= 10,
-	.timeout	= 100,
-};
-
 static struct i2c_adapter i2c_adap_template = {
 	.owner = THIS_MODULE,
 	.name              = "usbvision",
 	.id                = I2C_HW_B_BT848, /* FIXME */
-	.algo              = NULL,
-	.algo_data         = NULL,
 	.client_register   = attach_inform,
 	.client_unregister = detach_inform,
 #ifdef I2C_ADAP_CLASS_TV_ANALOG
diff --git a/drivers/media/video/usbvision/usbvision.h b/drivers/media/video/usbvision/usbvision.h
index 5ad07f8..b1645f9 100644
--- a/drivers/media/video/usbvision/usbvision.h
+++ b/drivers/media/video/usbvision/usbvision.h
@@ -219,18 +219,6 @@ #define USBVISION_IS_OPERATIONAL(udevice
 	((udevice)->last_error == 0) && \
 	(!(udevice)->remove_pending))
 
-/* I2C structures */
-struct i2c_algo_usb_data {
-	void *data;		/* private data for lowlevel routines */
-	int (*inb) (void *data, unsigned char addr, char *buf, short len);
-	int (*outb) (void *data, unsigned char addr, char *buf, short len);
-
-	/* local settings */
-	int udelay;
-	int mdelay;
-	int timeout;
-};
-
 #define I2C_USB_ADAP_MAX	16
 
 /* ----------------------------------------------------------------- */
@@ -383,7 +371,6 @@ struct usb_usbvision {
 
 	/* i2c Declaration Section*/
 	struct i2c_adapter i2c_adap;
-	struct i2c_algo_usb_data i2c_algo;
 	struct i2c_client i2c_client;
 
 	struct urb *ctrlUrb;
@@ -491,16 +478,6 @@ struct usb_usbvision {
 
 int usbvision_i2c_usb_del_bus(struct i2c_adapter *);
 
-static inline void *i2c_get_algo_usb_data (struct i2c_algo_usb_data *dev)
-{
-	return dev->data;
-}
-
-static inline void i2c_set_algo_usb_data (struct i2c_algo_usb_data *dev, void *data)
-{
-	dev->data = data;
-}
-
 
 /* ----------------------------------------------------------------------- */
 /* usbvision specific I2C functions                                        */

