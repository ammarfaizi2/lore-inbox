Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWJJRPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWJJRPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWJJRPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:15:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:49545 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964805AbWJJRPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:33 -0400
Date: Tue, 10 Oct 2006 10:14:19 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Ang Way Chuang <wcang@nrg.cs.usm.my>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/19] dvb-core: Proper handling ULE SNDU length of 0 (CVE-2006-4623)
Message-ID: <20061010171419.GB6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-core-proper-handling-ule-sndu-length-of-0.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
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

--- linux-2.6.17.13.orig/drivers/media/dvb/dvb-core/dvb_net.c
+++ linux-2.6.17.13/drivers/media/dvb/dvb-core/dvb_net.c
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
