Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUAYKip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 05:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUAYKip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 05:38:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:49311 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263996AbUAYKin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 05:38:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 25 Jan 2004 11:38:35 +0100 (MET)
Message-Id: <UTC200401251038.i0PAcZS27912.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [uPATCH] add comments to sddr09.c
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People ask how to write the CIS on a SmartMedia card
using an sddr09 reader/writer. The patch below documents
the required command (but does not add the code).

Two years ago or so I used this to fix the CIS on a card
that my camera no longer wanted to accept. A Linux utility
to do this might be useful, but the problem always is that
we do not really have a good mechanism.

How does one tell a driver that it has to do something special?
Add yet another ioctl?

Andries

--- /linux/2.6/linux-2.6.1/linux/drivers/usb/storage/sddr09.c	2004-01-11 14:20:50.000000000 +0100
+++ sddr09.c	2004-01-25 11:26:19.000000000 +0100
@@ -27,6 +27,20 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+/*
+ * Known vendor commands: 12 bytes, first byte is opcode
+ *
+ * E7: read scatter gather
+ * E8: read
+ * E9: write
+ * EA: erase
+ * EB: reset
+ * EC: read status
+ * ED: read ID
+ * EE: write CIS (?)
+ * EF: compute checksum (?)
+ */
+
 #include "transport.h"
 #include "protocol.h"
 #include "usb.h"
@@ -461,6 +475,7 @@
  * 
  * Always precisely one block is erased; bytes 2-5 and 10-11 are ignored.
  * The byte address being erased is 2*Eaddress.
+ * The CIS cannot be erased.
  */
 static int
 sddr09_erase(struct us_data *us, unsigned long Eaddress) {
@@ -487,6 +502,20 @@
 }
 
 /*
+ * Write CIS Command: 12 bytes.
+ * byte 0: opcode: EE
+ * bytes 2-5: write address in shorts
+ * bytes 10-11: sector count
+ *
+ * This writes at the indicated address. Don't know how it differs
+ * from E9. Maybe it does not erase? However, it will also write to
+ * the CIS.
+ *
+ * When two such commands on the same page follow each other directly,
+ * the second one is not done.
+ */
+
+/*
  * Write Command: 12 bytes.
  * byte 0: opcode: E9
  * bytes 2-5: write address (big-endian, counting shorts, sector aligned).
