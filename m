Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUBJQxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUBJQxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:53:43 -0500
Received: from smtp2.us.dell.com ([143.166.85.133]:43954 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S266008AbUBJQwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:52:17 -0500
Date: Tue, 10 Feb 2004 10:46:08 -0600 (CST)
From: Stuart Hayes <Stuart_Hayes@dell.com>
X-X-Sender: stuart_hayes@tux.linuxdev.us.dell.com
To: axboe@suse.de
cc: linux-kernel@vger.kernel.org, <stuart_hayes@dell.com>
Subject: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct
Message-ID: <Pine.LNX.4.44.0402101035050.29125-100000@tux.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch will make the "dvd_read_struct" function in cdrom.c 
check that the DVD drive can currently do the DVD read structure command 
before sending the command to the drive.  It does this by checking the 
"dvd read" feature using the "get configuration" command.

Currently, cdrom.c only checks that the drive is a DVD drive before 
allowing the dvd read structure command to go to the drive--it does not 
make sure that the DVD drive has a DVD in it.  Without this patch, if CD 
medium is in a DVD drive, and the DVD_READ_STRUCT ioctl is used, the drive
will spew an ugly "illegal request" error (magicdev does this).

Thanks
Stuart



diff -BurN linux-2.6.3-rc1/drivers/cdrom/cdrom.c linux-2.6.3-rc1-cdrompatch/drivers/cdrom/cdrom.c
--- linux-2.6.3-rc1/drivers/cdrom/cdrom.c	2004-02-09 15:55:18.000000000 -0600
+++ linux-2.6.3-rc1-cdrompatch/drivers/cdrom/cdrom.c	2004-02-10 09:20:31.000000000 -0600
@@ -1643,8 +1643,41 @@
 	return ret;
 }
 
+static int check_feature_current(struct cdrom_device_info *cdi, __u16 feature)
+{
+	int ret;
+	u_char buf[12];
+	struct cdrom_generic_command cgc;
+	struct cdrom_device_ops *cdo = cdi->ops;
+
+	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
+	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
+	cgc.cmd[1] = 2; /* only get one feature descriptor */
+	cgc.cmd[2] = feature >> 8;
+	cgc.cmd[3] = feature & 0xff;
+	cgc.cmd[8] = 12;
+
+	if ((ret = cdo->generic_packet(cdi, &cgc)))
+		return ret;
+	if (buf[3] < 8) /* i.e., drive doesn't support the feature */
+		return -EMEDIUMTYPE;
+	if ((buf[10] & 1)==0) /* feature is not current */ 
+		return -EMEDIUMTYPE;
+	return 0;
+}
+
 static int dvd_read_struct(struct cdrom_device_info *cdi, dvd_struct *s)
 {
+	int ret;
+
+	/* do a GET_CONFIGURATION to make sure drive can do
+	 * DVD_READ_STRUCTURE command with current media
+	 */
+	ret = check_feature_current(cdi, CDF_DVD_READ);
+	if (ret)
+		return ret;
+
+	/* actually read the requested DVD structure */
 	switch (s->type) {
 	case DVD_STRUCT_PHYSICAL:
 		return dvd_read_physical(cdi, s);
diff -BurN linux-2.6.3-rc1/include/linux/cdrom.h linux-2.6.3-rc1-cdrompatch/include/linux/cdrom.h
--- linux-2.6.3-rc1/include/linux/cdrom.h	2004-02-09 15:55:25.000000000 -0600
+++ linux-2.6.3-rc1-cdrompatch/include/linux/cdrom.h	2004-02-10 09:20:29.000000000 -0600
@@ -722,6 +722,7 @@
 /*
  * feature profile
  */
+#define CDF_DVD_READ	0x1F
 #define CDF_MRW		0x28
 
 /*


