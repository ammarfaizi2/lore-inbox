Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbRGQEW2>; Tue, 17 Jul 2001 00:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbRGQEWS>; Tue, 17 Jul 2001 00:22:18 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:17058 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S267761AbRGQEWG>; Tue, 17 Jul 2001 00:22:06 -0400
Date: Tue, 17 Jul 2001 13:21:43 +0900
Message-ID: <k818gp7s.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.4.6] PPID of a process is set to itself
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 (Art is long, life is
 short) SLIM/1.14.7 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE
 XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When I am playing with clone system call, I found the case the cloned process
becomes the zombie which is not reaped because the PPID of the process is
set to itself. The test program are following.



#include <sched.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int	stack[2048];

int
func(void *p)
{
	exit(0);
}

int
main(int argc, char *argv[])
{
	clone(func, &stack[2048],
		CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD,
		NULL);

	sleep(1);
	exit(0);
}

Following patch fixes the bug, but I don't know this is correct. Can
someone please explain me why in forget_original_parent(), the parent of
processes in a thread group is set to another process in the thread
group?

diff -u -r linux.org/kernel/exit.c linux/kernel/exit.c
--- linux.org/kernel/exit.c	Sat May  5 06:44:06 2001
+++ linux/kernel/exit.c	Tue Jul 17 11:06:59 2001
@@ -168,7 +168,7 @@
 			/* We dont want people slaying init */
 			p->exit_signal = SIGCHLD;
 			p->self_exec_id++;
-			p->p_opptr = reaper;
+			p->p_opptr = p == reaper ? child_reaper : reaper;
 			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
 		}
 	}
