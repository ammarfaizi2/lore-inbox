Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264323AbRFSPpn>; Tue, 19 Jun 2001 11:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbRFSPpd>; Tue, 19 Jun 2001 11:45:33 -0400
Received: from [32.97.182.103] ([32.97.182.103]:39156 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264323AbRFSPp2>;
	Tue, 19 Jun 2001 11:45:28 -0400
Importance: Normal
Subject: [RFQ]  aic7xxx driver panics under heavy swap.
To: gibbs@scsiguy.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFFC1B2C1B.7F406B4A-ON85256A70.00564265@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Tue, 19 Jun 2001 11:46:02 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V508_06042001 |June 4, 2001) at
 06/19/2001 11:45:02 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,
When free memory is low, I get a series of aic7xxx messages followed by
panic.
It appears to be a race condition in the code.  Should you panic?  I tried
the following
patch to not panic.  But I am not sure if it is functionally correct.
Bulent


scsi0: Temporary Resource Shortage
scsi0: Temporary Resource Shortage
scsi0: Temporary Resource Shortage
scsi0: Temporary Resource Shortage
scsi0: Temporary Resource Shortage
Kernel panic: running device on run list


--- aic7xxx_linux.c.save Mon Jun 18 20:25:35 2001
+++ aic7xxx_linux.c Mon Jun 18 20:26:29 2001
@@ -1552,12 +1552,14 @@
           * Get an scb to use.
           */
          if ((scb = ahc_get_scb(ahc)) == NULL) {
+              ahc->flags |= AHC_RESOURCE_SHORTAGE;
               if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
-                   panic("running device on run list");
+                   return;
+                   // panic("running device on run list");
               LIST_INSERT_HEAD(&ahc->platform_data->device_runq,
                          dev, links);
               dev->flags |= AHC_DEV_ON_RUN_LIST;
-              ahc->flags |= AHC_RESOURCE_SHORTAGE;
+              // ahc->flags |= AHC_RESOURCE_SHORTAGE;
               printf("%s: Temporary Resource Shortage\n",
                      ahc_name(ahc));
               return;



