Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267995AbRGZOm7>; Thu, 26 Jul 2001 10:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbRGZOmk>; Thu, 26 Jul 2001 10:42:40 -0400
Received: from sesys.exodata.se ([193.44.92.66]:961 "EHLO sesys.se.transtec.de")
	by vger.kernel.org with ESMTP id <S267995AbRGZOm3>;
	Thu, 26 Jul 2001 10:42:29 -0400
From: Roland Fehrenbacher <rfehrenb@transtec.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15200.7444.971399.948422@gargle.gargle.HOWL>
Date: Thu, 26 Jul 2001 15:37:24 +0200
Subject: Re: qlogicfc driver
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

    Roland> While the controller itself sees all the 3 drives when booting up,
    Roland> under Linux I am only able to see the LUN 0 drives.

    Roland> The command echo "scsi add-single-device 0 0 0 1" > /proc/scsi/scsi
    Roland> makes the LUN 1 device appear, so it seems the problem is with the
    Roland> SCSI scanning code.

In the meantime I found out that I need to identify the RAID controller as a
sparse LUN device. This works fine as long as there is a host drive mapped to
LUN 0. If there is no host drive mapped to LUN 0, we run into a bug of the SCSI
scanning code: The variable *sparse_lun=1 never gets set and any other host
drives at LUNs > 0 are not detected. This problem has already been discussed
in a different context previously
(http://groups.google.com/groups?q=scsi_scan.c&hl=en&safe=off&rnum=2&selm=F888C30C3021D411B9DA00B0D0209BE8FAB0EB%40cvo-exchange.roguewave.com).

The following patch fixes the problem, and I can't see any side effects. Please
review the patch, and if approved, include it in the kernel.

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
