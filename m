Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVCFXRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVCFXRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVCFWmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:42:37 -0500
Received: from coderock.org ([193.77.147.115]:16048 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261590AbVCFWi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:29 -0500
Subject: [patch 7/8] drivers/isdn/i4l/* - compile warning cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, yrgrknmxpzlk@gawab.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:19 +0100
Message-Id: <20050306223819.9A6F51EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


compile warning cleanup - handle copy_to/from_user error 
returns, initialize return value to reasonable number in case used before 
initialized.

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/i4l/isdn_common.c |    6 +++++-
 kj-domen/drivers/isdn/i4l/isdn_ppp.c    |    3 ++-
 kj-domen/drivers/isdn/i4l/isdn_v110.c   |    2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff -puN drivers/isdn/i4l/isdn_common.c~return_code-drivers_isdn_i4l drivers/isdn/i4l/isdn_common.c
--- kj/drivers/isdn/i4l/isdn_common.c~return_code-drivers_isdn_i4l	2005-03-05 16:13:07.000000000 +0100
+++ kj-domen/drivers/isdn/i4l/isdn_common.c	2005-03-05 16:13:07.000000000 +0100
@@ -1843,8 +1843,12 @@ isdn_writebuf_stub(int drvidx, int chan,
 	if (!skb)
 		return 0;
 	skb_reserve(skb, hl);
-	copy_from_user(skb_put(skb, len), buf, len);
+	if (copy_from_user(skb_put(skb, len), buf, len)) {
+		ret = -EFAULT;
+		goto after_writebuf_skb;
+	}
 	ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, skb);
+after_writebuf_skb:
 	if (ret <= 0)
 		dev_kfree_skb(skb);
 	if (ret > 0)
diff -puN drivers/isdn/i4l/isdn_ppp.c~return_code-drivers_isdn_i4l drivers/isdn/i4l/isdn_ppp.c
--- kj/drivers/isdn/i4l/isdn_ppp.c~return_code-drivers_isdn_i4l	2005-03-05 16:13:07.000000000 +0100
+++ kj-domen/drivers/isdn/i4l/isdn_ppp.c	2005-03-05 16:13:07.000000000 +0100
@@ -789,7 +789,8 @@ isdn_ppp_read(int min, struct file *file
 	is->first = b;
 
 	spin_unlock_irqrestore(&is->buflock, flags);
-	copy_to_user(buf, save_buf, count);
+	if (copy_to_user(buf, save_buf, count))
+		count = -EFAULT; /* make sure we free the save_buf */
 	kfree(save_buf);
 
 	return count;
diff -puN drivers/isdn/i4l/isdn_v110.c~return_code-drivers_isdn_i4l drivers/isdn/i4l/isdn_v110.c
--- kj/drivers/isdn/i4l/isdn_v110.c~return_code-drivers_isdn_i4l	2005-03-05 16:13:07.000000000 +0100
+++ kj-domen/drivers/isdn/i4l/isdn_v110.c	2005-03-05 16:13:07.000000000 +0100
@@ -520,7 +520,7 @@ isdn_v110_stat_callback(int idx, isdn_ct
 {
 	isdn_v110_stream *v = NULL;
 	int i;
-	int ret;
+	int ret = 0;
 
 	if (idx < 0)
 		return 0;
_
