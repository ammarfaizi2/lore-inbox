Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130658AbQKDFz7>; Sat, 4 Nov 2000 00:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131537AbQKDFzu>; Sat, 4 Nov 2000 00:55:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45981 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S130658AbQKDFzj>; Sat, 4 Nov 2000 00:55:39 -0500
From: kumon@flab.fujitsu.co.jp
Date: Sat, 4 Nov 2000 14:55:30 +0900
Message-Id: <200011040555.OAA02581@asami.proc.flab.fujitsu.co.jp>
To: linux-kernel@vger.kernel.org
cc: andrewm@uow.edu.au, dean-list-linux-kernel@arctic.org
Cc: viro@math.psu.edu
Subject: Preemptive scheduling of woken-up processes
In-Reply-To: <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current schduler has a problem handling waken up processes.

In the current kernel woken up processes probably try to preempt CPU
from the currently running process.

That is the fundamental reason of the negative scalability of Apache
on a large SMP system, which has been reported already.
The modification of scheduler is introduced  between test8 and test9.
So, test9 owes two problems for the Apache performance.
One for flock, another for scheduler.


Detailed Description:

When a process releases the semaphore, it wakes up the slept process
through wake_up_process(). Then, schedule_idle() has the final duty.

In the current scheduler logic, the woken up process may preempt CPU
from the current process if the goodness tells to do so.  This is done
even if there are lots of idle CPUs. This severy disables parallel
execution on a MP system.  The previously runnning process is runnable
but wating on run queue until the next scheduling timing, which
possibly is few milliseconds later.

# We've not yet proved above senario by experimentation. We'll do in
# next week if it is needed. 

I think this scheduling policy is bad for MP systems.
Basically, the waken up process should run on the previous CPU ,
or, should run on an idle CPU.
This policy has been adopted in test8, and that is better, I think.

# Sorry to whom get this mail twice. I mistook LK-ML address.


--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
