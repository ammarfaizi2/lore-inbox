Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264591AbUDTXQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUDTXQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUDTXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:14:58 -0400
Received: from fmr11.intel.com ([192.55.52.31]:62185 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264181AbUDTXIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:08:47 -0400
Date: Tue, 20 Apr 2004 16:04:26 -0700 (PDT)
From: Scott Feldman <scott.feldman@intel.com>
To: Mike Keehan <mike_keehan@yahoo.com>, eamonn.hamilton@saic.com
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: e100 NETDEV WATCHDOG transmit timeout since 2.6.4
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0103E9A4E6@orsmsx402.jf.intel.com>
Message-ID: <Pine.LNX.4.58.0404201559290.7794@snichols-desk.amr.corp.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103E9A4E6@orsmsx402.jf.intel.com>
ReplyTo: "Scott Feldman" <scott.feldman@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Apr 2004, Mike Keehan wrote:

> I am getting these too in recent kernels, but only on a
> 10Mhz half-duplex network. I have to manually down
> and up the interface to recover.
>
> On a 100Mhz switched network, the e100 is OK (at least 12hours+).


Mike/Eamonn,

Give this patch a try.  This adds a required workaround for ICH when
working at 10/Half.  (Guessing you have an ICH system).

--- linux-2.5/drivers/net/e100.c	2004-04-20 15:52:24.000000000 -0700
+++ linux-2.5/drivers/net/e100.c.mod	2004-04-20 15:55:32.000000000 -0700
@@ -287,6 +287,7 @@ enum scb_cmd_hi {
 };

 enum scb_cmd_lo {
+	cuc_nop        = 0x00,
 	ruc_start      = 0x01,
 	ruc_load_base  = 0x06,
 	cuc_start      = 0x10,
@@ -514,10 +515,11 @@ struct nic {
 	/* End: frequently used values: keep adjacent for cache effect */

 	enum {
-		ich           = (1 << 0),
-		promiscuous   = (1 << 1),
-		multicast_all = (1 << 2),
-		wol_magic     = (1 << 3),
+		ich                = (1 << 0),
+		promiscuous        = (1 << 1),
+		multicast_all      = (1 << 2),
+		wol_magic          = (1 << 3),
+		ich_10h_workaround = (1 << 4),
 	} flags					____cacheline_aligned;

 	enum mac mac;
@@ -1225,6 +1227,12 @@ static void e100_watchdog(unsigned long
 		/* Issue a multicast command to workaround a 557 lock up */
 		e100_set_multicast_list(nic->netdev);

+	if(nic->flags & ich && cmd.speed==SPEED_10 && cmd.duplex==DUPLEX_HALF)
+		/* Need SW workaround for ICH[x] 10Mbps/half duplex Tx hang. */
+		nic->flags |= ich_10h_workaround;
+	else
+		nic->flags &= ~ich_10h_workaround;
+
 	mod_timer(&nic->watchdog, jiffies + E100_WATCHDOG_PERIOD);
 }

@@ -1244,7 +1252,17 @@ static inline void e100_xmit_prepare(str
 static int e100_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct nic *nic = netdev->priv;
-	int err = e100_exec_cb(nic, skb, e100_xmit_prepare);
+	int err;
+
+	if(nic->flags & ich_10h_workaround) {
+		/* SW workaround for ICH[x] 10Mbps/half duplex Tx hang.
+		   Issue a NOP command followed by a 1us delay before
+		   issuing the Tx command. */
+		e100_exec_cmd(nic, cuc_nop, 0);
+		udelay(1);
+	}
+
+	err = e100_exec_cb(nic, skb, e100_xmit_prepare);

 	switch(err) {
 	case -ENOSPC:

