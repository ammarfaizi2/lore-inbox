Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbWGKEgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbWGKEgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWGKEgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:36:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:11499 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965164AbWGKEgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:36:42 -0400
Subject: [Patch 6/6] per task delay accounting taskstats interface: fix
	clone skbs for each listener
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152592599.14142.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:36:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a cloned sk_buff for each netlink message sent to multiple listeners.

Earlier, the same skb, representing a netlink message, was being erroneously 
reused for doing genetlink_unicast()'s (effectively netlink_unicast()) to 
each listener on the per-cpu list of listeners. Since netlink_unicast() frees
up the skb passed to it, regardless of status of the send, reuse is bad.

Thanks to Chandra Seetharaman for discovering this bug.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 kernel/taskstats.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc1/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc1.orig/kernel/taskstats.c	2006-07-10 23:44:56.000000000 -0400
+++ linux-2.6.18-rc1/kernel/taskstats.c	2006-07-10 23:45:15.000000000 -0400
@@ -125,6 +125,7 @@ static int send_cpu_listeners(struct sk_
 	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
 	struct listener_list *listeners;
 	struct listener *s, *tmp;
+	struct sk_buff *skb_next, *skb_cur = skb;
 	void *reply = genlmsg_data(genlhdr);
 	int rc, ret;
 
@@ -138,12 +139,22 @@ static int send_cpu_listeners(struct sk_
 	listeners = &per_cpu(listener_array, cpu);
 	down_write(&listeners->sem);
 	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
-		ret = genlmsg_unicast(skb, s->pid);
+		skb_next = NULL;
+		if (!list_islast(&s->list, &listeners->list)) {
+			skb_next = skb_clone(skb_cur, GFP_KERNEL);
+			if (!skb_next) {
+				nlmsg_free(skb_cur);
+				rc = -ENOMEM;
+				break;
+			}
+		}
+		ret = genlmsg_unicast(skb_cur, s->pid);
 		if (ret == -ECONNREFUSED) {
 			list_del(&s->list);
 			kfree(s);
 			rc = ret;
 		}
+		skb_cur = skb_next;
 	}
 	up_write(&listeners->sem);
 


