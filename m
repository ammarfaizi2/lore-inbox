Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWGQVyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWGQVyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWGQVyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:54:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16772 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751200AbWGQVyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:54:17 -0400
Subject: [Patch 2/3] taskstats: free skb, avoid returns in
	send_cpu_listeners
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Chris Sturtivant <csturtiv@sgi.com>
In-Reply-To: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
References: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1153173255.4551.16.camel@dyn9002218086.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Jul 2006 17:54:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing freeing of skb in the case there are no listeners at all.
Also remove the returning of error values by the function as it is unused by
the sole caller.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 kernel/taskstats.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

Index: linux-2.6.18-rc2/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/taskstats.c	2006-07-17 17:03:41.000000000 -0400
+++ linux-2.6.18-rc2/kernel/taskstats.c	2006-07-17 17:06:52.000000000 -0400
@@ -121,46 +121,45 @@ static int send_reply(struct sk_buff *sk
 /*
  * Send taskstats data in @skb to listeners registered for @cpu's exit data
  */
-static int send_cpu_listeners(struct sk_buff *skb, unsigned int cpu)
+static void send_cpu_listeners(struct sk_buff *skb, unsigned int cpu)
 {
 	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
 	struct listener_list *listeners;
 	struct listener *s, *tmp;
 	struct sk_buff *skb_next, *skb_cur = skb;
 	void *reply = genlmsg_data(genlhdr);
-	int rc, ret, delcount = 0;
+	int rc, delcount = 0;
 
 	rc = genlmsg_end(skb, reply);
 	if (rc < 0) {
 		nlmsg_free(skb);
-		return rc;
+		return;
 	}
 
 	rc = 0;
 	listeners = &per_cpu(listener_array, cpu);
 	down_read(&listeners->sem);
-	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
+	list_for_each_entry(s, &listeners->list, list) {
 		skb_next = NULL;
 		if (!list_is_last(&s->list, &listeners->list)) {
 			skb_next = skb_clone(skb_cur, GFP_KERNEL);
-			if (!skb_next) {
-				nlmsg_free(skb_cur);
-				rc = -ENOMEM;
+			if (!skb_next)
 				break;
-			}
 		}
-		ret = genlmsg_unicast(skb_cur, s->pid);
-		if (ret == -ECONNREFUSED) {
+		rc = genlmsg_unicast(skb_cur, s->pid);
+		if (rc == -ECONNREFUSED) {
 			s->valid = 0;
 			delcount++;
-			rc = ret;
 		}
 		skb_cur = skb_next;
 	}
 	up_read(&listeners->sem);
 
+	if (skb_cur)
+		nlmsg_free(skb_cur);
+
 	if (!delcount)
-		return rc;
+		return;
 
 	/* Delete invalidated entries */
 	down_write(&listeners->sem);
@@ -171,7 +170,6 @@ static int send_cpu_listeners(struct sk_
 		}
 	}
 	up_write(&listeners->sem);
-	return rc;
 }
 
 static int fill_pid(pid_t pid, struct task_struct *pidtsk,


