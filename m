Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWB0Weo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWB0Weo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWB0Wej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:34:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58752 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932471AbWB0WcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:32:10 -0500
Message-Id: <20060227223348.165128000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Drzewiecki <z@drze.net>, Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/39] [PATCH] [BRIDGE]: Fix deadlock in br_stp_disable_bridge
Content-Disposition: inline; filename=fix-deadlock-in-br_stp_disable_bridge.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Looks like somebody forgot to use the _bh spin_lock variant. We ran into a
deadlock where br->hello_timer expired while br_stp_disable_br() walked
br->port_list.

Signed-off-by: Adrian Drzewiecki <z@drze.net>
Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/bridge/br_stp_if.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15.4.orig/net/bridge/br_stp_if.c
+++ linux-2.6.15.4/net/bridge/br_stp_if.c
@@ -67,7 +67,7 @@ void br_stp_disable_bridge(struct net_br
 {
 	struct net_bridge_port *p;
 
-	spin_lock(&br->lock);
+	spin_lock_bh(&br->lock);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (p->state != BR_STATE_DISABLED)
 			br_stp_disable_port(p);
@@ -76,7 +76,7 @@ void br_stp_disable_bridge(struct net_br
 
 	br->topology_change = 0;
 	br->topology_change_detected = 0;
-	spin_unlock(&br->lock);
+	spin_unlock_bh(&br->lock);
 
 	del_timer_sync(&br->hello_timer);
 	del_timer_sync(&br->topology_change_timer);

--
