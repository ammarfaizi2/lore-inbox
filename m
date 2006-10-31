Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423064AbWJaKFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423064AbWJaKFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423066AbWJaKFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:05:12 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:1292 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423064AbWJaKFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:05:10 -0500
Date: Tue, 31 Oct 2006 10:05:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Timo Teras <timo.teras@solidboot.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: Select only one voltage bit in OCR response
Message-ID: <20061031100503.GB19812@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Timo Teras <timo.teras@solidboot.com>, linux-kernel@vger.kernel.org
References: <20061009150044.GB1637@mail.solidboot.com> <20061009165317.GA6431@flint.arm.linux.org.uk> <20061009172350.GC1637@mail.solidboot.com> <453327EC.1000402@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453327EC.1000402@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 08:34:20AM +0200, Pierre Ossman wrote:
> Timo Teras wrote:
> > I see. But if we do send an OCR with an unsupported bit set, the card will
> > go to inactive state and is unusable. This problem is masked on controllers
> > with only 3.3V support, but I'm working with a controller supporting several
> > different voltages.
> >
> > For example, I have a card giving an OCR reply of 0x0ff80080. The current
> > code will reply to this with 0x00000180 which is clearly incorrect.
> >
> > Maybe something like "ocr &= 3 << bit;" would be more approriate?
> >   
> 
> Russell? Comments? Do you still have the offending card?

It wasn't my cards, but was reported by several other folk.  I don't think
we can revert on this without breakage.

However, we should probably ensure that we don't end up setting voltage
bits which the cards don't support.  So maybe masking the resulting OCR
value with the received combined OCR would be a good idea?  Such as:

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ee8863c..45e0598 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -467,23 +467,24 @@ static inline void mmc_delay(unsigned in
  */
 static u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 {
+	u32 selected_ocr;
 	int bit;
 
-	ocr &= host->ocr_avail;
+	selected_ocr = ocr & host->ocr_avail;
 
-	bit = ffs(ocr);
+	bit = ffs(selected_ocr);
 	if (bit) {
 		bit -= 1;
 
-		ocr = 3 << bit;
+		selected_ocr = 3 << bit;
 
 		host->ios.vdd = bit;
 		mmc_set_ios(host);
 	} else {
-		ocr = 0;
+		selected_ocr = 0;
 	}
 
-	return ocr;
+	return selected_ocr & ocr;
 }
 
 #define UNSTUFF_BITS(resp,start,size)					\


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
