Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbTFRU4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTFRU4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:56:23 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:53942 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S265529AbTFRU4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:56:20 -0400
Message-Id: <200306182110.h5ILAAsG018450@ginger.cmf.nrl.navy.mil>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Mon, 02 Jun 2003 00:42:32 +0200."
             <20030602004232.A25795@electric-eye.fr.zoreil.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 18 Jun 2003 17:08:10 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030602004232.A25795@electric-eye.fr.zoreil.com>,Francois Romieu w
rites:
>An unconditional HE_SPIN_UNLOCK(he_dev, flags); stands behind the
>'close_tx_incomplete' label in he_close(). The following patch should cure
>a possible unlock of a non-locked lock (courtesy of kbugs.org, see
>http://kbugs.org/cgi-bin/index.py?page=source&version=2.5.70&file=drivers/atm/
>he.c#line2840).

dave, please apply the following patch:

[atm]: he: cure possible unlock of a non-locked lock

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1333  -> 1.1334 
#	    drivers/atm/he.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	chas@relax.cmf.nrl.navy.mil	1.1334
# fix possible unlock of a non-locked lock
# --------------------------------------------
#
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Wed Jun 18 17:07:21 2003
+++ b/drivers/atm/he.c	Wed Jun 18 17:07:21 2003
@@ -2685,12 +2685,13 @@
 		remove_wait_queue(&he_vcc->tx_waitq, &wait);
 		set_current_state(TASK_RUNNING);
 
+		spin_lock_irqsave(&he_dev->global_lock, flags);
+
 		if (timeout == 0) {
 			hprintk("close tx timeout cid 0x%x\n", cid);
 			goto close_tx_incomplete;
 		}
 
-		spin_lock_irqsave(&he_dev->global_lock, flags);
 		while (!((tsr4 = he_readl_tsr4(he_dev, cid)) & TSR4_SESSION_ENDED)) {
 			HPRINTK("close tx cid 0x%x !TSR4_SESSION_ENDED (tsr4 = 0x%x)\n", cid, tsr4);
 			udelay(250);
