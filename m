Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbULAPtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbULAPtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbULAPtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:49:55 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:15769 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261278AbULAPtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:49:47 -0500
Date: Wed, 1 Dec 2004 16:49:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: akpm@osdl.org
Cc: tspat@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/1] s390: qeth network driver fix.
Message-ID: <20041201154934.GA18591@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thomas created the patch below which removes the hardcoded 3900 bytes
limit as suggested by Jeff Garzik. Please apply.

Thanks,
Heiko

-----

[patch 1/1] s390: qeth network driver fix.

From: Thomas Spatzier <tspat@de.ibm.com>

network driver changes:
 - qeth: Calculate end of sysfs data buffer correctly.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 drivers/s390/net/qeth_sys.c |   69 +++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 35 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2004-12-01 15:39:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2004-12-01 15:39:54.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.38 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.40 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.38 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.40 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -876,30 +876,31 @@
 {
 	struct qeth_ipato_entry *ipatoe;
 	unsigned long flags;
-	char addr_str[49];
+	char addr_str[40];
+	int entry_len; /* length of 1 entry string, differs between v4 and v6 */
 	int i = 0;
 
 	if (qeth_check_layer2(card))
 		return -EPERM;
 
+	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
+	/* add strlen for "/<mask>\n" */
+	entry_len += (proto == QETH_PROT_IPV4)? 5 : 6;
 	spin_lock_irqsave(&card->ip_lock, flags);
 	list_for_each_entry(ipatoe, &card->ipato.entries, entry){
 		if (ipatoe->proto != proto)
 			continue;
-		/* String must not be longer than PAGE_SIZE. So we check for
-		 * length >= 3900 here. Then we can savely display the next
-		 * IPv6 address and our info message below */
-		if (i >= 3900) {
-			i += sprintf(buf + i,
-				     "... Too many entries to be displayed. "
-				     "Skipping remaining entries.\n");
+		/* String must not be longer than PAGE_SIZE. So we check if
+		 * string length gets near PAGE_SIZE. Then we can savely display
+		 * the next IPv6 address (worst case, compared to IPv4) */
+		if ((PAGE_SIZE - i) <= entry_len)
 			break;
-		}
 		qeth_ipaddr_to_string(proto, ipatoe->addr, addr_str);
-		i += sprintf(buf + i, "%s/%i\n", addr_str, ipatoe->mask_bits);
+		i += snprintf(buf + i, PAGE_SIZE - i,
+			      "%s/%i\n", addr_str, ipatoe->mask_bits);
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
-	i += sprintf(buf + i, "\n");
+	i += snprintf(buf + i, PAGE_SIZE - i, "\n");
 
 	return i;
 }
@@ -1131,33 +1132,32 @@
 			enum qeth_prot_versions proto)
 {
 	struct qeth_ipaddr *ipaddr;
-	char addr_str[49];
+	char addr_str[40];
+	int entry_len; /* length of 1 entry string, differs between v4 and v6 */
 	unsigned long flags;
 	int i = 0;
 
 	if (qeth_check_layer2(card))
 		return -EPERM;
 
+	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
+	entry_len += 2; /* \n + terminator */
 	spin_lock_irqsave(&card->ip_lock, flags);
 	list_for_each_entry(ipaddr, &card->ip_list, entry){
 		if (ipaddr->proto != proto)
 			continue;
 		if (ipaddr->type != QETH_IP_TYPE_VIPA)
 			continue;
-		/* String must not be longer than PAGE_SIZE. So we check for
-		 * length >= 3900 here. Then we can savely display the next
-		 * IPv6 address and our info message below */
-		if (i >= 3900) {
-			i += sprintf(buf + i,
-				     "... Too many entries to be displayed. "
-				     "Skipping remaining entries.\n");
+		/* String must not be longer than PAGE_SIZE. So we check if
+		 * string length gets near PAGE_SIZE. Then we can savely display
+		 * the next IPv6 address (worst case, compared to IPv4) */
+		if ((PAGE_SIZE - i) <= entry_len)
 			break;
-		}
 		qeth_ipaddr_to_string(proto, (const u8 *)&ipaddr->u, addr_str);
-		i += sprintf(buf + i, "%s\n", addr_str);
+		i += snprintf(buf + i, PAGE_SIZE - i, "%s\n", addr_str);
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
-	i += sprintf(buf + i, "\n");
+	i += snprintf(buf + i, PAGE_SIZE - i, "\n");
 
 	return i;
 }
@@ -1313,33 +1313,32 @@
 		       enum qeth_prot_versions proto)
 {
 	struct qeth_ipaddr *ipaddr;
-	char addr_str[49];
+	char addr_str[40];
+	int entry_len; /* length of 1 entry string, differs between v4 and v6 */
 	unsigned long flags;
 	int i = 0;
 
 	if (qeth_check_layer2(card))
 		return -EPERM;
 
+	entry_len = (proto == QETH_PROT_IPV4)? 12 : 40;
+	entry_len += 2; /* \n + terminator */
 	spin_lock_irqsave(&card->ip_lock, flags);
 	list_for_each_entry(ipaddr, &card->ip_list, entry){
 		if (ipaddr->proto != proto)
 			continue;
 		if (ipaddr->type != QETH_IP_TYPE_RXIP)
 			continue;
-		/* String must not be longer than PAGE_SIZE. So we check for
-		 * length >= 3900 here. Then we can savely display the next
-		 * IPv6 address and our info message below */
-		if (i >= 3900) {
-			i += sprintf(buf + i,
-				     "... Too many entries to be displayed. "
-				     "Skipping remaining entries.\n");
+		/* String must not be longer than PAGE_SIZE. So we check if
+		 * string length gets near PAGE_SIZE. Then we can savely display
+		 * the next IPv6 address (worst case, compared to IPv4) */
+		if ((PAGE_SIZE - i) <= entry_len)
 			break;
-		}
 		qeth_ipaddr_to_string(proto, (const u8 *)&ipaddr->u, addr_str);
-		i += sprintf(buf + i, "%s\n", addr_str);
+		i += snprintf(buf + i, PAGE_SIZE - i, "%s\n", addr_str);
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
-	i += sprintf(buf + i, "\n");
+	i += snprintf(buf + i, PAGE_SIZE - i, "\n");
 
 	return i;
 }
