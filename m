Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVB1Nyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVB1Nyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVB1Nys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:54:48 -0500
Received: from lumumba.luc.ac.be ([193.190.9.252]:33294 "EHLO
	lumumba.luc.ac.be") by vger.kernel.org with ESMTP id S261617AbVB1Nue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:50:34 -0500
Date: Mon, 28 Feb 2005 14:50:32 +0100
From: Panagiotis Issaris <takis@lumumba.luc.ac.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Possible VIA-Rhine free irq issue
Message-ID: <20050228145032.B32550@lumumba.luc.ac.be>
Reply-To: panagiotis.issaris@mech.kuleuven.ac.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems to me that in the VIA Rhine device driver the requested irq might
not be freed in case the alloc_ring() function fails. alloc_ring()
can fail with a ENOMEM return value because of possible
pci_alloc_consistent() failures.

This patch applies to 2.6.11-rc5-bk2.

diff -uprN linux-2.6.11-rc5-bk2/drivers/net/via-rhine.c linux-2.6.11-rc5-bk2-pi/drivers/net/via-rhine.c
--- linux-2.6.11-rc5-bk2/drivers/net/via-rhine.c	2005-02-28 13:44:37.000000000 +0100
+++ linux-2.6.11-rc5-bk2-pi/drivers/net/via-rhine.c	2005-02-28 13:44:31.000000000 +0100
@@ -1198,7 +1198,10 @@ static int rhine_open(struct net_device 
 
 	rc = alloc_ring(dev);
 	if (rc)
+	{
+		free_irq(rp->pdev->irq, dev);
 		return rc;
+	}
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
 	rhine_chip_reset(dev);


With friendly regards,
Takis
-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
