Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269950AbUJTECy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbUJTECy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269885AbUJTAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:25:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:23476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268189AbUJTATi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:38 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315063481@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <10982315061975@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2071, 2004/10/19 15:20:59-07:00, R.Marek@sh.cvut.cz

[PATCH] I2C: fix it8712 detection

Following patch fixes the bug introduced by me in VID VRM patch.
Spotted (and later reviewed) by Jean Delvare. This bug is non-fatal,
it8712 will be just treated as it was before my VID VRM patch.

Tested on it8705 and it8712  hardware.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-10-19 16:54:04 -07:00
+++ b/drivers/i2c/chips/it87.c	2004-10-19 16:54:04 -07:00
@@ -105,6 +105,10 @@
 /* Reset the registers on init if true */
 static int reset;
 
+/* Chip Type */
+
+static u16 chip_type;
+
 /* Many IT87 constants specified below */
 
 /* Length of ISA address segment */
@@ -592,9 +596,9 @@
 	u16 val;
 
 	superio_enter();
-	val = (superio_inb(DEVID) << 8) |
+	chip_type = (superio_inb(DEVID) << 8) |
 	       superio_inb(DEVID + 1);
-	if (val != IT8712F_DEVID) {
+	if (chip_type != IT8712F_DEVID) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -691,11 +695,9 @@
 	if (kind <= 0) {
 		i = it87_read_value(new_client, IT87_REG_CHIPID);
 		if (i == 0x90) {
-			u16 val;
 			kind = it87;
-			val = (superio_inb(DEVID) << 8) |
-			superio_inb(DEVID + 1);
-			if (val == IT8712F_DEVID) kind = it8712;
+			if ((is_isa) && (chip_type == IT8712F_DEVID))
+				kind = it8712;
 		}
 		else {
 			if (kind == 0)

