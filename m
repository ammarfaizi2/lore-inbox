Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265794AbUE1EwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUE1EwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 00:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUE1EwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 00:52:14 -0400
Received: from CPE-203-45-91-93.nsw.bigpond.net.au ([203.45.91.93]:61172 "EHLO
	mudlark.pw.nest") by vger.kernel.org with ESMTP id S265794AbUE1EwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 00:52:06 -0400
Message-ID: <40B6C571.3000103@aurema.com>
Date: Fri, 28 May 2004 14:52:01 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with
 a single array
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a modification of the O(1) scheduler to replace the active and 
expired priority arrays with a single priority array:

<http://users.bigpond.net.au/Peter-Williams/patch-2.6.6-spa>

This patch simplifies the scheduler code by:

- removing the need to manage two priority arrays per CPU
- removing the need to use variable time slices to implement "nice" 
which means no more sharing of time slices between parents and children 
at fork and exit.

Key features are:

-- uses the existing "interactive task" bonus scheme so there is no 
change to interactive responsiveness
-- the number of priority slots has been increased by MAX_BONUS + 1 so 
that there is no need to truncate the allocated priority after 
allocation of the bonus and to allow the "idle" tasks to be placed on 
the queues
-- at the end of each time slice (or when waking up) each task is given 
a complete new time slice and, if class SCHED_NORMAL, is put in a 
priority slot given by (static_prio + MAX_BONUS - interactive_bonus)
-- starvation is prevented by promoting all runnable tasks by one 
priority slot at intervals determined by a base promotion interval 
multiplied by the number of runnable tasks on the CPU in question
-- when there are less than 2 runnable processes on the CPU the 
promotion is not performed
-- in order for the anti starvation promotion mechanism to be O(1) the 
"prio" field has been removed from the task structure
-- to enable the priority of the current task to be available for 
various uses that previously used current->prio a record of the priority 
slot for the current task is now kept in the runqueue struct
-- having the "idle" tasks on the queues allows the code for selecting 
the "next" task in schedule() to be simplified

Effected files are:

init_task.h -- cope with removal of "prio" and "array" from task struct
sched.h -- remove "prio" and "array" from task struct
exit.c -- remove call to sched_exit()
sched.c -- the bulk of the change

Performance:

- no discernible change in interactive responsiveness
- slight improvements in results from tests such as kernbench e.g.

Average Half Load -j 3 Run:
Elapsed Time 573.582 (vs 576.196)
User Time 1576.36 (vs 1582.19)
System Time 100.866 (vs 102.266)
Percent CPU 291.8 (vs 291.8)
Context Switches 9970.2 (vs 10653.6)
Sleeps 23996 (vs 23736.2)

Average Optimal -j 16 Load Run:
Elapsed Time 439.88 (vs 443.21)
User Time 1605.09 (vs 1613.75)
System Time 104.618 (vs 106.99)
Percent CPU 388 (vs 387.6)
Context Switches 29816.4 (vs 35444.6)
Sleeps 25589.8 (vs 27509.4)

Average Maximal -j Load Run:
Elapsed Time 460.252 (vs 460.72)
User Time 1628.57 (vs 1633.04)
System Time 147.666 (vs 147.222)
Percent CPU 385.4 (vs 386.2)
Context Switches 78475.6 (vs 78242.4)
Sleeps 126011 (vs 113026)

In summary, this patch provides code simplification without cost.
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

