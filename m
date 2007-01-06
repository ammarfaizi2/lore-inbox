Return-Path: <linux-kernel-owner+w=401wt.eu-S1751144AbXAFCdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbXAFCdg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbXAFCdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:19 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36873 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbXAFCcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:53 -0500
Message-Id: <20070106023608.586611000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:33 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [patch 40/50] dvb-core: fix bug in CRC-32 checking on 64-bit systems
Content-Disposition: inline; filename=dvb-core-fix-bug-in-crc-32-checking-on-64-bit-systems.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ang Way Chuang <wcang@nrg.cs.usm.my>

CRC-32 checking during ULE decapsulation always failed on x86_64 systems due
to the size of a variable used to store CRC. This bug was discovered on
Fedora Core 6 with kernel-2.6.18-1.2849. The i386 counterpart has no such
problem. This patch has been tested on 64-bit system as well as 32-bit system.

Signed-off-by: Ang Way Chuang <wcang@nrg.cs.usm.my>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
(cherry picked from commit dedcefb085fe98a1feaf63590fe2fc7e0ecb1987)

 drivers/media/dvb/dvb-core/dvb_net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19.1.orig/drivers/media/dvb/dvb-core/dvb_net.c
+++ linux-2.6.19.1/drivers/media/dvb/dvb-core/dvb_net.c
@@ -604,7 +604,7 @@ static void dvb_net_ule( struct net_devi
 				{ &utype, sizeof utype },
 				{ priv->ule_skb->data, priv->ule_skb->len - 4 }
 			};
-			unsigned long ule_crc = ~0L, expected_crc;
+			u32 ule_crc = ~0L, expected_crc;
 			if (priv->ule_dbit) {
 				/* Set D-bit for CRC32 verification,
 				 * if it was set originally. */
@@ -617,7 +617,7 @@ static void dvb_net_ule( struct net_devi
 				       *((u8 *)priv->ule_skb->tail - 2) << 8 |
 				       *((u8 *)priv->ule_skb->tail - 1);
 			if (ule_crc != expected_crc) {
-				printk(KERN_WARNING "%lu: CRC32 check FAILED: %#lx / %#lx, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
+				printk(KERN_WARNING "%lu: CRC32 check FAILED: %08x / %08x, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
 				       priv->ts_count, ule_crc, expected_crc, priv->ule_sndu_len, priv->ule_sndu_type, ts_remain, ts_remain > 2 ? *(unsigned short *)from_where : 0);
 
 #ifdef ULE_DEBUG

--
