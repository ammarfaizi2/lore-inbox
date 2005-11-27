Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVK0ROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVK0ROE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 12:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVK0ROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 12:14:04 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:12162 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751117AbVK0ROC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 12:14:02 -0500
Message-ID: <4389E99A.8020204@sw.ru>
Date: Sun, 27 Nov 2005 20:15:06 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Stanislav Protassov <st@sw.com.sg>
Subject: [SCSI] aic7xxx: reset handler selects a wrong command
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050405020905090502040004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405020905090502040004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Justin

To transport scsi reset command to device aic7xxx reset handler looks at the
driver's pending_list and searches any proper command. However the search
condition has been inverted: ahc_match_scb() returns TRUE if a matched command
is found.
As a result the reset on required devices did not turn out well, a correctly
working neighbour device may be surprised by the reset. aic7xxx reset handler
reports about the success, but really the original situation is not corrected yet.

The problem has been found first on 2.4 kernels but still it is present in
latest 2.6 drivers too.

Marcelo, you can use this patch for 2.4 kernel tree.

Thank you,
        Vasily Averin
SWSoft Linux Kernel Team

[SCSI] aic7xxx: reset handler selects a wrong command

To transport scsi reset command to device aic7xxx reset handler looks at the
driver's pending_list and searches any proper command. However the search
condition has been inverted: ahc_match_scb() returns TRUE if a matched command
is found.
As a result the reset on required devices did not turn out well, a correctly
working neighbour device may be surprised by the reset. aic7xxx reset handler
reports about the success, but really the original situation is not corrected yet.

Signed-off-by: Vasily Averin <vvs@sw.ru>
---

--------------050405020905090502040004
Content-Type: text/plain;
 name="diff-drv-aic7xxx-20051127"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-drv-aic7xxx-20051127"

--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-11-27 18:05:03.000000000 +0300
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-11-27 18:06:36.000000000 +0300
@@ -2169,7 +2169,7 @@ ahc_linux_queue_recovery_cmd(struct scsi
 		  	if (ahc_match_scb(ahc, pending_scb, scmd_id(cmd),
 					  scmd_channel(cmd) + 'A',
 					  CAM_LUN_WILDCARD,
-					  SCB_LIST_NULL, ROLE_INITIATOR) == 0)
+					  SCB_LIST_NULL, ROLE_INITIATOR))
 				break;
 		}
 	}

--------------050405020905090502040004--
