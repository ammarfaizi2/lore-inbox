Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSFOA6H>; Fri, 14 Jun 2002 20:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSFOA6G>; Fri, 14 Jun 2002 20:58:06 -0400
Received: from jalon.able.es ([212.97.163.2]:58089 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314748AbSFOA6F>;
	Fri, 14 Jun 2002 20:58:05 -0400
Date: Sat, 15 Jun 2002 02:58:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Lista Mdk-Cooker <cooker@linux-mandrake.com>,
        Lista Mdk-Expert <expert@linux-mandrake.com>
Cc: Lista Linux-BProc <bproc-users@lists.sourceforge.net>,
        Lista Linux-Cluster <linux-cluster@nl.linux.org>
Subject: Problems with clone and gcc
Message-ID: <20020615005801.GA1695@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I write this here to see if you can give me some clue on a strange behaviour
with the clone system call. Really I want a hint about if it is a kernel
issue, a glibc(pthreads) one or a gcc issue. If sometimes it works looks
like not a kernel issue, but who knows...

Abstract: compiling a program with 'gcc -pthread' or just linking with
-lpthread (even if I just do not call any pthread_xxx), makes the
'clone()' call (glibc) fail. It does not jump to the given function.
Checked on both:
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)
gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)

Sample test:

#include <sched.h>
#include <signal.h>
#include <stdio.h>

#define STSZ (4*1024)

int pslave(void *data);

int main(int argc,char** argv)
{
	int		tid;
	char*	stack;

	stack = (char*)valloc(STSZ);
	puts("about to clone...");
	tid = clone(pslave,stack+STSZ-1,CLONE_VM|SIGCHLD,0);
	if (tid<0)
	{
		perror("clone");
		exit(1);
	}
	puts("clone ok");

	wait(0);

	free(stack);

	return 0;
}

int pslave(void *data)
{
	puts("slave running");
	sleep(1);
	puts("slave done");

	return 0;
}


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)
