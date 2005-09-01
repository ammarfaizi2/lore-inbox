Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVIATi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVIATi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVIATi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:38:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32247 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965182AbVIATi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:38:27 -0400
Subject: [PATCH 2.6.13] Unhandled error condition in aic7xxx
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 01 Sep 2005 12:38:24 -0700
Message-Id: <1125603504.4867.22.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch should handle the case when scsi_add_host() fails.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/scsi/aic7xxx/aic7xxx_osm.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-08-31 18:45:20.000000000 +0000
@@ -996,6 +996,7 @@ ahc_linux_register_host(struct ahc_softc
 	struct	 Scsi_Host *host;
 	char	*new_name;
 	u_long	 s;
+	int error = 0;
 
 	template->name = ahc->description;
 	host = scsi_host_alloc(template, sizeof(struct ahc_softc *));
@@ -1029,8 +1030,16 @@ ahc_linux_register_host(struct ahc_softc
 
 	host->transportt = ahc_linux_transport_template;
 
-	scsi_add_host(host, (ahc->dev_softc ? &ahc->dev_softc->dev : NULL)); /* XXX handle failure */
-	scsi_scan_host(host);
+	error = scsi_add_host(host, (ahc->dev_softc ? &ahc->dev_softc->dev : NULL));
+	if (error) {
+		/* 
+		 * Discard host variable on error.
+		 */
+		scsi_host_put(host);
+		return (error);
+	} 
+ 	scsi_scan_host(host);
+	
 	return (0);
 }
 


