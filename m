Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937100AbWLFSvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937100AbWLFSvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937105AbWLFSvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:51:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45971 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937100AbWLFSvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:51:42 -0500
Date: Wed, 6 Dec 2006 18:51:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: more work_struct-induced breakage
Message-ID: <20061206185140.GD4587@ftp.linux.org.uk>
References: <20061206184145.GC4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206184145.GC4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/net/hamradio/dmascc.c b/drivers/net/hamradio/dmascc.c
index 0f8b9af..e6e721a 100644
--- a/drivers/net/hamradio/dmascc.c
+++ b/drivers/net/hamradio/dmascc.c
@@ -252,7 +252,7 @@ static inline void z8530_isr(struct scc_
 static irqreturn_t scc_isr(int irq, void *dev_id);
 static void rx_isr(struct scc_priv *priv);
 static void special_condition(struct scc_priv *priv, int rc);
-static void rx_bh(void *arg);
+static void rx_bh(struct work_struct *);
 static void tx_isr(struct scc_priv *priv);
 static void es_isr(struct scc_priv *priv);
 static void tm_isr(struct scc_priv *priv);
@@ -579,7 +579,7 @@ static int __init setup_adapter(int card
 		priv->param.clocks = TCTRxCP | RCRTxCP;
 		priv->param.persist = 256;
 		priv->param.dma = -1;
-		INIT_WORK(&priv->rx_work, rx_bh, priv);
+		INIT_WORK(&priv->rx_work, rx_bh);
 		dev->priv = priv;
 		sprintf(dev->name, "dmascc%i", 2 * n + i);
 		dev->base_addr = card_base;
@@ -1272,9 +1272,9 @@ static void special_condition(struct scc
 }
 
 
-static void rx_bh(void *arg)
+static void rx_bh(struct work_struct *ugli_api)
 {
-	struct scc_priv *priv = arg;
+	struct scc_priv *priv = container_of(ugli_api, struct scc_priv, rx_work);
 	int i = priv->rx_tail;
 	int cb;
 	unsigned long flags;

