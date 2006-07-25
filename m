Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWGYDyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWGYDyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 23:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWGYDyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 23:54:54 -0400
Received: from mail.windriver.com ([147.11.1.11]:24226 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S932289AbWGYDyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 23:54:53 -0400
Message-ID: <44C595ED.7070209@windriver.com>
Date: Tue, 25 Jul 2006 11:54:21 +0800
From: Mark Zhan <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: linux-mtd@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the unlock addr lookup BUG in MTD JEDEC probe
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jul 2006 03:54:25.0432 (UTC) FILETIME=[053E9980:01C6AF9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch fixes a BUG in the function finfo_uaddr() in driver/mtd/chips/jedec_probe.c.
This function will fetch the unlock addr type from the pre-defined flash chip info.

static inline __u8 finfo_uaddr(const struct amd_flash_info *finfo, int device_type)
{
	int uaddr_idx;
	__u8 uaddr = MTD_UADDR_NOT_SUPPORTED;

	switch ( device_type ) {
	case CFI_DEVICETYPE_X8:  uaddr_idx = 0; break;
	case CFI_DEVICETYPE_X16: uaddr_idx = 1; break;
	case CFI_DEVICETYPE_X32: uaddr_idx = 2; break;
	default:
		printk(KERN_NOTICE "MTD: %s(): unknown device_type %d\n",
		       __func__, device_type);
		goto uaddr_done;
	}

	uaddr = finfo->uaddr[uaddr_idx];

	if (uaddr != MTD_UADDR_NOT_SUPPORTED ) {
		/* ASSERT("The unlock addresses for non-8-bit mode
		   are bollocks. We don't really need an array."); */
		uaddr = finfo->uaddr[0];
	}

  uaddr_done:
	return uaddr;
}

However, the later 'if' sentence will force that the first unlock addr type is always returned.
If a chip has two device types (x8 x16) and the chip works in x16 mode, this bug will result in
that the chip can't be probed correctly because the unlock addr doesn't match.

This patch fixes this bug.

Signed-off-by: Rongkai.Zhan <rongkai.zhan@windriver.com>

----
diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 8f39d0a..a0ab0df 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1804,7 +1804,7 @@ static inline __u8 finfo_uaddr(const str

  	uaddr = finfo->uaddr[uaddr_idx];

-	if (uaddr != MTD_UADDR_NOT_SUPPORTED ) {
+	if (uaddr == MTD_UADDR_NOT_SUPPORTED ) {
  		/* ASSERT("The unlock addresses for non-8-bit mode
  		   are bollocks. We don't really need an array."); */
  		uaddr = finfo->uaddr[0];
