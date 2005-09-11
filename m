Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVIKQnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVIKQnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVIKQnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:43:23 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:36736 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964855AbVIKQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:43:23 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pktcdvd documentation update
References: <m3irx7v9nq.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 18:43:12 +0200
In-Reply-To: <m3irx7v9nq.fsf@telia.com>
Message-ID: <m3ek7vv9lr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the "theory of operation" description.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   48 +++++++++++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -5,29 +5,41 @@
  * May be copied or modified under the terms of the GNU General Public
  * License.  See linux/COPYING for more information.
  *
- * Packet writing layer for ATAPI and SCSI CD-R, CD-RW, DVD-R, and
- * DVD-RW devices (aka an exercise in block layer masturbation)
+ * Packet writing layer for ATAPI and SCSI CD-RW, DVD+RW, DVD-RW and
+ * DVD-RAM devices.
  *
+ * Theory of operation:
  *
- * TODO: (circa order of when I will fix it)
- * - Only able to write on CD-RW media right now.
- * - check host application code on media and set it in write page
- * - interface for UDF <-> packet to negotiate a new location when a write
- *   fails.
- * - handle OPC, especially for -RW media
+ * At the lowest level, there is the standard driver for the CD/DVD device,
+ * typically ide-cd.c or sr.c. This driver can handle read and write requests,
+ * but it doesn't know anything about the special restrictions that apply to
+ * packet writing. One restriction is that write requests must be aligned to
+ * packet boundaries on the physical media, and the size of a write request
+ * must be equal to the packet size. Another restriction is that a
+ * GPCMD_FLUSH_CACHE command has to be issued to the drive before a read
+ * command, if the previous command was a write.
  *
- * Theory of operation:
+ * The purpose of the packet writing driver is to hide these restrictions from
+ * higher layers, such as file systems, and present a block device that can be
+ * randomly read and written using 2kB-sized blocks.
+ *
+ * The lowest layer in the packet writing driver is the packet I/O scheduler.
+ * Its data is defined by the struct packet_iosched and includes two bio
+ * queues with pending read and write requests. These queues are processed
+ * by the pkt_iosched_process_queue() function. The write requests in this
+ * queue are already properly aligned and sized. This layer is responsible for
+ * issuing the flush cache commands and scheduling the I/O in a good order.
  *
- * We use a custom make_request_fn function that forwards reads directly to
- * the underlying CD device. Write requests are either attached directly to
- * a live packet_data object, or simply stored sequentially in a list for
- * later processing by the kcdrwd kernel thread. This driver doesn't use
- * any elevator functionally as defined by the elevator_s struct, but the
- * underlying CD device uses a standard elevator.
+ * The next layer transforms unaligned write requests to aligned writes. This
+ * transformation requires reading missing pieces of data from the underlying
+ * block device, assembling the pieces to full packets and queuing them to the
+ * packet I/O scheduler.
  *
- * This strategy makes it possible to do very late merging of IO requests.
- * A new bio sent to pkt_make_request can be merged with a live packet_data
- * object even if the object is in the data gathering state.
+ * At the top layer there is a custom make_request_fn function that forwards
+ * read requests directly to the iosched queue and puts write requests in the
+ * unaligned write queue. A kernel thread performs the necessary read
+ * gathering to convert the unaligned writes to aligned writes and then feeds
+ * them to the packet I/O scheduler.
  *
  *************************************************************************/
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
