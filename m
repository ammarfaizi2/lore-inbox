Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSLBL6P>; Mon, 2 Dec 2002 06:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSLBL6P>; Mon, 2 Dec 2002 06:58:15 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:19699 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262631AbSLBL6O>; Mon, 2 Dec 2002 06:58:14 -0500
Message-Id: <200212021205.NAA22003@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] Unsafe MODULE_ usage in crc32.c
To: Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org
Date: Mon, 02 Dec 2002 14:31:10 +0100
References: <20021130181224.4b4cddad.arashi@arashi.yi.org>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reppert wrote:

> Okay, I know, it's just a library module, doesn't need to ever be unloaded
> anyway. But error noise in dmesg annoys me, hence this patch.

I don't think you even need to set the use count at all for crc32:
As long as another module is using it, you can't unload it because
the exported symbols are used. When those symbols are not known
to other modules, it is also safe to unload crc32.

I noticed another small problem with init_crc: if crc32init_be()
fails, the memory allocated by crc32init_le() is never freed,
see below.

	Arnd <><

--- 1.5/lib/crc32.c	Mon Apr  8 22:22:00 2002
+++ edited/lib/crc32.c	Mon Dec  2 14:25:37 2002
@@ -547,11 +547,13 @@
  */
 static int __init init_crc32(void)
 {
-	int rc1, rc2, rc;
-	rc1 = crc32init_le();
-	rc2 = crc32init_be();
-	rc = rc1 || rc2;
-	if (!rc) MOD_INC_USE_COUNT;
+	int rc;
+	rc = crc32init_le();
+	if (rc)
+		return rc;
+	rc = crc32init_be();
+	if (rc)
+		crc32cleanup_le();
 	return rc;
 }
