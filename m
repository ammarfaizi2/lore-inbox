Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWBMWbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWBMWbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWBMWbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:31:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030218AbWBMWbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:31:41 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17393.2242.720631.636489@segfault.boston.redhat.com>
Date: Mon, 13 Feb 2006 17:31:30 -0500
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, akpm@osdl.org
Subject: [patch] fix BUG: in fw_realloc_buffer
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fw_realloc_buffer routine does not handle an increase in buffer size of
more than 4k.  It's not clear to me why it expects that it will only get an
extra 4k of data.  The attached patch modifies fw_realloc_buffer to vmalloc
as much memory as is requested, instead of what we previously had + 4k.

I've tested this on my laptop, which would crash occaisionally on boot
without the patch.  With the patch, it hasn't crashed, but I can't be
certain that this code path is exercised.

Comments are very welcome.

Thanks,

Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- vanilla/drivers/base/firmware_class.c.orig	2006-02-13 15:46:15.000000000 -0500
+++ vanilla/drivers/base/firmware_class.c	2006-02-13 15:46:04.000000000 -0500
@@ -211,18 +211,22 @@ static int
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
 	u8 *new_data;
+	int new_size = fw_priv->alloc_size;
 
 	if (min_size <= fw_priv->alloc_size)
 		return 0;
 
-	new_data = vmalloc(fw_priv->alloc_size + PAGE_SIZE);
+	while (new_size < min_size)
+		new_size += PAGE_SIZE;
+
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
