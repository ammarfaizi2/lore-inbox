Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVGEJkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVGEJkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 05:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVGEJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 05:40:31 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:53459 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261772AbVGEJin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 05:38:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Date: Tue, 5 Jul 2005 18:59:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17098.19471.40130.621127@cse.unsw.edu.au>
Subject: Re: REGRESSION in 2.6.13-rc1: Massive slowdown with Adaptec SCSI
In-Reply-To: message from Neil Brown on Tuesday July 5
References: <17097.56705.490622.759154@cse.unsw.edu.au>
	<20050705012141.GB9312@parcelfarce.linux.theplanet.co.uk>
	<17097.57991.652937.849090@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 5, neilb@cse.unsw.edu.au wrote:
> On Tuesday July 5, matthew@wil.cx wrote:
> > On Tue, Jul 05, 2005 at 11:08:17AM +1000, Neil Brown wrote:
> > >  On 2.6.13-rc1 the same test takes just short on 1 minute and reports
> > >  slightly less than 2 M/Second.
> > 
> > That sounds like your drives have negotiated an asynchronous transfer
> > agreement.  Could you provide your dmesg to confirm that diagnosis?
> 
> Yes, that looks right.


I just noticed:


> From: James Bottomley <James.Bottomley@SteelEye.com>
> To: Tony Vroon <chainsaw@gentoo.org>
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
>         SCSI Mailing List <linux-scsi@vger.kernel.org>,
>         Andy Whitcroft <apw@shadowen.org>
> Subject: Re: aic7xxx regression occuring after 2.6.12 final
> Date: 	Sat, 02 Jul 2005 14:46:14 -0500

which had the following patch which fixes this problem nicely.  Sorry for the
extra noise.

(Thanks James)

NeilBrown


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
 
