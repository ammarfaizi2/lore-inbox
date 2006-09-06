Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWIFXHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWIFXHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWIFXFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:05:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:30669 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964967AbWIFXDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:07 -0400
Date: Wed, 6 Sep 2006 15:57:40 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
Message-ID: <20060906225740.GD15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-core-proper-handling-ule-sndu-length-of-0.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Ang Way Chuang <wcang@nrg.cs.usm.my>

ULE (Unidirectional Lightweight Encapsulation RFC 4326) decapsulation
code has a bug that allows an attacker to send a malformed ULE packet
with SNDU length of 0 and bring down the receiving machine. This patch
fix the bug and has been tested on version 2.6.17.11. This bug is 100%
reproducible and the modified source code (GPL) used to produce this bug
will be posted on http://nrg.cs.usm.my/downloads.htm shortly.  The
kernel will produce a dump during CRC32 checking on faulty ULE packet.


Signed-off-by: Ang Way Chuang <wcang@nrg.cs.usm.my>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/dvb/dvb-core/dvb_net.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.11.orig/drivers/media/dvb/dvb-core/dvb_net.c
+++ linux-2.6.17.11/drivers/media/dvb/dvb-core/dvb_net.c
@@ -492,7 +492,8 @@ static void dvb_net_ule( struct net_devi
 				} else
 					priv->ule_dbit = 0;
 
-				if (priv->ule_sndu_len > 32763) {
+				if (priv->ule_sndu_len > 32763 ||
+				    priv->ule_sndu_len < ((priv->ule_dbit) ? 4 : 4 + ETH_ALEN)) {
 					printk(KERN_WARNING "%lu: Invalid ULE SNDU length %u. "
 					       "Resyncing.\n", priv->ts_count, priv->ule_sndu_len);
 					priv->ule_sndu_len = 0;

--
