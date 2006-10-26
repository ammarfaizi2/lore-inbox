Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWJZCTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWJZCTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWJZCTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:15 -0400
Received: from isilmar.linta.de ([213.239.214.66]:34783 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965292AbWJZCTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:07 -0400
Date: Wed, 25 Oct 2006 22:18:08 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/11] PCMCIA: fix __must_check warnings
Message-ID: <20061026021808.GL20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Wed, 25 Oct 2006 19:56:55 -0400
Subject: [PATCH] PCMCIA: fix __must_check warnings

Fix the remaining __must_check warnings in the PCMCIA core.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/ds.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index af392bf..0f70192 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -717,6 +717,7 @@ static int pcmcia_requery(struct device 
 static void pcmcia_bus_rescan(struct pcmcia_socket *skt)
 {
 	int no_devices=0;
+	int ret = 0;
 	unsigned long flags;
 
 	/* must be called with skt_mutex held */
@@ -729,7 +730,7 @@ static void pcmcia_bus_rescan(struct pcm
 	 * missing resource information or other trouble, we need to
 	 * do this now. */
 	if (no_devices) {
-		int ret = pcmcia_card_add(skt);
+		ret = pcmcia_card_add(skt);
 		if (ret)
 			return;
 	}
@@ -741,7 +742,9 @@ static void pcmcia_bus_rescan(struct pcm
 
 	/* we re-scan all devices, not just the ones connected to this
 	 * socket. This does not matter, though. */
-	bus_rescan_devices(&pcmcia_bus_type);
+	ret = bus_rescan_devices(&pcmcia_bus_type);
+	if (ret)
+		printk(KERN_INFO "pcmcia: bus_rescan_devices failed\n");
 }
 
 static inline int pcmcia_devmatch(struct pcmcia_device *dev,
@@ -1001,6 +1004,7 @@ static ssize_t pcmcia_store_allow_func_i
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
+	int ret;
 
 	if (!count)
 		return -EINVAL;
@@ -1009,7 +1013,10 @@ static ssize_t pcmcia_store_allow_func_i
 	p_dev->allow_func_id_match = 1;
 	mutex_unlock(&p_dev->socket->skt_mutex);
 
-	bus_rescan_devices(&pcmcia_bus_type);
+	ret = bus_rescan_devices(&pcmcia_bus_type);
+	if (ret)
+		printk(KERN_INFO "pcmcia: bus_rescan_devices failed after "
+		       "allowing func_id matches\n");
 
 	return count;
 }
-- 
1.4.3

