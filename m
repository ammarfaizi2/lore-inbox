Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWHVPJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWHVPJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHVPJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:09:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:3956 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932299AbWHVPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:09:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:message-id;
        b=Y+c/qldbbU7h26W89rQwNk/ps8GoaHhKra4a9Accyzo2HZpoj8oNZaa4fBWBVzCSVLTnlCtbWwtSXM2Ysf2XrGAi25LIUdRdwDSziGcqoiNFFKFPxYRjHk2KnsjhrIZFk+wId4ZAEyJmL5H8MCqnKOBBKTBT+0op+SEt0M92/y4=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] remove references to MAX_UDELAY_MS; fix comment
Date: Tue, 22 Aug 2006 15:51:48 +0200
User-Agent: KMail/1.8.2
References: <200608221545.26019.vda.linux@googlemail.com> <200608221548.37192.vda.linux@googlemail.com>
In-Reply-To: <200608221548.37192.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0vw6EJmsZ76XDUz"
Message-Id: <200608221551.48423.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_0vw6EJmsZ76XDUz
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 August 2006 15:48, Denis Vlasenko wrote:
> A few arch files won't see the definition of udelay()
> in asm/delay.h anymore. Prevent that from biting us later.

We are going to kill MAX_UDELAY_MS, so replace it
in common code with 1. Also fix a buglet on the way:
mpc83xx_spi->nsecs > MAX_UDELAY_MS * 1000
was comparing nanoseconds to microseconds.

Signed-off-by: Denis Vlasenko <vda.linux@googlemail.com>
--
vda

--Boundary-00=_0vw6EJmsZ76XDUz
Content-Type: text/x-diff;
  charset="koi8-r";
  name="delay_new7.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delay_new7.2.patch"

diff -urpN linux-2.6.17.9.new7.1/drivers/scsi/ipr.c linux-2.6.17.9.new7.2/drivers/scsi/ipr.c
--- linux-2.6.17.9.new7.1/drivers/scsi/ipr.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.2/drivers/scsi/ipr.c	2006-08-22 15:28:17.000000000 +0200
@@ -1598,11 +1598,7 @@ static int ipr_wait_iodbg_ack(struct ipr
 		if (pcii_reg & IPR_PCII_IO_DEBUG_ACKNOWLEDGE)
 			return 0;
 
-		/* udelay cannot be used if delay is more than a few milliseconds */
-		if ((delay / 1000) > MAX_UDELAY_MS)
-			mdelay(delay / 1000);
-		else
-			udelay(delay);
+		udelay(delay);
 
 		delay += delay;
 	}
diff -urpN linux-2.6.17.9.new7.1/drivers/spi/spi_bitbang.c linux-2.6.17.9.new7.2/drivers/spi/spi_bitbang.c
--- linux-2.6.17.9.new7.1/drivers/spi/spi_bitbang.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.2/drivers/spi/spi_bitbang.c	2006-08-22 15:28:17.000000000 +0200
@@ -169,7 +169,7 @@ int spi_bitbang_setup_transfer(struct sp
 		hz = spi->max_speed_hz;
 	if (hz) {
 		cs->nsecs = (1000000000/2) / hz;
-		if (cs->nsecs > (MAX_UDELAY_MS * 1000 * 1000))
+		if (cs->nsecs > (1000 * 1000))
 			return -EINVAL;
 	}
 
diff -urpN linux-2.6.17.9.new7.1/drivers/spi/spi_mpc83xx.c linux-2.6.17.9.new7.2/drivers/spi/spi_mpc83xx.c
--- linux-2.6.17.9.new7.1/drivers/spi/spi_mpc83xx.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.2/drivers/spi/spi_mpc83xx.c	2006-08-22 15:28:17.000000000 +0200
@@ -211,7 +211,7 @@ int mpc83xx_spi_setup_transfer(struct sp
 	if (!hz)
 		hz = spi->max_speed_hz;
 	mpc83xx_spi->nsecs = (1000000000 / 2) / hz;
-	if (mpc83xx_spi->nsecs > MAX_UDELAY_MS * 1000)
+	if (mpc83xx_spi->nsecs > (1000 * 1000))
 		return -EINVAL;
 
 	if (bits_per_word == 32)
diff -urpN linux-2.6.17.9.new7.1/include/asm-parisc/delay.h linux-2.6.17.9.new7.2/include/asm-parisc/delay.h
--- linux-2.6.17.9.new7.1/include/asm-parisc/delay.h	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.2/include/asm-parisc/delay.h	2006-08-22 15:28:17.000000000 +0200
@@ -24,9 +24,8 @@ static __inline__ void __cr16_delay(unsi
 
 	/*
 	 * Note: Due to unsigned math, cr16 rollovers shouldn't be
-	 * a problem here. However, on 32 bit, we need to make sure
-	 * we don't pass in too big a value. The current default
-	 * value of MAX_UDELAY_MS should help prevent this.
+	 * a problem here. On 32 bit, we are protected in udelay()
+	 * from passing in too big a value.
 	 */
 
 	start = mfctl(16);

--Boundary-00=_0vw6EJmsZ76XDUz--
