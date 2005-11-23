Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVKWEIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVKWEIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVKWEIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:08:16 -0500
Received: from mail.deathmatch.net ([216.200.85.210]:59025 "EHLO
	mail.deathmatch.net") by vger.kernel.org with ESMTP id S932503AbVKWEIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:08:16 -0500
Date: Tue, 22 Nov 2005 23:07:52 -0500
From: Bob Copeland <me@bobcopeland.com>
To: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
       mdharm-usb@one-eyed-alien.net
Subject: [PATCH] usb-storage: Add support for Rio Karma
Message-ID: <20051123040752.GA5595@hash.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Rio Karma portable digital audio player to usb-storage.

Signed-off-by: Bob Copeland <me@bobcopeland.com>

---

This is the first in a pair of patches to add the Rio Karma as a mass
storage device.  This patch exposes the player as a block device when
connected to USB, and the next patch, "Read Rio Karma boot sector," also
properly exposes the partitions.  This is useful as-is to users for purposes
of back-up/restore or blanking the disk on the unit, e.g. with dd.

A filesystem driver for the Optimized MPEG File System, used by both Rio Karma
and ReplayTV, is in an embryonic stage at http://bobcopeland.com/karma/.

 drivers/usb/storage/rio_karma.c |  104 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/storage/rio_karma.h |    9 +++
 2 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/storage/rio_karma.c
 create mode 100644 drivers/usb/storage/rio_karma.h

applies-to: 3c36672829527bef6951ca2f1eae7da4285fee31
ece6a8eb17d1b6464349ab2b025fdb8bc76e00da
diff --git a/drivers/usb/storage/rio_karma.c b/drivers/usb/storage/rio_karma.c
new file mode 100644
index 0000000..ea1be9a
--- /dev/null
+++ b/drivers/usb/storage/rio_karma.c
@@ -0,0 +1,104 @@
+/* USB driver for DNNA Rio Karma 
+ *
+ * (C) 2005 Bob Copeland (me@bobcopeland.com)
+ *
+ * The Karma is a mass storage device, although it requires some 
+ * initialization code to get in that mode.  
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/jiffies.h>
+#include "rio_karma.h"
+#include "usb.h"
+#include "transport.h"
+#include "debug.h"
+
+#define RIO_MSC 0x08
+#define RIOP_INIT "RIOP\x00\x01\x08\x00"
+#define CMD_LEN 40
+#define RECV_LEN 0x200
+
+/* Initialize the Karma and get it into mass storage mode.  
+ * 
+ * The initialization begins by sending 40 bytes starting
+ * RIOP\x00\x01\x08\x00, which the device will ack with a 512-byte
+ * packet with the high four bits set and everything else null.
+ *
+ * Next, we send RIOP\x80\x00\x08\x00.  Each time, a 512 byte response
+ * must be read, but we must loop until byte 5 in the response is 0x08,
+ * indicating success. 
+ */
+int rio_karma_init(struct us_data *us) 
+{
+	int result, partial;
+	char *recv;
+	static char init_cmd[] = RIOP_INIT;
+	unsigned long timeout;
+
+	// us->iobuf is big enough to hold cmd but not receive
+	if (!(recv = kmalloc(RECV_LEN, GFP_KERNEL | __GFP_DMA)))
+		goto die_nomem;
+
+	US_DEBUGP("Initializing Karma...\n");
+
+	memcpy(us->iobuf, init_cmd, sizeof(init_cmd));
+	memset(&us->iobuf[sizeof(init_cmd)], 0, CMD_LEN - sizeof(init_cmd));
+
+	result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe, 
+		us->iobuf, CMD_LEN, &partial);
+	if (result != USB_STOR_XFER_GOOD)
+		goto die;
+
+	result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe, 
+		recv, RECV_LEN, &partial);
+	if (result != USB_STOR_XFER_GOOD)
+		goto die;
+
+	us->iobuf[4] = 0x80;
+	us->iobuf[5] = 0;
+	timeout = jiffies + msecs_to_jiffies(3000); 
+	for (;;) {
+		US_DEBUGP("Sending init command\n");
+		result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe, 
+			us->iobuf, CMD_LEN, &partial);
+		if (result != USB_STOR_XFER_GOOD)
+			goto die;
+
+		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe, 
+			recv, RECV_LEN, &partial);
+		if (result != USB_STOR_XFER_GOOD)
+			goto die;
+		
+		if (recv[5] == RIO_MSC) 
+			break;
+		if (time_after(jiffies, timeout))
+			goto die;
+		msleep(10);
+	}
+	US_DEBUGP("Karma initialized.\n");
+	kfree(recv);
+	return 0;
+
+die:
+	kfree(recv);
+die_nomem:
+	US_DEBUGP("Could not initialize karma.\n");
+	return USB_STOR_TRANSPORT_FAILED;
+}
+
diff --git a/drivers/usb/storage/rio_karma.h b/drivers/usb/storage/rio_karma.h
new file mode 100644
index 0000000..99b44fd
--- /dev/null
+++ b/drivers/usb/storage/rio_karma.h
@@ -0,0 +1,9 @@
+#ifndef _RIO_KARMA_H
+#define _RIO_KARMA_H
+
+#include <linux/config.h>
+#include "usb.h"
+
+int rio_karma_init(struct us_data *);
+
+#endif
---
0.99.9i
-- 
Bob Copeland %% www.bobcopeland.com 
