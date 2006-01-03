Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWACXdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWACXdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWACXdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:33:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37016 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965099AbWACX3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:46 -0500
To: torvalds@osdl.org
Subject: [PATCH 40/41] m68k: fix PIO case in esp
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvb7-0003Q2-Qg@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135537383 -0500

we always set ->SCp.ptr to physical address of buffer; for DMA that's
just what we need, but we end up using it as virtual address in PIO
case of esp_do_data(), with obvious breakage as soon as memory mapping
becomes non-trivial.  The fix is obvious.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/scsi/NCR53C9x.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

7f89e0aea371b83e79fb3752b7dd6deeb21f01d9
diff --git a/drivers/scsi/NCR53C9x.c b/drivers/scsi/NCR53C9x.c
index 640590b..c7dd015 100644
--- a/drivers/scsi/NCR53C9x.c
+++ b/drivers/scsi/NCR53C9x.c
@@ -1799,6 +1799,7 @@ static int esp_do_data(struct NCR_ESP *e
 		 */
 		int oldphase, i = 0; /* or where we left off last time ?? esp->current_data ?? */
 		int fifocnt = 0;
+		unsigned char *p = phys_to_virt((unsigned long)SCptr->SCp.ptr);
 
 		oldphase = esp_read(eregs->esp_status) & ESP_STAT_PMASK;
 
@@ -1860,7 +1861,7 @@ static int esp_do_data(struct NCR_ESP *e
 
 				/* read fifo */
 				for(j=0;j<fifocnt;j++)
-					SCptr->SCp.ptr[i++] = esp_read(eregs->esp_fdata);
+					p[i++] = esp_read(eregs->esp_fdata);
 
 				ESPDATA(("(%d) ", i));
 
@@ -1882,7 +1883,7 @@ static int esp_do_data(struct NCR_ESP *e
 
 				/* fill fifo */
 				for(j=0;j<this_count;j++)
-					esp_write(eregs->esp_fdata, SCptr->SCp.ptr[i++]);
+					esp_write(eregs->esp_fdata, p[i++]);
 
 				/* how many left if this goes out ?? */
 				hmuch -= this_count;
-- 
0.99.9.GIT

