Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbULPXjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbULPXjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbULPXjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:39:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:13267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262193AbULPXjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:39:36 -0500
Date: Thu, 16 Dec 2004 15:39:24 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2/2] USB: avoid OHCI autosuspend on some boxes
Message-ID: <20041216233924.GB10997@kroah.com>
References: <20041216233815.GA10997@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216233815.GA10997@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't try autosuspend if we think the hardware won't resume correctly
from the OHCI suspend state.  This makes the RWC bit serve double duty,
but that appears to work OK, and the only penalty is increased power
consumption (from OHCI clocks) on boards/chips that don't work right.

For example, the amd756 erratum 4 workaround needs this logic; and at
least one ServerWorks box issues spurious resume IRQs (~3x/second!)
in the suspend state.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
--- a/drivers/usb/host/ohci-hub.c	2004-12-16 15:36:00 -08:00
+++ b/drivers/usb/host/ohci-hub.c	2004-12-16 15:36:00 -08:00
@@ -305,7 +305,7 @@
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	int		ports, i, changed = 0, length = 1;
-	int		can_suspend = 1;
+	int		can_suspend = hcd->can_wakeup;
 	unsigned long	flags;
 
 	spin_lock_irqsave (&ohci->lock, flags);
