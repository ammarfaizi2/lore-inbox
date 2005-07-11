Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVGKQkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVGKQkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGKQhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:37:39 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:22402 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262067AbVGKQfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:35:44 -0400
Date: Mon, 11 Jul 2005 18:35:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 6/12] s390: resource accessibility event handling.
Message-ID: <20050711163543.GF10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/12] s390: resource accessibility event handling.

From: Cornelia Huck <cohuck@de.ibm.com>

When processing resource accessibility events, continue searching for
further affected subchannels if a link address is provided in the
event information.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/chsc.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2005-07-11 17:37:30.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2005-07-11 17:37:46.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.119 $
+ *   $Revision: 1.120 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -412,11 +412,7 @@ s390_process_res_acc (u8 chpid, __u16 fl
 		if (chp_mask == 0) {
 
 			spin_unlock_irq(&sch->lock);
-
-			if (fla_mask != 0)
-				break;
-			else
-				continue;
+			continue;
 		}
 		old_lpm = sch->lpm;
 		sch->lpm = ((sch->schib.pmcw.pim &
@@ -430,7 +426,7 @@ s390_process_res_acc (u8 chpid, __u16 fl
 
 		spin_unlock_irq(&sch->lock);
 		put_device(&sch->dev);
-		if (fla_mask != 0)
+		if (fla_mask == 0xffff)
 			break;
 	}
 	return rc;
