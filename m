Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWDUM6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDUM6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWDUM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:58:19 -0400
Received: from fc-cn.com ([218.25.172.144]:779 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932290AbWDUM6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:58:18 -0400
Date: Fri, 21 Apr 2006 20:59:49 +0800
From: Qi Yong <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: [patch] raid5_end_write_request spinlock fix
Message-ID: <20060421125949.GA15550@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Reduce the raid5_end_write_request() spinlock window.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3184360..9c24377 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -581,7 +581,6 @@ static int raid5_end_write_request (stru
  	struct stripe_head *sh = bi->bi_private;
 	raid5_conf_t *conf = sh->raid_conf;
 	int disks = sh->disks, i;
-	unsigned long flags;
 	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
 
 	if (bi->bi_size)
@@ -599,16 +598,14 @@ static int raid5_end_write_request (stru
 		return 0;
 	}
 
-	spin_lock_irqsave(&conf->device_lock, flags);
 	if (!uptodate)
 		md_error(conf->mddev, conf->disks[i].rdev);
 
 	rdev_dec_pending(conf->disks[i].rdev, conf->mddev);
-	
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
-	__release_stripe(conf, sh);
-	spin_unlock_irqrestore(&conf->device_lock, flags);
+	release_stripe(sh);
+
 	return 0;
 }
 

-- 
Coywolf Qi Hunt
