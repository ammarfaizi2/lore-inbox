Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTENOCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTENOCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:02:11 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:9193 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S262308AbTENOAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:00:33 -0400
Date: Wed, 14 May 2003 16:13:15 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
In-Reply-To: <20030514134704.GA1062@babylon.d2dc.net>
Message-ID: <Pine.LNX.4.51.0305141611130.22227@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv>
 <20030514134704.GA1062@babylon.d2dc.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-1774618890-1052921595=:22227"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-1774618890-1052921595=:22227
Content-Type: TEXT/PLAIN; charset=US-ASCII

> I'm seeing it too, only with recent kernels.
Exactly like me.
Someone suggested Bartlomiej Zolnierkiewicz's patch.
Try this on for size. I haven't tested it yet, but please give it a shot.

Regards,
Maciej

# Fix masked_irq arg handling for ide_do_request().
# Solves "hdx: lost interrupt" bug.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

--- linux-2.5.68-bk6/drivers/ide/ide-io.c	Fri Apr 25 16:08:53 2003
+++ linux/drivers/ide/ide-io.c	Fri Apr 25 16:13:37 2003
@@ -850,14 +850,14 @@
 		 * happens anyway when any interrupt comes in, IDE or otherwise
 		 *  -- the kernel masks the IRQ while it is being handled.
 		 */
-		if (hwif->irq != masked_irq)
+		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
 		spin_unlock(&ide_lock);
 		local_irq_enable();
 			/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 		spin_lock_irq(&ide_lock);
-		if (hwif->irq != masked_irq)
+		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
 		if (startstop == ide_released)
 			goto queue_next;
---23717851-1774618890-1052921595=:22227
Content-Type: TEXT/plain; name="masked_irq.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0305141613150.22227@dns.toxicfilms.tv>
Content-Description: masked_irq.diff
Content-Disposition: attachment; filename="masked_irq.diff"

IyBGaXggbWFza2VkX2lycSBhcmcgaGFuZGxpbmcgZm9yIGlkZV9kb19yZXF1
ZXN0KCkuDQojIFNvbHZlcyAiaGR4OiBsb3N0IGludGVycnVwdCIgYnVnLg0K
Iw0KIyBCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6IDxiem9sbmllckBlbGth
LnB3LmVkdS5wbD4NCg0KLS0tIGxpbnV4LTIuNS42OC1iazYvZHJpdmVycy9p
ZGUvaWRlLWlvLmMJRnJpIEFwciAyNSAxNjowODo1MyAyMDAzDQorKysgbGlu
dXgvZHJpdmVycy9pZGUvaWRlLWlvLmMJRnJpIEFwciAyNSAxNjoxMzozNyAy
MDAzDQpAQCAtODUwLDE0ICs4NTAsMTQgQEANCiAJCSAqIGhhcHBlbnMgYW55
d2F5IHdoZW4gYW55IGludGVycnVwdCBjb21lcyBpbiwgSURFIG9yIG90aGVy
d2lzZQ0KIAkJICogIC0tIHRoZSBrZXJuZWwgbWFza3MgdGhlIElSUSB3aGls
ZSBpdCBpcyBiZWluZyBoYW5kbGVkLg0KIAkJICovDQotCQlpZiAoaHdpZi0+
aXJxICE9IG1hc2tlZF9pcnEpDQorCQlpZiAobWFza2VkX2lycSAhPSBJREVf
Tk9fSVJRICYmIGh3aWYtPmlycSAhPSBtYXNrZWRfaXJxKQ0KIAkJCWRpc2Fi
bGVfaXJxX25vc3luYyhod2lmLT5pcnEpOw0KIAkJc3Bpbl91bmxvY2soJmlk
ZV9sb2NrKTsNCiAJCWxvY2FsX2lycV9lbmFibGUoKTsNCiAJCQkvKiBhbGxv
dyBvdGhlciBJUlFzIHdoaWxlIHdlIHN0YXJ0IHRoaXMgcmVxdWVzdCAqLw0K
IAkJc3RhcnRzdG9wID0gc3RhcnRfcmVxdWVzdChkcml2ZSwgcnEpOw0KIAkJ
c3Bpbl9sb2NrX2lycSgmaWRlX2xvY2spOw0KLQkJaWYgKGh3aWYtPmlycSAh
PSBtYXNrZWRfaXJxKQ0KKwkJaWYgKG1hc2tlZF9pcnEgIT0gSURFX05PX0lS
USAmJiBod2lmLT5pcnEgIT0gbWFza2VkX2lycSkNCiAJCQllbmFibGVfaXJx
KGh3aWYtPmlycSk7DQogCQlpZiAoc3RhcnRzdG9wID09IGlkZV9yZWxlYXNl
ZCkNCiAJCQlnb3RvIHF1ZXVlX25leHQ7DQo=

---23717851-1774618890-1052921595=:22227--
