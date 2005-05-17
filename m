Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVEQVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVEQVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVEQVG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:06:56 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:33247 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261953AbVEQVG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:06:27 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050517195650.GC9121@gmail.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com>
	 <1116359432.4989.48.camel@mulgrave>  <20050517195650.GC9121@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 17 May 2005 16:06:11 -0500
Message-Id: <1116363971.4989.51.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 21:56 +0200, Grégoire Favre wrote:
> On Tue, May 17, 2005 at 02:50:31PM -0500, James Bottomley wrote:
> 
> > Right, but the problem I think it will fix is the initial inquiry being
> > sent with the wrong transport parameters.
> > 
> > You have a different problem, I think ... it looks like your Toshiba DVD
> > does somthing strange during Domain Validation ... the question I don't
> > have an answer to yet, is what.
> 
> Oh, sorry, thank you for the patch :-)

Well, the attached is what I'd like you to try, capturing the
information from the initial inquiry on ... it will be quite a bit.

Hopefully it will give me a clearer idea of what's going on.

Thanks,

James

--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -669,14 +669,23 @@ spi_dv_retrain(struct scsi_request *sreq
 {
 	struct spi_internal *i = to_spi_internal(sreq->sr_host->transportt);
 	struct scsi_device *sdev = sreq->sr_device;
+	struct scsi_target *starget = sdev->sdev_target;
 	int period = 0, prevperiod = 0; 
 	enum spi_compare_returns retval;
 
 
 	for (;;) {
 		int newperiod;
+
 		retval = compare_fn(sreq, buffer, ptr, DV_LOOPS);
 
+		if(i->f->get_period)
+			i->f->get_period(starget);
+		if (i->f->get_offset)
+			i->f->get_offset(starget);
+
+		spi_display_xfer_agreement(starget);
+
 		if (retval == SPI_COMPARE_SUCCESS
 		    || retval == SPI_COMPARE_SKIP_TEST)
 			break;
@@ -765,6 +774,8 @@ spi_dv_device_internal(struct scsi_reque
 	/* first set us up for narrow async */
 	DV_SET(offset, 0);
 	DV_SET(width, 0);
+
+	printk("BEGINNING ASYNC, inq len = %d\n", sdev->inquiry_len);
 	
 	if (spi_dv_device_compare_inquiry(sreq, buffer, buffer, DV_LOOPS)
 	    != SPI_COMPARE_SUCCESS) {
@@ -773,11 +784,13 @@ spi_dv_device_internal(struct scsi_reque
 		return;
 	}
 
+	printk("ASYNC INQUIRY SUCCEEDED\n");
+
 	/* test width */
 	if (i->f->set_width && spi_max_width(starget) && sdev->wdtr) {
 		i->f->set_width(sdev->sdev_target, 1);
 
-		printk("WIDTH IS %d\n", spi_max_width(starget));
+		printk("TRYING WIDE ASYNC INQUIRY\n");
 
 		if (spi_dv_device_compare_inquiry(sreq, buffer,
 						   buffer + len,
@@ -802,12 +815,17 @@ spi_dv_device_internal(struct scsi_reque
 	if (sdev->ppr)
 		len = spi_dv_device_get_echo_buffer(sreq, buffer);
 
+	printk("ECHO BUFFER HAS LEN %d\n", len);
+
  retry:
 
 	/* now set up to the maximum */
 	DV_SET(offset, spi_max_offset(starget));
 	DV_SET(period, spi_min_period(starget));
 
+	printk("DV SETTING TO period %d, offset %d\n", spi_min_period(starget),
+	       spi_max_offset(starget));
+
 	if (len == 0) {
 		SPI_PRINTK(sdev->sdev_target, KERN_INFO, "Domain Validation skipping write tests\n");
 		spi_dv_retrain(sreq, buffer, buffer + len,


