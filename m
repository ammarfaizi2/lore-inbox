Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTL3Dd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 22:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTL3Dd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 22:33:26 -0500
Received: from fmr05.intel.com ([134.134.136.6]:18308 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264361AbTL3DdV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 22:33:21 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: waipid() block in multi-thread program
Date: Tue, 30 Dec 2003 11:33:18 +0800
Message-ID: <A12F5F3545A0654B97BFD863950C1E1802F8FB59@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: waipid() block in multi-thread program
Thread-Index: AcPOhamaLHlTB33ESpyDtTE6fUMAbg==
From: "Li, Adam" <adam.li@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Li, Adam" <adam.li@intel.com>
X-OriginalArrivalTime: 30 Dec 2003 03:33:18.0773 (UTC) FILETIME=[AAC84650:01C3CE85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I wrote a small test case using waitpid() in multi-thread program, and find it will cause program block sometime.
The program will create a (child) thread. The thread tries to exec a executable (simple busy-loop in my case).
After a while the main thread will kill the executable. 
Then both the main thread and the child thread call waitpid() to wait for the executable.

Test platform:
----------------------
cpu: 2-Way Pentium III 933MHz, memory: 512MB
kernel: 2.6.0-SMP
glibc: libc_12_04_03 with NPTL enabled

Test case:
-----------------------
waitpid_test.c , busy_loop.c (please see bellow)
Since the block will not happen all the time, I have a small script to run it in a loop:
And I think the block can be reproduced more easily on a SMP system. 

(script to run the test in a loop)
#!/bin/sh
for((i=0; i< 10000; i++))
do
echo $i
./waitpid_test ./busy_loop
done

In one of the run:
.........
10
busy_loop started
main: kill child_proc
child thread: return from waitpid()
main: waitpid(): No child processes
11
busy_loop started
main: kill child_proc
main: return from waitpid()
(block here)

Some trace down:
-------------------------
1) I ran this test using Linuxthread (libc_120403), and find there is _no_ block. 
I think that is because the kernel support for thread is not used.

2) Strace -f show that (part):
...................
[pid  4818] clone(child_stack=0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_IDLETASK|CLONE_PTRACE|CLONE_VFORK|CLONE_PARENT|CLONE_THREAD|CLONE_NEWNS|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED|CLONE_UNTRACED|CLONE_CHILD_SETTID|0xbe0000d4, 0, 0, 0x40987bf8) = 4819
[pid  4818] waitpid(4819,  <unfinished ...>
[pid  4819] execve("./busy_loop", ["./busy_loop"], [/* 26 vars */]) = 0
.........
[pid  4819] write(2, "busy_loop started\n", 18busy_loop started
) = 18
[pid  4817] <... nanosleep resumed> {1, 0}) = 0
[pid  4817] write(2, "main: kill child_proc\n", 22main: kill child_proc
) = 22
[pid  4817] kill(4819, SIGKILL)         = 0
[pid  4817] waitpid(4819,  <unfinished ...>
[pid  4819] +++ killed by SIGKILL +++
PANIC: handle_group_exit: 4819 leader 4817
[pid  4817] <... waitpid resumed> NULL, 0) = -1 ECHILD (No child processes)
[pid  4817] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid  4817] write(2, "main: waitpid(): No child proces"..., 36main: waitpid(): No child processes
) = 36
[pid  4817] futex(0x40987bf8, FUTEX_WAIT, 4818, NULL <unfinished ...> 

We can see that the child thread(pid 4818) blocks at waitpid(4819..),  while main thread (pid 4817) got SIGCHLD and
return from waitpid().
(The behavior of using strace will be different, since (pid 4817) returns from waitpid() with ECHILD. And what is that 'PANIC'?)

3) I think the cause may be the handling of SIGCHLD. The child thread will has no chance to got SIGCHLD while it keeps waiting for it.
And there might be some race condition there, which makes child thread cannot return from waitpid() with ECHILD. 

-------------------
I am not sure this block should be regarded as a bug or my mis-use. (I know I should not call waitpid() two times, but I would expect an ECHILD
if a waitpid() fails because the child process has been waited). Hoping for your comments :). 

waitpid_test.c
-----------------------------
/**
 * Test case to reproduce a waitpid block.
 */
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

static volatile pid_t child_proc = 0;

void * th_fn(void *arg)
{
        char *exec_file = arg;
        int rc;

        if ((child_proc = fork()) == 0) {
                execl(exec_file, exec_file, NULL);
                perror("execl()");
        }
        rc = waitpid(child_proc, NULL, 0);
        if (rc == -1)
                perror("child thread: waitpid()");
        else
                fprintf(stderr, "child thread: return from waitpid()\n");
        return (void *)0;
}

int main(int argc, char *argv[])
{
        pthread_t child_th;
        int rc;
        if (argc < 2) {
                fprintf(stderr, "waitpid_test exec_file\n");
                return -1;
        }

        pthread_create(&child_th, NULL, th_fn, argv[1]);
        while (!child_proc) {
                sleep(1);
                //sched_yield();
        }
        fprintf(stderr, "main: kill child_proc\n");
        kill(child_proc, SIGKILL);
        rc = waitpid(child_proc, NULL, 0);
        if (rc == -1)
                perror("main: waitpid()");
        else
                fprintf(stderr, "main: return from waitpid()\n");
        pthread_join(child_th, NULL);
        return 0;
}

busy_loop.c
-----------------
#include <stdio.h>
int main()
{
        fprintf(stderr, "busy_loop started\n");
        while(1);
        fprintf(stderr, "busy_loop out\n");
        return 0;
}

Regards,

====================================================================
Information above represents only my personal view, not corporate.  
adam.li@intel.com
