Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWJ1Cle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWJ1Cle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWJ1Cle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:41:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10473 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751619AbWJ1Cld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:41:33 -0400
Date: Fri, 27 Oct 2006 19:41:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061028024117.10809.74875.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/7] Avoid taking rq lock in wake_priority_sleeper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid taking the rq lock in wake_priority sleeper

Avoid taking the request queue lock in wake_priority_sleeper if
there are no running processes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-26 21:30:11.328325096 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-27 11:58:02.142767971 -0500
@@ -2898,6 +2898,9 @@ static inline int wake_priority_sleeper(
 	int ret = 0;
 
 #ifdef CONFIG_SCHED_SMT
+	if (!rq->nr_running)
+		return 0;
+
 	spin_lock(&rq->lock);
 	/*
 	 * If an SMT sibling task has been put to sleep for priority
