Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTIYRtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbTIYRZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:25:59 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:13004 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261346AbTIYRVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:21:42 -0400
Date: Thu, 25 Sep 2003 19:21:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (13/19): ctc driver.
Message-ID: <20030925172101.GN2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Add type attribute.
 - Remove initialization of device.name.
 - Remove unnecessary include.

diffstat:
 drivers/s390/net/ctcmain.c |   31 ++++++++++++++++++++++---------
 drivers/s390/net/ctctty.h  |    3 +--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Thu Sep 25 18:33:27 2003
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Thu Sep 25 18:33:31 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.43 2003/05/27 11:34:23 mschwide Exp $
+ * $Id: ctcmain.c,v 1.47 2003/09/22 13:40:51 cohuck Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.43 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.47 $
  *
  */
 
@@ -102,7 +102,7 @@
 #define READ			0
 #define WRITE			1
 
-#define CTC_ID_SIZE             DEVICE_ID_SIZE+3
+#define CTC_ID_SIZE             BUS_ID_SIZE+3
 
 
 struct ctc_profile {
@@ -272,7 +272,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.43 $";
+	char vbuf[] = "$Revision: 1.47 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -1791,7 +1791,7 @@
 	ch->ccw[7].cda = 0;
 
 	ch->cdev = cdev;
-	snprintf(ch->id, DEVICE_ID_SIZE, "ch-%s", cdev->dev.bus_id);
+	snprintf(ch->id, CTC_ID_SIZE, "ch-%s", cdev->dev.bus_id);
 	ch->type = type;
 	ch->fsm = init_fsm(ch->id, ch_state_names,
 			   ch_event_names, NR_CH_STATES, NR_CH_EVENTS,
@@ -2786,8 +2786,23 @@
 
 static DEVICE_ATTR(protocol, 0644, ctc_proto_show, ctc_proto_store);
 
+static ssize_t
+ctc_type_show(struct device *dev, char *buf)
+{
+	struct ccwgroup_device *cgdev;
+
+	cgdev = to_ccwgroupdev(dev);
+	if (!cgdev)
+		return -ENODEV;
+
+	return sprintf(buf, "%s\n", cu3088_type[cgdev->cdev[0]->id.driver_info]);
+}
+
+static DEVICE_ATTR(type, 0444, ctc_type_show, NULL);
+
 static struct attribute *ctc_attr[] = {
 	&dev_attr_protocol.attr,
+	&dev_attr_type.attr,
 	NULL,
 };
 
@@ -2845,8 +2860,6 @@
 	cgdev->dev.driver_data = priv;
 	cgdev->cdev[0]->dev.driver_data = priv;
 	cgdev->cdev[1]->dev.driver_data = priv;
-	snprintf(cgdev->dev.name, DEVICE_NAME_SIZE, "%s",
-		 cu3088_type[cgdev->cdev[0]->id.driver_info]);
 
 	return 0;
 }
@@ -2875,8 +2888,8 @@
 
 	type = get_channel_type(&cgdev->cdev[0]->id);
 	
-	snprintf(read_id, DEVICE_ID_SIZE, "ch-%s", cgdev->cdev[0]->dev.bus_id);
-	snprintf(write_id, DEVICE_ID_SIZE, "ch-%s", cgdev->cdev[1]->dev.bus_id);
+	snprintf(read_id, CTC_ID_SIZE, "ch-%s", cgdev->cdev[0]->dev.bus_id);
+	snprintf(write_id, CTC_ID_SIZE, "ch-%s", cgdev->cdev[1]->dev.bus_id);
 
 	if (add_channel(cgdev->cdev[0], type))
 		return -ENOMEM;
diff -urN linux-2.6/drivers/s390/net/ctctty.h linux-2.6-s390/drivers/s390/net/ctctty.h
--- linux-2.6/drivers/s390/net/ctctty.h	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/drivers/s390/net/ctctty.h	Thu Sep 25 18:33:31 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.h,v 1.3 2002/10/24 16:42:55 cohuck Exp $
+ * $Id: ctctty.h,v 1.4 2003/09/18 08:01:10 mschwide Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -24,7 +24,6 @@
 #ifndef _CTCTTY_H_
 #define _CTCTTY_H_
 
-#include <linux/version.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 
