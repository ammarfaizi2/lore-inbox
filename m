Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWDJXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWDJXjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWDJXjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:39:37 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:6592 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932179AbWDJXjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:39:36 -0400
From: Zach Brown <zach.brown@oracle.com>
To: linux-driver@qlogic.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Message-Id: <20060410233936.28628.13303.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH] [qla2xxx] only free_irq() after request_irq() succeeds
Date: Mon, 10 Apr 2006 16:39:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[qla2xxx] only free_irq() after request_irq() succeeds

If qla2x00_probe_one() fails before calling request_irq() but gets to
qla2x00_free_device() then it will mistakenly tree to free an irq it didn't
request.  It's chosing to free based on ha->pdev->irq which is always set.

host->irq is set after request_irq() succeeds so let's use that to decide
to free or not.

This was observed and tested when a silly set of circumstances lead to firmware
loading failing on a 2100.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 drivers/scsi/qla2xxx/qla_os.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.17-rc1-mm2-qlafreeirq/drivers/scsi/qla2xxx/qla_os.c
===================================================================
--- 2.6.17-rc1-mm2-qlafreeirq.orig/drivers/scsi/qla2xxx/qla_os.c
+++ 2.6.17-rc1-mm2-qlafreeirq/drivers/scsi/qla2xxx/qla_os.c
@@ -1700,8 +1700,8 @@ qla2x00_free_device(scsi_qla_host_t *ha)
 	ha->flags.online = 0;
 
 	/* Detach interrupts */
-	if (ha->pdev->irq)
-		free_irq(ha->pdev->irq, ha);
+	if (ha->host->irq)
+		free_irq(ha->host->irq, ha);
 
 	/* release io space registers  */
 	if (ha->iobase)
