Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWGKEdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWGKEdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWGKEdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:33:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48361 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965144AbWGKEdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:33:05 -0400
Subject: [Patch 4/6] per task delay accounting taskstats interface: fix
	drop listener only on socket close
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152592382.14142.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:33:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove listeners from per-cpu listener lists only if they've closed the
socket (resulting in an ECONNREFUSED failure of genetlink unicast). 
For other errors returned by genlmsg_unicast like -EAGAIN which results 
from the receiver's buffer having insufficient space, userspace gets an 
ENOBUF warning and the kernel can continue.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Balbir Singh <balbir@in.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 kernel/taskstats.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc1/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc1.orig/kernel/taskstats.c	2006-07-10 23:44:54.000000000 -0400
+++ linux-2.6.18-rc1/kernel/taskstats.c	2006-07-10 23:44:56.000000000 -0400
@@ -139,7 +139,7 @@ static int send_cpu_listeners(struct sk_
 	down_write(&listeners->sem);
 	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
 		ret = genlmsg_unicast(skb, s->pid);
-		if (ret) {
+		if (ret == -ECONNREFUSED) {
 			list_del(&s->list);
 			kfree(s);
 			rc = ret;


