Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWEECTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWEECTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 22:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWEECTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 22:19:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:25525 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932435AbWEECTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 22:19:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=E0bNFTKz8a+sM7AIZHOBqUPwthDbiNZNRQw+TSldTA8+xDE0DokqiyMvHZWQXSMFZcIFJRaimZKPMFvgPdcaYZfRCcxPATMzw0jh/EaB/WM/tC4I9FrUiKxWBaW/H+tQ4O8c10s35O0dE18D3nLqaNm1D6leQ8lW+C5AOvmLMGU=
Message-ID: <ea59786f0605041919w337c7164id5f4e7b3efa818e0@mail.gmail.com>
Date: Thu, 4 May 2006 19:19:21 -0700
From: "Constantine Sapuntzakis" <csapuntz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop.c: respect bio barrier and sync
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3695_13764168.1146795561038"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3695_13764168.1146795561038
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I believe that the loop block device does not currently respect
barriers or syncs issued by its clients. As a result, I have seen
corrupted log errors when a loopback mounted ext3 file system is
remounted after a hard stop.

The attached patch attempts to fix this problem by respecting the
barrier and sync flags on the I/O request. The sync_file function was
cut-and-paste from the implementation of fsync (I think there's no fd
so I can't call fsync) to allow the patch to be deployed as an updated
module. Is there another function that could be used?

Comments are welcome. I am not on the list so please cc: me on any response=
.

-Costa

------=_Part_3695_13764168.1146795561038
Content-Type: application/octet-stream; name=loop-barrier-patch.diff
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emtw0yl2
Content-Disposition: attachment; filename="loop-barrier-patch.diff"

--- loop.c	2006-05-04 18:48:34.000000000 -0700
+++ loop.c	2006-05-04 18:52:42.000000000 -0700
@@ -467,16 +467,53 @@
 	return ret;
 }
 
+/*
+ * This is best effort. We really wouldn't know what to do with a returned
+ * error. This code is taken from the implementation of fsync.
+ */
+static void sync_file(struct file * file)  
+{
+        struct address_space *mapping;
+
+        if (!file->f_op || !file->f_op->fsync)
+		return;
+
+        mapping = file->f_mapping;
+
+        current->flags |= PF_SYNCWRITE;
+        filemap_fdatawrite(mapping);
+
+        /*
+         * We need to protect against concurrent writers,
+         * which could cause livelocks in fsync_buffers_list
+         */
+        mutex_lock(&mapping->host->i_mutex);
+        file->f_op->fsync(file, file->f_dentry, 1);
+        mutex_unlock(&mapping->host->i_mutex);
+
+        filemap_fdatawait(mapping);
+        current->flags &= ~PF_SYNCWRITE;
+}
+
 static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
 {
 	loff_t pos;
 	int ret;
+	int sync = bio_sync(bio);
+	int barrier = bio_barrier(bio);
+
+	if (barrier)
+		sync_file(lo->lo_backing_file);
 
 	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
 	if (bio_rw(bio) == WRITE)
 		ret = lo_send(lo, bio, lo->lo_blocksize, pos);
 	else
 		ret = lo_receive(lo, bio, lo->lo_blocksize, pos);
+
+	if (barrier || sync)
+		sync_file(lo->lo_backing_file);
+
 	return ret;
 }
 










------=_Part_3695_13764168.1146795561038--
