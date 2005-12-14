Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVLNS03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVLNS03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVLNS02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:26:28 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:57275 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbVLNS02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:26:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uGkkNHGGsvK33mHEUXBfBSpfm6JyWMWOzSHA3ieiHn/zxZ6/W+lS3Hey+JlZnQVlxQmld1q5nwGSFjqdaaVzBEmsiB6XieWzlKJ9KrQsQT6an6L9vvLXHEb4PvzLVAhMbYFjZUFq6Dj0E+K7zP4VauDwDgZJ0TK9yVr6bo7gA70=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: [PATCH] handle scsi_add_host failure for aic7xxx and fix compiler warning
Date: Wed, 14 Dec 2005 19:27:20 +0100
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
Message-Id: <200512141927.21144.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add scsi_add_host() failure handling for aic7xxx
Also silence a compiler warning : 
 drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_register_host':
 drivers/scsi/aic7xxx/aic7xxx_osm.c:1100: warning: ignoring return value of `scsi_add_host', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/aic7xxx/aic7xxx_osm.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

--- linux-2.6.15-rc5-git3-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-12-04 18:48:12.000000000 +0100
+++ linux-2.6.15-rc5-git3/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-12-14 19:13:58.000000000 +0100
@@ -1061,10 +1061,11 @@ uint32_t aic7xxx_verbose;
 int
 ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *template)
 {
-	char	 buf[80];
-	struct	 Scsi_Host *host;
+	char	buf[80];
+	struct	Scsi_Host *host;
 	char	*new_name;
-	u_long	 s;
+	u_long	s;
+	int	retval;
 
 	template->name = ahc->description;
 	host = scsi_host_alloc(template, sizeof(struct ahc_softc *));
@@ -1097,9 +1098,16 @@ ahc_linux_register_host(struct ahc_softc
 
 	host->transportt = ahc_linux_transport_template;
 
-	scsi_add_host(host, (ahc->dev_softc ? &ahc->dev_softc->dev : NULL)); /* XXX handle failure */
+	retval = scsi_add_host(host,
+			(ahc->dev_softc ? &ahc->dev_softc->dev : NULL));
+	if (retval) {
+		printk(KERN_WARNING "aic7xxx: scsi_add_host failed\n");
+		scsi_host_put(host);
+		return retval;
+	}
+
 	scsi_scan_host(host);
-	return (0);
+	return 0;
 }
 
 /*


