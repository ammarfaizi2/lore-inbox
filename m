Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRHAJHu>; Wed, 1 Aug 2001 05:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRHAJHl>; Wed, 1 Aug 2001 05:07:41 -0400
Received: from rainbow.transtec.de ([153.94.51.2]:25349 "EHLO
	rainbow.transtec.de") by vger.kernel.org with ESMTP
	id <S265844AbRHAJHa>; Wed, 1 Aug 2001 05:07:30 -0400
From: Roland Fehrenbacher <rfehrenb@transtec.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15207.47005.173877.328503@gargle.gargle.HOWL>
Date: Wed, 1 Aug 2001 10:02:37 +0200
Subject: Patch for scsi_scan.c (was: qlogicfc driver)
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems nobody was interested in the thread qlogicfc. Here is a patch for
scsi_scan.c (against the 2.4.7 version) which solves the problem described in
the last few messages of the qlogicfc thread. It is absolutely necessary for
sparse_lun devices with LUN 0 not present.

Please review the patch, and if approved, include it in the kernel.

Cheers,

Roland

--- scsi_scan.c.orig    Mon Jul 23 09:24:53 2001
+++ scsi_scan.c Thu Jul 26 16:29:14 2001
@@ -153,6 +153,8 @@
        {"DELL", "PSEUDO DEVICE .",   "*", BLIST_SPARSELUN}, // Dell PV 530F
        {"DELL", "PV530F",    "*", BLIST_SPARSELUN}, // Dell PV 530F
        {"EMC", "SYMMETRIX", "*", BLIST_SPARSELUN},
+       {"CMD", "CRA-7280", "*", BLIST_SPARSELUN},   // CMD RAID Controller
+       {"Zzyzx", "RocketStor 500S", "*", BLIST_SPARSELUN}, // Zzyzx RocketStor Raid
        {"SONY", "TSL",       "*", BLIST_FORCELUN},  // DDS3 & DDS4 autoloaders
        {"DELL", "PERCRAID", "*", BLIST_FORCELUN},
        {"HP", "NetRAID-4M", "*", BLIST_FORCELUN},
@@ -565,20 +567,26 @@
        }
 
        /*
-        * Check the peripheral qualifier field - this tells us whether LUNS
-        * are supported here or not.
+        * Check for SPARSELUN before checking the peripheral qualifier,
+        * so sparse lun devices are completely scanned.
         */
-       if ((scsi_result[0] >> 5) == 3) {
-               scsi_release_request(SRpnt);
-               return 0;       /* assume no peripheral if any sort of error */
-       }
 
        /*
         * Get any flags for this device.  
         */
        bflags = get_device_flags (scsi_result);
 
-
+       if (bflags & BLIST_SPARSELUN) {
+         *sparse_lun = 1;
+       }
+       /*
+        * Check the peripheral qualifier field - this tells us whether LUNS
+        * are supported here or not.
+        */
+       if ((scsi_result[0] >> 5) == 3) {
+               scsi_release_request(SRpnt);
+               return 0;       /* assume no peripheral if any sort of error */
+       }
         /*   The Toshiba ROM was "gender-changed" here as an inline hack.
              This is now much more generic.
              This is a mess: What we really want is to leave the scsi_result
