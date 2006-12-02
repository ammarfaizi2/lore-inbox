Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162490AbWLBVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162490AbWLBVZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162491AbWLBVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:25:46 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:24799 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1162490AbWLBVZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:25:45 -0500
Date: Sun, 3 Dec 2006 00:25:17 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
Message-ID: <20061202212517.GA1199@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of rcu-add-a-prefetch-in-rcu_do_batch.patch

rcu_do_batch:

	struct rcu_head *next, *list;

	while (list) {
		next = list->next;	<------ [1]
		list->func(list);
		list = next;
	}

We can't trust *list after list->func() call, that is why we load list->next
beforehand. However I suspect in theory this is not enough, suppose that

	- [1] is stalled

	- list->func() marks *list as unused in some way

	- another CPU re-uses this rcu_head and dirties it

	- [1] completes and gets a wrong result

This means we need a barrier in between. mb() looks more suitable, but I think
rmb() should suffice.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 19-rc6/kernel/rcupdate.c~rdp	2006-12-02 20:46:03.000000000 +0300
+++ 19-rc6/kernel/rcupdate.c	2006-12-02 21:04:12.000000000 +0300
@@ -236,6 +236,8 @@ static void rcu_do_batch(struct rcu_data
 	list = rdp->donelist;
 	while (list) {
 		next = list->next;
+		/* complete the load above before we call ->func() */
+		smp_rmb();
 		prefetch(next);
 		list->func(list);
 		list = next;

