Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbVKVVI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVKVVI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVKVVHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:07:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965191AbVKVVHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:07:32 -0500
Date: Tue, 22 Nov 2005 13:06:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>
Subject: [patch 09/23] [PATCH] [NETFILTER] nf_queue: Fix Ooops when no queue handler registered
Message-ID: <20051122210644.GJ28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nf_queue-fix-oops-when-no-queue-handler-registered.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

With the new nf_queue generalization in 2.6.14, we've introduced a bug
that causes an oops as soon as a packet is queued but no queue handler
registered.  This patch fixes it.

Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/netfilter/nf_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.2.orig/net/netfilter/nf_queue.c
+++ linux-2.6.14.2/net/netfilter/nf_queue.c
@@ -117,7 +117,7 @@ int nf_queue(struct sk_buff **skb, 
 
 	/* QUEUE == DROP if noone is waiting, to be safe. */
 	read_lock(&queue_handler_lock);
-	if (!queue_handler[pf]->outfn) {
+	if (!queue_handler[pf] || !queue_handler[pf]->outfn) {
 		read_unlock(&queue_handler_lock);
 		kfree_skb(*skb);
 		return 1;

--
