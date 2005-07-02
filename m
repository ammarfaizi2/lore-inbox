Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVGBQWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVGBQWS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVGBQWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:22:18 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13734 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261203AbVGBQWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:22:05 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120318925.21935.9.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>
Content-Type: text/plain
Date: Sat, 02 Jul 2005 12:22:01 -0400
Message-Id: <1120321322.5073.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 16:42 +0100, Tony Vroon wrote:
> target0:0:0: asynchronous
>   Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
>  target0:0:0: Beginning Domain Validation
>  target0:0:0: wide asynchronous
> (scsi0:A:0): refuses tagged commands. Performing non-tagged I/O
>  target0:0:0: asynchronous
> [The PC hangs at this point]

Well, my best guess is that this is a double bug.  I think the
aic7xxx_core is processing the reject wrongly and the device is
rejecting a QAS or IU negotiation attempt.

So, see if the attached patch helps.

Thanks,

James

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -787,7 +787,8 @@ spi_dv_device_internal(struct scsi_devic
 	}
 
 	/* test width */
-	if (i->f->set_width && spi_max_width(starget) && sdev->wdtr) {
+	if (i->f->set_width && spi_max_width(starget) &&
+	    scsi_device_wide(sdev)) {
 		i->f->set_width(starget, 1);
 
 		if (spi_dv_device_compare_inquiry(sdev, buffer,
@@ -803,14 +804,14 @@ spi_dv_device_internal(struct scsi_devic
 		return;
 
 	/* device can't handle synchronous */
-	if (!sdev->ppr && !sdev->sdtr)
+	if (!scsi_device_sync(sdev) && !scsi_device_dt(sdev))
 		return;
 
 	/* see if the device has an echo buffer.  If it does we can
 	 * do the SPI pattern write tests */
 
 	len = 0;
-	if (sdev->ppr)
+	if (scsi_device_dt(sdev))
 		len = spi_dv_device_get_echo_buffer(sdev, buffer);
 
  retry:
@@ -820,9 +821,11 @@ spi_dv_device_internal(struct scsi_devic
 	DV_SET(period, spi_min_period(starget));
 	/* try QAS requests; this should be harmless to set if the
 	 * target supports it */
-	DV_SET(qas, 1);
+	if (scsi_device_qas(sdev))
+		DV_SET(qas, 1);
 	/* Also try IU transfers */
-	DV_SET(iu, 1);
+	if (scsi_device_ius(sdev))
+		DV_SET(iu, 1);
 	if (spi_min_period(starget) < 9) {
 		/* This u320 (or u640). Ignore the coupled parameters
 		 * like DT and IU, but set the optional ones */


