Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWAKMHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWAKMHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAKMHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:07:13 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:50054 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751208AbWAKMHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:07:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17348.62703.715407.716894@jaguar.mkp.net>
Date: Wed, 11 Jan 2006 07:07:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, petero2@telia.com
Subject: [patch] sem2mutex pktcdvd
X-Mailer: VM 7.19 under Emacs 21.4.1
From: jes@trained-monkey.org (Jes Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Relative to Linus' git tree this morning. I don't have anything to test
it with but it seems obviously correct.

Cheers,
Jes


Convert to use mutex from a semaphore

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 drivers/block/pktcdvd.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.orig/drivers/block/pktcdvd.c
+++ linux-2.6/drivers/block/pktcdvd.c
@@ -58,6 +58,7 @@
 #include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/suspend.h>
+#include <linux/mutex.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
 
@@ -82,7 +83,7 @@
 static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
 static struct proc_dir_entry *pkt_proc;
 static int pkt_major;
-static struct semaphore ctl_mutex;	/* Serialize open/close/setup/teardown */
+static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t *psd_pool;
 
 
@@ -2030,7 +2031,7 @@
 
 	VPRINTK("pktcdvd: entering open\n");
 
-	down(&ctl_mutex);
+	mutex_lock(&ctl_mutex);
 	pd = pkt_find_dev_from_minor(iminor(inode));
 	if (!pd) {
 		ret = -ENODEV;
@@ -2057,14 +2058,14 @@
 		set_blocksize(inode->i_bdev, CD_FRAMESIZE);
 	}
 
-	up(&ctl_mutex);
+	mutex_unlock(&ctl_mutex);
 	return 0;
 
 out_dec:
 	pd->refcnt--;
 out:
 	VPRINTK("pktcdvd: failed open (%d)\n", ret);
-	up(&ctl_mutex);
+	mutex_unlock(&ctl_mutex);
 	return ret;
 }
 
@@ -2073,14 +2074,14 @@
 	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
 	int ret = 0;
 
-	down(&ctl_mutex);
+	mutex_lock(&ctl_mutex);
 	pd->refcnt--;
 	BUG_ON(pd->refcnt < 0);
 	if (pd->refcnt == 0) {
 		int flush = test_bit(PACKET_WRITABLE, &pd->flags);
 		pkt_release_dev(pd, flush);
 	}
-	up(&ctl_mutex);
+	mutex_unlock(&ctl_mutex);
 	return ret;
 }
 
@@ -2614,21 +2615,21 @@
 	case PKT_CTRL_CMD_SETUP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		down(&ctl_mutex);
+		mutex_lock(&ctl_mutex);
 		ret = pkt_setup_dev(&ctrl_cmd);
-		up(&ctl_mutex);
+		mutex_unlock(&ctl_mutex);
 		break;
 	case PKT_CTRL_CMD_TEARDOWN:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		down(&ctl_mutex);
+		mutex_lock(&ctl_mutex);
 		ret = pkt_remove_dev(&ctrl_cmd);
-		up(&ctl_mutex);
+		mutex_unlock(&ctl_mutex);
 		break;
 	case PKT_CTRL_CMD_STATUS:
-		down(&ctl_mutex);
+		mutex_lock(&ctl_mutex);
 		pkt_get_status(&ctrl_cmd);
-		up(&ctl_mutex);
+		mutex_unlock(&ctl_mutex);
 		break;
 	default:
 		return -ENOTTY;
@@ -2674,7 +2675,7 @@
 		goto out;
 	}
 
-	init_MUTEX(&ctl_mutex);
+	mutex_init(&ctl_mutex);
 
 	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
 
