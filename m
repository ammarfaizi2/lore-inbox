Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUD1Tou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUD1Tou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUD1Top
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:44:45 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:43500 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S264953AbUD1Qui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:50:38 -0400
Date: Wed, 28 Apr 2004 18:50:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/6): 3270 console driver.
Message-ID: <20040428165027.GE2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: 3270 driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

3270 device driver change:
 - Add missing irb error checking.

diffstat:
 drivers/s390/char/raw3270.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -urN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-s390/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/char/raw3270.c	Wed Apr 28 17:51:39 2004
@@ -345,8 +345,10 @@
 	rq = (struct raw3270_request *) intparm;
 	view = rq ? rq->view : rp->view;
 
-	if (irb->scsw.dstat == 
-	    (DEV_STAT_CHN_END | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP)) {
+	if (IS_ERR(irb))
+		rc = RAW3270_IO_RETRY;
+	else if (irb->scsw.dstat ==  (DEV_STAT_CHN_END | DEV_STAT_DEV_END |
+				      DEV_STAT_UNIT_EXCEP)) {
 		/* Handle CE-DE-UE and subsequent UDE */
 		set_bit(RAW3270_FLAGS_BUSY, &rp->flags);
 		rc = RAW3270_IO_BUSY;
