Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUDLO0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUDLOVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:21:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:23270 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262927AbUDLOT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:19:26 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 8/9
Date: Mon, 12 Apr 2004 09:19:15 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120919.15378.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-ioctl.c::retrieve_status(): Prevent overrunning the ioctl buffer by making
sure we don't call the target status routine with a buffer size limit of zero.
[Kevin Corry, Alasdair Kergon]

--- diff/drivers/md/dm-ioctl.c	2004-04-09 09:42:29.000000000 -0500
+++ source/drivers/md/dm-ioctl.c	2004-04-09 09:42:44.000000000 -0500
@@ -800,7 +800,7 @@
 		struct dm_target *ti = dm_table_get_target(table, i);
 
 		remaining = len - (outptr - outbuf);
-		if (remaining < sizeof(struct dm_target_spec)) {
+		if (remaining <= sizeof(struct dm_target_spec)) {
 			param->flags |= DM_BUFFER_FULL_FLAG;
 			break;
 		}
@@ -815,6 +815,10 @@
 
 		outptr += sizeof(struct dm_target_spec);
 		remaining = len - (outptr - outbuf);
+		if (remaining <= 0) {
+			param->flags |= DM_BUFFER_FULL_FLAG;
+			break;
+		}
 
 		/* Get the status/table string from the target driver */
 		if (ti->type->status) {
