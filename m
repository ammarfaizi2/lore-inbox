Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755995AbWKRF6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbWKRF6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbWKRF6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:58:45 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:59893 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1755992AbWKRF6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:58:31 -0500
Date: Fri, 17 Nov 2006 21:54:57 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: markus.lidel@shadowconnect.com, akpm <akpm@osdl.org>
Subject: [PATCH] I2O: handle __copy_from_user
Message-Id: <20061117215457.cb800735.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Handle __copy_from_user() return value.

Noticed by inspection, not from build warning.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/message/i2o/i2o_config.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2619-rc5mm2.orig/drivers/message/i2o/i2o_config.c
+++ linux-2619-rc5mm2/drivers/message/i2o/i2o_config.c
@@ -265,7 +265,11 @@ static int i2o_cfg_swdl(unsigned long ar
 		return -ENOMEM;
 	}
 
-	__copy_from_user(buffer.virt, kxfer.buf, fragsize);
+	if (__copy_from_user(buffer.virt, kxfer.buf, fragsize)) {
+		i2o_msg_nop(c, msg);
+		i2o_dma_free(&c->pdev->dev, &buffer);
+		return -EFAULT;
+	}
 
 	msg->u.head[0] = cpu_to_le32(NINE_WORD_MSG_SIZE | SGL_OFFSET_7);
 	msg->u.head[1] =


---
