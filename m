Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVAWBx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVAWBx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVAWBx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:53:27 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49844 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261185AbVAWBxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:53:07 -0500
Subject: [PATCH] e100 locking up netconsole.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux NICS <linux.nics@intel.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 22 Jan 2005 20:52:26 -0500
Message-Id: <1106445146.11995.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working with Ingo's RT patched kernel, but I believe this
affects the mainline too.

If the transmit buffer of the e100 overflowed, then the system would
hang. This was caused because the e100 driver would stop the queue, and
find_skb in netpoll.c would then loop forever.  This is because the e100
net_poll would never start the queue again after the transmits have
completed.

For those that use the e100 and netconsole, all you need to do is a
sysreq 't' to lock up the system.

Here's the patch: (from Ingo's linux-2.6.11-rc2-V0.7.36-02, but should
be OK with 2.6.11-rc2)


Index: drivers/net/e100.c
===================================================================
--- drivers/net/e100.c	(revision 60)
+++ drivers/net/e100.c	(working copy)
@@ -1630,6 +1630,7 @@
 	struct nic *nic = netdev_priv(netdev);
 	e100_disable_irq(nic);
 	e100_intr(nic->pdev->irq, netdev, NULL);
+	e100_tx_clean(nic);
 	e100_enable_irq(nic);
 }
 #endif



-- Steve


