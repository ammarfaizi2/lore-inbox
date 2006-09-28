Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWI1QJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWI1QJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWI1QIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:08:04 -0400
Received: from mx.pathscale.com ([64.160.42.68]:63413 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751827AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 28] IB/ipath - only allow complete writes to flash
X-Mercurial-Node: 934e5c1d6adecef606f877e543962c79ef55b7d4
Message-Id: <934e5c1d6adecef606f8.1159459205@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:05 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow a write to the eeprom from ipathfs unless the write is exactly
128 bytes and starts at offset 0.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r cc3350eeb557 -r 934e5c1d6ade drivers/infiniband/hw/ipath/ipath_fs.c
--- a/drivers/infiniband/hw/ipath/ipath_fs.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c	Thu Sep 28 08:57:12 2006 -0700
@@ -357,18 +357,15 @@ static ssize_t flash_write(struct file *
 
 	pos = *ppos;
 
-	if ( pos < 0) {
+	if (pos != 0) {
 		ret = -EINVAL;
 		goto bail;
 	}
 
-	if (pos >= sizeof(struct ipath_flash)) {
-		ret = 0;
-		goto bail;
-	}
-
-	if (count > sizeof(struct ipath_flash) - pos)
-		count = sizeof(struct ipath_flash) - pos;
+	if (count != sizeof(struct ipath_flash)) {
+		ret = -EINVAL;
+		goto bail;
+	}
 
 	tmp = kmalloc(count, GFP_KERNEL);
 	if (!tmp) {
