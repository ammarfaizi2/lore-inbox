Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271865AbRIQRHQ>; Mon, 17 Sep 2001 13:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271905AbRIQRHI>; Mon, 17 Sep 2001 13:07:08 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:1409 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271865AbRIQRG6>;
	Mon, 17 Sep 2001 13:06:58 -0400
Date: Mon, 17 Sep 2001 10:06:04 -0700
From: Patrick Mansfield <patman@sequent.com>
To: "conway, heather" <conway_heather@emc.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: v2.4.9 and sequential scan
Message-ID: <20010917100604.A15537@eng2.beaverton.ibm.com>
In-Reply-To: <2CE33F05597DD411AAE800D0B769587C04EA05FA@sryoung.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2CE33F05597DD411AAE800D0B769587C04EA05FA@sryoung.lss.emc.com>; from conway_heather@emc.com on Mon, Sep 17, 2001 at 09:07:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 09:07:25AM -0400, conway, heather wrote:
> Hi Alan,
> I tried two separate hosts, one with the aic7xxx driver using the AHA-2944UW
> and one with the qla2x00 driver, both running v2.4.9 attached to external
> storage.  Both hosts are set to 128 for the max # of SCSI disks top be
> laoded as modules and the kernel has been compiled, but no other patches or
> tweaks were applied to the kernel.  Both hosts panicked upon boot when
> trying to scan the external bus.  
> The host attached to the external storage via SCSI (aic7xxx) has The host
> attached via FC with the qla2x00 has only 24 devices assigned to it.  The
> qla2x00 driver reports trying to scan up to LUN 509 before timing out and
> panicking.  I have tried this a few times and I've seen the host scan up to
> LUN 814 with the qla2x00 driver.  I obtained a serial console trace from
> both hosts and have enclosed them.
> Any thoughts?  
> Thanks for the help.
> Heather

Heather -

EMC is in the device_list[] (in scsi_scan.c) as a sparse LUN device.

I don't quite follow your information about aic7xx and SCSI storage.

Doug Ledford posted a patch for this plus one other fix in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=98462326721779&w=2

If you look at the current setting of *max_dev_lun, it either jumps
around (for low values of max_scsi_luns, i.e. 1), or is incremented
by 1/2 of shpnt->max_lun until it reaches max_scsi_luns (for high
values of max_scsi_luns, i.e.  0xffffffff). It is currently modified 
(for sparse LUN or force LUN devices) only when you find a LUN, but
its value is set each time not just once.

Always setting it to shpnt->max_lun is not very bad - if max_lun is
high, you are on fibre/FCP, and scanning should be very fast
compared to SCSI.

Here's a patch if you want to try it out, it also sets *max_dev_lun
for the early sparse lun check (we don't need the duplicate setting
for the second sparse lun check, but it does return 1 there, so I
left the settings of *max_dev_lun and *sparse_lun).

I've compiled but haven't run with this patch, though I've previously
compiled and run when patched against an earlier version of the
kernel (2.4.5 or so).

--
Patrick Mansfield

--- linux-2.4.9/drivers/scsi/scsi_scan.c	Mon Aug 13 16:36:30 2001
+++ linux-2.4.9-maxlun/drivers/scsi/scsi_scan.c	Mon Sep 17 09:29:53 2001
@@ -579,7 +579,8 @@
 	bflags = get_device_flags (scsi_result);
 
 	if (bflags & BLIST_SPARSELUN) {
-	  *sparse_lun = 1;
+		*max_dev_lun = shpnt->max_lun;
+		*sparse_lun = 1;
 	}
 	/*
 	 * Check the peripheral qualifier field - this tells us whether LUNS
@@ -795,19 +796,7 @@
 	 * other settings, and scan all of them.
 	 */
 	if (bflags & BLIST_SPARSELUN) {
-		/*
-		 * Scanning MAX_SCSI_LUNS units would be a bad idea.
-		 * Any better idea?
-		 * I think we need REPORT LUNS in future to avoid scanning
-		 * of unused LUNs. But, that is another item.
-		 *
-		 * FIXME(eric) - perhaps this should be a kernel configurable?
-		 */
-		if (*max_dev_lun < shpnt->max_lun)
-			*max_dev_lun = shpnt->max_lun;
-		else 	if ((max_scsi_luns >> 1) >= *max_dev_lun)
-				*max_dev_lun += shpnt->max_lun;
-			else	*max_dev_lun = max_scsi_luns;
+		*max_dev_lun = shpnt->max_lun;
 		*sparse_lun = 1;
 		return 1;
 	}
@@ -816,17 +805,7 @@
 	 * settings, and scan all of them.
 	 */
 	if (bflags & BLIST_FORCELUN) {
-		/* 
-		 * Scanning MAX_SCSI_LUNS units would be a bad idea.
-		 * Any better idea?
-		 * I think we need REPORT LUNS in future to avoid scanning
-		 * of unused LUNs. But, that is another item.
-		 */
-		if (*max_dev_lun < shpnt->max_lun)
-			*max_dev_lun = shpnt->max_lun;
-		else 	if ((max_scsi_luns >> 1) >= *max_dev_lun)
-				*max_dev_lun += shpnt->max_lun;
-			else	*max_dev_lun = max_scsi_luns;
+		*max_dev_lun = shpnt->max_lun;
 		return 1;
 	}
 	/*

