Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131616AbRCOCYG>; Wed, 14 Mar 2001 21:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRCOCX6>; Wed, 14 Mar 2001 21:23:58 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:6837 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131607AbRCOCXo>; Wed, 14 Mar 2001 21:23:44 -0500
Message-ID: <3AB028BE.E8940EE6@redhat.com>
Date: Wed, 14 Mar 2001 21:28:14 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: scsi_scan problem.
Content-Type: multipart/mixed;
 boundary="------------3F6354DD00CFE15992CC021F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3F6354DD00CFE15992CC021F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


A bug report I was charged with fixing (qla2x00 driver doesn't see all luns or
sees multiple identical luns in different scenarios) was not a bug in the
qla2x00 driver.  The recent changes to allow max luns in the mid layer to be >
7 seems to have caused this problem.  However, the proper fix is a bit of a
quandry for me.  You see, I don't have any Nakamichi or Yamaha multi-cd
changers, or a DAT or DLT autoloader, or several of the different models of
raid chassis.  The bug is that we were detecting offline devices and linking
them into the device list.  But, some devices (at least the Clariion raid
chassis) report luns that don't currently have any device bound to them as
present but offline.  This meant if we truly scanned all luns then we got
something like 100+ devices on one ID from this chassis when only 1 might be
valid :-(  So, I've attached a patch that solves the problem here perfectly. 
But, I need people that have access to the above listed hardware to test it. 
Most specifically, I'm afraid that the CD changers or autoloaders will report
some of their luns as offline so we will skip them even though we want them
entered into the device list.  If that's not the case, and they list their
luns as all being connected, then this patch needs to go into the mainstream
kernel.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
--------------3F6354DD00CFE15992CC021F
Content-Type: text/plain; charset=us-ascii;
 name="scsi_scan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_scan.patch"

--- scsi_scan.c.save	Wed Mar 14 20:58:21 2001
+++ scsi_scan.c	Wed Mar 14 21:10:28 2001
@@ -557,6 +557,23 @@
 	}
 
 	/*
+	 * If we are offline and we are on a LUN != 0, then skip this entry.
+	 * If we are on a BLIST_FORCELUN device this will stop the scan at
+	 * the first offline LUN (typically the correct thing to do).  If
+	 * we are on a BLIST_SPARSELUN device then this won't stop the scan,
+	 * but it will keep us from having false entries in our device
+	 * array. DL
+	 *
+	 * NOTE: Need to test this to make sure it doesn't cause problems
+	 * with tape autoloaders, multidisc CD changers, and external
+	 * RAID chassis that might use sparse luns or multiluns... DL
+	 */
+	if (lun != 0 && (scsi_result[0] >> 5) == 1) {
+		scsi_release_request(SRpnt);
+		return 0;
+	}
+
+	/*
 	 * Get any flags for this device.  
 	 */
 	bflags = get_device_flags (scsi_result);
@@ -776,11 +793,26 @@
 		 *
 		 * FIXME(eric) - perhaps this should be a kernel configurable?
 		 */
+		/*
 		if (*max_dev_lun < shpnt->max_lun)
 			*max_dev_lun = shpnt->max_lun;
 		else 	if ((max_scsi_luns >> 1) >= *max_dev_lun)
 				*max_dev_lun += shpnt->max_lun;
 			else	*max_dev_lun = max_scsi_luns;
+		*/
+		/*
+		 * Blech...the above code is broken.  When you have a device
+		 * that is present, and it is a SPARSELUN device, then we
+		 * need to scan *all* the luns on that device.  Besides,
+		 * skipping the scanning of LUNs is a false optimization.
+		 * Scanning for a LUN on a present device is a very fast
+		 * operation, it's scanning for devices that don't exist that
+		 * is expensive and slow (although if you are truly scanning
+		 * through MAX_SCSI_LUNS devices that would be bad, I hope
+		 * all of the controllers out there set a reasonable value
+		 * in shpnt->max_lun).  DL
+		 */
+		*max_dev_lun = shpnt->max_lun;
 		*sparse_lun = 1;
 		return 1;
 	}
@@ -795,11 +827,26 @@
 		 * I think we need REPORT LUNS in future to avoid scanning
 		 * of unused LUNs. But, that is another item.
 		 */
+		/*
 		if (*max_dev_lun < shpnt->max_lun)
 			*max_dev_lun = shpnt->max_lun;
 		else 	if ((max_scsi_luns >> 1) >= *max_dev_lun)
 				*max_dev_lun += shpnt->max_lun;
 			else	*max_dev_lun = max_scsi_luns;
+		*/
+		/*
+		 * Blech...the above code is broken.  When you have a device
+		 * that is present, and it is a FORCELUN device, then we
+		 * need to scan *all* the luns on that device.  Besides,
+		 * skipping the scanning of LUNs is a false optimization.
+		 * Scanning for a LUN on a present device is a very fast
+		 * operation, it's scanning for devices that don't exist that
+		 * is expensive and slow (although if you are truly scanning
+		 * through MAX_SCSI_LUNS devices that would be bad, I hope
+		 * all of the controllers out there set a reasonable value
+		 * in shpnt->max_lun).  DL
+		 */
+		*max_dev_lun = shpnt->max_lun;
 		return 1;
 	}
 	/*

--------------3F6354DD00CFE15992CC021F--

