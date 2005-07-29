Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVG2RQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVG2RQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVG2ROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:14:35 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:63641 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262620AbVG2RMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:12:25 -0400
Date: Fri, 29 Jul 2005 19:12:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/4] s390: device recognition.
Message-ID: <20050729171223.GA5720@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

Close a small window where a device may be not operational again after
senseid finished and the "same device" check fails due to dev=0000 by
checking for dnv after stsch() by then setting the device to not
operational. (No need to check for dnv in ccw_device_handle_oper() again
since we don't do stsch() into the subchannel's schib in the meantime
and will get a crw anyway if the device becomes not oper again).

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/device_fsm.c |    3 +++
 1 files changed, 3 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2005-07-29 18:43:39.000000000 +0200
@@ -235,6 +235,9 @@ ccw_device_recog_done(struct ccw_device 
 		sch->schib.pmcw.pam &
 		sch->schib.pmcw.pom &
 		sch->opm;
+	/* Check since device may again have become not operational. */
+	if (!sch->schib.pmcw.dnv)
+		state = DEV_STATE_NOT_OPER;
 	if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID)
 		/* Force reprobe on all chpids. */
 		old_lpm = 0;
