Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVEQW0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEQW0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVEQWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:24:19 -0400
Received: from [85.8.12.41] ([85.8.12.41]:14762 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262022AbVEQWTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:19:33 -0400
Message-ID: <428A6DF2.2010604@drzeus.cx>
Date: Wed, 18 May 2005 00:19:30 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-5861-1116368372-0001-2"
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 2/2] Proper MMC command classes support
References: <428A6C3A.40505@drzeus.cx>
In-Reply-To: <428A6C3A.40505@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-5861-1116368372-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Removes the check for high command classes and instead checks that the
command classes needed are present.
Previous solution killed forward compatibility at no apparent gain.

Signed-of-by: Pierre Ossman <drzeus@drzeus.cx>

This patch only checks for CCC_BLOCK_READ even though CCC_BLOCK_WRITE is
also needed. My intention is to make the card read-only if the write
command class is unavailable. But such a patch will conflict with the SD
patches previously submitted. So I need to know which version should be
used as a base.


--=_hermes.drzeus.cx-5861-1116368372-0001-2
Content-Type: text/x-patch; name="mmc-block-ccc.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-block-ccc.patch"

Index: linux-wbsd/drivers/mmc/mmc_block.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc_block.c	(revision 134)
+++ linux-wbsd/drivers/mmc/mmc_block.c	(working copy)
@@ -443,7 +443,10 @@
 	struct mmc_blk_data *md;
 	int err;
 
-	if (card->csd.cmdclass & ~0x1ff)
+	/*
+	 * Check that the card supports the command class(es) we need.
+	 */
+	if (!(card->csd.cmdclass & CCC_BLOCK_READ))
 		return -ENODEV;
 
 	if (card->csd.read_blkbits < 9) {

--=_hermes.drzeus.cx-5861-1116368372-0001-2--
