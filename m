Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271606AbTHHPsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271685AbTHHPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:48:42 -0400
Received: from tux.appstate.edu ([152.10.143.20]:60035 "EHLO tux.appstate.edu")
	by vger.kernel.org with ESMTP id S271606AbTHHPsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:48:40 -0400
Message-ID: <3227.152.14.51.180.1060357468.squirrel@tux.appstate.edu>
Date: Fri, 8 Aug 2003 11:44:28 -0400 (EDT)
Subject: How to schedule idle_task?
From: "Feng Pan" <fp38660@tux.appstate.edu>
To: linux-kernel@vger.kernel.org
Reply-To: fp38660@tux.appstate.edu
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to force idle_task in schedule() but could not get it to work.
Here is my requirement: I would like the scheduler to prevent any task
with low priority (meaning lower than a cutoff point) from being scheduled
to run, even if there are no high priority tasks running (when this
happens, idle_task should be scheduled to run). They (the low priority
tasks) have to wait until their dynamic priorities boosted to be able to
run.

So here is what I added to schedule():

/*
 * Default process to select..
 */
next = idle_task(this_cpu);
c = -1000;
list_for_each(tmp, &runqueue_head) {
        p = list_entry(tmp, struct task_struct, run_list);
        if (can_schedule(p, this_cpu)) {
                int weight = goodness(p, this_cpu, prev->active_mm);
                if (weight > c)
                        c = weight, next = p;
        }
}


// This is what I added:

        if((c > 2) && (c < CUTOFF_PRIORITY)) {
                //printk("LOW PRIORITY PROCESS (%d)\n", c);
                next = idle_task(this_cpu);
        }


// End

/* Do we need to re-calculate counters? */
if (unlikely(!c))
...
...
...


The problem is that once the idle_task is forced to run, no other tasks
can be scheduled again, and the system hangs, even if there is another
high priority task running. And if I uncomment the printk statement, the
message is printed repeatly.

So the question is, how do I do this properly so that high priority tasks
can still run?

btw, the kernel version is 2.4.21

Thanks

Feng


