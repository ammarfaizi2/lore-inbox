Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTDJX0g (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTDJX0g (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:26:36 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:47505 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264241AbTDJX0e (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:26:34 -0400
Subject: [PATCH] fix modify-after-free bug in ip_conntrack
From: Martin Josefsson <gandalf@netfilter.org>
Reply-To: gandalf@wlug.westbo.se
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050017895.11156.95.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Apr 2003 01:38:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here's a patch that fixes a modify-after-free bug in ip_conntrack which
was caught by the slab-debugging in 2.5

I've tried to get Harald to approve it and send it to you but I've been
unable to get any response from him for ~2 weeks, so here it is. He can
complain later and provide a diffrent fix if he doesn't like this one.

This patch fixes the case where a related connection terminates after
the connection that expected it has already terminated. In this case the
list_head of the already terminated (and free'd) connection were
modified and we might get invalid pointers in other expectations.

Andrew has had a slightly diffrent fix in -mm during this time. That
patch fixed the modify-after-free but still left invalid pointers in
expectations, this one doesn't.

Please apply to both 2.4 and 2.5


diff -urN linux-2.5.65.orig/net/ipv4/netfilter/ip_conntrack_core.c linux-2.5.65.fixed/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.5.65.orig/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-17 22:43:37.000000000 +0100
+++ linux-2.5.65.fixed/net/ipv4/netfilter/ip_conntrack_core.c	2003-04-11 01:07:19.000000000 +0200
@@ -274,6 +274,8 @@
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
+			/* Indicate that this expectations parent is dead */
+			exp->expectant = NULL;
 			continue;
 		}
 
@@ -325,6 +327,9 @@
 		ip_conntrack_destroyed(ct);
 
 	WRITE_LOCK(&ip_conntrack_lock);
+	/* Delete us from our own list to prevent corruption later */
+	list_del(&ct->sibling_list);
+
 	/* Delete our master expectation */
 	if (ct->master) {
 		/* can't call __unexpect_related here,


-- 
/Martin
