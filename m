Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTDWObJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTDWObJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:31:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:47564 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264044AbTDWObH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:31:07 -0400
Date: Wed, 23 Apr 2003 07:43:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 619] New: [perf][sdet]sched_best_cpu does not pick best cpu 
Message-ID: <14600000.1051108990@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=619

           Summary: [perf][sdet]sched_best_cpu does not pick best cpu
    Kernel Version: 2.6.65
            Status: NEW
          Severity: normal
             Owner: rml@tech9.net
         Submitter: habanero@us.ibm.com


Hardware Environment:
pSeries NUMA 

Software Environment:
Linux 2.5


Steps to Reproduce:
1.Boot Linux 2.5 kernel with NUMA support
2.Run any workload with fork+exec


Actual Results:
sched_best_cpu does not pick best cpu

Expected Results:
sched_best_cpu does pick best cpu


This occurs when you have NUMA nodes with no cpus, like on p670: node0 has 8
cpus, node1 has 0 cpus, node2 has 8 cpus.  sched_best_cpu() uses
node_nr_running, which is initialized with "0" for each node.  Since there
are no cpus in node1, no tasks are mograted there, and node_nr_running[1]
does not go above 0.  So, with at least one task running, node1 is always
picked as the least loaded node to place a newly exec'd task.

Eventually the parent's task_cpu will be picked, making sched_best_cpu 
ineffective.

Also, ideally this code needs some attention in node load.  node load is
currently computed by summing up all the running tasks in a node.  This
does not compensate for nodes that have different cpu counts, which may be
a likely situation with cpu hot plug, dynamic partitions, etc.  This stuff
is probably a bit in the future and not highest priority, be we should
probably think about  it.


Anyway, to fix the basic problem, add a new function, node_online, which
functions simialr to cpu_online, and add  a statement "if
(!node_online(node) continue;" anywhere we do for(node=0; node<maxnumnodes;
node++)

Node_online for pSereis is easy, use numa_node_exists[] array.
I guess we need a asm-generic one, too.

I have a rough version of this running right now, I'll send a patch asap.


