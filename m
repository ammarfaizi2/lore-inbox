Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIYRvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIYRZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:25:38 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:17356 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261334AbTIYRWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:22:00 -0400
Date: Thu, 25 Sep 2003 19:21:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (14/19): iucv driver.
Message-ID: <20030925172119.GO2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Move iucv bus and root device initialization from netiucv to iucv.
 - Fix race condition in iucv_connect.
 - Add 'user' attribute to netiucv driver.

diffstat:
 drivers/s390/net/iucv.c    |   72 +++++++++++++++++++++++++++++++++++----------
 drivers/s390/net/iucv.h    |    3 +
 drivers/s390/net/netiucv.c |   55 ++++++++--------------------------
 3 files changed, 74 insertions(+), 56 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Mon Sep  8 21:49:52 2003
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Thu Sep 25 18:33:31 2003
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.11 2003/04/15 16:45:37 aberg Exp $
+ * $Id: iucv.c,v 1.14 2003/09/23 16:48:17 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -29,11 +29,12 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.11 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.14 $
  *
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 
 #include <linux/spinlock.h>
@@ -43,6 +44,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/device.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
@@ -71,6 +73,21 @@
 #define IPANSLST        0x08
 #define IPBUFLST        0x40
 
+static int
+iucv_bus_match (struct device *dev, struct device_driver *drv)
+{
+	return 0;
+}
+
+struct bus_type iucv_bus = {
+	.name = "iucv",
+	.match = iucv_bus_match,
+};	
+
+struct device iucv_root = {
+	.bus_id = "iucv",
+};
+
 /* General IUCV interrupt structure */
 typedef struct {
 	__u16 ippathid;
@@ -283,7 +300,7 @@
 #ifdef DEBUG
 static int debuglevel = 0;
 
-MODULE_PARM(debuglevel, "i");
+module_param(debuglevel, int, 0);
 MODULE_PARM_DESC(debuglevel,
  "Specifies the debug level (0=off ... 3=all)");
 
@@ -332,7 +349,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.11 $";
+	char vbuf[] = "$Revision: 1.14 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -353,9 +370,24 @@
 static int
 iucv_init(void)
 {
+	int ret;
+
 	if (iucv_external_int_buffer)
 		return 0;
 
+	ret = bus_register(&iucv_bus);
+	if (ret != 0) {
+		printk(KERN_ERR "IUCV: failed to register bus.\n");
+		return ret;
+	}
+
+	ret = device_register(&iucv_root);
+	if (ret != 0) {
+		printk(KERN_ERR "IUCV: failed to register iucv root.\n");
+		bus_unregister(&iucv_bus);
+		return ret;
+	}
+
 	/* Note: GFP_DMA used used to get memory below 2G */
 	iucv_external_int_buffer = kmalloc(sizeof(iucv_GeneralInterrupt),
 					   GFP_KERNEL|GFP_DMA);
@@ -401,6 +433,8 @@
 		kfree(iucv_external_int_buffer);
 	if (iucv_param_pool)
 		kfree(iucv_param_pool);
+	device_unregister(&iucv_root);
+	bus_unregister(&iucv_bus);
 	printk(KERN_INFO "IUCV lowlevel driver unloaded\n");
 }
 
@@ -528,9 +562,8 @@
  *	   - ENOMEM - storage allocation for a new pathid table failed
 */
 static int
-iucv_add_pathid(__u16 pathid, handler *handler)
+__iucv_add_pathid(__u16 pathid, handler *handler)
 {
-	ulong flags;
 
 	iucv_debug(1, "entering");
 
@@ -539,21 +572,30 @@
 	if (pathid > (max_connections - 1))
 		return -EINVAL;
 
-	spin_lock_irqsave (&iucv_lock, flags);
 	if (iucv_pathid_table[pathid]) {
-		spin_unlock_irqrestore (&iucv_lock, flags);
 		iucv_debug(1, "pathid entry is %p", iucv_pathid_table[pathid]);
 		printk(KERN_WARNING
 		       "%s: Pathid being used, error.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 	iucv_pathid_table[pathid] = handler;
-	spin_unlock_irqrestore (&iucv_lock, flags);
 
 	iucv_debug(1, "exiting");
 	return 0;
 }				/* end of add_pathid function */
 
+static int
+iucv_add_pathid(__u16 pathid, handler *handler)
+{
+	ulong flags;
+	int rc;
+
+	spin_lock_irqsave (&iucv_lock, flags);
+	rc = __iucv_add_pathid(pathid, handler);
+	spin_unlock_irqrestore (&iucv_lock, flags);
+	return rc;
+}
+
 static void
 iucv_remove_pathid(__u16 pathid)
 {
@@ -1090,15 +1132,18 @@
 		EBC_TOUPPER(parm->iptarget, sizeof(parm->iptarget));
 	}
 
+	spin_lock_irqsave (&iucv_lock, flags);
 	parm->ipflags1 = (__u8)flags1;
 	b2f0_result = b2f0(CONNECT, parm);
+	if (b2f0_result == 0)
+		add_pathid_result = __iucv_add_pathid(parm->ippathid, h);
+	spin_unlock_irqrestore (&iucv_lock, flags);
 
 	if (b2f0_result) {
 		release_param(parm);
 		return b2f0_result;
 	}
 
-	add_pathid_result = iucv_add_pathid(parm->ippathid, h);
 	*pathid = parm->ippathid;
 
 	if (msglim)
@@ -2171,8 +2216,6 @@
 {
 	iucv_irqdata *irqdata;
 
-	irq_enter();
-
 	irqdata = kmalloc(sizeof(iucv_irqdata), GFP_ATOMIC);
 	if (!irqdata) {
 		printk(KERN_WARNING "%s: out of memory\n", __FUNCTION__);
@@ -2188,9 +2231,6 @@
 	spin_unlock(&iucv_irq_queue_lock);
 
 	tasklet_schedule(&iucv_tasklet);
-
-	irq_exit();
-	return;
 }
 
 /**
@@ -2407,6 +2447,8 @@
  * 	  using them or should some of them be made
  * 	  static / removed? pls review. Arnd
  */
+EXPORT_SYMBOL (iucv_bus);
+EXPORT_SYMBOL (iucv_root);
 EXPORT_SYMBOL (iucv_accept);
 EXPORT_SYMBOL (iucv_connect);
 #if 0
diff -urN linux-2.6/drivers/s390/net/iucv.h linux-2.6-s390/drivers/s390/net/iucv.h
--- linux-2.6/drivers/s390/net/iucv.h	Mon Sep  8 21:50:43 2003
+++ linux-2.6-s390/drivers/s390/net/iucv.h	Thu Sep 25 18:33:31 2003
@@ -202,6 +202,9 @@
 	u32 length;
 } iucv_array_t __attribute__ ((aligned (8)));
 
+extern struct bus_type iucv_bus;
+extern struct device iucv_root;
+
 /*   -prototypes-    */
 /*                                                                
  * Name: iucv_register_program                                    
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Thu Sep 25 18:33:27 2003
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Thu Sep 25 18:33:31 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.20 2003/05/27 11:34:24 mschwide Exp $
+ * $Id: netiucv.c,v 1.26 2003/09/23 16:48:17 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,11 +30,10 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.20 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.26 $
  *
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -115,23 +114,6 @@
 /* Keep track of interfaces. */
 static int ifno;
 
-static int
-iucv_bus_match (struct device *dev, struct device_driver *drv)
-{
-	return 0;
-}
-
-/* Hm - move to iucv.c and export? - CH */
-static struct bus_type iucv_bus = {
-	.name = "iucv",
-	.match = iucv_bus_match,
-};	
-
-static struct device iucv_root = {
-	.name   = "IUCV",
-	.bus_id = "iucv",
-};
-
 /**
  * Representation of event-data for the
  * connection state machine.
@@ -1255,6 +1237,16 @@
 #define CTRL_BUFSIZE 40
 
 static ssize_t
+user_show (struct device *dev, char *buf)
+{
+	struct netiucv_priv *priv = dev->driver_data;
+
+	return sprintf(buf, "%s\n", netiucv_printname(priv->conn->userid));
+}
+
+static DEVICE_ATTR(user, 0444, user_show, NULL);
+
+static ssize_t
 buffer_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
@@ -1437,6 +1429,7 @@
 
 static struct attribute *netiucv_attrs[] = {
 	&dev_attr_buffer.attr,
+	&dev_attr_user.attr,
 	NULL,
 };
 
@@ -1490,7 +1483,6 @@
 	int ret;
 	char *str = "netiucv";
 
-	snprintf(dev->name, DEVICE_NAME_SIZE, "%s", priv->conn->userid);
 	snprintf(dev->bus_id, BUS_ID_SIZE, "%s%x", str, ifno);
 	dev->bus = &iucv_bus;
 	dev->parent = &iucv_root;
@@ -1739,7 +1731,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.20 $";
+	char vbuf[] = "$Revision: 1.26 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -1763,7 +1755,6 @@
 
 	driver_remove_file(&netiucv_driver, &driver_attr_connection);
 	driver_unregister(&netiucv_driver);
-	bus_unregister(&iucv_bus);
 
 	printk(KERN_INFO "NETIUCV driver unloaded\n");
 	return;
@@ -1774,25 +1765,9 @@
 {
 	int ret;
 	
-	/* Move the bus stuff to iucv.c? - CH */
-	ret = bus_register(&iucv_bus);
-	if (ret != 0) {
-		printk(KERN_ERR "NETIUCV: failed to register bus.\n");
-		return ret;
-	}
-
 	ret = driver_register(&netiucv_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "NETIUCV: failed to register driver.\n");
-		bus_unregister(&iucv_bus);
-		return ret;
-	}
-
-	ret = device_register(&iucv_root);
-	if (ret != 0) {
-		printk(KERN_ERR "NETIUCV: failed to register iucv root.\n");
-		driver_unregister(&netiucv_driver);
-		bus_unregister(&iucv_bus);
 		return ret;
 	}
 
@@ -1803,9 +1778,7 @@
 		netiucv_banner();
 	else {
 		printk(KERN_ERR "NETIUCV: failed to add driver attribute.\n");
-		device_unregister(&iucv_root);
 		driver_unregister(&netiucv_driver);
-		bus_unregister(&iucv_bus);
 	}
 	return ret;
 }
