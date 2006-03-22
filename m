Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWCVQku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWCVQku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWCVQku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:40:50 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48301 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932068AbWCVQkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:40:46 -0500
Date: Wed, 22 Mar 2006 17:42:06 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 3/6] s390: qeth driver cleanups
Message-ID: <20060322174206.2c6fe238@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/6] s390: qeth driver cleanups 

From: Ursula Braun <braunu@de.ibm.com>
	- code analyzing tool BEAM has found some unreachable 
	  and unnecessary statements and also conditions 
	  which are always true.
	- removed some useless MII code since OSA card will never 
	  allow to set such values.
			
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth_main.c |   49 ++++---------------------------------------------
 qeth_proc.c |   18 +++++++++---------
 qeth_sys.c  |    2 +-
 3 files changed, 14 insertions(+), 55 deletions(-)

diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 634c395..69329ea 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1364,7 +1364,7 @@ qeth_wait_for_buffer(struct qeth_channel
 static void
 qeth_clear_cmd_buffers(struct qeth_channel *channel)
 {
-	int cnt = 0;
+	int cnt;
 
 	for (cnt=0; cnt < QETH_CMD_BUFFER_NO; cnt++)
 		qeth_release_buffer(channel,&channel->iob[cnt]);
@@ -2814,11 +2814,11 @@ qeth_handle_send_error(struct qeth_card 
 		QETH_DBF_TEXT_(trace,1,"%s",CARD_BUS_ID(card));
 		return QETH_SEND_ERROR_LINK_FAILURE;
 	case 3:
+	default:
 		QETH_DBF_TEXT(trace, 1, "SIGAcc3");
 		QETH_DBF_TEXT_(trace,1,"%s",CARD_BUS_ID(card));
 		return QETH_SEND_ERROR_KICK_IT;
 	}
-	return QETH_SEND_ERROR_LINK_FAILURE;
 }
 
 void
@@ -3865,6 +3865,7 @@ qeth_get_cast_type(struct qeth_card *car
 	        	if ((hdr_mac == QETH_TR_MAC_NC) ||
 			    (hdr_mac == QETH_TR_MAC_C))
 				return RTN_MULTICAST;
+			break;
 	        /* eth or so multicast? */
                 default:
                       	if ((hdr_mac == QETH_ETH_MAC_V4) ||
@@ -4586,38 +4587,11 @@ qeth_mdio_read(struct net_device *dev, i
 	case MII_NCONFIG: /* network interface config */
 		break;
 	default:
-		rc = 0;
 		break;
 	}
 	return rc;
 }
 
-static void
-qeth_mdio_write(struct net_device *dev, int phy_id, int regnum, int value)
-{
-	switch(regnum){
-	case MII_BMCR: /* Basic mode control register */
-	case MII_BMSR: /* Basic mode status register */
-	case MII_PHYSID1: /* PHYS ID 1 */
-	case MII_PHYSID2: /* PHYS ID 2 */
-	case MII_ADVERTISE: /* Advertisement control reg */
-	case MII_LPA: /* Link partner ability reg */
-	case MII_EXPANSION: /* Expansion register */
-	case MII_DCOUNTER: /* disconnect counter */
-	case MII_FCSCOUNTER: /* false carrier counter */
-	case MII_NWAYTEST: /* N-way auto-neg test register */
-	case MII_RERRCOUNTER: /* rx error counter */
-	case MII_SREVISION: /* silicon revision */
-	case MII_RESV1: /* reserved 1 */
-	case MII_LBRERROR: /* loopback, rx, bypass error */
-	case MII_PHYADDR: /* physical address */
-	case MII_RESV2: /* reserved 2 */
-	case MII_TPISTATUS: /* TPI status for 10mbps */
-	case MII_NCONFIG: /* network interface config */
-	default:
-		break;
-	}
-}
 
 static inline const char *
 qeth_arp_get_error_cause(int *rc)
@@ -5237,21 +5211,6 @@ qeth_do_ioctl(struct net_device *dev, st
 			mii_data->val_out = qeth_mdio_read(dev,mii_data->phy_id,
 							   mii_data->reg_num);
 		break;
-	case SIOCSMIIREG:
-		rc = -EOPNOTSUPP;
-		break;
-		/* TODO: remove return if qeth_mdio_write does something */
-		if (!capable(CAP_NET_ADMIN)){
-			rc = -EPERM;
-			break;
-		}
-		mii_data = if_mii(rq);
-		if (mii_data->phy_id != 0)
-			rc = -EINVAL;
-		else
-			qeth_mdio_write(dev, mii_data->phy_id, mii_data->reg_num,
-					mii_data->val_in);
-		break;
 	default:
 		rc = -EOPNOTSUPP;
 	}
@@ -6901,7 +6860,7 @@ qeth_send_setassparms(struct qeth_card *
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	if (len <= sizeof(__u32))
 		cmd->data.setassparms.data.flags_32bit = (__u32) data;
-	else if (len > sizeof(__u32))
+	else   /* (len > sizeof(__u32)) */
 		memcpy(&cmd->data.setassparms.data, (void *) data, len);
 
 	rc = qeth_send_ipa_cmd(card, iob, reply_cb, reply_param);
diff --git a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
index 1304641..360d782 100644
--- a/drivers/s390/net/qeth_proc.c
+++ b/drivers/s390/net/qeth_proc.c
@@ -74,7 +74,7 @@ qeth_procfile_seq_next(struct seq_file *
 static inline const char *
 qeth_get_router_str(struct qeth_card *card, int ipv)
 {
-	int routing_type = 0;
+	enum qeth_routing_types routing_type = NO_ROUTER;
 
 	if (ipv == 4) {
 		routing_type = card->options.route4.type;
@@ -86,26 +86,26 @@ qeth_get_router_str(struct qeth_card *ca
 #endif /* CONFIG_QETH_IPV6 */
 	}
 
-	if (routing_type == PRIMARY_ROUTER)
+	switch (routing_type){
+	case PRIMARY_ROUTER:
 		return "pri";
-	else if (routing_type == SECONDARY_ROUTER)
+	case SECONDARY_ROUTER:
 		return "sec";
-	else if (routing_type == MULTICAST_ROUTER) {
+	case MULTICAST_ROUTER:
 		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
 			return "mc+";
 		return "mc";
-	} else if (routing_type == PRIMARY_CONNECTOR) {
+	case PRIMARY_CONNECTOR:
 		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
 			return "p+c";
 		return "p.c";
-	} else if (routing_type == SECONDARY_CONNECTOR) {
+	case SECONDARY_CONNECTOR:
 		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
 			return "s+c";
 		return "s.c";
-	} else if (routing_type == NO_ROUTER)
+	default:   /* NO_ROUTER */
 		return "no";
-	else
-		return "unk";
+	}
 }
 
 static int
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
index c1831f5..f2a076a 100644
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
@@ -115,7 +115,7 @@ qeth_dev_portno_store(struct device *dev
 		return -EPERM;
 
 	portno = simple_strtoul(buf, &tmp, 16);
-	if ((portno < 0) || (portno > MAX_PORTNO)){
+	if (portno > MAX_PORTNO){
 		PRINT_WARN("portno 0x%X is out of range\n", portno);
 		return -EINVAL;
 	}
