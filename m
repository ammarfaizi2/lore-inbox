Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUFHA2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUFHA2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 20:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUFHA2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 20:28:51 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:8942 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S265138AbUFHA2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 20:28:48 -0400
Message-ID: <40C5083C.1070209@bigpond.net.au>
Date: Tue, 08 Jun 2004 10:28:44 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6.7-rc2]  Single Priority Array CPU Scheduler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The single priority array scheduler (SPA) is a patch that simplifies the 
O(1) scheduler while maintaining its good scalability and interactive 
response characteristics.  The patch comes as four sub patches to 
simplify perusal of the changes:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc2-SPA-v0.1> 
replaces the active and expired arrays with a single array and 
introduces an O(1) promotion mechanism to provide the anti starvation 
guarantee that the dual arrays were supposed to provide.  The interval 
between promotions can be used to control the "severity" of "nice" (but 
at present these must be done by editing the code).  This patch uses 
fixed time slices that are renewed each time a task leaves the CPU and 
removes the need for the complex sharing of ticks between parent and 
child at fork() and exit().

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc2-SPA_IAB-v0.1>
replaces the implementation of the interactive bonus scheme with a more 
theoretical (and IMO easier to understand) mechanism based on the 
(recent) average amounts of time a task spends 1) on the CPU, 2) on the 
run queue waiting for CPU access and 3) sleeping during scheduling 
cycles (SC) which are defined to be from one activation of the task to 
the next.

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc2-SPA_TPT-v0.1> 
adds a new bonus scheme (also based on the scheduling statistics 
described above) whose intent is to minimize the amount of time that 
tasks spend on run queues and consequently increase overall system 
throughput.

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc2-SPA_TSTATS-v0.1> 

makes the per task scheduling statistics described above (plus number of 
completed SC and context switch counts) available in a (time stamped) 
file /proc/<TGID>/task/<TID>/cpustats so that the scheduling performance 
can be monitored and analyzed.  It is intended to use this data to 
analyze the behaviour of key programs (e.g. the X server) to determine 
the best values to be used for the control of the above mechanisms.

Future Work:

It is intended that key control variable for the above mechanisms be 
made run time configurable (mechanism yet to be decided).  The main 
reason for this is to allow optimum settings to determined via 
experimentation without the need to rebuild and reboot the kernel.  At 
some later stage, some (or perhaps all) of these control levers may be 
withdrawn.

It is further intended that a choice of how "nice" works: i.e. as a 
priority mechanism or as an entitlement mechanism; be made available as 
a run time configuration option.

Your comments on this work are solicited.

Thanks,
Peter
PS I am aware that the staircase scheduler also uses a single priority 
array and attempts are being made (in consultation with Con) to unify 
this component of the two schedulers.
-- 
Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

