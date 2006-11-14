Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966330AbWKNUdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966330AbWKNUdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbWKNUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:33:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60833 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966330AbWKNUdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:19 -0500
Date: Tue, 14 Nov 2006 12:33:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061114203301.12761.56852.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/8] Avoid taking rq lock in wake_priority_sleeper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid taking the rq lock in wake_priority sleeper

Avoid taking the request queue lock in wake_priority_sleeper if
there are no running processes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-13 14:23:24.244457947 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-13 14:23:29.984173185 -0600
@@ -2918,6 +2918,9 @@ static inline int wake_priority_sleeper(
 	int ret = 0;
 
 #ifdef CONFIG_SCHED_SMT
+	if (!rq->nr_running)
+		return 0;
+
 	spin_lock(&rq->lock);
 	/*
 	 * If an SMT sibling task has been put to sleep for priority
