Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUFBLBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUFBLBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUFBLBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:01:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:17346 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261724AbUFBKxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:53:17 -0400
Date: Wed, 2 Jun 2004 12:53:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/4): network device driver.
Message-ID: <20040602105318.GE7108@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Network driver changes:
 - iucv: Fix special case of a "Connection Pending" interrupt within
   iucv_do_int.
 - netiucv: Revoke broken iucvMagic change for more than one connection.
 - qeth: Fix string parsing in notifier_register attribute function.
 - qeth: Add code for socket ioctl SIOC_QETH_GET_CARD_TYPE.
 - qeth: Fix debug log entry and buffer copy in qeth_snmp_command_cb.
 - qeth: Fix race on qeth_dbf_txt_buf.

diffstat:
 drivers/s390/net/iucv.c      |    9 +++++----
 drivers/s390/net/netiucv.c   |   25 ++++++++-----------------
 drivers/s390/net/qeth.h      |   14 +++++++++-----
 drivers/s390/net/qeth_main.c |   30 ++++++++++++++++++------------
 drivers/s390/net/qeth_sys.c  |   16 +++++++++-------
 5 files changed, 49 insertions(+), 45 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Wed Jun  2 11:29:39 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.32 2004/05/18 09:28:43 braunu Exp $
+ * $Id: iucv.c,v 1.33 2004/05/24 10:19:18 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.32 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.33 $
  *
  */
 
@@ -352,7 +352,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.32 $";
+	char vbuf[] = "$Revision: 1.33 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -2368,7 +2368,8 @@
 					iucv_debug(2,
 						   "found a matching handler");
 					break;
-				}
+				} else
+					h = NULL;
 			}
 			spin_unlock_irqrestore (&iucv_lock, flags);
 			if (h) {
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Wed Jun  2 11:29:39 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.53 2004/05/07 14:29:37 mschwide Exp $
+ * $Id: netiucv.c,v 1.54 2004/05/28 08:04:14 braunu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.53 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.54 $
  *
  */
 
@@ -60,7 +60,6 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/ebcdic.h>
 
 #include "iucv.h"
 #include "fsm.h"
@@ -167,10 +166,10 @@
 }
 
 static __u8 iucv_host[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
-//static __u8 iucvMagic[16] = {
-//	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
-//	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
-//};
+static __u8 iucvMagic[16] = {
+	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
+	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
+};
 
 /**
  * This mask means the 16-byte IUCV "magic" and the origin userid must
@@ -769,18 +768,10 @@
 	struct iucv_event *ev = (struct iucv_event *)arg;
 	struct iucv_connection *conn = ev->conn;
 	__u16 msglimit;
-	int rc, len;
-	__u8 iucvMagic[16] = {
-	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
-        0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
-	};
+	int rc;
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
-	len = (IFNAMSIZ < sizeof(conn->netdev->name)) ?
-		IFNAMSIZ : sizeof(conn->netdev->name);
-	memcpy(iucvMagic, conn->netdev->name, len);
-	ASCEBC (iucvMagic, len);
 	if (conn->handle == 0) {
 		conn->handle =
 			iucv_register_program(iucvMagic, conn->userid, mask,
@@ -1958,7 +1949,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.53 $";
+	char vbuf[] = "$Revision: 1.54 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Wed Jun  2 11:29:39 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.108 $"
+#define VERSION_QETH_H 		"$Revision: 1.109 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -91,10 +91,14 @@
 		debug_event(qeth_dbf_##name,level,(void*)(addr),len); \
 	} while (0)
 
-#define QETH_DBF_TEXT_(name,level,text...)				  \
-	do {								  \
-		sprintf(qeth_dbf_text_buf, text);			  \
-		debug_text_event(qeth_dbf_##name,level,qeth_dbf_text_buf);\
+extern DEFINE_PER_CPU(char[256], qeth_dbf_txt_buf);
+
+#define QETH_DBF_TEXT_(name,level,text...)				\
+	do {								\
+		char* dbf_txt_buf = get_cpu_var(qeth_dbf_txt_buf);	\
+		sprintf(dbf_txt_buf, text);			  	\
+		debug_text_event(qeth_dbf_##name,level,dbf_txt_buf);	\
+		put_cpu_var(qeth_dbf_txt_buf);				\
 	} while (0)
 
 #define QETH_DBF_SPRINTF(name,level,text...) \
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Wed Jun  2 11:29:39 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.112 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.118 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.112 $	 $Date: 2004/05/19 09:28:21 $
+ *    $Revision: 1.118 $	 $Date: 2004/06/02 06:34:52 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.112 $"
+#define VERSION_QETH_C "$Revision: 1.118 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -91,7 +91,8 @@
 static debug_info_t *qeth_dbf_trace = NULL;
 static debug_info_t *qeth_dbf_sense = NULL;
 static debug_info_t *qeth_dbf_qerr = NULL;
-static char qeth_dbf_text_buf[255];
+
+DEFINE_PER_CPU(char[256], qeth_dbf_txt_buf);
 
 /**
  * some more definitions and declarations
@@ -4182,9 +4183,10 @@
 	}
 	data_len = *((__u16*)QETH_IPA_PDU_LEN_PDU1(data));
 	if (cmd->data.setadapterparms.hdr.seq_no == 1)
-		data_len -= (__u16)((char*)&snmp->request - (char *)cmd);
-	else
 		data_len -= (__u16)((char *)&snmp->data - (char *)cmd);
+	else
+		data_len -= (__u16)((char*)&snmp->request - (char *)cmd);
+
 	/* check if there is enough room in userspace */
 	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
 		QETH_DBF_TEXT_(trace, 4, "scer3%i", -ENOMEM);
@@ -4193,15 +4195,17 @@
 	}
 	QETH_DBF_TEXT_(trace, 4, "snore%i",
 		       cmd->data.setadapterparms.hdr.used_total);
-	QETH_DBF_TEXT_(trace, 4, "sseqn%i", cmd->data.setassparms.hdr.seq_no);
+	QETH_DBF_TEXT_(trace, 4, "sseqn%i", cmd->data.setadapterparms.hdr.seq_no);
 	/*copy entries to user buffer*/
 	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
 		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)snmp,offsetof(struct qeth_snmp_cmd,data));
+		       (char *)snmp,
+		       data_len + offsetof(struct qeth_snmp_cmd,data));
 		qinfo->udata_offset += offsetof(struct qeth_snmp_cmd, data);
+	} else {
+		memcpy(qinfo->udata + qinfo->udata_offset,
+		       (char *)&snmp->request, data_len);
 	}
-	memcpy(qinfo->udata + qinfo->udata_offset,
-	       (char *)&snmp->data, data_len);
 	qinfo->udata_offset += data_len;
 	/* check if all replies received ... */
 		QETH_DBF_TEXT_(trace, 4, "srtot%i",
@@ -4212,7 +4216,6 @@
 	    cmd->data.setadapterparms.hdr.used_total)
 		return 1;
 	return 0;
-
 }
 
 static struct qeth_cmd_buffer *
@@ -4280,7 +4283,6 @@
 	 else
 		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
 
-
 	kfree(qinfo.udata);
 	return rc;
 }
@@ -4476,6 +4478,10 @@
 		rc = qeth_snmp_command(card, rq->ifr_ifru.ifru_data);
 		break;
 	case SIOC_QETH_GET_CARD_TYPE:
+		if ((card->info.type == QETH_CARD_TYPE_OSAE) &&
+		    !card->info.guestlan)
+			return 1;
+		return 0;
 		break;
 	case SIOCGMIIPHY:
 		mii_data = (struct mii_ioctl_data *) &rq->ifr_ifru.ifru_data;
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-s390/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_sys.c	Wed Jun  2 11:29:39 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.30 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.32 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.30 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.32 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -1447,14 +1447,16 @@
 {
 	int rc;
 	int signum;
-	char *tmp;
+	char *tmp, *tmp2;
 
 	tmp = strsep((char **) &buf, "\n");
-	if (!strcmp(tmp, "unregister")){
-		return qeth_notifier_unregister(current);
+	if (!strncmp(tmp, "unregister", 10)){
+		if ((rc = qeth_notifier_unregister(current)))
+			return rc;
+		return count;
 	}
 
-	signum = simple_strtoul(buf, &tmp, 10);
+	signum = simple_strtoul(tmp, &tmp2, 10);
 	if ((signum < 0) || (signum > 32)){
 		PRINT_WARN("Signal number %d is out of range\n", signum);
 		return -EINVAL;
@@ -1465,7 +1467,7 @@
 	return count;
 }
 
-static DRIVER_ATTR(notifier_register, 0644, 0,
+static DRIVER_ATTR(notifier_register, 0200, 0,
 		   qeth_driver_notifier_register_store);
 
 int
