Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUINLh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUINLh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269302AbUINLfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:35:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48531 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269291AbUINLeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:34:00 -0400
Date: Tue, 14 Sep 2004 13:35:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [patch] sched: fix scheduling latencies in NTFS mount
Message-ID: <20040914113523.GC2804@elte.hu>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20040914112847.GA2804@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


this patch fixes scheduling latencies in the NTFS mount path. We are
dropping the BKL because the code itself is using the ntfs_lock
semaphore which provides safe locking.

has been tested as part of the -VP patchset.

	Ingo

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-ntfs-mount.patch"


this patch fixes scheduling latencies in the NTFS mount path. We are
dropping the BKL because the code itself is using the ntfs_lock
semaphore which provides safe locking.

has been tested as part of the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/ntfs/super.c.orig	
+++ linux/fs/ntfs/super.c	
@@ -29,6 +29,7 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/moduleparam.h>
+#include <linux/smp_lock.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
@@ -2288,6 +2289,8 @@ static int ntfs_fill_super(struct super_
 	vol->fmask = 0177;
 	vol->dmask = 0077;
 
+	unlock_kernel();
+
 	/* Important to get the mount options dealt with now. */
 	if (!parse_options(vol, (char*)opt))
 		goto err_out_now;
@@ -2424,6 +2427,7 @@ static int ntfs_fill_super(struct super_
 		}
 		up(&ntfs_lock);
 		sb->s_export_op = &ntfs_export_ops;
+		lock_kernel();
 		return 0;
 	}
 	ntfs_error(sb, "Failed to allocate root directory.");
@@ -2527,6 +2531,7 @@ iput_tmp_ino_err_out_now:
 	}
 	/* Errors at this stage are irrelevant. */
 err_out_now:
+	lock_kernel();
 	sb->s_fs_info = NULL;
 	kfree(vol);
 	ntfs_debug("Failed, returning -EINVAL.");

--ZoaI/ZTpAVc4A5k6--
