Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291794AbSBAPKm>; Fri, 1 Feb 2002 10:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291792AbSBAPKc>; Fri, 1 Feb 2002 10:10:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22707 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291791AbSBAPKX>;
	Fri, 1 Feb 2002 10:10:23 -0500
Date: Fri, 1 Feb 2002 18:08:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O(1) J9 scheduler: set_cpus_allowed
In-Reply-To: <Pine.LNX.4.21.0202011435500.6004-100000@sx6.ess.nec.de>
Message-ID: <Pine.LNX.4.33.0202011803350.11284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Feb 2002, Erich Focht wrote:

> the function set_cpus_allowed(task_t *p, unsigned long new_mask) works
> "as is" only if called for the task p=current. The appended patch
> corrects this and enables e.g. external load balancers to change the
> cpus_allowed mask of an arbitrary process.

your patch does not solve the problem, the situation is more complex. What
happens if the target task is not 'current' and is running on some other
CPU? If we send the migration interrupt then nothing guarantees that the
task will reschedule anytime soon, so the target CPU will keep spinning
indefinitely. There are other problems too, like crossing calls to
set_cpus_allowed(), etc. Right now set_cpus_allowed() can only be used for
the current task, and must be used by kernel code that knows what it does.

i've put a BUG() into set_cpus_allowed() that prevents 'wrong' usage.

> BTW: how about migrating the definition of the structures runqueue and
> prio_array into include/linux/sched.h and exporting the symbol
> runqueues? It would help with debugging, monitoring and other
> developments.

for debugging you can export it temporarily. Otherwise i consider it a
feature that no scheduler internals are visible externally in any way.

	Ingo

