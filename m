Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTFGX1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 19:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTFGX1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 19:27:55 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:15744 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263953AbTFGX1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 19:27:53 -0400
Date: Sun, 8 Jun 2003 01:41:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Charles White <arrays@compaq.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpqarray.c fix stack usage
Message-ID: <20030607234123.GA8511@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch has been around for a while but didn't apply anymore.
Rewrite and resend.

Any reasons why this one hasn't been applied yet?

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

--- linux-2.5.70-bk12/drivers/block/cpqarray.c~stackfix_cpqarray	2003-06-05 17:47:17.000000000 +0200
+++ linux-2.5.70-bk12/drivers/block/cpqarray.c	2003-06-08 01:29:05.000000000 +0200
@@ -1028,7 +1028,7 @@
 	int diskinfo[4];
 	struct hd_geometry *geo = (struct hd_geometry *)arg;
 	ida_ioctl_t *io = (ida_ioctl_t*)arg;
-	ida_ioctl_t my_io;
+	ida_ioctl_t *my_io;
 
 	switch(cmd) {
 	case HDIO_GETGEO:
@@ -1051,12 +1051,24 @@
 			return -EFAULT;
 		return 0;
 	case IDAPASSTHRU:
-		if (!capable(CAP_SYS_RAWIO)) return -EPERM;
-		if (copy_from_user(&my_io, io, sizeof(my_io)))
-			return -EFAULT;
-		error = ida_ctlr_ioctl(host, drv - host->drv, &my_io);
-		if (error) return error;
-		return copy_to_user(io, &my_io, sizeof(my_io)) ? -EFAULT : 0;
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+		my_io = kmalloc(sizeof(ida_ioctl_t), GFP_KERNEL);
+		if (!my_io)
+			return -ENOMEM;
+		error = -EFAULT;
+		if (copy_from_user(my_io, io, sizeof(*my_io)))
+			goto out_passthru;
+		error = ida_ctlr_ioctl(host, drv - host->drv, my_io);
+		if (error)
+			goto out_passthru;
+		error = -EFAULT;
+		if (copy_to_user(io, &my_io, sizeof(*my_io)))
+			goto out_passthru;
+		error = 0;
+out_passthru:
+		kfree(my_io);
+		return error;
 	case IDAGETCTLRSIG:
 		if (!arg) return -EINVAL;
 		put_user(host->ctlr_sig, (int*)arg);
