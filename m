Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWJZQTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWJZQTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161429AbWJZQTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:19:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48590 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161399AbWJZQTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:19:47 -0400
Date: Thu, 26 Oct 2006 09:19:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 4/5] Create rebalance_domains from rebalance_tick
In-Reply-To: <4540A7CE.6060407@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610260913450.16978@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
 <20061024183124.4530.92230.sendpatchset@schroedinger.engr.sgi.com>
 <4540A7CE.6060407@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Nick Piggin wrote:

> > While we are at it: Take the opportunity to avoid taking
> > the request queue lock in wake_priority_sleeper if
> > there are no running processes.
> 
> Can you split this out? It is good without the tasklet based
> rebalancing.

Sure next rollup will have this:


Avoid taking the rq lock in wake_priority sleeper

Avoid taking the request queue lock in wake_priority_sleeper if
there are no running processes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-26 11:13:29.000000000 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-26 11:16:44.896476659 -0500
@@ -2900,6 +2900,9 @@ static inline int wake_priority_sleeper(
 	int ret = 0;
 
 #ifdef CONFIG_SCHED_SMT
+	if (!rq->nr_running)
+		return 0;
+
 	spin_lock(&rq->lock);
 	/*
 	 * If an SMT sibling task has been put to sleep for priority
