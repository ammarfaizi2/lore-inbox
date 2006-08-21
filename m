Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWHUStB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWHUStB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWHUSsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:48:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58044 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750760AbWHUSsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:33 -0400
Date: Mon, 21 Aug 2006 11:46:54 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>,
       Mark Huang <mlhuang@cs.princeton.edu>,
       Patrick McHardy <kaber@trash.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/20] : ulog: fix panic on SMP kernels
Message-ID: <20060821184654.GK21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ulog-fix-panic-on-smp-kernels.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Mark Huang <mlhuang@cs.princeton.edu>

[NETFILTER]: ulog: fix panic on SMP kernels

Fix kernel panic on various SMP machines. The culprit is a null
ub->skb in ulog_send(). If ulog_timer() has already been scheduled on
one CPU and is spinning on the lock, and ipt_ulog_packet() flushes the
queue on another CPU by calling ulog_send() right before it exits,
there will be no skbuff when ulog_timer() acquires the lock and calls
ulog_send(). Cancelling the timer in ulog_send() doesn't help because
it has already been scheduled and is running on the first CPU.

Similar problem exists in ebt_ulog.c and nfnetlink_log.c.

Signed-off-by: Mark Huang <mlhuang@cs.princeton.edu>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/bridge/netfilter/ebt_ulog.c |    3 +++
 net/ipv4/netfilter/ipt_ULOG.c   |    5 +++++
 net/netfilter/nfnetlink_log.c   |    3 +++
 3 files changed, 11 insertions(+)

--- linux-2.6.17.9.orig/net/bridge/netfilter/ebt_ulog.c
+++ linux-2.6.17.9/net/bridge/netfilter/ebt_ulog.c
@@ -75,6 +75,9 @@ static void ulog_send(unsigned int nlgro
 	if (timer_pending(&ub->timer))
 		del_timer(&ub->timer);
 
+	if (!ub->skb)
+		return;
+
 	/* last nlmsg needs NLMSG_DONE */
 	if (ub->qlen > 1)
 		ub->lastnlh->nlmsg_type = NLMSG_DONE;
--- linux-2.6.17.9.orig/net/ipv4/netfilter/ipt_ULOG.c
+++ linux-2.6.17.9/net/ipv4/netfilter/ipt_ULOG.c
@@ -116,6 +116,11 @@ static void ulog_send(unsigned int nlgro
 		del_timer(&ub->timer);
 	}
 
+	if (!ub->skb) {
+		DEBUGP("ipt_ULOG: ulog_send: nothing to send\n");
+		return;
+	}
+
 	/* last nlmsg needs NLMSG_DONE */
 	if (ub->qlen > 1)
 		ub->lastnlh->nlmsg_type = NLMSG_DONE;
--- linux-2.6.17.9.orig/net/netfilter/nfnetlink_log.c
+++ linux-2.6.17.9/net/netfilter/nfnetlink_log.c
@@ -366,6 +366,9 @@ __nfulnl_send(struct nfulnl_instance *in
 	if (timer_pending(&inst->timer))
 		del_timer(&inst->timer);
 
+	if (!inst->skb)
+		return 0;
+
 	if (inst->qlen > 1)
 		inst->lastnlh->nlmsg_type = NLMSG_DONE;
 

--
