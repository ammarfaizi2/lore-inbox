Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUHPTBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUHPTBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUHPTAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:00:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:28318 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267866AbUHPS7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:59:09 -0400
Subject: [PATCH] 2.4.27 scsi PHYS_4G merging doesn't work
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-sDlE0W05TSiV1q0LqtCW"
Organization: 
Message-Id: <1092682753.3641.868.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Aug 2004 14:59:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sDlE0W05TSiV1q0LqtCW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcelo,

We recently found that, BH_PHYS_4G() handling in scsi-merge
code is broken. Instead of creating new segment when the IO
crosses 4G boundary, its forcing to create a new request.
So we end up not merging IOs and start doing small IOs.

Only requirement is, driver can't handle crossing 4G boundary
in a single segment - but we can have multiple segments doing
IOs all over the place.

Here is the patch to fix it (suggested by Jens Axboe).

Thanks,
Badari



--=-sDlE0W05TSiV1q0LqtCW
Content-Disposition: attachment; filename=4g-merge.patch
Content-Type: text/plain; name=4g-merge.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.4.27.org/drivers/scsi/scsi_merge.c	2004-08-16 11:20:59.957655240 -0700
+++ linux-2.4.27/drivers/scsi/scsi_merge.c	2004-08-16 11:24:30.150701040 -0700
@@ -418,7 +418,7 @@ __inline static int __scsi_back_merge_fn
 		return 0;
 
 	if (!BH_PHYS_4G(req->bhtail, bh))
-		return 0;
+		goto new_end_segment;
 
 	if (use_clustering) {
 		/* 
@@ -477,7 +477,7 @@ __inline static int __scsi_front_merge_f
 		return 0;
 
 	if (!BH_PHYS_4G(bh, req->bh))
-		return 0;
+		goto new_start_segment;
 
 	if (use_clustering) {
 		/* 
@@ -640,7 +640,7 @@ __inline static int __scsi_merge_request
 		return 0;
 
 	if (!BH_PHYS_4G(req->bhtail, next->bh))
-		return 0;
+		goto dont_combine;
 
 	/*
 	 * The main question is whether the two segments at the boundaries

--=-sDlE0W05TSiV1q0LqtCW--

