Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWJ2O5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWJ2O5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 09:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWJ2O5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 09:57:31 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:28102 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932336AbWJ2O5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 09:57:31 -0500
Date: Sun, 29 Oct 2006 18:57:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Graf <tgraf@suug.ch>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] taskstats: fix? sk_buff size calculation
Message-ID: <20061029155716.GA1213@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, I am not sure this patch is correct, it needs an ack...

prepare_reply() adds GENL_HDRLEN to the payload (genlmsg_total_size()),
but then it does genlmsg_put()->nlmsg_put(). This means we forget to
reserve a room for 'struct nlmsghdr', no?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~2_size	2006-10-29 16:39:10.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-10-29 18:35:40.000000000 +0300
@@ -77,7 +77,8 @@ static int prepare_reply(struct genl_inf
 	/*
 	 * If new attributes are added, please revisit this allocation
 	 */
-	skb = nlmsg_new(genlmsg_total_size(size), GFP_KERNEL);
+	size = nlmsg_total_size(genlmsg_total_size(size));
+	skb = nlmsg_new(size, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 

