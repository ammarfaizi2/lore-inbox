Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264747AbTFAWip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbTFAWip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:38:45 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:4870 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264747AbTFAWio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:38:44 -0400
Date: Mon, 2 Jun 2003 00:42:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030602004232.A25795@electric-eye.fr.zoreil.com>
References: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Thu, May 29, 2003 at 12:09:54PM -0400
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An unconditional HE_SPIN_UNLOCK(he_dev, flags); stands behind the
'close_tx_incomplete' label in he_close(). The following patch should cure
a possible unlock of a non-locked lock (courtesy of kbugs.org, see
http://kbugs.org/cgi-bin/index.py?page=source&version=2.5.70&file=drivers/atm/he.c#line2840).

--- linux-2.5.70-1.1229.7.33-to-1.1330/drivers/atm/he.c	Mon Jun  2 00:33:38 2003
+++ linux-2.5.70-1.1229.7.33-to-1.1330/drivers/atm/he.c	Mon Jun  2 00:34:29 2003
@@ -2731,12 +2731,13 @@ he_close(struct atm_vcc *vcc)
 		remove_wait_queue(&he_vcc->tx_waitq, &wait);
 		set_current_state(TASK_RUNNING);
 
+		HE_SPIN_LOCK(he_dev, flags);
+
 		if (timeout == 0) {
 			hprintk("close tx timeout cid 0x%x\n", cid);
 			goto close_tx_incomplete;
 		}
 
-		HE_SPIN_LOCK(he_dev, flags);
 		while (!((tsr4 = he_readl_tsr4(he_dev, cid)) & TSR4_SESSION_ENDED)) {
 			HPRINTK("close tx cid 0x%x !TSR4_SESSION_ENDED (tsr4 = 0x%x)\n", cid, tsr4);
 			udelay(250);

