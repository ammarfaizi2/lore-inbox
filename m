Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWCVPYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWCVPYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCVPYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:24:34 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10675 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751309AbWCVPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:24:33 -0500
Date: Wed, 22 Mar 2006 16:25:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, holzheu@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 18/24] s390: tape operation abortion leads to panic
Message-ID: <20060322152500.GR5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[patch 18/24] s390: tape operation abortion leads to panic

When a request is aborted because of a signal, we currently stop the request
via csh, but we do not wait for the interrupt of csh in any case. We free the
request structure and therefore when the interrupt for the csh operation is
presented, the request object is no longer valid and an invalid callback
pointer is used.
To fix this wait until the interrupt for csh arrives and until
wait_event_interruptible() does not return -ERESTARTSYS.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-03-22 14:36:33.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-03-22 14:36:33.000000000 +0100
@@ -1015,7 +1015,7 @@ tape_do_io_interruptible(struct tape_dev
 				wq,
 				(request->callback == NULL)
 			);
-		} while (rc != -ERESTARTSYS);
+		} while (rc == -ERESTARTSYS);
 
 		DBF_EVENT(3, "IO stopped on %08x\n", device->cdev_id);
 		rc = -ERESTARTSYS;
