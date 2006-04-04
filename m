Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWDDTJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWDDTJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDDTJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:09:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45583 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750818AbWDDTJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:09:36 -0400
Date: Tue, 4 Apr 2006 21:09:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/tg3.c: fix a memory leak
Message-ID: <20060404190935.GB6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak (buf wasn't freed) spotted by the 
Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/tg3.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc1-mm1-full/drivers/net/tg3.c.old	2006-04-04 19:53:24.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/net/tg3.c	2006-04-04 19:54:40.000000000 +0200
@@ -8031,15 +8031,19 @@ static int tg3_test_nvram(struct tg3 *tp
 	if (cpu_to_be32(buf[0]) != TG3_EEPROM_MAGIC) {
 		u8 *buf8 = (u8 *) buf, csum8 = 0;
 
 		for (i = 0; i < size; i++)
 			csum8 += buf8[i];
 
-		if (csum8 == 0)
-			return 0;
-		return -EIO;
+		if (csum8 == 0) {
+			err = 0;
+			goto out;
+		}
+
+		err = -EIO;
+		goto out;
 	}
 
 	/* Bootstrap checksum at offset 0x10 */
 	csum = calc_crc((unsigned char *) buf, 0x10);
 	if(csum != cpu_to_le32(buf[0x10/4]))
 		goto out;

