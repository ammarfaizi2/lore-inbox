Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUFAUJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUFAUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUFAUJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:09:59 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:29135 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S265201AbUFAUJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:09:56 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] active_load_balance() deadlock
Date: Tue, 1 Jun 2004 14:09:54 -0600
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011409.54478.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

active_load_balance() looks susceptible to deadlock when busiest==rq.
Without the following patch, my 128-way box deadlocks consistently
during boot-time driver init.

===== kernel/sched.c 1.304 vs edited =====
--- 1.304/kernel/sched.c	2004-05-27 02:26:55 -06:00
+++ edited/kernel/sched.c	2004-05-31 12:03:32 -06:00
@@ -1847,6 +1847,8 @@
  		}
 
 		rq = cpu_rq(push_cpu);
+		if (busiest == rq)
+			goto next_group;
 		double_lock_balance(busiest, rq);
 		move_tasks(rq, push_cpu, busiest, 1, sd, IDLE);
 		spin_unlock(&rq->lock);




