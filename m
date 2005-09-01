Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVIATi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVIATi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVIATi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:38:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31479 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965101AbVIATiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:38:25 -0400
Subject: [PATCH 2.6.13] Unhandled error condition in aic79xx
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 01 Sep 2005 12:38:21 -0700
Message-Id: <1125603501.4867.21.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should handle the case when scsi_add_host() fails.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-31 18:49:09.000000000 +0000
@@ -1989,6 +1989,7 @@ ahd_linux_register_host(struct ahd_softc
 	char	*new_name;
 	u_long	s;
 	u_long	target;
+	int error = 0;
 
 	template->name = ahd->description;
 	host = scsi_host_alloc(template, sizeof(struct ahd_softc *));
@@ -2065,7 +2066,11 @@ ahd_linux_register_host(struct ahd_softc
 	ahd_unlock(ahd, &s);
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
+	error = scsi_add_host(host, &ahd->dev_softc->dev); 
+	if (error) {
+		scsi_host_put(host);
+		return(error);
+	}
 	scsi_scan_host(host);
 #endif
 	return (0);


