Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCVRlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCVRlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWCVRlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:41:01 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:53789 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932216AbWCVRjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:39:45 -0500
Date: Wed, 22 Mar 2006 16:03:39 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [patch 2/6] s390: qeth driver statistics fixes
Message-ID: <20060322160339.4e6cf34e@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/6] s390: qeth driver statistics fixes 

From: Ursula Braun <braunu@de.ibm.com>
	- display "unsigned int" values in /proc/qeth_perf with %u instead of %i
	- omit qdio header length when increasing card->stats.tx_bytes

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
qeth_main.c |    3 ++-
 qeth_proc.c |   38 +++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index dba7f7f..634c395 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -4419,6 +4419,7 @@ qeth_send_packet(struct qeth_card *card,
 	int elements_needed = 0;
 	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
 	struct qeth_eddp_context *ctx = NULL;
+	int tx_bytes = skb->len;
 	int rc;
 
 	QETH_DBF_TEXT(trace, 6, "sendpkt");
@@ -4499,7 +4500,7 @@ qeth_send_packet(struct qeth_card *card,
 					      elements_needed, ctx);
 	if (!rc){
 		card->stats.tx_packets++;
-		card->stats.tx_bytes += skb->len;
+		card->stats.tx_bytes += tx_bytes;
 #ifdef CONFIG_QETH_PERF_STATS
 		if (skb_shinfo(skb)->tso_size &&
 		   !(large_send == QETH_LARGE_SEND_NO)) {
diff --git a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
index 3c6339d..1304641 100644
--- a/drivers/s390/net/qeth_proc.c
+++ b/drivers/s390/net/qeth_proc.c
@@ -192,27 +192,27 @@ qeth_perf_procfile_seq_show(struct seq_f
 			CARD_DDEV_ID(card),
 			QETH_CARD_IFNAME(card)
 		  );
-	seq_printf(s, "  Skb's/buffers received                 : %li/%i\n"
-		      "  Skb's/buffers sent                     : %li/%i\n\n",
+	seq_printf(s, "  Skb's/buffers received                 : %lu/%u\n"
+		      "  Skb's/buffers sent                     : %lu/%u\n\n",
 		        card->stats.rx_packets, card->perf_stats.bufs_rec,
 		        card->stats.tx_packets, card->perf_stats.bufs_sent
 		  );
-	seq_printf(s, "  Skb's/buffers sent without packing     : %li/%i\n"
-		      "  Skb's/buffers sent with packing        : %i/%i\n\n",
+	seq_printf(s, "  Skb's/buffers sent without packing     : %lu/%u\n"
+		      "  Skb's/buffers sent with packing        : %u/%u\n\n",
 		   card->stats.tx_packets - card->perf_stats.skbs_sent_pack,
 		   card->perf_stats.bufs_sent - card->perf_stats.bufs_sent_pack,
 		   card->perf_stats.skbs_sent_pack,
 		   card->perf_stats.bufs_sent_pack
 		  );
-	seq_printf(s, "  Skbs sent in SG mode                   : %i\n"
-		      "  Skb fragments sent in SG mode          : %i\n\n",
+	seq_printf(s, "  Skbs sent in SG mode                   : %u\n"
+		      "  Skb fragments sent in SG mode          : %u\n\n",
 		      card->perf_stats.sg_skbs_sent,
 		      card->perf_stats.sg_frags_sent);
-	seq_printf(s, "  large_send tx (in Kbytes)              : %i\n"
-		      "  large_send count                       : %i\n\n",
+	seq_printf(s, "  large_send tx (in Kbytes)              : %u\n"
+		      "  large_send count                       : %u\n\n",
 		      card->perf_stats.large_send_bytes >> 10,
 		      card->perf_stats.large_send_cnt);
-	seq_printf(s, "  Packing state changes no pkg.->packing : %i/%i\n"
+	seq_printf(s, "  Packing state changes no pkg.->packing : %u/%u\n"
 		      "  Watermarks L/H                         : %i/%i\n"
 		      "  Current buffer usage (outbound q's)    : "
 		      "%i/%i/%i/%i\n\n",
@@ -229,16 +229,16 @@ qeth_perf_procfile_seq_show(struct seq_f
 				atomic_read(&card->qdio.out_qs[3]->used_buffers)
 				: 0
 		  );
-	seq_printf(s, "  Inbound handler time (in us)           : %i\n"
-		      "  Inbound handler count                  : %i\n"
-		      "  Inbound do_QDIO time (in us)           : %i\n"
-		      "  Inbound do_QDIO count                  : %i\n\n"
-		      "  Outbound handler time (in us)          : %i\n"
-		      "  Outbound handler count                 : %i\n\n"
-		      "  Outbound time (in us, incl QDIO)       : %i\n"
-		      "  Outbound count                         : %i\n"
-		      "  Outbound do_QDIO time (in us)          : %i\n"
-		      "  Outbound do_QDIO count                 : %i\n\n",
+	seq_printf(s, "  Inbound handler time (in us)           : %u\n"
+		      "  Inbound handler count                  : %u\n"
+		      "  Inbound do_QDIO time (in us)           : %u\n"
+		      "  Inbound do_QDIO count                  : %u\n\n"
+		      "  Outbound handler time (in us)          : %u\n"
+		      "  Outbound handler count                 : %u\n\n"
+		      "  Outbound time (in us, incl QDIO)       : %u\n"
+		      "  Outbound count                         : %u\n"
+		      "  Outbound do_QDIO time (in us)          : %u\n"
+		      "  Outbound do_QDIO count                 : %u\n\n",
 		        card->perf_stats.inbound_time,
 			card->perf_stats.inbound_cnt,
 		        card->perf_stats.inbound_do_qdio_time,
