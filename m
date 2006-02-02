Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWBBWkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWBBWkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWBBWkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:40:40 -0500
Received: from sipsolutions.net ([66.160.135.76]:53765 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932380AbWBBWkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:40:39 -0500
Subject: [RFC 2/4] firewire: dynamic cdev allocation below firewire major
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1138919238.3621.12.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 23:40:12 +0100
Message-Id: <1138920012.3621.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This  patch implements dynamic minor number allocation below the 171
major allocated for ieee1394. Since on today's systems one doesn't need
to have fixed device numbers any more we could just use any, but it's
probably still useful to use the ieee1394 major number for any firewire
related devices (like mem1394).

diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
index 25ef5a8..17afc3b 100644
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -29,10 +29,12 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/kdev_t.h>
 #include <linux/skbuff.h>
 #include <linux/suspend.h>
+#include <linux/cdev.h>
 
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -1053,9 +1055,14 @@ static int hpsbpkt_thread(void *__hi)
 	complete_and_exit(&khpsbpkt_complete, 0);
 }
 
+/* used further below, but needs to be here for initialisation */
+static spinlock_t used_minors_lock;
+
 static int __init ieee1394_init(void)
 {
 	int i, ret;
+	
+	spin_lock_init(&used_minors_lock);
 
 	skb_queue_head_init(&hpsbpkt_queue);
 
@@ -1197,6 +1204,47 @@ static void __exit ieee1394_cleanup(void
 module_init(ieee1394_init);
 module_exit(ieee1394_cleanup);
 
+/* dynamic minor allocation functions */
+static DECLARE_BITMAP(used_minors, IEEE1394_MINOR_DYNAMIC_COUNT);
+
+int hpsb_cdev_add(struct cdev *chardev)
+{
+	int minor, ret;
+
+	spin_lock(&used_minors_lock);
+	minor = find_first_zero_bit(used_minors, IEEE1394_MINOR_DYNAMIC_COUNT);
+	if (minor >= IEEE1394_MINOR_DYNAMIC_COUNT) {
+		spin_unlock(&used_minors_lock);
+		return -ENODEV;
+	}
+	set_bit(minor, used_minors);
+	spin_unlock(&used_minors_lock);
+
+	minor += IEEE1394_MINOR_DYNAMIC_FIRST;
+	ret = cdev_add(chardev, MKDEV(IEEE1394_MAJOR, minor), 1);
+	if (unlikely(ret)) {
+		spin_lock(&used_minors_lock);
+		clear_bit(minor-IEEE1394_MINOR_DYNAMIC_FIRST, used_minors);
+		spin_unlock(&used_minors_lock);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hpsb_cdev_add);
+
+void hpsb_cdev_del(struct cdev *chardev)
+{
+	dev_t dev;
+
+	BUG_ON(MAJOR(chardev->dev) != IEEE1394_MAJOR);
+	dev = chardev->dev;
+	cdev_del(chardev);
+
+	spin_lock(&used_minors_lock);
+	clear_bit(MINOR(dev) - IEEE1394_MINOR_DYNAMIC_FIRST, used_minors);
+	spin_unlock(&used_minors_lock);
+}
+EXPORT_SYMBOL_GPL(hpsb_cdev_del);
+
 /* Exported symbols */
 
 /** hosts.c **/
diff --git a/drivers/ieee1394/ieee1394_core.h b/drivers/ieee1394/ieee1394_core.h
index b354660..d248ed7 100644
--- a/drivers/ieee1394/ieee1394_core.h
+++ b/drivers/ieee1394/ieee1394_core.h
@@ -186,19 +186,38 @@ void hpsb_packet_received(struct hpsb_ho
  * 171:0-255, the various drivers must then cdev_add() their cdev
  * objects to handle their respective sub-regions.
  *
+ * Alternatively, drivers may use a dynamic minor number character
+ * device by using the functions hpsb_cdev_add and hpsb_cdev_del.
+ * hpsb_cdev_add requires an initialised struct cdev and will add
+ * it with cdev_add() automatically, reserving a new minor number
+ * for the new device (unless cdev_add() fails). It returns the
+ * status of cdev_add(), or -ENODEV if no minor could be allocated.
+ * 
+ * Currently 64 minor numbers are reserved for that, if necessary
+ * this number can be increased by simply adjusting the constant
+ * IEEE1394_MINOR_DYNAMIC_FIRST.
+ *
  * Minor device number block allocations:
  *
  * Block 0  (  0- 15)  raw1394
  * Block 1  ( 16- 31)  video1394
  * Block 2  ( 32- 47)  dv1394
  *
- * Blocks 3-14 free for future allocation
+ * Blocks 3-10 free for future allocation
  *
+ * Block 11 (176-191)  dynamic allocation region
+ * Block 12 (192-207)  dynamic allocation region
+ * Block 13 (208-223)  dynamic allocation region
+ * Block 14 (224-239)  dynamic allocation region
  * Block 15 (240-255)  reserved for drivers under development, etc.
  */
 
 #define IEEE1394_MAJOR			 171
 
+#define IEEE1394_MINOR_DYNAMIC_FIRST	176
+#define IEEE1394_MINOR_DYNAMIC_LAST	239
+#define IEEE1394_MINOR_DYNAMIC_COUNT	(IEEE1394_MINOR_DYNAMIC_LAST-IEEE1394_MINOR_DYNAMIC_FIRST+1)
+
 #define IEEE1394_MINOR_BLOCK_RAW1394	   0
 #define IEEE1394_MINOR_BLOCK_VIDEO1394	   1
 #define IEEE1394_MINOR_BLOCK_DV1394	   2
@@ -218,6 +237,11 @@ static inline unsigned char ieee1394_fil
 	return file->f_dentry->d_inode->i_cindex;
 }
 
+/* add a dynamic ieee1394 device */
+int hpsb_cdev_add(struct cdev *chardev);
+/* remove a dynamic ieee1394 device */
+void hpsb_cdev_del(struct cdev *chardev);
+
 extern int hpsb_disable_irm;
 
 /* Our sysfs bus entry */


