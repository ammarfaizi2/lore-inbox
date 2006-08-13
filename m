Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWHMNGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWHMNGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 09:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHMNGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 09:06:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:47811 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751236AbWHMNGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 09:06:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id;
        b=rfhnV+csqGiJYtFmamYtF0xcpnioAgJqSJ7fSscCVXTgcXbW7dOvS/FrYATuhpYLTfiZ9k20keXdQkVkUJammpIC+k2J+sLbvAbhepz2fGOX9Xnfau/s/1GLNnZY3aKJR48SDxi028cssM21zs29Y9FEPwIzVakYKMSCIASLpVw=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH 4/4] aic7xxx: remove excessive inlining
Date: Sun, 13 Aug 2006 15:05:58 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200608131457.21951.vda.linux@googlemail.com> <200608131502.10664.vda.linux@googlemail.com> <200608131503.07987.vda.linux@googlemail.com>
In-Reply-To: <200608131503.07987.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2Oy3EKef5TulWnp"
Message-Id: <200608131505.58608.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2Oy3EKef5TulWnp
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 13 August 2006 15:03, Denis Vlasenko wrote:
> Basically, patches deinline some functions, mainly those
> which perform port I/O.

Comment says "Read high byte first as some registers increment..."
but code doesn't guarantee that, I think:
	return ((ahd_inb(ahd, port+1) << 8) | ahd_inb(ahd, port));
Compiler can reorder it.

Make the order explicit.
--
vda

--Boundary-00=_2Oy3EKef5TulWnp
Content-Type: text/x-diff;
  charset="koi8-r";
  name="4.inb_order.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="4.inb_order.diff"

diff -urpN -U4 linux-2.6.17.8.aic3/drivers/scsi/aic7xxx/aic79xx_core.c linux-2.6.17.8.aic4/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.6.17.8.aic3/drivers/scsi/aic7xxx/aic79xx_core.c	2006-08-13 12:01:42.000000000 +0200
+++ linux-2.6.17.8.aic4/drivers/scsi/aic7xxx/aic79xx_core.c	2006-08-13 12:14:13.000000000 +0200
@@ -341,9 +341,11 @@ ahd_inw(struct ahd_softc *ahd, u_int por
 	 * Read high byte first as some registers increment
 	 * or have other side effects when the low byte is
 	 * read.
 	 */
-	return ((ahd_inb(ahd, port+1) << 8) | ahd_inb(ahd, port));
+	uint16_t r = ahd_inb(ahd, port+1) << 8;
+	r |= ahd_inb(ahd, port);
+	return r;
 }
 
 void
 ahd_outw(struct ahd_softc *ahd, u_int port, u_int value)

--Boundary-00=_2Oy3EKef5TulWnp--
