Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVKWLdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVKWLdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVKWLdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:33:52 -0500
Received: from mail.deathmatch.net ([216.200.85.210]:58010 "EHLO
	mail.deathmatch.net") by vger.kernel.org with ESMTP id S965124AbVKWLdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:33:51 -0500
Date: Wed, 23 Nov 2005 06:33:42 -0500
From: Bob Copeland <me@bobcopeland.com>
To: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] usb-storage: Add support for Rio Karma
Message-ID: <20051123113342.GA5815@hash.localnet>
References: <20051123040752.GA5595@hash.localnet> <20051123065427.GA23218@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123065427.GA23218@one-eyed-alien.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:54:27PM -0800, Matthew Dharm wrote:
> I'm guessing you're missing some significant portions of patch here... this
> code isn't compiled/linked, you don't add to the unusual_devs table, all
> you have here is an initializer function, etc etc.
> 
> The material on your web page supports this conclusion.

Oh, sorry, I fumbled the git commands to generate that one.  Here's the
full patch:

Subject: [PATCH] usb-storage: Add support for Rio Karma

Add support for the Rio Karma portable digital audio player to usb-storage.

Signed-off-by: Bob Copeland <me@bobcopeland.com>
---

 Kconfig        |    7 +++
 Makefile       |    1 
 rio_karma.c    |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rio_karma.h    |    9 ++++
 unusual_devs.h |    7 +++
 usb.c          |    3 +
 6 files changed, 131 insertions(+)
diff --git a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
index c41d64d..1a7bd5d 100644
--- a/drivers/usb/storage/Kconfig
+++ b/drivers/usb/storage/Kconfig
@@ -124,3 +124,10 @@ config USB_STORAGE_ONETOUCH
 	  hard drive's as an input device. An action can be associated with
 	  this input in any keybinding software. (e.g. gnome's keyboard short-
 	  cuts)
+
+config USB_STORAGE_KARMA
+	bool "Rio Karma MP3 player (EXPERIMENTAL)"
+	depends on USB_STORAGE && EXPERIMENTAL
+	help
+	  Say Y here to include additional code to support the Rio Karma
+	  digital music player as a mass storage device.
diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
index 44ab8f9..5f90c2b 100644
--- a/drivers/usb/storage/Makefile
+++ b/drivers/usb/storage/Makefile
@@ -19,6 +19,7 @@ usb-storage-obj-$(CONFIG_USB_STORAGE_ISD
 usb-storage-obj-$(CONFIG_USB_STORAGE_DATAFAB)	+= datafab.o
 usb-storage-obj-$(CONFIG_USB_STORAGE_JUMPSHOT)	+= jumpshot.o
 usb-storage-obj-$(CONFIG_USB_STORAGE_ONETOUCH)	+= onetouch.o
+usb-storage-obj-$(CONFIG_USB_STORAGE_KARMA)	+= rio_karma.o
 
 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
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
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 0a9858f..a223519 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -145,6 +145,13 @@ UNUSUAL_DEV(  0x0451, 0x5416, 0x0100, 0x
 		US_SC_DEVICE, US_PR_BULK, NULL,
 		US_FL_NEED_OVERRIDE ),
 
+#ifdef CONFIG_USB_STORAGE_KARMA
+UNUSUAL_DEV(  0x045a, 0x5210, 0x0101, 0x0101,
+		"Rio",
+		"Rio Karma",
+		US_SC_SCSI, US_PR_BULK, rio_karma_init, US_FL_FIX_INQUIRY),
+#endif
+
 /* Patch submitted by Philipp Friedrich <philipp@void.at> */
 UNUSUAL_DEV(  0x0482, 0x0100, 0x0100, 0x0100,
 		"Kyocera",
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 3847ebe..caeaa5e 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -94,6 +94,9 @@
 #ifdef CONFIG_USB_STORAGE_ONETOUCH
 #include "onetouch.h"
 #endif
+#ifdef CONFIG_USB_STORAGE_KARMA
+#include "rio_karma.h"
+#endif
 
 /* Some informational data */
 MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");



