Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUG1Uv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUG1Uv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUG1Uv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:51:58 -0400
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:20419 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263769AbUG1Uvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:51:54 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Fix setting of maximum read speed in CDRW packet writing
References: <m3llh3uavw.fsf@telia.com> <m3hdrrualq.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2004 22:49:55 +0200
Message-ID: <m3d62fuaa4.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pkt_iosched_process_queue() failed to enable maximum read speed on the
Iomega Super DVD 8x USB drive. It's better to use 0xffff to set
maximum speed, because it is what the driver does at other places, and
0xffff seems to be understood by more drive models than using some
other large but non-standard speed.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-read-speed drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-read-speed	2004-07-28 22:00:21.867649800 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-28 22:00:21.870649344 +0200
@@ -63,6 +63,8 @@
 #define VPRINTK(fmt, args...)
 #endif
 
+#define MAX_SPEED 0xffff
+
 #define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))
 
 
@@ -400,9 +402,9 @@ static int pkt_set_speed(struct pktcdvd_
 	int ret;
 
 	write_speed = write_speed * 177; /* should be 176.4, but CD-RWs rounds down */
-	write_speed = min_t(unsigned, write_speed, 0xffff);
+	write_speed = min_t(unsigned, write_speed, MAX_SPEED);
 	read_speed = read_speed * 177;
-	read_speed = min_t(unsigned, read_speed, 0xffff);
+	read_speed = min_t(unsigned, read_speed, MAX_SPEED);
 
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.sense = &sense;
@@ -519,7 +521,7 @@ static void pkt_iosched_process_queue(st
 		if (pd->iosched.successive_reads >= HI_SPEED_SWITCH) {
 			if (pd->read_speed == pd->write_speed) {
 				pd->read_speed = 0xff;
-				pkt_set_speed(pd, pd->write_speed, pd->read_speed);
+				pkt_set_speed(pd, pd->write_speed, MAX_SPEED);
 			}
 		} else {
 			if (pd->read_speed != pd->write_speed) {
@@ -1919,7 +1921,7 @@ static int pkt_open_dev(struct pktcdvd_d
 		spin_unlock_irq(q->queue_lock);
 		set_bit(PACKET_WRITABLE, &pd->flags);
 	} else {
-		pkt_set_speed(pd, 0xffff, 0xffff);
+		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
 		clear_bit(PACKET_WRITABLE, &pd->flags);
 	}
 
@@ -1955,7 +1957,7 @@ static void pkt_release_dev(struct pktcd
 	pkt_lock_door(pd, 0);
 
 	q = bdev_get_queue(pd->bdev);
-	pkt_set_speed(pd, 0xffff, 0xffff);
+	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
 	spin_lock_irq(q->queue_lock);
 	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
 	spin_unlock_irq(q->queue_lock);
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
