Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWIFXKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWIFXKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWIFXI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:08:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:26317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965061AbWIFXDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:02 -0400
Date: Wed, 6 Sep 2006 15:57:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 33/37] sky2: clear status IRQ after empty
Message-ID: <20060906225755.GH15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-status-clr.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

Don't clear status IRQ until list has been read to avoid causing
status list wraparound. Clearing IRQ forces a Transmit Status update
if it is pending.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17.11.orig/drivers/net/sky2.c
+++ linux-2.6.17.11/drivers/net/sky2.c
@@ -2016,6 +2016,9 @@ static int sky2_status_intr(struct sky2_
 		}
 	}
 
+	/* Fully processed status ring so clear irq */
+	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
+
 exit_loop:
 	return work_done;
 }
@@ -2218,9 +2221,6 @@ static int sky2_poll(struct net_device *
 	*budget -= work_done;
 	dev0->quota -= work_done;
 
-	if (status & Y2_IS_STAT_BMU)
-		sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
-
 	if (sky2_more_work(hw))
 		return 1;
 

--
