Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271355AbTG2Ja6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTG2Ja6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:30:58 -0400
Received: from mail.convergence.de ([212.84.236.4]:39902 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271355AbTG2Jaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:30:35 -0400
Subject: [PATCH 3/6] [DVB] mt312 DVB frontend update
In-Reply-To: <10594710303674@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 29 Jul 2003 11:30:31 +0200
Message-Id: <10594710311160@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - show i2c read errors only for registered frontends
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/frontends/mt312.c linux-2.6.0-test2.patch/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.0-test2.work/drivers/media/dvb/frontends/mt312.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/frontends/mt312.c	2003-07-29 09:17:53.000000000 +0200
@@ -41,6 +41,9 @@
 #define MT312_SYS_CLK		90000000UL	/* 90 MHz */
 #define MT312_PLL_CLK		10000000UL	/* 10 MHz */
 
+/* number of active frontends */
+static int mt312_count = 0;
+
 static struct dvb_frontend_info mt312_info = {
 	.name = "Zarlink MT312",
 	.type = FE_QPSK,
@@ -78,7 +81,7 @@
 
 	ret = i2c->xfer(i2c, msg, 2);
 
-	if (ret != 2) {
+	if ((ret != 2) && (mt312_count != 0)) {
 		printk(KERN_ERR "%s: ret == %d\n", __FUNCTION__, ret);
 		return -EREMOTEIO;
 	}
@@ -722,13 +725,21 @@
 	if ((id != ID_VP310) && (id != ID_MT312))
 		return -ENODEV;
 
-	return dvb_register_frontend(mt312_ioctl, i2c, (void *) (long) id,
-				     &mt312_info);
+	if ((ret = dvb_register_frontend(mt312_ioctl, i2c,
+				(void *)(long)id, &mt312_info)) < 0)
+		return ret;
+
+	mt312_count++;
+
+	return 0;
 }
 
 static void mt312_detach(struct dvb_i2c_bus *i2c)
 {
 	dvb_unregister_frontend(mt312_ioctl, i2c);
+
+	if (mt312_count)
+		mt312_count--;
 }
 
 static int __init mt312_module_init(void)

