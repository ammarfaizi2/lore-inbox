Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWCTWCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWCTWCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWCTWBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:60089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030541AbWCTWBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:16 -0500
Cc: Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/23] firmware: fix BUG: in fw_realloc_buffer
In-Reply-To: <11428920381250-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920382138-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fw_realloc_buffer routine does not handle an increase in buffer size of
more than 4k.  It's not clear to me why it expects that it will only get an
extra 4k of data.  The attached patch modifies fw_realloc_buffer to vmalloc
as much memory as is requested, instead of what we previously had + 4k.

I've tested this on my laptop, which would crash occaisionally on boot
without the patch.  With the patch, it hasn't crashed, but I can't be
certain that this code path is exercised.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/firmware_class.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

30560ba6eda308c13a361d08eb5d4eaab94ab37e
diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index e97e911..4723182 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -211,18 +211,20 @@ static int
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
 	u8 *new_data;
+	int new_size = fw_priv->alloc_size;
 
 	if (min_size <= fw_priv->alloc_size)
 		return 0;
 
-	new_data = vmalloc(fw_priv->alloc_size + PAGE_SIZE);
+	new_size = ALIGN(min_size, PAGE_SIZE);
+	new_data = vmalloc(new_size);
 	if (!new_data) {
 		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
 		fw_load_abort(fw_priv);
 		return -ENOMEM;
 	}
-	fw_priv->alloc_size += PAGE_SIZE;
+	fw_priv->alloc_size = new_size;
 	if (fw_priv->fw->data) {
 		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
 		vfree(fw_priv->fw->data);
-- 
1.2.4


