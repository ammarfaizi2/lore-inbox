Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUDLOXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbUDLOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:21:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5348 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262930AbUDLOTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:19:32 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 9/9
Date: Mon, 12 Apr 2004 09:19:22 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120919.22092.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Striped: Use an EMIT macro in the status function.

--- diff/drivers/md/dm-stripe.c	2004-04-03 21:37:06.000000000 -0600
+++ source/drivers/md/dm-stripe.c	2004-04-09 09:42:55.000000000 -0500
@@ -187,24 +187,24 @@
 			 status_type_t type, char *result, unsigned int maxlen)
 {
 	struct stripe_c *sc = (struct stripe_c *) ti->private;
-	int offset;
+	unsigned int sz = 0;
 	unsigned int i;
 	char buffer[32];
 
+#define EMIT(x...) sz += ((sz >= maxlen) ? \
+			  0 : scnprintf(result + sz, maxlen - sz, x))
+
 	switch (type) {
 	case STATUSTYPE_INFO:
 		result[0] = '\0';
 		break;
 
 	case STATUSTYPE_TABLE:
-		offset = scnprintf(result, maxlen, "%d " SECTOR_FORMAT,
-				  sc->stripes, sc->chunk_mask + 1);
+		EMIT("%d " SECTOR_FORMAT, sc->stripes, sc->chunk_mask + 1);
 		for (i = 0; i < sc->stripes; i++) {
 			format_dev_t(buffer, sc->stripe[i].dev->bdev->bd_dev);
-			offset +=
-			    scnprintf(result + offset, maxlen - offset,
-				     " %s " SECTOR_FORMAT, buffer,
-				     sc->stripe[i].physical_start);
+			EMIT(" %s " SECTOR_FORMAT, buffer,
+			     sc->stripe[i].physical_start);
 		}
 		break;
 	}
