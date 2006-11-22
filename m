Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756481AbWKVSxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbWKVSxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756485AbWKVSxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:53:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:63609 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756481AbWKVSxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:53:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=If99gonfRYn156CxxIYEJWmnYSeejON0Ajx3FIZsJGQf3zleEFf7kpKBMHdvQypUh1H1tfbDCKZUFXlmVYLdEbkG9iup0U40Ui678zRa5SnaX8rMFusob1fmW24phuo3uaU6OfRb2e8p3bUfQVMao08OoI0nY8y2njUBvsKAYYI=
Date: Thu, 23 Nov 2006 03:47:55 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata: fix platform_device_register_simple() error check
Message-ID: <20061122184755.GD2985@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Alan <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of platform_device_register_simple() should be checked
by IS_ERR().

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/ata/pata_legacy.c  |    4 +++-
 drivers/ata/pata_qdi.c     |    4 ++--
 drivers/ata/pata_winbond.c |    4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

Index: work-fault-inject/drivers/ata/pata_legacy.c
===================================================================
--- work-fault-inject.orig/drivers/ata/pata_legacy.c
+++ work-fault-inject/drivers/ata/pata_legacy.c
@@ -698,8 +698,10 @@ static __init int legacy_init_one(int po
 		goto fail_io;
 
 	pdev = platform_device_register_simple(DRV_NAME, nr_legacy_host, NULL, 0);
-	if (pdev == NULL)
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
 		goto fail_dev;
+	}
 
 	if (ht6560a & mask) {
 		ops = &ht6560a_port_ops;
Index: work-fault-inject/drivers/ata/pata_qdi.c
===================================================================
--- work-fault-inject.orig/drivers/ata/pata_qdi.c
+++ work-fault-inject/drivers/ata/pata_qdi.c
@@ -247,8 +247,8 @@ static __init int qdi_init_one(unsigned 
 	 */
 
 	pdev = platform_device_register_simple(DRV_NAME, nr_qdi_host, NULL, 0);
-	if (pdev == NULL)
-		return -ENOMEM;
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
 	memset(&ae, 0, sizeof(struct ata_probe_ent));
 	INIT_LIST_HEAD(&ae.node);
Index: work-fault-inject/drivers/ata/pata_winbond.c
===================================================================
--- work-fault-inject.orig/drivers/ata/pata_winbond.c
+++ work-fault-inject/drivers/ata/pata_winbond.c
@@ -206,8 +206,8 @@ static __init int winbond_init_one(unsig
 			 */
 
 			pdev = platform_device_register_simple(DRV_NAME, nr_winbond_host, NULL, 0);
-			if (pdev == NULL)
-				return -ENOMEM;
+			if (IS_ERR(pdev))
+				return PTR_ERR(pdev);
 
 			memset(&ae, 0, sizeof(struct ata_probe_ent));
 			INIT_LIST_HEAD(&ae.node);
