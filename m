Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTIVPxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTIVPxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:53:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41965 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263210AbTIVPwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:52:50 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com
Subject: [PATCH] DM 4/6: Return table status for dev_wait
Date: Mon, 22 Sep 2003 10:52:32 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200309221044.21694.kevcorry@us.ibm.com>
In-Reply-To: <200309221044.21694.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221052.32601.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev_wait was meant to return table status not dev status.  [Alasdair Kergon]

--- diff/drivers/md/dm-ioctl-v4.c	2003-09-17 13:09:04.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-09-17 13:09:26.000000000 +0100
@@ -769,6 +769,7 @@
 {
 	int r;
 	struct mapped_device *md;
+	struct dm_table *table;
 	DECLARE_WAITQUEUE(wq, current);
 
 	md = find_device(param);
@@ -791,7 +792,16 @@
 	 * him and save an ioctl.
 	 */
 	r = __dev_status(md, param);
+	if (r)
+		goto out;
+
+	table = dm_get_table(md);
+	if (table) {
+		retrieve_status(table, param, param_size);
+		dm_table_put(table);
+	}
 
+ out:
 	dm_put(md);
 	return r;
 }

