Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTDWNrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTDWNrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:47:35 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:38365 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264035AbTDWNrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:47:32 -0400
Date: Wed, 23 Apr 2003 09:46:00 -0400
From: Ben Collins <bcollins@debian.org>
To: Tony Spinillo <tspinillo@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423134600.GH354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423133256.GG354@phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tony, you are seeing a different problem. I'll get you a patch soon (for
> the record, I'm not even subscribed to linux1394-user, but to
> linux1394-devel).

Give this patch a try. It's only a workaround, but this check needs to
be there anyway for sanity. Seems cameras cause this problem more than
anything else. Has never happeneed to me with my DV camera and DCAM) so
I haven't been able to pin down the problem yet.


Index: nodemgr.c
===================================================================
--- nodemgr.c	(revision 899)
+++ nodemgr.c	(working copy)
@@ -1264,7 +1264,7 @@
 /* We need to ensure that if we are not the IRM, that the IRM node is capable of
  * everything we can do, otherwise issue a bus reset and try to become the IRM
  * ourselves. */
-static int nodemgr_check_irm_capability(struct hpsb_host *host)
+static int nodemgr_check_irm_capability(struct hpsb_host *host, int cycles)
 {
 	quadlet_t bc;
 	int status;
@@ -1281,10 +1281,19 @@
 		/* The current irm node does not have a valid BROADCAST_CHANNEL
 		 * register and we do, so reset the bus with force_root set */
 		HPSB_DEBUG("Current remote IRM is not 1394a-2000 compliant, resetting...");
+
+		if (cycles >= 5) {
+			/* Oh screw it! Just leave the bus as it is */
+			HPSB_DEBUG("Stopping reset loop for IRM sanity");
+			return 1;
+		}
+
 		hpsb_send_phy_config(host, host->node_id, -1);
 		hpsb_reset_bus(host, LONG_RESET_FORCE_ROOT);
+
 		return 0;
 	}
+
 	return 1;
 }
 
@@ -1292,6 +1301,7 @@
 {
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
+	int reset_cycles = 0;
 
 	/* No userlevel access needed */
 	daemonize();
@@ -1324,12 +1334,14 @@
 				i = HZ/4;
 		}
 
-		if (!nodemgr_check_irm_capability(host)) {
+		if (!nodemgr_check_irm_capability(host, reset_cycles++)) {
 			/* Do nothing, we are resetting */
 			up(&nodemgr_serialize);
 			continue;
 		}
 
+		reset_cycles = 0;
+
 		nodemgr_node_probe(hi, generation);
 		nodemgr_do_irm_duties(host);
 
