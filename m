Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSAQTZn>; Thu, 17 Jan 2002 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSAQTZ1>; Thu, 17 Jan 2002 14:25:27 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:42248 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S290184AbSAQTZM>; Thu, 17 Jan 2002 14:25:12 -0500
To: vic <zandy@cs.wisc.edu>
Cc: Mike Coleman <mkc@mathdogs.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 18 Jan 2002 04:23:24 +0900
In-Reply-To: <m3advcq5jv.fsf@localhost.localdomain>
Message-ID: <878zawvl1v.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vic <zandy@cs.wisc.edu> writes:

> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
> >> --- linux-2.4.16/kernel/ptrace.c	Wed Nov 21 16:43:01 2001
> >> +++ linux-2.4.16.1/kernel/ptrace.c	Fri Dec 21 10:42:44 2001
> >> @@ -89,8 +89,10 @@
> >>  		SET_LINKS(task);
> >>  	}
> >>  	write_unlock_irq(&tasklist_lock);
> >> -
> >> -	send_sig(SIGSTOP, task, 1);
> >> +	if (task->state != TASK_STOPPED)
> >> +		send_sig(SIGSTOP, task, 1);
> >> +	else
> >> +		task->exit_code = SIGSTOP;
> >>  	return 0;
> >>  
> >>  bad:
> >
> > It seems that trace is started in the place different from
> > usual. Then, I think PTRACE_KILL doesn't work.
> 
> I don't agree, it seems to work for me.

I tested the following on linux-2.4.16 + your_patch:

#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	pid_t pid;
	int ret, status;

	pid = fork();
	if (pid == -1)
		exit(1);
	if (pid == 0) {
		raise(SIGSTOP);
		while (1)
			;
		_exit(1);
	}

	ret = waitpid(pid, &status, WUNTRACED);
	if (ret == -1) {
		perror("waitpid (1)");
		exit(1);
	}

	ret = ptrace(PTRACE_ATTACH, pid, NULL, NULL);
	if (ret == -1) {
		perror("PTRACE_ATTACH");
		exit(1);
	}
	ret = waitpid(pid, &status, 0);
	if (ret == -1) {
		perror("waitpid (2)");
		exit(1);
	}
	ret = ptrace(PTRACE_KILL, pid, NULL, NULL);
	if (ret == -1) {
		perror("PTRACE_KILL");
		exit(1);
	}

	return 0;
}

Test result:

    hirofumi@devron (ptrace)[1111]$ ps ax|grep ptrace
      688 tty1     S      0:00 grep ptrace
    hirofumi@devron (ptrace)[1112]$ ls
    ptrace  ptrace.c
    hirofumi@devron (ptrace)[1113]$ ./ptrace
    hirofumi@devron (ptrace)[1114]$ ps ax|grep ptrace
      691 tty1     R      0:04 ./ptrace
      693 tty1     S      0:00 grep ptrace
    hirofumi@devron (ptrace)[1115]$

Do I misunderstand something?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
