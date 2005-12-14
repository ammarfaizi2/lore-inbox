Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVLNS0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVLNS0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLNS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:26:37 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:57275 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932493AbVLNS0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:26:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J2ckQFMwPZE7fnHTXmEr+SXtRyMbFuYuXC+KHNY0EHzTGokVkUW+Ikgc70gEsGimnbRLGmbffA8Pfv3u5DfxZeJ1shrhFt85w7FMUiaAgHuRyJ11gMu6bb6qi2kdtkZ80FrPcO3Wqrb6VTH54DKYLTdNTfXISLLLHQxl887yb6E=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: [PATCH] handle scsi_add_host failure for aic79xx and fix compiler warning
Date: Wed, 14 Dec 2005 19:27:28 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       "Daniel M. Eischen" <deischen@iworks.interworks.org>,
       Doug Ledford <dledford@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141927.29163.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add scsi_add_host() failure handling for aic79xx
Also silence a compiler warning : 
 drivers/scsi/aic7xxx/aic79xx_osm.c: In function `ahd_linux_register_host':
 drivers/scsi/aic7xxx/aic79xx_osm.c:1099: warning: ignoring return value of `scsi_add_host', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/aic7xxx/aic79xx_osm.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5-git3-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-12-04 18:48:12.000000000 +0100
+++ linux-2.6.15-rc5-git3/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-12-14 19:14:41.000000000 +0100
@@ -1064,6 +1064,7 @@ ahd_linux_register_host(struct ahd_softc
 	struct	Scsi_Host *host;
 	char	*new_name;
 	u_long	s;
+	int	retval;
 
 	template->name = ahd->description;
 	host = scsi_host_alloc(template, sizeof(struct ahd_softc *));
@@ -1096,9 +1097,15 @@ ahd_linux_register_host(struct ahd_softc
 
 	host->transportt = ahd_linux_transport_template;
 
-	scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
+	retval = scsi_add_host(host, &ahd->dev_softc->dev);
+	if (retval) {
+		printk(KERN_WARNING "aic79xx: scsi_add_host failed\n");
+		scsi_host_put(host);
+		return retval;
+	}
+
 	scsi_scan_host(host);
-	return (0);
+	return 0;
 }
 
 uint64_t


