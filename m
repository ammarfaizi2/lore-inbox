Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTGAOrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTGAOrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:47:14 -0400
Received: from smtp06.ya.com ([62.151.11.136]:45480 "EHLO smtp06.ya.com")
	by vger.kernel.org with ESMTP id S262367AbTGAOrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:47:02 -0400
Date: Tue, 1 Jul 2003 17:03:33 +0200
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: kenneth.w.chen@intel.com
Subject: Re:ipc semaphore optimization
Message-Id: <20030701170333.3b5d1f59.ktech@wanadoo.es>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is any of you taking care of this, posted to the lkml days ago? It seems a good improvement. Is it being incorporated / tested in any of the trees? Andrew?

Con, perhaps you can measure it in the next Contest? Perhaps it can help improve both interactiveness and throughput. I think it cannot be bad. Testing it with 01int and granularity.

Thanks for taking a look a it.

Luis Miguel Garcia



>This patch proposes a performance fix for the current IPC semaphore
implementation.

There are two shortcoming in the current implementation:
try_atomic_semop() was called two times to wake up a blocked process,
once from the update_queue() (executed from the process that wakes up
the sleeping process) and once in the retry part of the blocked process
(executed from the block process that gets woken up).

A second issue is that when several sleeping processes that are eligible
for wake up, they woke up in daisy chain formation and each one in turn
to wake up next process in line.  However, every time when a process
wakes up, it start scans the wait queue from the beginning, not from
where it was last scanned.  This causes large number of unnecessary
scanning of the wait queue under a situation of deep wait queue.
Blocked processes come and go, but chances are there are still quite a
few blocked processes sit at the beginning of that queue.

What we are proposing here is to merge the portion of the code in the
bottom part of sys_semtimedop() (code that gets executed when a sleeping
process gets woken up) into update_queue() function.  The benefit is two
folds: (1) is to reduce redundant calls to try_atomic_semop() and (2) to
increase efficiency of finding eligible processes to wake up and higher
concurrency for multiple wake-ups.

We have measured that this patch improves throughput for a large
application significantly on a industry standard benchmark.

This patch is relative to 2.5.72.  Any feedback is very much
appreciated.

Some kernel profile data attached:

Kernel profile before optimization:
-----------------------------------------------
                0.05    0.14   40805/529060      sys_semop [133]
                0.55    1.73  488255/529060      ia64_ret_from_syscall
[2]
[52]     2.5    0.59    1.88  529060         sys_semtimedop [52]
                0.05    0.83  477766/817966      schedule_timeout [62]
                0.34    0.46  529064/989340      update_queue [61]
                0.14    0.00 1006740/6473086     try_atomic_semop [75]
                0.06    0.00  529060/989336      ipcperms [149]
-----------------------------------------------

                0.30    0.40  460276/989340      semctl_main [68]
                0.34    0.46  529064/989340      sys_semtimedop [52]
[61]     1.5    0.64    0.87  989340         update_queue [61]
                0.75    0.00 5466346/6473086     try_atomic_semop [75]
                0.01    0.11  477676/576698      wake_up_process [146]
-----------------------------------------------
                0.14    0.00 1006740/6473086     sys_semtimedop [52]
                0.75    0.00 5466346/6473086     update_queue [61]
[75]     0.9    0.89    0.00 6473086         try_atomic_semop [75]
-----------------------------------------------


Kernel profile with optimization:

-----------------------------------------------
                0.03    0.05   26139/503178      sys_semop [155]
                0.46    0.92  477039/503178      ia64_ret_from_syscall
[2]
[61]     1.2    0.48    0.97  503178         sys_semtimedop [61]
                0.04    0.79  470724/784394      schedule_timeout [62]
                0.05    0.00  503178/3301773     try_atomic_semop [109]
                0.05    0.00  503178/930934      ipcperms [149]
                0.00    0.03   32454/460210      update_queue [99]
-----------------------------------------------
                0.00    0.03   32454/460210      sys_semtimedop [61]
                0.06    0.36  427756/460210      semctl_main [75]
[99]     0.4    0.06    0.39  460210         update_queue [99]
                0.30    0.00 2798595/3301773     try_atomic_semop [109]
                0.00    0.09  470630/614097      wake_up_process [146]
-----------------------------------------------
                0.05    0.00  503178/3301773     sys_semtimedop [61]
                0.30    0.00 2798595/3301773     update_queue [99]
[109]    0.3    0.35    0.00 3301773         try_atomic_semop [109]
----------------------------------------------- 

Both number of function calls to try_atomic_semop() and update_queue()
are reduced by 50% as a result of the merge.  Execution time of
sys_semtimedop is reduced because of the reduction in the low level
functions.

unhandled content-type:application/octet-stream (sem25.patch)

-- 
=============================================================
Luis Miguel Garcia Mancebo
Ingenieria Tecnica en Informatica de Gestion
Universidad de Deusto / University of Deusto
Bilbao / Spain
=============================================================
