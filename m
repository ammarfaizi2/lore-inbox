Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVETCat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVETCat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 22:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVETCat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 22:30:49 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:12756 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261323AbVETCaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 22:30:35 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <428D4371.6020809@cybsft.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <428C030E.8030102@cybsft.com>
	 <1116476630.5867.2.camel@mulgrave>  <20050519095143.GA3972@in.ibm.com>
	 <1116546970.5037.137.camel@mulgrave>  <428D37CF.5070903@cybsft.com>
	 <1116551853.5037.145.camel@mulgrave>  <428D3E1C.2020802@cybsft.com>
	 <1116553229.5037.155.camel@mulgrave>  <428D4371.6020809@cybsft.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 21:30:13 -0500
Message-Id: <1116556213.5037.161.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 20:54 -0500, K.R. Foley wrote:
> the dt setting is 0. can't set it to 1, at least not so that you can see
> it stay that way. tried setting period to 12.5, stays at 25. min_period
> is set to 12.5 but doesn't seem to matter. what's next :)

Well, I think it's my fault.  I naively assumed the aic7xxx core setting
code would do the right thing with coupled parameters, which, as I read
through it, apparently it doesn't do.

My excuse is that I can't test any of this because my fastest aic7xxx
card is only a U2 ...

Could you try this, I think it does the correct thing with the coupled
parameters.

Thanks,

James

--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2679,6 +2679,11 @@ static void ahc_linux_set_period(struct 
 	if (offset == 0)
 		offset = MAX_OFFSET;
 
+	if (period < 9)
+		period = 9;	/* 12.5ns is our minimum */
+	if (period == 9)
+		ppr_options |= MSG_EXT_PPR_DT_REQ;
+
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
 
@@ -2764,6 +2769,12 @@ static void ahc_linux_set_dt(struct scsi
 	unsigned long flags;
 	struct ahc_syncrate *syncrate;
 
+	if (dt) {
+		period = 9;	/* 12.5ns is the only period valid for DT */
+		ppr_options |= MSG_EXT_PPR_DT_REQ;
+	} else if (period == 9)
+		period = 10;	/* if resetting DT, period must be >= 25ns */
+
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
 	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,AHC_SYNCRATE_DT);


