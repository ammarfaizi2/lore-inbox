Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVATR7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVATR7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVATR7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:59:30 -0500
Received: from mailfe02.swip.net ([212.247.154.33]:42919 "EHLO
	mailfe02.swip.net") by vger.kernel.org with ESMTP id S261244AbVATRzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:55:16 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
	scheduling
From: Alexander Nyberg <alexn@dsv.su.se>
To: utz lehmann <lkml@s2y4n2c.de>
Cc: Con Kolivas <kernel@kolivas.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, joq@io.com, CK Kernel <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1106180177.4036.27.camel@segv.aura.of.mankind>
References: <41EEE1B1.9080909@kolivas.org>
	 <1106180177.4036.27.camel@segv.aura.of.mankind>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 18:54:58 +0100
Message-Id: <1106243698.719.6.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My simple yield DoS don't work anymore. But i found another way.
> Running this as SCHED_ISO:

Yep, bad accounting in queue_iso() which relied on p->array == rq->active
This fixes it:


Index: vanilla/kernel/sched.c
===================================================================
--- vanilla.orig/kernel/sched.c	2005-01-20 18:05:59.000000000 +0100
+++ vanilla/kernel/sched.c	2005-01-20 18:41:26.000000000 +0100
@@ -2621,15 +2621,19 @@
 static task_t* queue_iso(runqueue_t *rq, prio_array_t *array)
 {
 	task_t *p = list_entry(rq->iso_queue.next, task_t, iso_list);
-	if (p->prio == MAX_RT_PRIO)
-		goto out;
+	prio_array_t *old_array = p->array;
+	
+	old_array->nr_active--;
 	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+	if (list_empty(old_array->queue + p->prio))
+		__clear_bit(p->prio, old_array->bitmap);
+	
 	p->prio = MAX_RT_PRIO;
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
-out:
+	array->nr_active++;
+	p->array = array;
+	
 	return p;
 }
 


