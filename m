Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUDIIfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 04:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUDIIfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 04:35:53 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:11204 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261887AbUDIIfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 04:35:48 -0400
Date: Fri, 9 Apr 2004 10:34:04 +0200
From: Peter Seiderer <seiderer123@ciselant.de>
To: linux-kernel@vger.kernel.org
Subject: Question about PTRACE_DETACH
Message-ID: <20040409083404.GA1461@zodiak>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
shouldn't ptrace(PTRACE_DETACH, pid, NULL, SIGSTOP) stop the child?

The Valgrind [1] sequence call to stop a child, change the registers and
attach a debugger to the child is as following (or take a look at
[2] function start_debugger(), or the attached test program):

if ((pid = fork()) == 0) {
	ptrace(PTRACE_TRACEME, ...);
	kill(getpid(), SIGSTOP);
	// should never be reached
} else {
	waitpid(pid, ...);
	ptrace(PTRACE_SETREGS, ...)
	ptrace(PTRACE_DETACH, pid, NULL, SIGSTOP)
	// attach gdb to child
}

But the child seems to resume execution after the PTRACE_DETACH call (in
contradiction to what the ptrace man page [3] tells).

Example programm gdb_attach.c attached to the e-mail.

gcc -Wall -g -o g db_attach gdb_attach.c
./gdb_attach 
parent
child
parent: cmdl: gdb gdb_attach 1509
child: should never be reached
<gdb output snipped>
0x400d4411 in nanosleep () from /lib/libc.so.6
(gdb) bt
#0  0x400d4411 in nanosleep () from /lib/libc.so.6
#1  0x400d43a8 in sleep () from /lib/libc.so.6
#2  0x08048704 in start_debugger () at gdb_attach.c:20
#3  0x08048889 in main (argc=1, argv=0xbffff444) at gdb_attach.c:46
#4  0x400499ed in __libc_start_main () from /lib/libc.so.6

One 'workaround' is to send an additional SIGSTOP from the parent:
gcc -Wall -g -DADDITIONAL_SIGSTOP -o gdb_attach gdb_attach.c
 ./gdb_attach 
parent
child
parent: cmdl: gdb gdb_attach 1519
<gdb output>
0x4005aab1 in kill () from /lib/libc.so.6
(gdb) bt
#0  0x4005aab1 in kill () from /lib/libc.so.6
#1  0x080486ec in start_debugger () at gdb_attach.c:17
#2  0x080488c5 in main (argc=1, argv=0xbffff444) at gdb_attach.c:46
#3  0x400499ed in __libc_start_main () from /lib/libc.so.6
(gdb) 

It this a PTRACE_DETACH bug (kernel used 2.4.25)?
If not, is the additional SIGSTOP a valid 'workaround'?
If not, is there a better workaround/solution?

Thanks in advance for your help,
Peter Seiderer


[1] http://valgrind.kde.org/

[2] http://webcvs.kde.org/cgi-bin/cvsweb.cgi/~checkout~/valgrind/coregrind/vg_main.c?rev=1.147&content-type=text/plain

[3] http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi?coll=linux&db=man&fname=/usr/share/catman/man2/ptrace.2.html
	PTRACE_DETACH: ... Restarts  the stopped child as for PTRACE_CONT ...
	PTRACE_CONT: ... Restarts  the  stopped  child  process.  If data is
	non-zero and not SIGSTOP, it is  interpreted  as  a signal  to be
	delivered to the child ...

-- 
------------------------------------------------------------------------
Peter Seiderer                     E-Mail:  seiderer123@ciselant.de

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gdb_attach.c"

#include <stdio.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

void start_debugger() {
  int pid;
  if ((pid = fork()) == 0) {
    printf("child\n");
    ptrace(PTRACE_TRACEME, 0, NULL, NULL);
    kill(getpid(), SIGSTOP);
    while(1){
      printf("child: should never be reached\n");
      sleep(1);
    }
  } else if (pid > 0) {
    int status;
    printf("parent\n");
    assert(waitpid(pid, &status, 0) == pid);
    assert(WIFSTOPPED(status));
    assert(WSTOPSIG(status) == SIGSTOP);
    
#ifdef ADDITIONAL_SIGSTOP
    // send additional SIGSTOP to work around possible PTRACE_DETACH bug
    assert(kill(pid, SIGSTOP) == 0);
#endif
    assert(ptrace(PTRACE_DETACH, pid, NULL, SIGSTOP) == 0);
    
    char buf[1024];
    snprintf(buf, 1024, "gdb gdb_attach %d", pid);
    printf("parent: cmdl: %s\n", buf);
    system(buf);
  } else {
    printf("parent: fork failed\n");
  }
}


int main(int argc, char *argv[]) {
  start_debugger();
  return 0;
}

--HlL+5n6rz5pIUxbD--
