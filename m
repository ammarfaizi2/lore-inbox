Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVI0RV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVI0RV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVI0RV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:21:58 -0400
Received: from mother.openwall.net ([195.42.179.200]:49611 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S965018AbVI0RV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:21:58 -0400
Date: Tue, 27 Sep 2005 21:20:48 +0400
From: Solar Designer <solar@openwall.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, security@linux.kernel.org
Subject: PID reuse safety for userspace apps (Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio)
Message-ID: <20050927172048.GA3423@openwall.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927165206.GB20466@master.mivlgu.local>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I am changing the topic somewhat, so I've trimmed the CC list and
adjusted the Subject. ]

On Tue, Sep 27, 2005 at 08:52:06PM +0400, Sergey Vlasov wrote:
> (Why they did not make a kind of "file descriptor" for processes...)

Actually, I made a proposal back in 1999 which I think would let many
userspace apps deal with PID reuse nicely.

The idea is to introduce a kernel call (it can be a prctl(2) setting,
although my pseudo-code "defines" an entire syscall for simplicity)
which would "lock" the invoking process' view of a given PID (while
letting the PID get reused - so there's no added risk of DoS).  The
original posting and subsequent thread can be seen here:

http://lists.nas.nasa.gov/archives/ext/linux-security-audit/1999/08/msg00108.html

The proposal itself (unedited since 1999, but the idea holds) is as
follows:

in task_struct:
	int locked_pid;

int sys_lockpid(int pid)
{
	int old;

	old = current->locked_pid;
	current->locked_pid = pid;

	return old;
}

on kill(2) and ptrace(2):
	if (pid > 0 && -pid == current->locked_pid)
		return -ESRCH;

on execve(2):
	current->locked_pid = 0;

on fork(2), in get_pid(), where last_pid is the PID being allocated:
	for_each_task (p)
		if (p->locked_pid == last_pid) p->locked_pid = -lastpid;

in applications, such as killall(1):
	do {
		lockpid(target);
		if (!need_to_kill(target)) break;
		if (kill(target, SIGKILL) == 0) break;
	} while (errno == ESRCH);
	lockpid(0);

Performance can be improved by maintaining a global locked_pid_count,
so that fork(2) could skip the loop if count is zero.  Implementing
this would require an extra spinlock (the pseudo-code above will need
some anyway, if actually implemented).

It is possible to clear locked_pid in kill(2) and ptrace(2), but I'm
not sure whether that's a good idea, as we could have these syscalls
in signal handlers that are not aware of the new feature.

-- 
Alexander
