Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWC1UOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWC1UOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWC1UOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:14:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4802 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932136AbWC1UOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:14:50 -0500
Date: Tue, 28 Mar 2006 14:14:29 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Eric Dumazet <dada1@cosmosbay.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, roe@sgi.com, steiner@sgi.com, clameter@sgi.com
Subject: [PATCH] Call get_softirq_time() only when necessary in run_hrtimer_queue()
Message-ID: <20060328201429.GA17130@sgi.com>
References: <20060324175136.GA10186@sgi.com> <20060324142849.5cc27edb.akpm@osdl.org> <20060328165127.GC10411@sgi.com> <442974BC.30304@cosmosbay.com> <20060328175511.GC13918@sgi.com> <1143573640.5344.215.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143573640.5344.215.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that run_hrtimer_queue() is calling get_softirq_time() more
often than it needs to.

With this patch, it only calls get_softirq_time() if there's a
pending timer.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c	2006-03-28 11:46:45.279722496 -0600
+++ linux/kernel/hrtimer.c	2006-03-28 11:51:36.722469752 -0600
@@ -606,6 +606,9 @@ static inline void run_hrtimer_queue(str
 {
 	struct rb_node *node;
 
+	if (!base->first)
+		return;
+
 	if (base->get_softirq_time)
 		base->softirq_time = base->get_softirq_time();
 
