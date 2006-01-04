Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWADUIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWADUIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWADUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:08:18 -0500
Received: from natsluvver.rzone.de ([81.169.145.176]:14565 "EHLO
	natsluvver.rzone.de") by vger.kernel.org with ESMTP
	id S1751289AbWADUIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:08:17 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch 2.6] dm-crypt: zero key before freeing it
Date: Wed, 4 Jan 2006 21:08:04 +0100
User-Agent: KMail/1.8
Cc: Clemens Fruhwirth <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042108.04544.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

dm-crypt does not clear struct crypt_config before freeing it. Thus, 
information on the key could leak f.e. to a swsusp image even after the 
encrypted device has been removed. The attached patch against 2.6.14 / 2.6.15 
fixes it.

Signed-off-by: Stefan Rompf <stefan@loplof.de>
Acked-by: Clemens Fruhwirth <clemens@endorphin.org>

--- linux-2.6.14.4/drivers/md/dm-crypt.c.old	2005-12-16 18:27:05.000000000 +0100
+++ linux-2.6.14.4/drivers/md/dm-crypt.c	2005-12-28 12:49:13.000000000 +0100
@@ -694,6 +694,7 @@ bad3:
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 	return -EINVAL;
 }
@@ -710,6 +711,7 @@ static void crypt_dtr(struct dm_target *
 		cc->iv_gen_ops->dtr(cc);
 	crypto_free_tfm(cc->tfm);
 	dm_put_device(ti, cc->dev);
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 }
 

