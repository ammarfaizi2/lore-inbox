Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbUKKSuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUKKSuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbUKKRUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:20:04 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:51955 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262298AbUKKRPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:15:43 -0500
Date: Thu, 11 Nov 2004 18:15:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/10] s390: dasd driver.
Message-ID: <20041111171533.GE4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/10] s390: dasd driver.

From: Stefan Weinhuber <wein@de.ibm.com>

dasd driver changes:
 - Fix parameter parsing to allow sequences of devices, ranges
   and keywords.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd_devmap.c |  170 +++++++++++++++++++++++----------------
 1 files changed, 103 insertions(+), 67 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2004-10-18 23:54:27.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2004-11-11 15:06:55.000000000 +0100
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.30 $
+ * $Revision: 1.33 $
  */
 
 #include <linux/config.h>
@@ -204,94 +204,130 @@
 }
 
 /*
- * Read comma separated list of dasd ranges.
+ * Try to match the first element on the comma separated parse string
+ * with one of the known keywords. If a keyword is found, take the approprate
+ * action and return a pointer to the residual string. If the first element
+ * could not be matched to any keyword then return an error code.
+ */
+static char *
+dasd_parse_keyword( char *parsestring ) {
+
+	char *nextcomma, *residual_str;
+	int length;
+
+	nextcomma = strchr(parsestring,',');
+	if (nextcomma) {
+		length = nextcomma - parsestring;
+		residual_str = nextcomma + 1;
+	} else {
+		length = strlen(parsestring);
+		residual_str = parsestring + length;
+        }
+	if (strncmp ("autodetect", parsestring, length) == 0) {
+		dasd_autodetect = 1;
+		MESSAGE (KERN_INFO, "%s",
+			 "turning to autodetection mode");
+                return residual_str;
+        }
+        if (strncmp ("probeonly", parsestring, length) == 0) {
+		dasd_probeonly = 1;
+		MESSAGE(KERN_INFO, "%s",
+			"turning to probeonly mode");
+                return residual_str;
+        }
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * Try to interprete the first element on the comma separated parse string
+ * as a device number or a range of devices. If the interpretation is
+ * successfull, create the matching dasd_devmap entries and return a pointer
+ * to the residual string.
+ * If interpretation fails or in case of an error, return an error code.
  */
-static inline int
-dasd_ranges_list(char *str)
-{
+static char *
+dasd_parse_range( char *parsestring ) {
+
 	struct dasd_devmap *devmap;
 	int from, from_id0, from_id1;
 	int to, to_id0, to_id1;
 	int features, rc;
-	char bus_id[BUS_ID_SIZE+1], *orig_str;
+	char bus_id[BUS_ID_SIZE+1], *str;
 
-	orig_str = str;
-	while (1) {
-		rc = dasd_busid(&str, &from_id0, &from_id1, &from);
-		if (rc == 0) {
-			to = from;
-			to_id0 = from_id0;
-			to_id1 = from_id1;
-			if (*str == '-') {
-				str++;
-				rc = dasd_busid(&str, &to_id0, &to_id1, &to);
-			}
-		}
-		if (rc == 0 &&
-		    (from_id0 != to_id0 || from_id1 != to_id1 || from > to))
-			rc = -EINVAL;
-		if (rc) {
-			MESSAGE(KERN_ERR, "Invalid device range %s", orig_str);
-			return rc;
+	str = parsestring;
+	rc = dasd_busid(&str, &from_id0, &from_id1, &from);
+	if (rc == 0) {
+		to = from;
+		to_id0 = from_id0;
+		to_id1 = from_id1;
+		if (*str == '-') {
+			str++;
+			rc = dasd_busid(&str, &to_id0, &to_id1, &to);
 		}
-		features = dasd_feature_list(str, &str);
-		if (features < 0)
-			return -EINVAL;
-		while (from <= to) {
-			sprintf(bus_id, "%01x.%01x.%04x",
-				from_id0, from_id1, from++);
-			devmap = dasd_add_busid(bus_id, features);
-			if (IS_ERR(devmap))
-				return PTR_ERR(devmap);
-		}
-		if (*str != ',')
-			break;
-		str++;
-	}
-	if (*str != '\0') {
-		MESSAGE(KERN_WARNING,
-			"junk at end of dasd parameter string: %s\n", str);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/*
- * Parse a single dasd= parameter.
- */
-static int
-dasd_parameter(char *str)
-{
-	if (strcmp ("autodetect", str) == 0) {
-		dasd_autodetect = 1;
-		MESSAGE (KERN_INFO, "%s",
-			 "turning to autodetection mode");
-		return 0;
 	}
-	if (strcmp ("probeonly", str) == 0) {
-		dasd_probeonly = 1;
-		MESSAGE(KERN_INFO, "%s",
-			"turning to probeonly mode");
-		return 0;
+	if (rc == 0 &&
+	    (from_id0 != to_id0 || from_id1 != to_id1 || from > to))
+		rc = -EINVAL;
+	if (rc) {
+		MESSAGE(KERN_ERR, "Invalid device range %s", parsestring);
+		return ERR_PTR(rc);
 	}
-	/* turn off autodetect mode and scan for dasd ranges */
-	dasd_autodetect = 0;
-	return dasd_ranges_list(str);
+	features = dasd_feature_list(str, &str);
+	if (features < 0)
+		return ERR_PTR(-EINVAL);
+	while (from <= to) {
+		sprintf(bus_id, "%01x.%01x.%04x",
+			from_id0, from_id1, from++);
+		devmap = dasd_add_busid(bus_id, features);
+		if (IS_ERR(devmap))
+			return (char *)devmap;
+	}
+	if (*str == ',')
+		return str + 1;
+	if (*str == '\0')
+		return str;
+	MESSAGE(KERN_WARNING,
+		"junk at end of dasd parameter string: %s\n", str);
+	return ERR_PTR(-EINVAL);
+}
+
+static inline char *
+dasd_parse_next_element( char *parsestring ) {
+	char * residual_str;
+	residual_str = dasd_parse_keyword(parsestring);
+	if (!IS_ERR(residual_str))
+		return residual_str;
+	residual_str = dasd_parse_range(parsestring);
+	return residual_str;
 }
 
 /*
- * Parse parameters stored in dasd[] and dasd_disciplines[].
+ * Parse parameters stored in dasd[]
+ * The 'dasd=...' parameter allows to specify a comma separated list of
+ * keywords and device ranges. When the dasd driver is build into the kernel,
+ * the complete list will be stored as one element of the dasd[] array.
+ * When the dasd driver is build as a module, then the list is broken into
+ * it's elements and each dasd[] entry contains one element.
  */
 int
 dasd_parse(void)
 {
 	int rc, i;
+	char *parsestring;
 
 	rc = 0;
 	for (i = 0; i < 256; i++) {
 		if (dasd[i] == NULL)
 			break;
-		rc = dasd_parameter(dasd[i]);
+		parsestring = dasd[i];
+		/* loop over the comma separated list in the parsestring */
+		while (*parsestring) {
+			parsestring = dasd_parse_next_element(parsestring);
+			if(IS_ERR(parsestring)) {
+				rc = PTR_ERR(parsestring);
+				break;
+			}
+		}
 		if (rc) {
 			DBF_EVENT(DBF_ALERT, "%s", "invalid range found");
 			break;
