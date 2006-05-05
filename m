Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWEEC4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWEEC4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 22:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWEEC4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 22:56:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:16744 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932453AbWEEC4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 22:56:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=TOEUp5ru9ZDbmVEAIwv8rF7to4JSTMp42RVOFKAnWVXJHsR9Eq4MWCLQwlApxNfDz6pDobXOLEk6fBGgYjCPk54G8cXdOXtXtTBMA2XcUfVwLQ2job3bXU7xy9GRt3WUQSAN6FFPGdmYtARvuX/Uw3CJgN+JXBUrPhnbrzG1RbQ=
Message-ID: <ea59786f0605041956g6d1f9505ud5f070403b03910c@mail.gmail.com>
Date: Thu, 4 May 2006 19:56:33 -0700
From: "Constantine Sapuntzakis" <csapuntz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/block/loop.c: don't return garbage if LOOP_SET_STATUS not called
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3979_32720847.1146797793263"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3979_32720847.1146797793263
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

While writing a version of losetup, I ran into the problem that the
loop device was
returning total garbage.

It turns out the problem was that this losetup was only issuing
the LOOP_SET_FD ioctl and not issuing a subsequent LOOP_SET_STATUS
ioctl. This losetup didn't have any special status to set, so it left
out the call.

The deeper cause is that loop_set_fd sets the transfer function to
NULL, which causes no transfer to happen lo_do_transfer.

This patch fixes the problem by setting transfer to transfer_none in
loop_set_fd.

-Costa

------=_Part_3979_32720847.1146797793263
Content-Type: application/octet-stream; name=loop-fix-set-fd.diff
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emtxkp37
Content-Disposition: attachment; filename="loop-fix-set-fd.diff"

--- loop.c	(revision 3701)
+++ loop.c	(working copy)
@@ -855,7 +855,7 @@
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
-	lo->transfer = NULL;
+	lo->transfer = transfer_none;
 	lo->ioctl = NULL;
 	lo->lo_sizelimit = 0;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);




------=_Part_3979_32720847.1146797793263--
