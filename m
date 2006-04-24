Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWDXPEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWDXPEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWDXPEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:04:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11552 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750860AbWDXPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:04:02 -0400
Date: Mon, 24 Apr 2006 17:04:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, horst.hummel@de.ibm.com
Subject: [patch 6/13] s390: dasd ioctl never returns.
Message-ID: <20060424150405.GG15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 6/13] s390: dasd ioctl never returns.

The dasd state machine is not designed to enable an unformatted device,
since 'unformatted' is a final state. The BIODASDENABLE ioctl calls
dasd_enable_device() which never returns if the device is in this
special state. Return -EPERM in dasd_increase_state for unformatted
devices to make dasd_enable_device terminate.
Note: To get such an unformatted device online it has to be re-analyzed. 
This means that the device needs to be disabled prior to re-enablement. 

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-04-24 16:47:23.000000000 +0200
@@ -315,6 +315,11 @@ dasd_increase_state(struct dasd_device *
 		rc = dasd_state_basic_to_ready(device);
 
 	if (!rc &&
+	    device->state == DASD_STATE_UNFMT &&
+	    device->target > DASD_STATE_UNFMT)
+		rc = -EPERM;
+
+	if (!rc &&
 	    device->state == DASD_STATE_READY &&
 	    device->target >= DASD_STATE_ONLINE)
 		rc = dasd_state_ready_to_online(device);
