Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWBLLtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWBLLtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWBLLtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:49:33 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:5035 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751000AbWBLLtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:49:33 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pktcdvd: Allow non-writable media to be mounted
References: <m3mzgw7q8b.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Feb 2006 12:49:23 +0100
In-Reply-To: <m3mzgw7q8b.fsf@telia.com>
Message-ID: <m3irrk7q64.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If opening for write fails, the open method should return -EROFS.
This makes "mount" try again with a read-only mount, instead of just
giving up.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7879df0..d747f28 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1896,7 +1896,7 @@ static int pkt_open_write(struct pktcdvd
 
 	if ((ret = pkt_probe_settings(pd))) {
 		VPRINTK("pktcdvd: %s failed probe\n", pd->name);
-		return -EIO;
+		return -EROFS;
 	}
 
 	if ((ret = pkt_set_write_settings(pd))) {
@@ -2054,10 +2054,9 @@ static int pkt_open(struct inode *inode,
 			goto out_dec;
 		}
 	} else {
-		if (pkt_open_dev(pd, file->f_mode & FMODE_WRITE)) {
-			ret = -EIO;
+		ret = pkt_open_dev(pd, file->f_mode & FMODE_WRITE);
+		if (ret)
 			goto out_dec;
-		}
 		/*
 		 * needed here as well, since ext2 (among others) may change
 		 * the blocksize at mount time

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
