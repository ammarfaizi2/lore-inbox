Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWIVIJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWIVIJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWIVIJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:09:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:23698 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750944AbWIVIJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:message-id;
        b=ADzFxH+AOLW2+KUO5rzgTLdDxQReGjrTWPI+4uwEckhxN5rKIc6kV/xiLNNRm63+eqQcgEKgwrunIJs+NWPAw1k19ZP5HTlLymr0Dq2gJrGwFsBaaoVTL1bYGA5+RSqNMHQ6gdMu+6Oe97qEucSMFC4XsR8d0v5TK1pkZdeRDpM=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 2/3] delay: remove references to MAX_UDELAY_MS; fix comment
Date: Fri, 22 Sep 2006 09:58:52 +0200
User-Agent: KMail/1.8.2
References: <200609220955.35826.vda.linux@googlemail.com> <200609220957.43127.vda.linux@googlemail.com>
In-Reply-To: <200609220957.43127.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8e5EFCXQkunmc+Q"
Message-Id: <200609220958.52736.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8e5EFCXQkunmc+Q
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We are going to kill MAX_UDELAY_MS, so replace it
in common code with 1. Also fix a buglet on the way:
mpc83xx_spi->nsecs > MAX_UDELAY_MS * 1000
was comparing nanoseconds to microseconds.

Signed-off-by: Denis Vlasenko <vda.linux@googlemail.com>
--
vda

--Boundary-00=_8e5EFCXQkunmc+Q
Content-Type: text/x-diff;
  charset="koi8-r";
  name="delay8.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delay8.2.patch"

diff -urpN linux-2.6.18.new.1/drivers/scsi/ipr.c linux-2.6.18.new.2/drivers/scsi/ipr.c
--- linux-2.6.18.new.1/drivers/scsi/ipr.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.2/drivers/scsi/ipr.c	2006-09-22 00:00:48.000000000 +0200
@@ -1596,11 +1596,7 @@ static int ipr_wait_iodbg_ack(struct ipr
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
diff -urpN linux-2.6.18.new.1/drivers/spi/spi_bitbang.c linux-2.6.18.new.2/drivers/spi/spi_bitbang.c
--- linux-2.6.18.new.1/drivers/spi/spi_bitbang.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.2/drivers/spi/spi_bitbang.c	2006-09-22 00:00:48.000000000 +0200
@@ -168,7 +168,7 @@ int spi_bitbang_setup_transfer(struct sp
 		hz = spi->max_speed_hz;
 	if (hz) {
 		cs->nsecs = (1000000000/2) / hz;
-		if (cs->nsecs > (MAX_UDELAY_MS * 1000 * 1000))
+		if (cs->nsecs > (1000 * 1000))
 			return -EINVAL;
 	}
 
diff -urpN linux-2.6.18.new.1/drivers/spi/spi_mpc83xx.c linux-2.6.18.new.2/drivers/spi/spi_mpc83xx.c
--- linux-2.6.18.new.1/drivers/spi/spi_mpc83xx.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.2/drivers/spi/spi_mpc83xx.c	2006-09-22 00:00:48.000000000 +0200
@@ -211,7 +211,7 @@ int mpc83xx_spi_setup_transfer(struct sp
 	if (!hz)
 		hz = spi->max_speed_hz;
 	mpc83xx_spi->nsecs = (1000000000 / 2) / hz;
-	if (mpc83xx_spi->nsecs > MAX_UDELAY_MS * 1000)
+	if (mpc83xx_spi->nsecs > (1000 * 1000))
 		return -EINVAL;
 
 	if (bits_per_word == 32)
diff -urpN linux-2.6.18.new.1/include/asm-parisc/delay.h linux-2.6.18.new.2/include/asm-parisc/delay.h
--- linux-2.6.18.new.1/include/asm-parisc/delay.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.new.2/include/asm-parisc/delay.h	2006-09-22 00:00:48.000000000 +0200
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

--Boundary-00=_8e5EFCXQkunmc+Q--
