Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSDELMj>; Fri, 5 Apr 2002 06:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311594AbSDELMa>; Fri, 5 Apr 2002 06:12:30 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:40849 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S310214AbSDELMN>; Fri, 5 Apr 2002 06:12:13 -0500
Date: Fri, 5 Apr 2002 13:12:02 +0200 (MEST)
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: O(1) scheduler: lockup with set_cpus_allowed
Message-ID: <Pine.LNX.4.21.0204051202230.10372-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is a potential lockup problem with the current
set_cpus_allowed() mechanism. As the comment right before the function
suggests, one should make sure that the task referenced is valid and that
it doesn't exit prematurely. Therefore in a pseudo-device driver used for
changing the cpus_allowed masks of processes I do:

	read_lock(&tasklist_lock);
	task = find_task_by_pid(pid);
	if (task)
		set_cpus_allowed(task, new_mask);
	read_unlock(&tasklist_lock);

This is accessed by a user-space program, for example:
% oncpu -c 0 $$
pins the shell to logical CPU #0.

The lockup with the new task migration mechanism can be observed if one
does:

	for cpu in 1 3 5 ; do
		oncpu -c $cpu $$
		run_job.sh > out.$cpu &
	done

For cpu=1 everything goes well, the shell is pinned to CPU#1, forks
run_job.sh (which itself forks another process) which is pinned to CPU#1,
too (cpus_allowed is inherited by children).

For cpu=3 the shell forks, execs "oncpu -c 3 $$" (which is pinned to
CPU#1), this one calls the device driver which gets a read_lock of
tasklist_lock. Then set_cpus_allowed() wakes up migration_CPU1 which
migrates the shell to CPU#3. When migration_CPU1 finishes, it reactivates
the "oncpu" process (which was running on CPU#1) but the currently running
process is "run_job.sh" on CPU#1. This one forks and spinlocks on
tasklist_lock, which it will never get because "oncpu" never gets the
chance to read_unlock(&tasklist_lock).

So the problem is that it is not guaranteed that the task calling
set_cpus_allowed() will run right after migration_task() finished its
job.

How about raising the priority in set_cpus_allowed() before the
	down(&req.sem);
and resetting it afterwards? Would this help?

Another possible solution would be to take care of the validity of the
task inside set_cpus_allowed(), i.e. pass it a pid as argument, lock the
tasklist there and unlock it in migration_task().

Any ideas, comments?

Best regards,
Erich



