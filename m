Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKJMqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKJMqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKJMqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:46:47 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63138 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750727AbVKJMqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:46:45 -0500
Date: Thu, 10 Nov 2005 13:49:02 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/7] s390: synthax checking for VIPA addresses fixed
Message-ID: <20051110124902.GA7936@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/7] s390: synthax checking for VIPA addresses fixed

From: Peter Tiedemann <ptiedem@de.ibm.com>
	- synthax checking for VIPA addresses fixed

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth.h     |   65 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 qeth_sys.c |    6 ++---
 2 files changed, 55 insertions(+), 16 deletions(-)


diff -Naupr orig/drivers/s390/net/qeth.h patched-linux/drivers/s390/net/qeth.h
--- orig/drivers/s390/net/qeth.h	2005-11-09 20:06:57.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth.h	2005-11-09 20:11:20.000000000 +0100
@@ -8,6 +8,7 @@
 #include <linux/trdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/ctype.h>
 
 #include <net/ipv6.h>
 #include <linux/in6.h>
@@ -24,7 +25,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.142 $"
+#define VERSION_QETH_H 		"$Revision: 1.151 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -1074,6 +1075,26 @@ qeth_get_qdio_q_format(struct qeth_card 
 	}
 }
 
+static inline int
+qeth_isdigit(char * buf)
+{
+	while (*buf) {
+		if (!isdigit(*buf++))
+			return 0;
+	}
+	return 1;
+}
+
+static inline int
+qeth_isxdigit(char * buf)
+{
+	while (*buf) {
+		if (!isxdigit(*buf++))
+			return 0;
+	}
+	return 1;
+}
+
 static inline void
 qeth_ipaddr4_to_string(const __u8 *addr, char *buf)
 {
@@ -1090,18 +1111,27 @@ qeth_string_to_ipaddr4(const char *buf, 
 	int i;
 
 	start = buf;
-	for (i = 0; i < 3; i++) {
-		if (!(end = strchr(start, '.')))
+	for (i = 0; i < 4; i++) {
+		if (i == 3) {
+			end = strchr(start,0xa);
+			if (end)
+				len = end - start;
+			else		
+				len = strlen(start);
+		}
+		else {
+			end = strchr(start, '.');
+			len = end - start;
+		}
+		if ((len <= 0) || (len > 3))
 			return -EINVAL;
-		len = end - start;
 		memset(abuf, 0, 4);
 		strncpy(abuf, start, len);
+		if (!qeth_isdigit(abuf))
+			return -EINVAL;
 		addr[i] = simple_strtoul(abuf, &tmp, 10);
 		start = end + 1;
 	}
-	memset(abuf, 0, 4);
-	strcpy(abuf, start);
-	addr[3] = simple_strtoul(abuf, &tmp, 10);
 	return 0;
 }
 
@@ -1128,18 +1158,27 @@ qeth_string_to_ipaddr6(const char *buf, 
 
 	tmp_addr = (u16 *)addr;
 	start = buf;
-	for (i = 0; i < 7; i++) {
-		if (!(end = strchr(start, ':')))
+	for (i = 0; i < 8; i++) {
+		if (i == 7) {
+			end = strchr(start,0xa);
+			if (end)
+				len = end - start;
+			else
+				len = strlen(start);
+		}
+		else {
+			end = strchr(start, ':');
+			len = end - start;
+		}
+		if ((len <= 0) || (len > 4))
 			return -EINVAL;
-		len = end - start;
 		memset(abuf, 0, 5);
 		strncpy(abuf, start, len);
+		if (!qeth_isxdigit(abuf))
+			return -EINVAL;
 		tmp_addr[i] = simple_strtoul(abuf, &tmp, 16);
 		start = end + 1;
 	}
-	memset(abuf, 0, 5);
-	strcpy(abuf, start);
-	tmp_addr[7] = simple_strtoul(abuf, &tmp, 16);
 	return 0;
 }
 
diff -Naupr orig/drivers/s390/net/qeth_sys.c patched-linux/drivers/s390/net/qeth_sys.c
--- orig/drivers/s390/net/qeth_sys.c	2005-11-09 20:06:57.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth_sys.c	2005-11-09 20:11:59.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.55 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.58 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.55 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.58 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -1117,7 +1117,7 @@ qeth_parse_ipatoe(const char* buf, enum 
 	start = buf;
 	/* get address string */
 	end = strchr(start, '/');
-	if (!end){
+	if (!end || (end-start >= 49)){
 		PRINT_WARN("Invalid format for ipato_addx/delx. "
 			   "Use <ip addr>/<mask bits>\n");
 		return -EINVAL;
