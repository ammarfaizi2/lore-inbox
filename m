Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWBNDJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWBNDJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWBNDJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:09:18 -0500
Received: from fmr21.intel.com ([143.183.121.13]:13442 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750967AbWBNDJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:09:17 -0500
Message-Id: <200602140309.k1E394g17590@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "'Ingo Molnar'" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Mon, 13 Feb 2006 19:09:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxFAK2pbwTbFOMQ5WU5455NIBdvQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d7102e95b7b9c00277562c29aad421d2d521c5f6 in linus's git tree

[PATCH] sched: filter affine wakeups
From: Nick Piggin <nickpiggin@yahoo.com.au>
Track the last waker CPU, and only consider wakeup-balancing if there's a
match between current waker CPU and the previous waker CPU.  This ensures
that there is some correlation between two subsequent wakeup events before
we move the task.  Should help random-wakeup workloads on large SMP
systems, by reducing the migration attempts by a factor of nr_cpus.


Apparently caused more than 10% performance regression for aim7 benchmark.
The setup in use is 16-cpu HP rx8620, 64Gb of memory and 12 MSA1000s with
144 disks. Each disk is 72Gb with a single ext3 filesystem (courtesy of
HP, who supplied benchmark results).

The problem is, for aim7, the wake-up pattern is random, but it still needs
load balancing action in the wake-up path to achieve best performance. With
the above commit, lack of load balancing hurts that workload.

However, for workloads like database transaction processing, the requirement
is exactly opposite.  In the wake up path, best performance is achieved with
absolutely zero load balancing.   We simply wake up the process on the CPU
that it was previously run.  Worst performance is obtained when we do load
balancing at wake up.

There isn't an easy way to auto detect the workload characteristics.  Ingo's 
earlier patch that detects idle CPU and decide whether to load balance or not 
doesn't perform with aim7 either since all CPUs are busy (it causes even
bigger perf. regression).

We should back out the above commit and add a sysctl variable to control the
behavior of load balancing in wake up path, so user can dynamically select
a mode that best fit for the workload environment.  And kernel can achieve
best performance in two extreme ends of incompatible workload environments.

Two patches to follow.

- Ken

