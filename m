Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWB0Wej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWB0Wej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWB0WcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39554 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932459AbWB0Wbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:55 -0500
Message-Id: <20060227223406.476841000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [patch 36/39] [PATCH] sbp2: fix another deadlock after disconnection
Content-Disposition: inline; filename=sbp2-fix-another-deadlock-after-disconnection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

sbp2: fix another deadlock after disconnection

If there were commands enqueued but not completed before an SBP-2 unit
was unplugged (or an attempt to reconnect failed), knodemgrd or any
process which tried to remove the device would sleep uninterruptibly
in blk_execute_rq().  Therefore make sure that all commands are
completed when sbp2 retreats.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Same as commit bf637ec3ef4159da3dd156ecf6f6987d8c8c5dae in Linus' tree.

 drivers/ieee1394/sbp2.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

--- linux-2.6.15.4.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.15.4/drivers/ieee1394/sbp2.c
@@ -650,9 +650,15 @@ static int sbp2_remove(struct device *de
 	if (!scsi_id)
 		return 0;
 
-	/* Trigger shutdown functions in scsi's highlevel. */
-	if (scsi_id->scsi_host)
+	if (scsi_id->scsi_host) {
+		/* Get rid of enqueued commands if there is no chance to
+		 * send them. */
+		if (!sbp2util_node_is_available(scsi_id))
+			sbp2scsi_complete_all_commands(scsi_id, DID_NO_CONNECT);
+		/* scsi_remove_device() will trigger shutdown functions of SCSI
+		 * highlevel drivers which would deadlock if blocked. */
 		scsi_unblock_requests(scsi_id->scsi_host);
+	}
 	sdev = scsi_id->sdev;
 	if (sdev) {
 		scsi_id->sdev = NULL;

--
