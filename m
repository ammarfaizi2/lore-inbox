Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759674AbWLFCNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759674AbWLFCNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759680AbWLFCNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:13:30 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:58156 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759675AbWLFCN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:13:29 -0500
Message-ID: <45762745.7010202@steeleye.com>
Date: Tue, 05 Dec 2006 21:13:25 -0500
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, wouter@grep.be
Subject: [PATCH] nbd: show nbd client pid in sysfs
Content-Type: multipart/mixed;
 boundary="------------030202050704080006060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202050704080006060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This simple patch allows nbd to expose the nbd-client daemon's PID in 
/sys/block/nbd<x>/pid. This is helpful for tracking connection status of 
a device and for determining which nbd devices are currently in use.

Tested against 2.6.19.

Thanks,
Paul

--------------030202050704080006060702
Content-Type: text/plain;
 name="nbd_pid_sysfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_pid_sysfs.diff"

--- ./drivers/block/nbd.c	Wed Nov 29 16:57:37 2006
+++ ./drivers/block/nbd.c	Tue Nov 28 16:09:31 2006
@@ -355,14 +389,30 @@ harderror:
 	return NULL;
 }
 
+static ssize_t pid_show(struct gendisk *disk, char *page)
+{
+	return sprintf(page, "%ld\n",
+		(long) ((struct nbd_device *)disk->private_data)->pid);
+}
+
+static struct disk_attribute pid_attr = {
+	.attr = { .name = "pid", .mode = S_IRUGO },
+	.show = pid_show,
+};
+	
 static void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
 
 	BUG_ON(lo->magic != LO_MAGIC);
 
+	lo->pid = current->pid;
+	sysfs_create_file(&lo->disk->kobj, &pid_attr.attr);
+
 	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
+
+	sysfs_remove_file(&lo->disk->kobj, &pid_attr.attr);
 	return;
 }
 
--- ./include/linux/nbd.h	Wed Nov 29 16:57:37 2006
+++ ./include/linux/nbd.h	Mon Dec  4 23:28:30 2006
@@ -64,6 +64,7 @@ struct nbd_device {
 	struct gendisk *disk;
 	int blksize;
 	u64 bytesize;
+	pid_t pid; /* pid of nbd-client, if attached */
 };
 
 #endif

--------------030202050704080006060702--
