Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTDXXit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTDXXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:38:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35234 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264504AbTDXXeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:08 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280522043@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280523879@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.6, 2003/04/23 12:06:40-07:00, baldrick@wanadoo.fr

[PATCH] USB speedtouch: crc optimization


 drivers/usb/misc/speedtch.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Thu Apr 24 16:26:18 2003
+++ b/drivers/usb/misc/speedtch.c	Thu Apr 24 16:26:18 2003
@@ -406,11 +406,12 @@
 **  encode  **
 *************/
 
+static const unsigned char zeros[ATM_CELL_PAYLOAD];
+
 static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct udsl_control *ctrl = UDSL_SKB (skb);
-	unsigned int i, zero_padding;
-	unsigned char zero = 0;
+	unsigned int zero_padding;
 	u32 crc;
 
 	ctrl->atm_data.vcc = vcc;
@@ -436,8 +437,7 @@
 	ctrl->aal5_trailer [3] = skb->len;
 
 	crc = crc32_be (~0, skb->data, skb->len);
-	for (i = 0; i < zero_padding; i++)
-		crc = crc32_be (crc, &zero, 1);
+	crc = crc32_be (crc, zeros, zero_padding);
 	crc = crc32_be (crc, ctrl->aal5_trailer, 4);
 	crc = ~crc;
 

