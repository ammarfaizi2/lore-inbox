Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVF0Nhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVF0Nhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVF0Nc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:32:29 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:25061 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262076AbVF0MQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:51 -0400
Message-Id: <20050627121410.172610000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:03 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Beutner <p.beutner@gmx.net>
Content-Disposition: inline; filename=dvb-core-fe_read_status-race-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 03/51] core: fix race condition in FE_READ_STATUS ioctl
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Beutner <p.beutner@gmx.net>

Fix a race condition where an application which issued a FE_READ_STATUS
ioctl directly after FE_SET_FRONTEND would see an old status, i.e.
FE_READ_STATUS would be executed before the frontend thread
has even seen the tungin request from FE_SET_FRONTEND.

Signed-off-by: Peter Beutner <p.beutner@gmx.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_frontend.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-06-27 13:22:55.000000000 +0200
@@ -626,11 +626,21 @@ static int dvb_frontend_ioctl(struct ino
 		break;
 	}
 
-	case FE_READ_STATUS:
+	case FE_READ_STATUS: {
+		fe_status_t* status = parg;
+
+		/* if retune was requested but hasn't occured yet, prevent
+		 * that user get signal state from previous tuning */
+		if(fepriv->state == FESTATE_RETUNE) {
+			err=0;
+			*status = 0;
+			break;
+		}
+
 		if (fe->ops->read_status)
-			err = fe->ops->read_status(fe, (fe_status_t*) parg);
+			err = fe->ops->read_status(fe, status);
 		break;
-
+	}
 	case FE_READ_BER:
 		if (fe->ops->read_ber)
 			err = fe->ops->read_ber(fe, (__u32*) parg);

--

