Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264994AbSJPOT5>; Wed, 16 Oct 2002 10:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264995AbSJPOT5>; Wed, 16 Oct 2002 10:19:57 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:39951 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S264994AbSJPOTz>;
	Wed, 16 Oct 2002 10:19:55 -0400
Message-ID: <3DAD786A.E238B234@tv-sign.ru>
Date: Wed, 16 Oct 2002 18:32:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: [BUG] [3d RESEND] de_thread()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Thu, 10 Oct 2002, Oleg Nesterov wrote:
> 
> Suppose process P in thread group was cloned _without_
> CLONE_DETACHED flag. Then another thread, group_leader
> for simplicity, does exec and calls de_thread(). It kills
> P via _broadcast_thread_group(). While doing do_exit(),
> P skips release_task(), because its exit_signal != -1,
> and becomes TASK_ZOMBIE.
>
> Then leader calls schedule() with TASK_UNINTERRUPTIBLE
> in while(oldsig->count > 1) {...} and sleeps forever,
> because nobody can do wake_up_process(sig->group_exit_task).
>

This program should hang leaving task in D state.

#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <asm/unistd.h>

#define CLONE_SIGHAND	0x00000800
#define CLONE_THREAD	0x00010000

#define	__NR_sys_clone	__NR_clone

static inline _syscall2(int,sys_clone, int,flag, void*,stack)

int main(void)
{
	static char stack[1024];
	int pid = sys_clone(CLONE_THREAD | CLONE_SIGHAND | SIGCHLD, stack);

	if (pid < 0) {
		printf("ERR!! clone: %s.\n", strerror(errno));
		return -1;
	}

	if (pid == 0) _exit(0);

	execlp("echo", "echo", "Should not happen.", 0);
	printf("ERR!! exec: %s.\n", strerror(errno));

	return 0;
}

Oleg.
