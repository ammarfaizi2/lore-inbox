Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTEGAUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTEGAT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:19:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42447 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262124AbTEGATL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052267615125@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <10522676141842@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1084, 2003/05/06 17:16:36-07:00, kraxel@bytesex.org

[PATCH] i2c #3/3: add class field to i2c_adapter

This is the last of three patches for i2c.  It introduces a new field
to i2c_adapter which classifies the kind of hardware a i2c adapter
belongs to (analog tv card / dvb card / smbus / gfx card ...).  i2c chip
drivers can use this infomation to decide whenever they want to look for
hardware on that adapter or not.  It doesn't make sense to probe for a
tv tuner on a smbus for example ...


 drivers/i2c/busses/i2c-ali15x3.c          |    1 +
 drivers/i2c/busses/i2c-amd756.c           |    1 +
 drivers/i2c/busses/i2c-amd8111.c          |    1 +
 drivers/i2c/busses/i2c-i801.c             |    1 +
 drivers/i2c/busses/i2c-isa.c              |    1 +
 drivers/i2c/busses/i2c-piix4.c            |    1 +
 drivers/i2c/busses/i2c-viapro.c           |    1 +
 drivers/i2c/chips/adm1021.c               |    2 ++
 drivers/i2c/chips/it87.c                  |    2 ++
 drivers/i2c/chips/lm75.c                  |    2 ++
 drivers/i2c/chips/via686a.c               |    2 ++
 drivers/i2c/chips/w83781d.c               |    2 ++
 drivers/media/video/bt832.c               |   22 +++-------------------
 drivers/media/video/bttv-if.c             |    1 +
 drivers/media/video/msp3400.c             |    2 +-
 drivers/media/video/saa5249.c             |    6 +-----
 drivers/media/video/saa7134/saa7134-i2c.c |    1 +
 drivers/media/video/tda7432.c             |    2 +-
 drivers/media/video/tda9875.c             |    2 +-
 drivers/media/video/tda9887.c             |   20 +++-----------------
 drivers/media/video/tuner.c               |   22 ++++------------------
 drivers/media/video/tvaudio.c             |    9 ++-------
 drivers/media/video/tvmixer.c             |    7 +------
 include/linux/i2c.h                       |    7 +++++++
 24 files changed, 43 insertions(+), 75 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Tue May  6 17:24:33 2003
@@ -475,6 +475,7 @@
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Tue May  6 17:24:33 2003
@@ -313,6 +313,7 @@
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Tue May  6 17:24:33 2003
@@ -360,6 +360,7 @@
 	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
+	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Tue May  6 17:24:33 2003
@@ -547,6 +547,7 @@
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-isa.c	Tue May  6 17:24:33 2003
@@ -40,6 +40,7 @@
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &isa_algorithm,
 	.dev		= {
 		.name	= "ISA main adapter",
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Tue May  6 17:24:33 2003
@@ -395,6 +395,7 @@
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Tue May  6 17:24:33 2003
@@ -295,6 +295,7 @@
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.dev		= {
 		.name	= "unset",
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/chips/adm1021.c	Tue May  6 17:24:33 2003
@@ -203,6 +203,8 @@
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
 
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/chips/it87.c	Tue May  6 17:24:33 2003
@@ -525,6 +525,8 @@
      * when a new adapter is inserted (and it87_driver is still present) */
 static int it87_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
 
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/chips/lm75.c	Tue May  6 17:24:33 2003
@@ -121,6 +121,8 @@
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
 
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/chips/via686a.c	Tue May  6 17:24:33 2003
@@ -661,6 +661,8 @@
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Tue May  6 17:24:33 2003
+++ b/drivers/i2c/chips/w83781d.c	Tue May  6 17:24:33 2003
@@ -1026,6 +1026,8 @@
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+		return 0;
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
 
diff -Nru a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
--- a/drivers/media/video/bt832.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/bt832.c	Tue May  6 17:24:33 2003
@@ -198,25 +198,9 @@
 
 static int bt832_probe(struct i2c_adapter *adap)
 {
-	int rc;
-
-	printk("bt832_probe\n");
-
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-		printk("bt832: probing %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
-		rc = i2c_probe(adap, &addr_data, bt832_attach);
-		break;
-	default:
-		printk("bt832: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->name,adap->id);
-		rc = 0;
-		/* nothing */
-	}
-	return rc;
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, bt832_attach);
+	return 0;
 }
 
 static int bt832_detach(struct i2c_client *client)
diff -Nru a/drivers/media/video/bttv-if.c b/drivers/media/video/bttv-if.c
--- a/drivers/media/video/bttv-if.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/bttv-if.c	Tue May  6 17:24:33 2003
@@ -233,6 +233,7 @@
 	.owner             = THIS_MODULE,
 	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
+	.class             = I2C_ADAP_CLASS_TV_ANALOG,
 	.client_register   = attach_inform,
 };
 
diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/msp3400.c	Tue May  6 17:24:33 2003
@@ -1372,7 +1372,7 @@
 
 static int msp_probe(struct i2c_adapter *adap)
 {
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, msp_attach);
 	return 0;
 }
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/saa5249.c	Tue May  6 17:24:33 2003
@@ -224,12 +224,8 @@
  
 static int saa5249_probe(struct i2c_adapter *adap)
 {
-	/* Only attach these chips to the BT848 bus for now */
-	
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
-	{
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa5249_attach);
-	}
 	return 0;
 }
 
diff -Nru a/drivers/media/video/saa7134/saa7134-i2c.c b/drivers/media/video/saa7134/saa7134-i2c.c
--- a/drivers/media/video/saa7134/saa7134-i2c.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/saa7134/saa7134-i2c.c	Tue May  6 17:24:33 2003
@@ -336,6 +336,7 @@
 	.owner         = THIS_MODULE,
 	I2C_DEVNAME("saa7134"),
 	.id            = I2C_ALGO_SAA7134,
+	.class         = I2C_ADAP_CLASS_TV_ANALOG,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
 };
diff -Nru a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/tda7432.c	Tue May  6 17:24:33 2003
@@ -340,7 +340,7 @@
 
 static int tda7432_probe(struct i2c_adapter *adap)
 {
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
 	return 0;
 }
diff -Nru a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/tda9875.c	Tue May  6 17:24:33 2003
@@ -273,7 +273,7 @@
 
 static int tda9875_probe(struct i2c_adapter *adap)
 {
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
 	return 0;
 }
diff -Nru a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/tda9887.c	Tue May  6 17:24:33 2003
@@ -368,23 +368,9 @@
 
 static int tda9887_probe(struct i2c_adapter *adap)
 {
-	int rc;
-
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-		printk("tda9887: probing %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = i2c_probe(adap, &addr_data, tda9887_attach);
-		break;
-	default:
-		printk("tda9887: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = 0;
-		/* nothing */
-	}
-	return rc;
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, tda9887_attach);
+	return 0;
 }
 
 static int tda9887_detach(struct i2c_client *client)
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/tuner.c	Tue May  6 17:24:33 2003
@@ -817,29 +817,15 @@
 
 static int tuner_probe(struct i2c_adapter *adap)
 {
-	int rc;
-
 	if (0 != addr) {
 		normal_i2c_range[0] = addr;
 		normal_i2c_range[1] = addr;
 	}
 	this_adap = 0;
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-	case I2C_ALGO_SAA7134:
-	case I2C_ALGO_SAA7146:
-		printk("tuner: probing %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = i2c_probe(adap, &addr_data, tuner_attach);
-		break;
-	default:
-		printk("tuner: ignoring %s i2c adapter [id=0x%x]\n",
-		       adap->dev.name,adap->id);
-		rc = 0;
-		/* nothing */
-	}
-	return rc;
+
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, tuner_attach);
+	return 0;
 }
 
 static int tuner_detach(struct i2c_client *client)
diff -Nru a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/tvaudio.c	Tue May  6 17:24:33 2003
@@ -1408,14 +1408,9 @@
 
 static int chip_probe(struct i2c_adapter *adap)
 {
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, chip_attach);
-	default:
-		/* ignore this i2c bus */
-		return 0;
-	}
+	return 0;
 }
 
 static int chip_detach(struct i2c_client *client)
diff -Nru a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
--- a/drivers/media/video/tvmixer.c	Tue May  6 17:24:33 2003
+++ b/drivers/media/video/tvmixer.c	Tue May  6 17:24:33 2003
@@ -254,12 +254,7 @@
 	int i,minor;
 
 	/* TV card ??? */
-	switch (client->adapter->id) {
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
-		/* ok, have a look ... */
-		break;
-	default:
+	if (!(client->adapter->class & I2C_ADAP_CLASS_TV_ANALOG)) {
 		/* ignore that one */
 		if (debug)
 			printk("tvmixer: %s is not a tv card\n",
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Tue May  6 17:24:33 2003
+++ b/include/linux/i2c.h	Tue May  6 17:24:33 2003
@@ -225,6 +225,7 @@
 	struct module *owner;
 	unsigned int id;/* == is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
+	unsigned int class;
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;
 
@@ -277,6 +278,12 @@
 #define I2C_CLIENT_PEC  0x04			/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */
+
+/* i2c adapter classes (bitmask) */
+#define I2C_ADAP_CLASS_SMBUS      (1<<0)        /* lm_sensors, ... */
+#define I2C_ADAP_CLASS_TV_ANALOG  (1<<1)        /* bttv + friends */
+#define I2C_ADAP_CLASS_TV_DIGINAL (1<<2)        /* dbv cards */
+#define I2C_ADAP_CLASS_DDC        (1<<3)        /* i2c-matroxfb ? */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the

