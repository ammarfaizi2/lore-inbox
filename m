Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWBCUQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBCUQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWBCUQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:16:45 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:9103 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750799AbWBCUQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:16:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Phillip Susi <psusi@cfl.rr.com>
Subject: [PATCH 1/5] pktcdvd: Fix overflow for discs with large packets
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2006 21:16:27 +0100
Message-ID: <m3bqxoci5g.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Susi <psusi@cfl.rr.com>

The pktcdvd driver was using an 8 bit field to store the packet length
obtained from the disc track info.  This causes it to overflow packet
length values of 128KB or more.  I changed the field to 32 bits to fix
this.

The pktcdvd driver defaulted to its maximum allowed packet length
when it detected a 0 in the track info field.  I changed this to fail
the operation and refuse to access the media.  This seems more sane
than attempting to access it with a value that almost certainly will
not work.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    2 +-
 include/linux/pktcdvd.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 81ad466..f0a0ad4 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1640,7 +1640,7 @@ static int pkt_probe_settings(struct pkt
 	pd->settings.size = be32_to_cpu(ti.fixed_packet_size) << 2;
 	if (pd->settings.size == 0) {
 		printk("pktcdvd: detected zero packet size!\n");
-		pd->settings.size = 128;
+		return -ENXIO;
 	}
 	if (pd->settings.size > PACKET_MAX_SECTORS) {
 		printk("pktcdvd: packet size is too big\n");
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 2c177e4..d1c9c4a 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -114,7 +114,7 @@ struct pkt_ctrl_command {
 
 struct packet_settings
 {
-	__u8			size;		/* packet size in (512 byte) sectors */
+	__u32			size;		/* packet size in (512 byte) sectors */
 	__u8			fp;		/* fixed packets */
 	__u8			link_loss;	/* the rest is specified
 						 * as per Mt Fuji */
-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
