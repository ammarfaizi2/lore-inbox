Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVGBTqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVGBTqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 15:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVGBTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 15:46:34 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:35495 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261267AbVGBTqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 15:46:16 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120331026.22021.2.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>  <1120325613.5073.16.camel@mulgrave>
	 <1120326423.22057.3.camel@localhost>  <1120329389.5073.21.camel@mulgrave>
	 <1120331026.22021.2.camel@localhost>
Content-Type: text/plain
Date: Sat, 02 Jul 2005 14:46:14 -0500
Message-Id: <1120333574.5073.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 20:03 +0100, Tony Vroon wrote:
> As you predicted, it tried but gave up.

Well, I've looked more closely at this.  There's no support in either
the core or the sequencer for IU or QAS, so I think the safe course is
just to strip them out of the transport parameters (I don't have the
sequencer docs anyway, so there's no way I can correct the problem).

This should, therefore, get the whole lot booting again.

James

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2633,6 +2633,11 @@ static void ahc_linux_set_dt(struct scsi
 	ahc_unlock(ahc, &flags);
 }
 
+#if 0
+/* FIXME: This code claims to support IU and QAS.  However, the actual
+ * sequencer code and aic7xxx_core have no support for these parameters and
+ * will get into a bad state if they're negotiated.  Do not enable this
+ * unless you know what you're doing */
 static void ahc_linux_set_qas(struct scsi_target *starget, int qas)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -2688,6 +2693,7 @@ static void ahc_linux_set_iu(struct scsi
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
 	ahc_unlock(ahc, &flags);
 }
+#endif
 
 static struct spi_function_template ahc_linux_transport_functions = {
 	.set_offset	= ahc_linux_set_offset,
@@ -2698,10 +2704,12 @@ static struct spi_function_template ahc_
 	.show_width	= 1,
 	.set_dt		= ahc_linux_set_dt,
 	.show_dt	= 1,
+#if 0
 	.set_iu		= ahc_linux_set_iu,
 	.show_iu	= 1,
 	.set_qas	= ahc_linux_set_qas,
 	.show_qas	= 1,
+#endif
 };
 
 


