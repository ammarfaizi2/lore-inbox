Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUJTA0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUJTA0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUJTAXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:23:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:19124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268053AbUJTATg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:36 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315042830@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <10982315043635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.3, 2004/09/14 10:50:58-07:00, khali@linux-fr.org

[PATCH] I2C: More verbose debug in w83781d detection

Quoting myself:
> As for me, I will propose my extra-debug patch (slightly cleaned up)
> for inclusion into the 2.6 kernel. It helped us once, so it could
> prove to be valuable in the future as well.

Here is the patch. It makes the w83781d (mis)detection more verbose so
as to help debugging problems. The extra messages of course only show
when I2C chip debugging is enabled. It additionally features some code
refactoring, some CodingStyle cleanups and adds a missing white space in
one debug message.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83781d.c |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-10-19 16:55:16 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-10-19 16:55:16 -07:00
@@ -1062,6 +1062,9 @@
 	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
+			dev_dbg(&adapter->dev, "Request of region "
+				"0x%x-0x%x for w83781d failed\n", address,
+				address + W83781D_EXTENT - 1);
 			err = -EBUSY;
 			goto ERROR0;
 		}
@@ -1075,15 +1078,11 @@
 			/* We need the timeouts for at least some LM78-like
 			   chips. But only if we read 'undefined' registers. */
 			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 3) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 7) != i) {
+			if (inb_p(address + 2) != i
+			 || inb_p(address + 3) != i
+			 || inb_p(address + 7) != i) {
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 1\n");
 				err = -ENODEV;
 				goto ERROR1;
 			}
@@ -1092,8 +1091,13 @@
 			/* Let's just hope nothing breaks here */
 			i = inb_p(address + 5) & 0x7f;
 			outb_p(~i & 0x7f, address + 5);
-			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
+			val2 = inb_p(address + 5) & 0x7f;
+			if (val2 != (~i & 0x7f)) {
 				outb_p(i, address + 5);
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 2 (0x%x != "
+					"0x%x at 0x%x)\n", val2, ~i & 0x7f,
+					address + 5);
 				err = -ENODEV;
 				goto ERROR1;
 			}
@@ -1125,7 +1129,9 @@
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80){
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80) {
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"3\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1135,6 +1141,8 @@
 		if ((!(val1 & 0x07)) &&
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"4\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1144,6 +1152,8 @@
 				  ((val1 & 0x80) && (val2 == 0x5c)))) {
 			if (w83781d_read_value
 			    (new_client, W83781D_REG_I2C_ADDR) != address) {
+				dev_dbg(&new_client->dev, "Detection failed "
+					"at step 5\n");
 				err = -ENODEV;
 				goto ERROR2;
 			}
@@ -1166,6 +1176,8 @@
 		else if (val2 == 0x12)
 			vendid = asus;
 		else {
+			dev_dbg(&new_client->dev, "Chip was made by neither "
+				"Winbond nor Asus?\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1186,10 +1198,10 @@
 			kind = w83697hf;
 		else {
 			if (kind == 0)
-				dev_warn(&new_client->dev,
-				       "Ignoring 'force' parameter for unknown chip at"
-				       "adapter %d, address 0x%02x\n",
-				       i2c_adapter_id(adapter), address);
+				dev_warn(&new_client->dev, "Ignoring 'force' "
+					 "parameter for unknown chip at "
+					 "adapter %d, address 0x%02x\n",
+					 i2c_adapter_id(adapter), address);
 			err = -EINVAL;
 			goto ERROR2;
 		}

