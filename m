Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWBLLws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWBLLws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWBLLws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:52:48 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:22014 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932385AbWBLLwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:52:47 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pktcdvd: Don't unlock the door if the disc is in use
References: <m3mzgw7q8b.fsf@telia.com> <m3irrk7q64.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Feb 2006 12:52:37 +0100
In-Reply-To: <m3irrk7q64.fsf@telia.com>
Message-ID: <m3ek287q0q.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlocking the door when the disc is in use is obviously not good,
because then it's possible to eject the disc at the wrong time and
cause severe disc data corruption.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d747f28..d794f2b 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2436,7 +2436,8 @@ static int pkt_ioctl(struct inode *inode
 		 * The door gets locked when the device is opened, so we
 		 * have to unlock it or else the eject command fails.
 		 */
-		pkt_lock_door(pd, 0);
+		if (pd->refcnt == 1)
+			pkt_lock_door(pd, 0);
 		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	default:

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
