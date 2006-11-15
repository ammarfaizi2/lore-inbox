Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966629AbWKOCCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966629AbWKOCCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966628AbWKOCCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:02:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:23186 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S966622AbWKOCCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:02:09 -0500
Message-ID: <455A751F.4040607@us.ibm.com>
Date: Tue, 14 Nov 2006 18:02:07 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] aic94xx: delete ascb timers when freeing queues
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the aic94xx driver creates ascbs, each ascb is initialized with a
timeout timer.  If there are any ascbs left over when the driver is being
torn down, these timers need to be deleted.  In particular, we seem to
hit this case when ascbs are issued yet never end up on the done list.
Right now there's a sequencer bug that results in this happening every
so often.

CONTROL PHY commands are typically sent when things are really messed
up with the sequencer; however, any other leftover ascb should produce
loud warnings.

--

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 2148afd..c2c233d 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -727,6 +727,15 @@ static void asd_free_queues(struct asd_h
 
 	list_for_each_safe(pos, n, &pending) {
 		struct asd_ascb *ascb = list_entry(pos, struct asd_ascb, list);
+		/*
+		 * Delete unexpired ascb timers.  This may happen if we issue
+		 * a CONTROL PHY scb to an adapter and rmmod before the scb
+		 * times out.  Apparently we don't wait for the CONTROL PHY
+		 * to complete, so it doesn't matter if we kill the timer.
+		 */
+		del_timer_sync(&ascb->timer);
+		WARN_ON(ascb->scb->header.opcode != CONTROL_PHY);
+
 		list_del_init(pos);
 		ASD_DPRINTK("freeing from pending\n");
 		asd_ascb_free(ascb);
