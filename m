Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUJEHKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUJEHKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 03:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUJEHKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 03:10:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268902AbUJEHKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 03:10:06 -0400
Date: Tue, 5 Oct 2004 03:09:31 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: bug in sched.c:activate_task()
In-Reply-To: <cone.1096959567.406629.10082.502@pc.kolivas.org>
Message-ID: <Pine.LNX.4.58.0410050303280.7299@devserv.devel.redhat.com>
References: <200410050216.i952Gb620657@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com>
 <cone.1096958170.135056.10082.502@pc.kolivas.org>
 <Pine.LNX.4.58.0410050250580.4941@devserv.devel.redhat.com>
 <cone.1096959567.406629.10082.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Oct 2004, Con Kolivas wrote:

> We used to compare jiffy difference in can_migrate_task by comparing it
> to cache_decay_ticks. Somewhere in the merging of sched_domains it was
> changed to task_hot which uses timestamp.

yep, that's fishy. Kenneth, could you try the simple patch below? It gets
rid of task_hot() in essence. If this works out we could try it - it gets
rid of some more code from sched.c too. Perhaps SD_WAKE_AFFINE is enough
control.

	Ingo

--- kernel/sched.c.orig	2004-10-05 08:28:42.295395160 +0200
+++ kernel/sched.c	2004-10-05 09:07:44.081389576 +0200
@@ -180,7 +180,7 @@ static unsigned int task_timeslice(task_
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
-#define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
+#define task_hot(p, now, sd) 0
 
 enum idle_type
 {
