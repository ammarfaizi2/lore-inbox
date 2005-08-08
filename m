Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVHHLir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVHHLir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVHHLir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:38:47 -0400
Received: from [85.8.12.41] ([85.8.12.41]:57996 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750826AbVHHLiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:38:46 -0400
Message-ID: <42F74425.90908@drzeus.cx>
Date: Mon, 08 Aug 2005 13:38:13 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-30146-1123501124-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk> <42D81AD7.3000407@drzeus.cx> <20050718184554.A31022@flint.arm.linux.org.uk>
In-Reply-To: <20050718184554.A31022@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-30146-1123501124-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Russell King wrote:

>
>I still don't like the needless duplication.  How about doing it this
>way (see the attached patch.)
>
>Note: I also intend to move MMC over to using an IDR for the host
>numbers, which is why we need to setup the name at registration
>time, not allocation time.
>
>  
>

This patch should cover the edge case of allocating but not registering
a host.

Rgds
Pierre


--=_hermes.drzeus.cx-30146-1123501124-0001-2
Content-Type: text/x-patch; name="04-safe_free.diff"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-safe_free.diff"

diff -uNp linux-2.6.13-rc6/drivers/mmc.orig/mmc.c linux-2.6.13-rc6/drivers/mmc/mmc.c
--- linux-2.6.13-rc6/drivers/mmc.orig/mmc.c	2005-08-08 13:29:53.000000000 +0200
+++ linux-2.6.13-rc6/drivers/mmc/mmc.c	2005-08-08 13:36:08.000000000 +0200
@@ -874,7 +874,11 @@ EXPORT_SYMBOL(mmc_remove_host);
 void mmc_free_host(struct mmc_host *host)
 {
 	flush_scheduled_work();
-	mmc_free_host_sysfs(host);
+
+	if (host->class_dev.class != NULL)
+		mmc_free_host_sysfs(host);
+	else
+		kfree(host);
 }
 
 EXPORT_SYMBOL(mmc_free_host);

--=_hermes.drzeus.cx-30146-1123501124-0001-2--
