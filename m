Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWAINQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWAINQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWAINQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:16:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:60333 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751404AbWAINQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:16:50 -0500
Message-ID: <43C27417.AA1BA306@tv-sign.ru>
Date: Mon, 09 Jan 2006 17:32:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/5][RFC] rcu: start new grace period from rcu_pending()
References: <43C165D7.6EAB8E47@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
>
> I think it is better to set ->qs_pending = 1 directly in __rcu_pending():

This patch has a bug. I am sending a trivial fix, but now I am not
sure myself that 1 timer tick saved worth the code uglification.

[PATCH 6/5] rcu: start new grace period from rcu_pending() fix

We should not miss __rcu_pending(&rcu_bh_ctrlblk) in rcu_pending().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/rcupdate.c~6_FIX	2006-01-09 00:26:44.000000000 +0300
+++ 2.6.15/kernel/rcupdate.c	2006-01-09 19:19:27.000000000 +0300
@@ -464,7 +464,7 @@ static int __rcu_pending(struct rcu_ctrl
 
 int rcu_pending(int cpu)
 {
-	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
+	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) |
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
