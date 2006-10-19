Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945936AbWJSAxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945936AbWJSAxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423209AbWJSAxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:53:36 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:46905 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1423208AbWJSAxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:53:35 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=WfR7jhfEQavoS0hk+pb7h0DD75Jg06GgONPq8d095ljoYClONkFJ/Dqe1bHkA4tIdgIRtvDIodPl4WFNTit1hcbRCntpF+YND+2y+qqatxVQcfeiOqeYfpBQ0TrVUCzR;
X-IronPort-AV: i="4.09,326,1157346000"; 
   d="scan'208"; a="99797181:sNHT18223137"
Date: Wed, 18 Oct 2006 19:54:42 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware/dcdbas: add size check in smi_data_write
Message-ID: <20061019005441.GA8850@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a size check in smi_data_write to prevent possible wrapping problems with large pos values when calling smi_data_buf_realloc on 32-bit.

Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>

---

--- linux-2.6.19-rc2/drivers/firmware/dcdbas.c.orig	2006-10-18 18:52:43.000000000 -0500
+++ linux-2.6.19-rc2/drivers/firmware/dcdbas.c	2006-10-18 18:55:08.000000000 -0500
@@ -8,7 +8,7 @@
  *
  *  See Documentation/dcdbas.txt for more information.
  *
- *  Copyright (C) 1995-2005 Dell Inc.
+ *  Copyright (C) 1995-2006 Dell Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License v2.0 as published by
@@ -40,7 +40,7 @@
 #include "dcdbas.h"
 
 #define DRIVER_NAME		"dcdbas"
-#define DRIVER_VERSION		"5.6.0-2"
+#define DRIVER_VERSION		"5.6.0-3.2"
 #define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
 
 static struct platform_device *dcdbas_pdev;
@@ -175,6 +175,9 @@ static ssize_t smi_data_write(struct kob
 {
 	ssize_t ret;
 
+	if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
+		return -EINVAL;
+
 	mutex_lock(&smi_data_lock);
 
 	ret = smi_data_buf_realloc(pos + count);
