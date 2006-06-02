Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWFBTqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWFBTqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFBTqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23425 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750863AbWFBTqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:06 -0400
Message-Id: <20060602194747.131106000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 11/11] sbp2: backport read_capacity workaround for iPod
Content-Disposition: inline; filename=sbp2-backport-read_capacity-workaround-for-ipod.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stefan Richter <stefanr@s5r6.in-berlin.de>

There is a firmware bug in several Apple iPods which prevents access to
these iPods under certain conditions. The disk size reported by the iPod
is one sector too big. Once access to the end of the disk is attempted,
the iPod becomes inaccessible. This problem has been known for USB iPods
for some time and has recently been discovered to exist with
FireWire/USB combo iPods too.

This patch is derived from the fix in Linux 2.6.17, commit
e9a1c52c7b19d10342226c12f170d7ab644427e2, to be applicable to 2.6.16.x
without prerequisite patches. It hard-wires a workaround for three known
affected model numbers (those of 4th generation iPod, iPod Photo, iPod
mini).

Note: This patch lacks Linux 2.6.17's ability to enable and disable the
workaround via a module parameter.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/ieee1394/sbp2.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.16.19.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.16.19/drivers/ieee1394/sbp2.c
@@ -2491,9 +2491,20 @@ static int sbp2scsi_slave_alloc(struct s
 
 static int sbp2scsi_slave_configure(struct scsi_device *sdev)
 {
+	struct scsi_id_instance_data *scsi_id =
+		(struct scsi_id_instance_data *)sdev->host->hostdata[0];
+
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+
+	if ((scsi_id->sbp2_firmware_revision & 0xffff00) == 0x0a2700 &&
+	    (scsi_id->ud->model_id == 0x000021 /* gen.4 iPod */ ||
+	     scsi_id->ud->model_id == 0x000023 /* iPod mini  */ ||
+	     scsi_id->ud->model_id == 0x00007e /* iPod Photo */ )) {
+		SBP2_INFO("enabling iPod workaround: decrement disk capacity");
+		sdev->fix_capacity = 1;
+	}
 	return 0;
 }
 

--
