Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWCaWW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWCaWW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWCaWW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:22:27 -0500
Received: from amdext4.amd.com ([163.181.251.6]:52953 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751450AbWCaWW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:22:26 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Fri, 31 Mar 2006 15:49:54 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: lm-sensors@lm-sensors.org, info-linux@ldcmail.amd.com, BGardner@Wabtec.com
Subject: [PATCH 2.6] scx200_acb - Fix for CS5535 eratta
Message-ID: <20060331224954.GC17261@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Mar 2006 22:21:20.0018 (UTC)
 FILETIME=[6F812F20:01C65511]
X-WSS-ID: 683374EA33K110776-01-01
Content-Type: multipart/mixed;
 boundary=gKMricLos+KVdGMg
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hey all - This is a fix for the recently added CS5535/CS5536 support in
the scx200_acb driver.  This works around an errata in the CS5535 that 
sometimes results in NEGACK not being cleared.  It would be great if we
could get this into 2.6.17 with the driver.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--gKMricLos+KVdGMg
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=smb-stsreset.patch
Content-Transfer-Encoding: 7bit

[PATCH] scx200_acb: Fix for negack clear errata

From: Jordan Crouse <jordan.crouse@amd.com>

This patch is a fix for the CS5535 errata 111:

When the SMB controller tries to access a non-existing device, it sets
the NEGACK bit, SMB I/O Offset 01h[4], to 1 after it detects no
acknowledge at the ninth clock. The specification says there are only
two ways to clear this status bit: write 1 to this bit or disable the
SMB controller. Sometimes this bit is cleared by a read of this
register, but not always.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/i2c/busses/scx200_acb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 8bd305e..e7a2225 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -133,6 +133,9 @@ static void scx200_acb_machine(struct sc
 
 		outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 		outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+
+		/* Reset the status register */
+		outb(0, ACBST);
 		return;
 	}
 
@@ -228,6 +231,10 @@ static void scx200_acb_poll(struct scx20
 	timeout = jiffies + POLL_TIMEOUT;
 	while (time_before(jiffies, timeout)) {
 		status = inb(ACBST);
+
+		/* Reset the status register to avoid the hang */
+		outb(0, ACBST);
+
 		if ((status & (ACBST_SDAST|ACBST_BER|ACBST_NEGACK)) != 0) {
 			scx200_acb_machine(iface, status);
 			return;

--gKMricLos+KVdGMg--

