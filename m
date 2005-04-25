Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVDYRUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVDYRUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDYRN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:13:56 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:36318 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262695AbVDYRI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:08:28 -0400
Message-ID: <426D2409.9020201@acm.org>
Date: Mon, 25 Apr 2005 12:08:25 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix for handling bad IPMI DMI data
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070102020000020006080106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070102020000020006080106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070102020000020006080106
Content-Type: text/x-patch;
 name="ipmi_dmi_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_dmi_fix.diff"

Ignore the bottom bit of the base address from the DMI data.  It
is supposed to be set to 1 if it is I/O space.  Few systems do this,
but this enables the ones that do set it to work properly.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc2/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.12-rc2/drivers/char/ipmi/ipmi_si_intf.c
@@ -1654,7 +1654,13 @@
 		}
 	} else {
 		/* Old DMI spec. */
-		ipmi_data->base_addr = base_addr;
+		/* Note that technically, the lower bit of the base
+		 * address should be 1 if the address is I/O and 0 if
+		 * the address is in memory.  So many systems get that
+		 * wrong (and all that I have seen are I/O) so we just
+		 * ignore that bit and assume I/O.  Systems that use
+		 * memory should use the newer spec, anyway. */
+		ipmi_data->base_addr = base_addr & 0xfffe;
 		ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
 		ipmi_data->offset = 1;
 	}

--------------070102020000020006080106--
