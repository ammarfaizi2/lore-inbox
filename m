Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbWJZCWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbWJZCWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWJZCTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:08 -0400
Received: from isilmar.linta.de ([213.239.214.66]:29663 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965285AbWJZCTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:04 -0400
Date: Wed, 25 Oct 2006 22:15:48 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, om.turyx@gmail.com,
       yoichi_yuasa@tripeaks.co.jp
Subject: [RFC PATCH 7/11] pcmcia: au1000_generic fix
Message-ID: <20061026021548.GH20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, om.turyx@gmail.com,
	yoichi_yuasa@tripeaks.co.jp
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Om Narasimhan <om.turyx@gmail.com>
Date: Fri, 20 Oct 2006 14:44:15 -0700
Subject: [PATCH] pcmcia: au1000_generic fix

The previous code did something like,

if (error) goto out_err;
....
do {
             struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
              del_timer_sync(&skt->poll_timer);
               pcmcia_unregister_socket(&skt->socket);
out_err:
               flush_scheduled_work();
               ops->hw_shutdown(skt);
               i--;
} while (i > 0)
.....

- On the error path, skt would not contain a valid value for the first
  iteration (skt is masked by uninitialized automatic skt)

- Does not do hw_shutdown() for 0th element of PCMCIA_SOCKET

Signed-off-by: Om Narasimhan <om.turyx@gmail.com>
Cc: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/au1000_generic.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index d5dd0ce..5387de6 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -351,6 +351,7 @@ struct skt_dev_info {
 int au1x00_pcmcia_socket_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr)
 {
 	struct skt_dev_info *sinfo;
+	struct au1000_pcmcia_socket *skt;
 	int ret, i;
 
 	sinfo = kzalloc(sizeof(struct skt_dev_info), GFP_KERNEL);
@@ -365,7 +366,7 @@ int au1x00_pcmcia_socket_probe(struct de
 	 * Initialise the per-socket structure.
 	 */
 	for (i = 0; i < nr; i++) {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+		skt = PCMCIA_SOCKET(i);
 		memset(skt, 0, sizeof(*skt));
 
 		skt->socket.resource_ops = &pccard_static_ops;
@@ -438,17 +439,19 @@ #endif
 	dev_set_drvdata(dev, sinfo);
 	return 0;
 
-	do {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+
+out_err:
+	flush_scheduled_work();
+	ops->hw_shutdown(skt);
+	while (i-- > 0) {
+		skt = PCMCIA_SOCKET(i);
 
 		del_timer_sync(&skt->poll_timer);
 		pcmcia_unregister_socket(&skt->socket);
-out_err:
 		flush_scheduled_work();
 		ops->hw_shutdown(skt);
 
-		i--;
-	} while (i > 0);
+	}
 	kfree(sinfo);
 out:
 	return ret;
-- 
1.4.3

