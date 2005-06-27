Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVF0MmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVF0MmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVF0MlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:41:25 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:2789 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262024AbVF0MQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:06 -0400
Message-Id: <20050627121415.255291000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:29 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-firmware-error-handling-fixes3.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 29/51] ttpci: error handling fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change error handling in av7110_stop_feed() to stop as
many filters as possible in case of errors.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:21.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:22.000000000 +0200
@@ -1050,8 +1050,7 @@ static int av7110_stop_feed(struct dvb_d
 {
 	struct dvb_demux *demux = feed->demux;
 	struct av7110 *av7110 = demux->priv;
-
-	int ret = 0;
+	int i, rc, ret = 0;
 	dprintk(4, "%p\n", av7110);
 
 	if (feed->type == DMX_TYPE_TS) {
@@ -1072,17 +1071,17 @@ static int av7110_stop_feed(struct dvb_d
 	}
 
 	if (!ret && feed->type == DMX_TYPE_SEC) {
-		int i;
-
-		for (i = 0; i<demux->filternum; i++)
+		for (i = 0; i<demux->filternum; i++) {
 			if (demux->filter[i].state == DMX_STATE_GO &&
 			    demux->filter[i].filter.parent == &feed->feed.sec) {
 				demux->filter[i].state = DMX_STATE_READY;
 				if (demux->dmx.frontend->source != DMX_MEMORY_FE) {
-					ret = StopHWFilter(&demux->filter[i]);
-					if (ret)
-						break;
+					rc = StopHWFilter(&demux->filter[i]);
+					if (!ret)
+						ret = rc;
+					/* keep going, stop as many filters as possible */
 				}
+			}
 		}
 	}
 

--

