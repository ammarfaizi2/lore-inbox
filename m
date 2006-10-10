Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWJJXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWJJXgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWJJXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:36:40 -0400
Received: from havoc.gtf.org ([69.61.125.42]:8364 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932172AbWJJXgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:36:39 -0400
Date: Tue, 10 Oct 2006 19:36:37 -0400
From: Jeff Garzik <jeff@garzik.org>
To: khc@pm.waw.pl, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] WAN/pc300: handle, propagate minor errors
Message-ID: <20061010233637.GA20090@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- move definition of 'tmc' and 'br' locals closer to usage

- handle clock_rate_calc() error

- propagate errors back to upper level open routine

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/net/wan/pc300_drv.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wan/pc300_drv.c b/drivers/net/wan/pc300_drv.c
index 5823e3b..2ae3776 100644
--- a/drivers/net/wan/pc300_drv.c
+++ b/drivers/net/wan/pc300_drv.c
@@ -2867,7 +2867,6 @@ static int ch_config(pc300dev_t * d)
 	uclong clktype = chan->conf.phys_settings.clock_type;
 	ucshort encoding = chan->conf.proto_settings.encoding;
 	ucshort parity = chan->conf.proto_settings.parity;   
-	int tmc, br;
 	ucchar md0, md2;
     
 	/* Reset the channel */
@@ -2940,8 +2939,12 @@ static int ch_config(pc300dev_t * d)
 		case PC300_RSV:
 		case PC300_X21:
 			if (clktype == CLOCK_INT || clktype == CLOCK_TXINT) {
+				int tmc, br;
+
 				/* Calculate the clkrate parameters */
 				tmc = clock_rate_calc(clkrate, card->hw.clock, &br);
+				if (tmc < 0)
+					return -EIO;
 				cpc_writeb(scabase + M_REG(TMCT, ch), tmc);
 				cpc_writeb(scabase + M_REG(TXS, ch),
 					   (TXS_DTRXC | TXS_IBRG | br));
@@ -3097,14 +3100,16 @@ static int cpc_attach(struct net_device 
 	return 0;
 }
 
-static void cpc_opench(pc300dev_t * d)
+static int cpc_opench(pc300dev_t * d)
 {
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
-	int ch = chan->channel;
+	int ch = chan->channel, rc;
 	void __iomem *scabase = card->hw.scabase;
 
-	ch_config(d);
+	rc = ch_config(d);
+	if (rc)
+		return rc;
 
 	rx_config(d);
 
@@ -3113,6 +3118,8 @@ static void cpc_opench(pc300dev_t * d)
 	/* Assert RTS and DTR */
 	cpc_writeb(scabase + M_REG(CTL, ch),
 		   cpc_readb(scabase + M_REG(CTL, ch)) & ~(CTL_RTS | CTL_DTR));
+
+	return 0;
 }
 
 static void cpc_closech(pc300dev_t * d)
@@ -3168,9 +3175,16 @@ #endif
 	}
 
 	sprintf(ifr.ifr_name, "%s", dev->name);
-	cpc_opench(d);
+	result = cpc_opench(d);
+	if (result)
+		goto err_out;
+
 	netif_start_queue(dev);
 	return 0;
+
+err_out:
+	hdlc_close(dev);
+	return result;
 }
 
 static int cpc_close(struct net_device *dev)
