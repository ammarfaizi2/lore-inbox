Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbUK0GDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUK0GDB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUK0Dqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:46:33 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17604 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262599AbUKZTfh (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:37 -0500
Date: Fri, 26 Nov 2004 11:30:21 +0100
From: Colin Leroy <colin@colino.net>
To: Linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Ohci-hcd: fix endless loop (second take)
Message-ID: <20041126113021.135e79df@pirandello>
X-Mailer: Sylpheed-Claws 0.9.12cvs169.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
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

It supercedes the previous one where 
.I hadn't noticed limit was unsigned,
.Decrementing limit was twice too fast,
.the goto was a bit useless.

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/usb/host/ohci-hcd.c	2004-11-26 11:28:21.284259057 +0100
+++ b/drivers/usb/host/ohci-hcd.c	2004-11-26 11:28:03.437351150 +0100
@@ -344,7 +344,7 @@
 	int			epnum = ep & USB_ENDPOINT_NUMBER_MASK;
 	unsigned long		flags;
 	struct ed		*ed;
-	unsigned		limit = 1000;
+	int			limit = 1000;
 
 	/* ASSERT:  any requests/urbs are being unlinked */
 	/* ASSERT:  nobody can be submitting urbs for this any more */
@@ -375,6 +375,11 @@
 		spin_unlock_irqrestore (&ohci->lock, flags);
 		set_current_state (TASK_UNINTERRUPTIBLE);
 		schedule_timeout (1);
+		if (limit < 1000) {
+			ohci_warn (ohci, "Can't recover, restarting.\n");
+			ohci_restart(ohci);
+			return;
+		}
 		goto rescan;
 	case ED_IDLE:		/* fully unlinked */
 		if (list_empty (&ed->td_list)) {
