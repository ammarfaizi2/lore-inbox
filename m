Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289657AbSAXBm6>; Wed, 23 Jan 2002 20:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290230AbSAXBmt>; Wed, 23 Jan 2002 20:42:49 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:11021 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S289657AbSAXBmg>; Wed, 23 Jan 2002 20:42:36 -0500
To: vic <zandy@cs.wisc.edu>
Cc: Mike Coleman <mkc@mathdogs.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
	<878zawvl1v.fsf@devron.myhome.or.jp>
	<m3sn8xkkyn.fsf@localhost.localdomain>
	<87r8ogr9za.fsf@devron.myhome.or.jp>
	<m33d0wlmzj.fsf@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 24 Jan 2002 10:41:51 +0900
In-Reply-To: <m33d0wlmzj.fsf@localhost.localdomain>
Message-ID: <87it9splsw.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vic <zandy@cs.wisc.edu> writes:

> > PTRACE_SYSCALL, PTRACE_CONT, and PTRACE_SINGLESTEP can't send a signal
> > by the same reason. Please read the do_signal().
> 
> I've read that function, but I don't see why it would not get along
> with my suggestion to send SIGKILL rather than set exit_code to
> implement PTRACE_KILL.
> 
> No doubt I can be rather thick; in this case, induction doesn't help me.

kill(pid, SIGKILL) != ptrace(PTRACE_KILL, pid, NULL, NULL).

Whether the same effect as kill() is required for PTRACE_KILL is the
problem which is unrelated to this problem. If so, please argue on
another thread.


And If PTRACE_SYSCALL, PTRACE_CONT, and PTRACE_SINGLESTEP can send the
signal, PTRACE_KILL also work.

BTW, did you read my first email? What do you think of my suggestion?

In an example,

ptrace_attach(),

	if (task->p_pptr != current) {
		REMOVE_LINKS(task);
		task->p_pptr = current;
		SET_LINKS(task);
	}
	write_unlock_irq(&tasklist_lock);

	stopped = (task->state == TASK_STOPPED);
	send_sig(SIGSTOP, task, 1);
	if (stopped)
		wake_up_process(task);

	return 0;

Note, this code isn't investigating at all. 
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
