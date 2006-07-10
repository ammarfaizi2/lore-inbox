Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWGJBKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWGJBKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWGJBKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:10:52 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:51676 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964874AbWGJBKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:10:52 -0400
Message-ID: <44B1A8FA.5020607@myri.com>
Date: Sun, 09 Jul 2006 21:10:18 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>   All these functions return error codes, and we're not checking them.  We
>   should.  So there's a patch which marks all these things as __must_check,
>   which causes around 1,500 new warnings.
>   


Hi Andrew,

The following patch fixes such a warning in myri10ge.

thanks,
Brice


Check pci_enable_device() return value in myri10ge_resume().

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/net/myri10ge/myri10ge.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-mm/drivers/net/myri10ge/myri10ge.c
===================================================================
--- linux-mm.orig/drivers/net/myri10ge/myri10ge.c	2006-07-09 10:36:22.000000000 -0400
+++ linux-mm/drivers/net/myri10ge/myri10ge.c	2006-07-09 11:05:23.000000000 -0400
@@ -2412,14 +2412,20 @@
 		return -EIO;
 	}
 	myri10ge_restore_state(mgp);
-	pci_enable_device(pdev);
+
+	status = pci_enable_device(pdev);
+	if (status < 0) {
+		dev_err(&pdev->dev, "failed to enable device\n");
+		return -EIO;
+	}
+
 	pci_set_master(pdev);
 
 	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
 			     netdev->name, mgp);
 	if (status != 0) {
 		dev_err(&pdev->dev, "failed to allocate IRQ\n");
-		goto abort_with_msi;
+		goto abort_with_enabled;
 	}
 
 	myri10ge_reset(mgp);
@@ -2438,7 +2444,8 @@
 
 	return 0;
 
-abort_with_msi:
+abort_with_enabled:
+	pci_disable_device(pdev);
 	return -EIO;
 
 }


