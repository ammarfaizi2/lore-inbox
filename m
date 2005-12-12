Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVLLP1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVLLP1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVLLP1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:27:23 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:34726 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750789AbVLLP1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:27:22 -0500
Date: Mon, 12 Dec 2005 18:27:51 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git 4/4] SPI core refresh: dumb EEPROM driver
Message-Id: <20051212182751.72eef2d2.vwool@ru.mvista.com>
In-Reply-To: <20051212182026.4e393d5a.vwool@ru.mvista.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitry Pervushin <dpervushinl@gmail.com>
Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

 pnx4008-eeprom.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

Index: linux-2.6.orig/drivers/spi/pnx4008-eeprom.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/pnx4008-eeprom.c
@@ -0,0 +1,121 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/spi.h>
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
+
+#include "spipnx.h"
+
+#define EEPROM_SIZE		256
+#define DRIVER_NAME		"EEPROM"
+#define READ_BUFF_SIZE 160
+
+static int __init spi_eeprom_init(void);
+static void __exit spi_eeprom_cleanup(void);
+
+static int spiee_read_block (struct device *d, void *block)
+{
+	struct spi_device *device = TO_SPI_DEV (d);
+	char cmd[2];
+	struct spi_msg *msg = spimsg_alloc(device,
+					SPI_M_CS|SPI_M_CSREL,
+					NULL,
+					0,
+					NULL);
+	struct spi_msg *msg_cmd = spimsg_chain(msg, SPI_M_CS|SPI_M_WR|SPI_M_DMAUNSAFE, cmd, 2, NULL);
+	spimsg_chain(msg_cmd, SPI_M_RD|SPI_M_CSREL,  block, 256, NULL);
+
+	cmd[ 0 ] = 0x03;
+	cmd[ 1 ] = 0x00;
+
+	spimsg_set_clock(msg, 2000000); /* 2 MHz */
+	spi_transfer(msg, NULL);
+	spimsg_free(msg);
+	return 256;
+}
+static ssize_t blk_show (struct device *d, struct device_attribute *attr, char *text )
+{
+	char *rdbuff = kmalloc (256, SLAB_KERNEL);
+	char line1[80],line2[80];
+	char item1[5], item2[5];
+	int bytes, i, x, blen;
+
+	blen = spiee_read_block (d, rdbuff);
+
+	bytes = 0;
+
+	strcpy(text, "");
+	for (i = 0; i < blen; i += 8) {
+		strcpy(line1, "");
+		strcpy(line2, "" );
+		for (x = i; x < i + 8; x++) {
+			if (x > blen) {
+				sprintf(item1, "   ");
+				sprintf(item2, " " );
+			} else {
+				sprintf(item1, "%02x ", rdbuff[x]);
+				if (isprint(rdbuff[x])) {
+					sprintf(item2, "%c", rdbuff[x]);
+				} else {
+					sprintf(item2, ".");
+				}
+			}
+			strcat(line1, item1);
+			strcat(line2, item2);
+		}
+
+		strcat(text, line1);
+		strcat(text, "|  " );
+		strcat(text, line2);
+		strcat(text, "\n" );
+
+		bytes += (strlen (line1 ) + strlen(line2) + 4);
+	}
+
+	kfree (rdbuff);
+
+	return bytes + 1;
+}
+
+static DEVICE_ATTR(blk, S_IRUGO, blk_show, NULL );
+
+
+static int spiee_probe(struct spi_device *this_dev)
+{
+	device_create_file(&this_dev->dev, &dev_attr_blk);
+	return 0;
+}
+
+static int spiee_remove(struct spi_device *this_dev)
+{
+	device_remove_file(&this_dev->dev, &dev_attr_blk);
+	return 0;
+}
+
+static struct spi_driver eeprom_driver = {
+	.driver = {
+		   .name = DRIVER_NAME,
+	},
+	.probe = spiee_probe,
+	.remove = spiee_remove,
+};
+
+static int __init spi_eeprom_init(void)
+{
+	return spi_driver_add(&eeprom_driver);
+}
+static void __exit spi_eeprom_cleanup(void)
+{
+	spi_driver_del(&eeprom_driver);
+}
+
+module_init(spi_eeprom_init);
+module_exit(spi_eeprom_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dmitry pervushin <dpervushin@gmail.com>");
+MODULE_DESCRIPTION("SPI EEPROM driver");

