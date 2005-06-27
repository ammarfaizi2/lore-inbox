Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVF0Mwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVF0Mwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVF0MuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:50:10 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:6117 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262040AbVF0MQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:20 -0400
Message-Id: <20050627121415.695318000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:31 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Oliver Endriss <o.endriss@gmx.de>
Content-Disposition: inline; filename=dvb-ttpci-firmware-error-handling-fixes5.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 31/51] ttpci: make av7110_fe_lock_fix() retryable
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Endriss <o.endriss@gmx.de>

av7110_fe_lock_fix() modified in a way that it can be retried after -ERESTARTSYS

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:23.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:24.000000000 +0200
@@ -2038,15 +2038,13 @@ static int av7110_fe_lock_fix(struct av7
 	if (av7110->fe_synced == synced)
 		return 0;
 
-	av7110->fe_synced = synced;
-
 	if (av7110->playing)
 		return 0;
 
 	if (down_interruptible(&av7110->pid_mutex))
 		return -ERESTARTSYS;
 
-	if (av7110->fe_synced) {
+	if (synced) {
 		ret = SetPIDs(av7110, av7110->pids[DMX_PES_VIDEO],
 			av7110->pids[DMX_PES_AUDIO],
 			av7110->pids[DMX_PES_TELETEXT], 0,
@@ -2062,6 +2060,9 @@ static int av7110_fe_lock_fix(struct av7
 		}
 	}
 
+	if (!ret)
+		av7110->fe_synced = synced;
+
 	up(&av7110->pid_mutex);
 	return ret;
 }

--

