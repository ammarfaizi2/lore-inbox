Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVESEZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVESEZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 00:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVESEZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 00:25:04 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:61889 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262472AbVESEYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 00:24:30 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <428C030E.8030102@cybsft.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave>  <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave>  <428C030E.8030102@cybsft.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 23:23:50 -0500
Message-Id: <1116476630.5867.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 22:07 -0500, K.R. Foley wrote: 
> This also solves my problem that I reported in this thread
> http://marc.theaimsgroup.com/?l=linux-scsi&m=111422854418964&w=2

OK, I think the patch below is the extract of this.  Could you see if it
works by simply patching vanilla 2.6.12-rc4 with no other SCSI patches
(if it does, I'll push it for 2.6.12 final).

James

--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2300,6 +2300,30 @@ ahc_linux_alloc_target(struct ahc_softc 
 	targ->target = target;
 	targ->ahc = ahc;
 	ahc->platform_data->targets[target_offset] = targ;
+
+	/* FIXME: This code is just for a bug workaround in 2.6.12
+	 * The correct fix will be in 2.6.13 */
+	{
+		struct ahc_devinfo devinfo;
+		struct ahc_initiator_tinfo *tinfo;
+		struct ahc_tmode_tstate *tstate;
+		char my_channel = channel + 'A';
+		unsigned int our_id = ahc->our_id;
+		
+		if (channel)
+			our_id = ahc->our_id_b;
+
+		tinfo = ahc_fetch_transinfo(ahc, my_channel, ahc->our_id,
+					    targ->target, &tstate);
+		ahc_compile_devinfo(&devinfo, our_id, targ->target,
+				    CAM_LUN_WILDCARD, my_channel,
+				    ROLE_INITIATOR);
+		ahc_set_syncrate(ahc, &devinfo, NULL, 0, 0, 0,
+				 AHC_TRANS_GOAL, /*paused*/FALSE);
+		ahc_set_width(ahc, &devinfo, MSG_EXT_WDTR_BUS_8_BIT,
+			      AHC_TRANS_GOAL, /*paused*/FALSE);
+	}
+
 	return (targ);
 }
 


