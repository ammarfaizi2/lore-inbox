Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbTCNA63>; Thu, 13 Mar 2003 19:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbTCNA6C>; Thu, 13 Mar 2003 19:58:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62987 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263209AbTCNAz4>;
	Thu, 13 Mar 2003 19:55:56 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.64
In-reply-to: <10476033233796@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 13 Mar 2003 16:55 -0800
Message-id: <1047603324728@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1112, 2003/03/13 12:26:39-08:00, greg@kroah.com

i2c: add i2c sysfs bus support.


 drivers/i2c/i2c-core.c |   33 ++++++++++++++++++++++++++++++---
 include/linux/i2c.h    |    3 +++
 2 files changed, 33 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Thu Mar 13 16:57:09 2003
+++ b/drivers/i2c/i2c-core.c	Thu Mar 13 16:57:09 2003
@@ -598,10 +598,37 @@
 {
 	remove_proc_entry("i2c",proc_bus);
 }
+#else
+static int __init i2cproc_init(void) { return 0; }
+static void __exit i2cproc_cleanup(void) { }
+#endif /* CONFIG_PROC_FS */
 
-module_init(i2cproc_init);
-module_exit(i2cproc_cleanup);
-#endif /* def CONFIG_PROC_FS */
+/* match always succeeds, as we want the probe() to tell if we really accept this match */
+static int i2c_device_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+};
+
+
+static int __init i2c_init(void)
+{
+	bus_register(&i2c_bus_type);
+	return i2cproc_init();
+}
+
+static void __exit i2c_exit(void)
+{
+	i2cproc_cleanup();
+	bus_unregister(&i2c_bus_type);
+}
+
+module_init(i2c_init);
+module_exit(i2c_exit);
 
 /* ----------------------------------------------------
  * the functional interface to the i2c busses.
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Thu Mar 13 16:57:09 2003
+++ b/include/linux/i2c.h	Thu Mar 13 16:57:09 2003
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/i2c-id.h>
+#include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
 
 /* --- General options ------------------------------------------------	*/
@@ -143,6 +144,8 @@
 	 */
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
 };
+
+extern struct bus_type i2c_bus_type;
 
 /*
  * i2c_client identifies a single device (i.e. chip) that is connected to an 

