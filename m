Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTIVARm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTIVARm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:17:42 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:14221 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262720AbTIVARO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:17:14 -0400
Date: Sun, 21 Sep 2003 20:10:12 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201012.GC24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030921200935.GB24897@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921200935.GB24897@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/09/21	ambx1@neo.rr.com	1.1355
# [PNP] release card devices on probe failure
# 
# When a driver's probe routine fails, it may not release all of the
# card devices it requested.  This patch allows the pnp layer to ensure
# that all devices claimed by the failing driver are released properly.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Sun Sep 21 19:46:10 2003
+++ b/drivers/pnp/card.c	Sun Sep 21 19:46:10 2003
@@ -62,8 +62,14 @@
 		if (drv->probe) {
 			if (drv->probe(clink, id)>=0)
 				return 1;
-			else
+			else {
+				struct pnp_dev * dev;
+				card_for_each_dev(card, dev) {
+					if (dev->card_link == clink)
+						pnp_release_card_device(dev);
+				}
 				kfree(clink);
+			}
 		} else
 			return 1;
 	}
