Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755907AbWKQVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbWKQVGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755912AbWKQVGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:06:14 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49568 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755907AbWKQVBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:18 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 03/15] aic94xx: Delete ascb timers when freeing queues
Date: Fri, 17 Nov 2006 13:07:46 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210746.17052.25031.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the aic94xx driver creates ascbs, each ascb is initialized with a
timeout timer.  If there are any ascbs left over when the driver is being
torn down, these timers need to be deleted.  In particular, we seem to
hit this case when ascbs are issued yet never end up on the done list.
Right now there's a sequencer bug that results in this happening every
so often.  CONTROL PHY commands also use these per-ascb timers.

We also want to print a warning if there are leftover ascbs that are
not for CONTROL PHY commands.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/aic94xx/aic94xx_init.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index f7f009e..d9cf607 100644
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
