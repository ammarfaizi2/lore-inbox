Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSBQO4q>; Sun, 17 Feb 2002 09:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293133AbSBQO4g>; Sun, 17 Feb 2002 09:56:36 -0500
Received: from 217-126-141-228.uc.nombres.ttd.es ([217.126.141.228]:55820 "HELO
	smtp.cespedes.org") by vger.kernel.org with SMTP id <S293129AbSBQO4W>;
	Sun, 17 Feb 2002 09:56:22 -0500
Date: Sun, 17 Feb 2002 15:56:15 +0100
From: Juan Cespedes <cespedes@debian.org>
To: linux-kernel@vger.kernel.org
Subject: ptrace() bug
Message-ID: <20020217145615.GB2064@thehackers.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am the author of "ltrace" and unfortunatelly it does not work in 2.4
kernels, due to a bug in the kernel.  Unfortunately, I don't know when
did this behaviour started and what could have caused it...

Summary: if I use ptrace() witth a process that does fork(), and after
the fork I modify with PTRACE_POKETEXT some of the code in the parent,
the same modification is observed in the child.

I need to modify the .text in order to introduce breakpoints, but with
this bug ltrace does not work with any process which forks.

The attached little program shows the bug: the child should not see the
content of "sync" modified after it is alive.

Thanks for your help,

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Juan Cespedes     /       \       /       \      cespedes@debian.org
.+'         `+...+'         `+...+'         `+...+'         `+...+'

--dDRMvlgZJXvWKvBx
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <signal.h>

void
traced_process(void) {
	if (ptrace(PTRACE_TRACEME, 0, 0, 0) < 0)
		exit(1);
	kill(getpid(), SIGCONT);
	if (fork()) {
		sleep(2);
/*		printf("parent: *sync=%d\n", *(unsigned char*)sync); */
	} else {
		printf("child is alive (*sync=%d)\n", *(unsigned char*)sync);
		sleep(1);
		printf("child: *sync=%d\n", *(unsigned char*)sync);
	}
	exit(0);
}

int
main(void) {
	pid_t pid;
	int status;
	int i=0;

	pid = fork();
	if (!pid) traced_process();

	while(1) {
		if (wait(&status)==-1) {
			break;
		}
		printf("ptrace(PTRACE_POKETEXT, %d, sync, %d)...\n", pid, ++i);
		ptrace(PTRACE_POKETEXT, pid, sync, i);
		ptrace(PTRACE_SYSCALL, pid, 0, 0);
	}
	exit(0);
}

--dDRMvlgZJXvWKvBx--
