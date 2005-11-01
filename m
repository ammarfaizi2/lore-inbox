Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVKAQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKAQRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVKAQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:17:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8384 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750834AbVKAQRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:17:01 -0500
Date: Tue, 1 Nov 2005 08:17:18 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, serue@us.ibm.com, minyard@acm.org
Subject: [PATCH] fix remaining list_for_each_safe_rcu in -mm (take 2)
Message-ID: <20051101161717.GA6346@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051101152933.GA6210@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101152933.GA6210@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I missed a use of list_for_each_rcu_safe() in -mm tree.  Here is an updated
patch to fix it.  This time tested on a machine that actually uses IPMI...
(Thanks to Serge Hallyn for spotting this.)

Signed-off-by: <paulmck@us.ibm.com>

---

diff -urpNa -X dontdiff linux-2.6.14-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.14-rc5-mm1-safe_rcu/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.6.14-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c	2005-11-01 06:44:09.000000000 -0800
+++ linux-2.6.14-rc5-mm1-safe_rcu/drivers/char/ipmi/ipmi_msghandler.c	2005-11-01 08:03:45.000000000 -0800
@@ -788,7 +788,6 @@ int ipmi_destroy_user(ipmi_user_t user)
 	int              i;
 	unsigned long    flags;
 	struct cmd_rcvr  *rcvr;
-	struct list_head *entry1, *entry2;
 	struct cmd_rcvr  *rcvrs = NULL;
 
 	user->valid = 1;
@@ -813,8 +812,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 	 * synchronize_rcu()) then free everything in that list.
 	 */
 	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
-	list_for_each_safe_rcu(entry1, entry2, &intf->cmd_rcvrs) {
-		rcvr = list_entry(entry1, struct cmd_rcvr, link);
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
 		if (rcvr->user == user) {
 			list_del_rcu(&rcvr->link);
 			rcvr->next = rcvrs;
