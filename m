Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWFBUHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWFBUHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFBUHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:07:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:42705 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932084AbWFBUHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:07:02 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:04:58 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 07/18] ieee1394: support for slow links or slow
 1394b phy ports
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>, Hakan Ardo <hakan@debian.org>,
       Calculex <linux@calculex.com>,
       "Robert J. Kosinski" <robk@cmcherald.com>,
       Manfred Weihs <weihs@ict.tuwien.ac.at>
In-Reply-To: <tkrat.f35772c971022262@s5r6.in-berlin.de>
Message-ID: <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.886) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ieee1394: support for slow links or slow 1394b phy ports

Add support for the following types of hardware:
 + nodes that have a link speed < PHY speed
 + 1394b PHYs that are less than S800 capable
 + 1394b/1394a adapter cable between two 1394b PHYs
Also, S1600 and S3200 are now supported if IEEE1394_SPEED_MAX is raised.

A probing function is added to nodemgr's config ROM fetching routine
which adjusts the allowable speed if an access problem was encountered.
Pros and Cons of the approach:
 + minimum code footprint to support this less widely used hardware
 + nearly no overhead for unaffected hardware
 - ineffective before nodemgr began to read the ROM of affected nodes
 - ineffective if ieee1394 is loaded with disable_nodemgr=1
The speed map CSRs which are published to the bus are not touched by the
patch.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Previous discussion:
http://marc.theaimsgroup.com/?t=107781458700006
http://marc.theaimsgroup.com/?t=112126523600002
http://marc.theaimsgroup.com/?t=112835623100003
http://marc.theaimsgroup.com/?t=113139375500008
http://marc.theaimsgroup.com/?t=114072686500005

TODO:
Update the speed map CSRs to reflect actual speeds.  Although the speed
map CSRs have been deprecated by IEEE 1394a-2000, there was a request to
continue to publish it on the bus to help application programs figure
out the correct speed.  The patch only probes connections between local
node and remote nodes though, not between two remote nodes.  The latter
requires to read phy port registers unless the local node is situated
between the two remote nodes.  IMO this should be implemented as a
separate helper thread.

 drivers/ieee1394/eth1394.c       |    6 +--
 drivers/ieee1394/hosts.h         |   11 +++----
 drivers/ieee1394/ieee1394_core.c |   14 +++++---
 drivers/ieee1394/nodemgr.c       |   61 +++++++++++++++++++++++++++++++++++++--
 drivers/ieee1394/sbp2.c          |    4 --
 5 files changed, 76 insertions(+), 20 deletions(-)

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/hosts.h	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.h	2006-06-01 20:55:42.000000000 +0200
@@ -30,12 +30,13 @@ struct hpsb_host {
 
 	unsigned char iso_listen_count[64];
 
-	int node_count; /* number of identified nodes on this bus */
-	int selfid_count; /* total number of SelfIDs received */
-	int nodes_active; /* number of nodes that are actually active */
+	int node_count;     /* number of identified nodes on this bus */
+	int selfid_count;   /* total number of SelfIDs received */
+	int nodes_active;   /* number of nodes with active link layer */
+	u8 speed[63];       /* speed between each node and local node */
 
-	nodeid_t node_id; /* node ID of this host */
-	nodeid_t irm_id; /* ID of this bus' isochronous resource manager */
+	nodeid_t node_id;   /* node ID of this host */
+	nodeid_t irm_id;    /* ID of this bus' isochronous resource manager */
 	nodeid_t busmgr_id; /* ID of this bus' bus manager */
 
 	/* this nodes state */
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/ieee1394_core.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/ieee1394_core.c	2006-06-01 20:55:42.000000000 +0200
@@ -286,9 +286,9 @@ static int check_selfids(struct hpsb_hos
 
 static void build_speed_map(struct hpsb_host *host, int nodecount)
 {
-	u8 speedcap[nodecount];
 	u8 cldcnt[nodecount];
 	u8 *map = host->speed_map;
+	u8 *speedcap = host->speed;
 	struct selfid *sid;
 	struct ext_selfid *esid;
 	int i, j, n;
@@ -355,6 +355,11 @@ static void build_speed_map(struct hpsb_
 			}
 		}
 	}
+
+	/* assume maximum speed for 1394b PHYs, nodemgr will correct it */
+	for (n = 0; n < nodecount; n++)
+		if (speedcap[n] == 3)
+			speedcap[n] = IEEE1394_SPEED_MAX;
 }
 
 
@@ -555,11 +560,10 @@ int hpsb_send_packet(struct hpsb_packet 
 		return 0;
 	}
 
-	if (packet->type == hpsb_async && packet->node_id != ALL_NODES) {
+	if (packet->type == hpsb_async &&
+	    NODEID_TO_NODE(packet->node_id) != ALL_NODES)
 		packet->speed_code =
-			host->speed_map[NODEID_TO_NODE(host->node_id) * 64
-				       + NODEID_TO_NODE(packet->node_id)];
-	}
+			host->speed[NODEID_TO_NODE(packet->node_id)];
 
 	dump_packet("send packet", packet->header, packet->header_size, packet->speed_code);
 
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/nodemgr.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/nodemgr.c	2006-06-01 20:55:42.000000000 +0200
@@ -38,6 +38,7 @@ struct nodemgr_csr_info {
 	struct hpsb_host *host;
 	nodeid_t nodeid;
 	unsigned int generation;
+	unsigned int speed_unverified:1;
 };
 
 
@@ -57,23 +58,75 @@ static char *nodemgr_find_oui_name(int o
 	return NULL;
 }
 
+/*
+ * Correct the speed map entry.  This is necessary
+ *  - for nodes with link speed < phy speed,
+ *  - for 1394b nodes with negotiated phy port speed < IEEE1394_SPEED_MAX.
+ * A possible speed is determined by trial and error, using quadlet reads.
+ */
+static int nodemgr_check_speed(struct nodemgr_csr_info *ci, u64 addr,
+			       quadlet_t *buffer)
+{
+	quadlet_t q;
+	u8 i, *speed, old_speed, good_speed;
+	int ret;
+
+	speed = ci->host->speed + NODEID_TO_NODE(ci->nodeid);
+	old_speed = *speed;
+	good_speed = IEEE1394_SPEED_MAX + 1;
+
+	/* Try every speed from S100 to old_speed.
+	 * If we did it the other way around, a too low speed could be caught
+	 * if the retry succeeded for some other reason, e.g. because the link
+	 * just finished its initialization. */
+	for (i = IEEE1394_SPEED_100; i <= old_speed; i++) {
+		*speed = i;
+		ret = hpsb_read(ci->host, ci->nodeid, ci->generation, addr,
+				&q, sizeof(quadlet_t));
+		if (ret)
+			break;
+		*buffer = q;
+		good_speed = i;
+	}
+	if (good_speed <= IEEE1394_SPEED_MAX) {
+		HPSB_DEBUG("Speed probe of node " NODE_BUS_FMT " yields %s",
+			   NODE_BUS_ARGS(ci->host, ci->nodeid),
+			   hpsb_speedto_str[good_speed]);
+		*speed = good_speed;
+		ci->speed_unverified = 0;
+		return 0;
+	}
+	*speed = old_speed;
+	return ret;
+}
 
 static int nodemgr_bus_read(struct csr1212_csr *csr, u64 addr, u16 length,
                             void *buffer, void *__ci)
 {
 	struct nodemgr_csr_info *ci = (struct nodemgr_csr_info*)__ci;
-	int i, ret = 0;
+	int i, ret;
 
 	for (i = 1; ; i++) {
 		ret = hpsb_read(ci->host, ci->nodeid, ci->generation, addr,
 				buffer, length);
-		if (!ret || i == 3)
+		if (!ret) {
+			ci->speed_unverified = 0;
+			break;
+		}
+		/* Give up after 3rd failure. */
+		if (i == 3)
 			break;
 
+		/* The ieee1394_core guessed the node's speed capability from
+		 * the self ID.  Check whether a lower speed works. */
+		if (ci->speed_unverified && length == sizeof(quadlet_t)) {
+			ret = nodemgr_check_speed(ci, addr, buffer);
+			if (!ret)
+				break;
+		}
 		if (msleep_interruptible(334))
 			return -EINTR;
 	}
-
 	return ret;
 }
 
@@ -1204,6 +1257,8 @@ static void nodemgr_node_scan_one(struct
 	ci->host = host;
 	ci->nodeid = nodeid;
 	ci->generation = generation;
+	ci->speed_unverified =
+		host->speed[NODEID_TO_NODE(nodeid)] > IEEE1394_SPEED_100;
 
 	/* We need to detect when the ConfigROM's generation has changed,
 	 * so we only update the node's info when it needs to be.  */
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/eth1394.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/eth1394.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/eth1394.c	2006-06-01 20:55:42.000000000 +0200
@@ -502,10 +502,8 @@ static void ether1394_reset_priv (struct
 
 	/* Determine speed limit */
 	for (i = 0; i < host->node_count; i++)
-		if (max_speed > host->speed_map[NODEID_TO_NODE(host->node_id) *
-						64 + i])
-			max_speed = host->speed_map[NODEID_TO_NODE(host->node_id) *
-						    64 + i];
+		if (max_speed > host->speed[i])
+			max_speed = host->speed[i];
 	priv->bc_sspd = max_speed;
 
 	/* We'll use our maxpayload as the default mtu */
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.c	2006-06-01 20:55:40.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c	2006-06-01 20:55:42.000000000 +0200
@@ -1664,10 +1664,8 @@ static int sbp2_max_speed_and_size(struc
 
 	SBP2_DEBUG_ENTER();
 
-	/* Initial setting comes from the hosts speed map */
 	scsi_id->speed_code =
-	    hi->host->speed_map[NODEID_TO_NODE(hi->host->node_id) * 64 +
-				NODEID_TO_NODE(scsi_id->ne->nodeid)];
+	    hi->host->speed[NODEID_TO_NODE(scsi_id->ne->nodeid)];
 
 	/* Bump down our speed if the user requested it */
 	if (scsi_id->speed_code > max_speed) {


