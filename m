Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTIVPxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTIVPxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:53:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24771 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263207AbTIVPwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:52:20 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com
Subject: [PATCH] DM 3/6: Move retrieve_status function
Date: Mon, 22 Sep 2003 10:52:09 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200309221044.21694.kevcorry@us.ibm.com>
In-Reply-To: <200309221044.21694.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221052.09440.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move retrieve_status up so dev_wait() can use it.

--- diff/drivers/md/dm-ioctl-v4.c	2003-09-17 13:08:53.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-09-17 13:09:04.000000000 +0100
@@ -700,6 +700,69 @@
 }
 
 /*
+ * Build up the status struct for each target
+ */
+static void retrieve_status(struct dm_table *table,
+			    struct dm_ioctl *param, size_t param_size)
+{
+	unsigned int i, num_targets;
+	struct dm_target_spec *spec;
+	char *outbuf, *outptr;
+	status_type_t type;
+	size_t remaining, len, used = 0;
+
+	outptr = outbuf = get_result_buffer(param, param_size, &len);
+
+	if (param->flags & DM_STATUS_TABLE_FLAG)
+		type = STATUSTYPE_TABLE;
+	else
+		type = STATUSTYPE_INFO;
+
+	/* Get all the target info */
+	num_targets = dm_table_get_num_targets(table);
+	for (i = 0; i < num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(table, i);
+
+		remaining = len - (outptr - outbuf);
+		if (remaining < sizeof(struct dm_target_spec)) {
+			param->flags |= DM_BUFFER_FULL_FLAG;
+			break;
+		}
+
+		spec = (struct dm_target_spec *) outptr;
+
+		spec->status = 0;
+		spec->sector_start = ti->begin;
+		spec->length = ti->len;
+		strncpy(spec->target_type, ti->type->name,
+			sizeof(spec->target_type));
+
+		outptr += sizeof(struct dm_target_spec);
+		remaining = len - (outptr - outbuf);
+
+		/* Get the status/table string from the target driver */
+		if (ti->type->status) {
+			if (ti->type->status(ti, type, outptr, remaining)) {
+				param->flags |= DM_BUFFER_FULL_FLAG;
+				break;
+			}
+		} else
+			outptr[0] = '\0';
+
+		outptr += strlen(outptr) + 1;
+		used = param->data_start + (outptr - outbuf);
+
+		align_ptr(outptr);
+		spec->next = outptr - outbuf;
+	}
+
+	if (used)
+		param->data_size = used;
+
+	param->target_count = num_targets;
+}
+
+/*
  * Wait for a device to report an event
  */
 static int dev_wait(struct dm_ioctl *param, size_t param_size)
@@ -920,69 +983,6 @@
 }
 
 /*
- * Build up the status struct for each target
- */
-static void retrieve_status(struct dm_table *table,
-			    struct dm_ioctl *param, size_t param_size)
-{
-	unsigned int i, num_targets;
-	struct dm_target_spec *spec;
-	char *outbuf, *outptr;
-	status_type_t type;
-	size_t remaining, len, used = 0;
-
-	outptr = outbuf = get_result_buffer(param, param_size, &len);
-
-	if (param->flags & DM_STATUS_TABLE_FLAG)
-		type = STATUSTYPE_TABLE;
-	else
-		type = STATUSTYPE_INFO;
-
-	/* Get all the target info */
-	num_targets = dm_table_get_num_targets(table);
-	for (i = 0; i < num_targets; i++) {
-		struct dm_target *ti = dm_table_get_target(table, i);
-
-		remaining = len - (outptr - outbuf);
-		if (remaining < sizeof(struct dm_target_spec)) {
-			param->flags |= DM_BUFFER_FULL_FLAG;
-			break;
-		}
-
-		spec = (struct dm_target_spec *) outptr;
-
-		spec->status = 0;
-		spec->sector_start = ti->begin;
-		spec->length = ti->len;
-		strncpy(spec->target_type, ti->type->name,
-			sizeof(spec->target_type));
-
-		outptr += sizeof(struct dm_target_spec);
-		remaining = len - (outptr - outbuf);
-
-		/* Get the status/table string from the target driver */
-		if (ti->type->status) {
-			if (ti->type->status(ti, type, outptr, remaining)) {
-				param->flags |= DM_BUFFER_FULL_FLAG;
-				break;
-			}
-		} else
-			outptr[0] = '\0';
-
-		outptr += strlen(outptr) + 1;
-		used = param->data_start + (outptr - outbuf);
-
-		align_ptr(outptr);
-		spec->next = outptr - outbuf;
-	}
-
-	if (used)
-		param->data_size = used;
-
-	param->target_count = num_targets;
-}
-
-/*
  * Return the status of a device as a text string for each
  * target.
  */

