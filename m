Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWJDNoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWJDNoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWJDNoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:44:18 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:52746 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S1030436AbWJDNoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:44:17 -0400
Date: Wed, 4 Oct 2006 22:44:06 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel@vger.kernel.org
Subject: [-mm PATCH] fixed PCMCIA au1000_generic.c
Message-Id: <20061004224406.46a9d05c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061003001115.e898b8cb.akpm@osdl.org>
References: <20061003001115.e898b8cb.akpm@osdl.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pcmcia-au1000_generic-fix.patch has a problem.
It needs more fix.
ops->shutdown(skt), skt is out of definition scope.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.18-mm3/Documentation/dontdiff linux-2.6.18-mm3-orig/drivers/pcmcia/au1000_generic.c linux-2.6.18-mm3/drivers/pcmcia/au1000_generic.c
--- linux-2.6.18-mm3-orig/drivers/pcmcia/au1000_generic.c	2006-10-04 11:24:33.017136250 +0900
+++ linux-2.6.18-mm3/drivers/pcmcia/au1000_generic.c	2006-10-04 22:32:21.806060500 +0900
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
@@ -442,7 +443,7 @@ out_err:
 	flush_scheduled_work();
 	ops->hw_shutdown(skt);
 	while (i-- > 0) {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+		skt = PCMCIA_SOCKET(i);
 		del_timer_sync(&skt->poll_timer);
 		pcmcia_unregister_socket(&skt->socket);
 		flush_scheduled_work();
