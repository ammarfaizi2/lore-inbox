Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVDYRPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVDYRPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVDYROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:14:08 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:37340 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262674AbVDYRJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:09:24 -0400
Message-ID: <426D2443.3030403@acm.org>
Date: Mon, 25 Apr 2005 12:09:23 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix for handling bad IPMI ACPI data
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010605010100020408040601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010605010100020408040601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010605010100020408040601
Content-Type: text/x-patch;
 name="ipmi_broken_acpi_register_bits.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_broken_acpi_register_bits.diff"

If the ACPI register bit width is zero (an invalid value) assume
it is the default spacing.  This avoids some coredumps on invalid
data and makes some systems work that have broken ACPI data.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc2/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.12-rc2/drivers/char/ipmi/ipmi_si_intf.c
@@ -1557,8 +1557,17 @@
 		info->irq_setup = NULL;
 	}
 
-	regspacings[intf_num] = spmi->addr.register_bit_width / 8;
-	info->io.regspacing = spmi->addr.register_bit_width / 8;
+	if (spmi->addr.register_bit_width) {
+		/* A (hopefully) properly formed register bit width. */
+		regspacings[intf_num] = spmi->addr.register_bit_width / 8;
+		info->io.regspacing = spmi->addr.register_bit_width / 8;
+	} else {
+		/* Some broken systems get this wrong and set the value
+		 * to zero.  Assume it is the default spacing.  If that
+		 * is wrong, too bad, the vendor should fix the tables. */
+		regspacings[intf_num] = DEFAULT_REGSPACING;
+		info->io.regspacing = DEFAULT_REGSPACING;
+	}
 	regsizes[intf_num] = regspacings[intf_num];
 	info->io.regsize = regsizes[intf_num];
 	regshifts[intf_num] = spmi->addr.register_bit_offset;

--------------010605010100020408040601--
