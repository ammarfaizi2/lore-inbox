Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbUK0DAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbUK0DAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUK0CEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:04:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262763AbUKZThL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:11 -0500
Date: Thu, 25 Nov 2004 19:17:26 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
Subject: [PATCH] Ohci-hcd: fix endless loop
Message-ID: <20041125191726.5ca95299@jack.colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs172.1 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Following patch fixes an endless loop that happens after having
slept and resumed my iBook with a linux-wlan-ng controller plugged in,
removed the stick and plugged it back (getting "IRQ lossage" message).

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/usb/host/ohci-hcd.c	2004-11-25 19:00:25.000000000 +0100
+++ b/drivers/usb/host/ohci-hcd.c	2004-11-25 19:08:59.000000000 +0100
@@ -375,6 +375,11 @@
 		spin_unlock_irqrestore (&ohci->lock, flags);
 		set_current_state (TASK_UNINTERRUPTIBLE);
 		schedule_timeout (1);
+		if (limit-- < -1000) {
+			ohci_warn (ohci, "Couldn't recover\n");
+			ohci_restart(ohci);
+			goto bail;
+		}
 		goto rescan;
 	case ED_IDLE:		/* fully unlinked */
 		if (list_empty (&ed->td_list)) {
@@ -396,6 +401,7 @@
 	dev->ep [epnum] = NULL;
 done:
 	spin_unlock_irqrestore (&ohci->lock, flags);
+bail:
 	return;
 }
 
