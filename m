Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWA2NvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWA2NvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWA2NvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:51:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64964 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750997AbWA2NvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:51:14 -0500
Date: Sun, 29 Jan 2006 07:51:04 -0600
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] - sys_sched_getaffinity & hotplug
Message-ID: <20060129135104.GA19068@sgi.com>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com> <20060128133244.GA22704@elte.hu> <20060128192736.GD18730@localhost.localdomain> <20060128120620.00be8227.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128120620.00be8227.pj@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change sched_getaffinity() so that it returns a bitmap that indicates the
legally schedulable cpus that a task is allowed to run on. 

Without this patch, if CONFIG_HOTPLUG_CPU is enabled, sched_getaffinity()
unconditionally returns (at least on IA64) a mask with NR_CPUS bits set.
This conveys no useful infornmation except for a kernel compile option.


	Signed-off-by: Jack Steiner <steiner@sgi.com>
	Acked-by: Ingo Molnar <mingo@elte.hu>

---
This fixes a breakage we obseved running recent kernels. We have MPI jobs
that use sched_getaffinity() to determine where to place their threads. 
Placing them on non-existant cpus is problematic :-)


Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-01-28 10:13:01.834293691 -0600
+++ linux/kernel/sched.c	2006-01-29 07:15:11.217227453 -0600
@@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
 		goto out_unlock;
 
 	retval = 0;
-	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
+	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
