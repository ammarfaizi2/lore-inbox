Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUFGOFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUFGOFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUFGOFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:05:05 -0400
Received: from holomorphy.com ([207.189.100.168]:17847 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264648AbUFGOEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:04:49 -0400
Date: Mon, 7 Jun 2004 07:04:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040607140445.GA21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406070139.38433.kernel@kolivas.org> <20040607135631.GY21007@holomorphy.com> <20040607135738.GZ21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607135738.GZ21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 06:57:38AM -0700, William Lee Irwin III wrote:
> JIFFIES_TO_NS() is unused.

array->nr_active only ever modified, never examined.


Index: kolivas-2.6.7-rc2/kernel/sched.c
===================================================================
--- kolivas-2.6.7-rc2.orig/kernel/sched.c	2004-06-07 06:53:26.779390000 -0700
+++ kolivas-2.6.7-rc2/kernel/sched.c	2004-06-07 07:03:00.910109000 -0700
@@ -92,7 +92,6 @@
 typedef struct runqueue runqueue_t;
 
 struct prio_array {
-	unsigned int nr_active;
 	unsigned long bitmap[BITMAP_SIZE];
 	struct list_head queue[MAX_PRIO + 1];
 };
@@ -204,7 +203,6 @@
 static void dequeue_task(struct task_struct *p, runqueue_t *rq)
 {
 	prio_array_t* array = &rq->array;
-	array->nr_active--;
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
@@ -215,7 +213,6 @@
 	prio_array_t* array = &rq->array;
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
 	p->array = array;
 }
 
@@ -229,7 +226,6 @@
 	prio_array_t* array = &rq->array;
 	list_add(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
 	p->array = array;
 }
 
@@ -1095,7 +1091,6 @@
 			p->prio = current->prio;
 			list_add_tail(&p->run_list, &current->run_list);
 			p->array = current->array;
-			p->array->nr_active++;
 			rq->nr_running++;
 		}
 	} else {
