Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWADVna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWADVna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWADVna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:43:30 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:23520 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1751233AbWADVn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:43:29 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Greg KH <greg@kroah.com>
Subject: [Patch 2.6] dm-crypt: Zero key material before free to avoid information leak
Date: Wed, 4 Jan 2006 22:44:57 +0100
User-Agent: KMail/1.8
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       Clemens Fruhwirth <clemens@endorphin.org>, stable@kernel.org,
       Arjan van de Ven <arjan@infradead.org>
References: <200601042108.04544.stefan@loplof.de> <Pine.LNX.4.58.0601041242270.19134@shark.he.net> <20060104211526.GA12042@kroah.com>
In-Reply-To: <20060104211526.GA12042@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042244.58683.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 04 Januar 2006 22:15 schrieb Greg KH:

> Yes, Stefan, care to redo this with an updated changelog command?


dm-crypt should clear struct crypt_config before freeing it to
avoid information leak f.e. to a swsusp image.

Signed-off-by: Stefan Rompf <stefan@loplof.de>
Acked-by: Clemens Fruhwirth <clemens@endorphin.org>

--- linux-2.6.15/drivers/md/dm-crypt.c.orig	2006-01-04 01:01:16.000000000 +0100
+++ linux-2.6.15/drivers/md/dm-crypt.c	2006-01-04 22:35:13.000000000 +0100
@@ -690,6 +690,8 @@
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
+	/* Zero key material before free to avoid information leak */
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 	return -EINVAL;
 }
@@ -706,6 +708,9 @@
 		cc->iv_gen_ops->dtr(cc);
 	crypto_free_tfm(cc->tfm);
 	dm_put_device(ti, cc->dev);
+
+	/* Zero key material before free to avoid information leak */
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 }
 
