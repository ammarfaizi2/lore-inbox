Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbVLJL0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbVLJL0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVLJL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 06:26:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53994 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932780AbVLJL0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 06:26:10 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-Id: <200512101125.jBABP7Z9001085@einhorn.in-berlin.de>
Date: Sat, 10 Dec 2005 12:24:59 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] sbp2: fix panic when ejecting an ipod
To: stable@kernel.org, torvalds@osdl.org
cc: linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       adq@lidskialf.net, scjody@modernduck.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051209171922.GW19441@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
X-Spam-Score: (0.127) AWL,BAYES_20,MSGID_FROM_MTA_ID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2: fix panic when ejecting an ipod

Sbp2 did not catch some bogus transfer directions in requests from upper
layers.  Problem became apparent when iPods were to be ejected:
http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435
Debugging and original variant of the patch by Andrew de Quincey.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew de Quincey <adq@lidskialf.net>

---

Corresponding fix of the places where transfer direction is actually set and
how to clean sbp2_create_command_orb() up after this fix is being discussed.
A patch for SCSI mid and high level has been submitted.
http://marc.theaimsgroup.com/?t=113400010000001
Please apply the following patch to prevent kernel panics as the first step.

 drivers/ieee1394/sbp2.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

--- linux/drivers/ieee1394.orig/sbp2.c	2005-11-24 23:10:21.000000000 +0100
+++ linux/drivers/ieee1394/sbp2.c	2005-12-10 11:57:41.000000000 +0100
@@ -1784,6 +1784,12 @@ static int sbp2_create_command_orb(struc
 			break;
 	}
 
+	if (orb_direction != ORB_DIRECTION_NO_DATA_TRANSFER &&
+	    scsi_request_bufflen == 0) {
+		SBP2_WARN("Enforcing transfer direction DMA_NONE");
+		orb_direction = ORB_DIRECTION_NO_DATA_TRANSFER;
+	}
+
 	/*
 	 * Set-up our pagetable stuff... unfortunately, this has become
 	 * messier than I'd like. Need to clean this up a bit.   ;-)
@@ -1900,16 +1906,6 @@ static int sbp2_create_command_orb(struc
 			command_orb->misc |= ORB_SET_DATA_SIZE(scsi_request_bufflen);
 			command_orb->misc |= ORB_SET_DIRECTION(orb_direction);
 
-			/*
-			 * Sanity, in case our direction table is not
-			 * up-to-date
-			 */
-			if (!scsi_request_bufflen) {
-				command_orb->data_descriptor_hi = 0x0;
-				command_orb->data_descriptor_lo = 0x0;
-				command_orb->misc |= ORB_SET_DIRECTION(1);
-			}
-
 		} else {
 			/*
 			 * Need to turn this into page tables, since the


