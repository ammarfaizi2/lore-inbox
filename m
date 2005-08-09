Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVHIAHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVHIAHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVHIAHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:07:44 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:58496 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932379AbVHIAHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:07:44 -0400
Subject: Re: 2.6.13-rc5-mm1 doesnt boot on x86_64
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, ashok.raj@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050808104206.42a51477.akpm@osdl.org>
References: <20050808094818.A17579@unix-os.sc.intel.com>
	 <20050808171126.GA32092@muc.de> <1123522409.5019.0.camel@mulgrave>
	 <20050808104206.42a51477.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 19:06:50 -0500
Message-Id: <1123546010.8235.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 10:42 -0700, Andrew Morton wrote:
> -mm has extra list_head debugging goodies.  I'd be suspecting a list_head
> corruption detected somewhere under spi_release_transport().

Aha, looking in wrong driver ... the problem actually appears to be a
double release of the transport template in aic79xx.  Try this patch

James

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -2326,8 +2326,6 @@ done:
 	return (retval);
 }
 
-static void ahd_linux_exit(void);
-
 static void ahd_linux_set_width(struct scsi_target *starget, int width)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -2772,7 +2770,7 @@ ahd_linux_init(void)
 	if (ahd_linux_detect(&aic79xx_driver_template) > 0)
 		return 0;
 	spi_release_transport(ahd_linux_transport_template);
-	ahd_linux_exit();
+
 	return -ENODEV;
 }
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2331,8 +2331,6 @@ ahc_platform_dump_card_state(struct ahc_
 {
 }
 
-static void ahc_linux_exit(void);
-
 static void ahc_linux_set_width(struct scsi_target *starget, int width)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);


