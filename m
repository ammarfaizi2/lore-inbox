Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWCPPLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWCPPLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCPPLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:11:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751258AbWCPPLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:11:24 -0500
Date: Thu, 16 Mar 2006 15:11:14 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: dm stripe: Fix bounds
Message-ID: <20060316151114.GS4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Corry <kevcorry@us.ibm.com>

The dm-stripe target currently does not enforce that the size of a stripe 
device be a multiple of the chunk-size. Under certain conditions, this can 
lead to I/O requests going off the end of an underlying device. This 
test-case shows one example.

echo "0 100 linear /dev/hdb1 0" | dmsetup create linear0
echo "0 100 linear /dev/hdb1 100" | dmsetup create linear1
echo "0 200 striped 2 32 /dev/mapper/linear0 0 /dev/mapper/linear1 0" | \
   dmsetup create stripe0
dd if=/dev/zero of=/dev/mapper/stripe0 bs=1k

This will produce the output:
dd: writing '/dev/mapper/stripe0': Input/output error
97+0 records in
96+0 records out

And in the kernel log will be:
attempt to access beyond end of device
dm-0: rw=0, want=104, limit=100

The patch below will check that the table size is a multiple of the stripe 
chunk-size when the table is created, which will prevent the above striped 
device from being created.

This should not affect tools like LVM or EVMS, since in all the cases I can 
think of, striped devices are always created with the sizes being a multiple 
of the chunk-size.

The size of a stripe device must be a multiple of its chunk-size.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

 dm-stripe.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.16-rc5/drivers/md/dm-stripe.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm-stripe.c	2006-03-14 18:25:38.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm-stripe.c	2006-03-15 17:56:37.000000000 +0000
@@ -103,9 +103,15 @@ static int stripe_ctr(struct dm_target *
 		return -EINVAL;
 	}
 
+	if (((uint32_t)ti->len) & (chunk_size - 1)) {
+		ti->error = "dm-stripe: Target length not divisible by "
+		    "chunk size";
+		return -EINVAL;
+	}
+
 	width = ti->len;
 	if (sector_div(width, stripes)) {
-		ti->error = "dm-stripe: Target length not divisable by "
+		ti->error = "dm-stripe: Target length not divisible by "
 		    "number of stripes";
 		return -EINVAL;
 	}
