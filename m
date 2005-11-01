Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVKAP3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVKAP3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVKAP3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:29:16 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41938 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750890AbVKAP3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:29:15 -0500
Date: Tue, 1 Nov 2005 07:29:33 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix remaining list_for_each_safe_rcu in -mm
Message-ID: <20051101152933.GA6210@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I missed a use of list_for_each_rcu_safe() in -mm tree.  Here is a patch
to fix it.

Signed-off-by: <paulmck@us.ibm.com>

---

 ipmi_msghandler.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.14-rc5-mm1-safe_rcu/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.6.14-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c	2005-11-01 06:44:09.000000000 -0800
+++ linux-2.6.14-rc5-mm1-safe_rcu/drivers/char/ipmi/ipmi_msghandler.c	2005-11-01 07:00:50.000000000 -0800
@@ -788,7 +788,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 	int              i;
 	unsigned long    flags;
 	struct cmd_rcvr  *rcvr;
-	struct list_head *entry1, *entry2;
+	struct list_head *entry1;
 	struct cmd_rcvr  *rcvrs = NULL;
 
 	user->valid = 1;
@@ -813,8 +813,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 	 * synchronize_rcu()) then free everything in that list.
 	 */
 	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
-	list_for_each_safe_rcu(entry1, entry2, &intf->cmd_rcvrs) {
-		rcvr = list_entry(entry1, struct cmd_rcvr, link);
+	list_for_each_entry_rcu(entry1, &intf->cmd_rcvrs, link) {
 		if (rcvr->user == user) {
 			list_del_rcu(&rcvr->link);
 			rcvr->next = rcvrs;
