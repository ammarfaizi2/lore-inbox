Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVCQANp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVCQANp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVCQAMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:12:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:46226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262893AbVCPX4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:56:36 -0500
Date: Wed, 16 Mar 2005 15:55:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: dilinger@debian.org, jgarzik@pobox.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [8/9] Possible VIA-Rhine free irq issue
Message-ID: <20050316235545.GG5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Andres Salomon <dilinger@debian.org>

It seems to me that in the VIA Rhine device driver the requested irq might
not be freed in case the alloc_ring() function fails. alloc_ring()
can fail with a ENOMEM return value because of possible
pci_alloc_consistent() failures.
   
Updated to CodingStyle.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- 1.89/drivers/net/via-rhine.c	2005-01-10 08:52:27 -08:00
+++ edited/drivers/net/via-rhine.c	2005-03-11 15:18:25 -08:00
@@ -1197,8 +1197,10 @@ static int rhine_open(struct net_device 
 		       dev->name, rp->pdev->irq);
 
 	rc = alloc_ring(dev);
-	if (rc)
+	if (rc) {
+		free_irq(rp->pdev->irq, dev);
 		return rc;
+	}
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
 	rhine_chip_reset(dev);
