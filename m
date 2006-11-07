Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754250AbWKGS3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbWKGS3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754251AbWKGS3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:29:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754246AbWKGS3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:29:46 -0500
Date: Tue, 7 Nov 2006 18:29:40 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 2.6.19 1/5] dm: fix find_device race
Message-ID: <20061107182940.GC6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between dev_create() and find_device().

If the mdptr has not yet been stored against a device,
find_device() needs to behave as though no device was
found.  It already returns NULL, but there is a dm_put()
missing: it must drop the reference dm_get_md() took.

The bug was introduced by dm-fix-mapped-device-ref-counting.patch.
 
It manifests itself if another dm ioctl attempts to reference a
newly-created device while the device creation ioctl is still running.
The consequence is that the device cannot be removed until the machine
is rebooted.  Certain udev configurations can lead to this happening.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc4/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.19-rc4.orig/drivers/md/dm-ioctl.c	2006-11-07 17:06:30.000000000 +0000
+++ linux-2.6.19-rc4/drivers/md/dm-ioctl.c	2006-11-07 17:07:53.000000000 +0000
@@ -606,9 +606,14 @@ static struct hash_cell *__find_device_h
 		return __get_name_cell(param->name);
 
 	md = dm_get_md(huge_decode_dev(param->dev));
-	if (md)
-		mdptr = dm_get_mdptr(md);
+	if (!md)
+		goto out;
 
+	mdptr = dm_get_mdptr(md);
+	if (!mdptr)
+		dm_put(md);
+
+out:
 	return mdptr;
 }
 
