Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274972AbTHMNRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHMNPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:15:48 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:14505 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S274961AbTHMNPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:15:31 -0400
Subject: Re: [PATCH] sched_best_cpu
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1060779608.1723.30.camel@tom>
References: <1060779608.1723.30.camel@tom>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 13 Aug 2003 15:15:28 +0200
Message-Id: <1060780528.2211.35.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the good one.

Frank.


--- sched.c.orig	2003-08-09 06:39:35.000000000 +0200
+++ sched.c	2003-08-13 15:13:00.000000000 +0200
@@ -776,7 +776,7 @@
  */
 static int sched_best_cpu(struct task_struct *p)
 {
-	int i, minload, load, best_cpu, node = 0;
+	int i, minload, load, best_cpu, node = 0, pnode;
 	unsigned long cpumask;
 
 	best_cpu = task_cpu(p);
@@ -784,14 +784,15 @@
 		return best_cpu;
 
 	minload = 10000000;
+	pnode = cpu_to_node(task_cpu(p));
 	for_each_node_with_cpus(i) {
 		/*
 		 * Node load is always divided by nr_cpus_node to normalise 
 		 * load values in case cpu count differs from node to node.
-		 * We first multiply node_nr_running by 10 to get a little
-		 * better resolution.   
+		 * If the node != our node we add the load of the task.
+		 * We multiply by 10 for better resolution.
 		 */
-		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
+		load = 10 * (atomic_read(&node_nr_running[i]) + (i != pnode)) / nr_cpus_node(i);
 		if (load < minload) {
 			minload = load;
 			node = i;

