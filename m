Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVBDKLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVBDKLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbVBDKLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:11:51 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56080 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262363AbVBDKKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:10:51 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: strace/signal interaction differ in 2.4 versus 2.6
Date: Fri, 4 Feb 2005 12:04:53 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041204.53077.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found out that I can't strace automount under 2.6.11-rc3:

# strace -p 1002
--- SIGSTOP (Stopped (signal)) ---
--- SIGSTOP (Stopped (signal)) ---
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
--- SIGALRM (Alarm clock) ---

and strace bails out. On 2.4.27-rc3 it doesn't happen:

# strace -p 6435
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
--- SIGALRM (Alarm clock) ---
write(6, "\2\0\0\0", 4)                 = 4
sigreturn()                             = ? (mask now [])
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN, revents=POLLIN}], 2, -1) = 1
read(5, "\2\0\0\0", 4)                  = 4
rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM CHLD], 8) = 0
fork()                                  = 23122
rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM], NULL, 8) = 0
--- SIGCHLD (Child exited) ---
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG, NULL) = 23122
alarm(4)                                = 0
wait4(-1, 0xbffff8fc, WNOHANG, NULL)    = -1 ECHILD (No child processes)
write(6, "\1\0\0\0", 4)                 = 4
sigreturn()                             = ? (mask now [HUP USR1 USR2 ALRM TERM])
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN, revents=POLLIN}], 2, -1) = 1
read(5, "\1\0\0\0", 4)                  = 4
rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM], 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [HUP USR1 USR2 ALRM TERM CHLD], NULL, 8) = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
...

I have a stripped-down testcase from automount (code below sig)
and ran it under both kernels. There are several differences
but the one which bites me most is strace dying when it traces
background process which gets SIGALRM

2.6:

# uname -a
Linux firebird 2.6.11-rc3smp #1 SMP Thu Feb 3 15:47:39 EET 2005 i686 unknown
# ./a.out &
[1] 2945
PID: 2945
# strace -p 2945
setup()                                 = -1 ERRNO_516 (errno 516)
--- SIGALRM (Alarm clock) ---
Got ALRM
[1]+  Done                    ./a.out

Notice that strace did not show any syscalls after SIGALRM.
Foreground strace for completeness sake:

execve("./a.out", ["./a.out"], [/* 16 vars */]) = 0
uname({sys="Linux", node="firebird", ...}) = 0
brk(0)                                  = 0x804a000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fee000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 6
fstat64(6, {st_mode=S_IFREG|0644, st_size=48875, ...}) = 0
mmap2(NULL, 48875, PROT_READ, MAP_PRIVATE, 6, 0) = 0xb7fe2000
close(6)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 6
read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\204P\1"..., 1024) = 1024
fstat64(6, {st_mode=S_IFREG|0755, st_size=1388063, ...}) = 0
mmap2(NULL, 1129924, PROT_READ|PROT_EXEC, MAP_PRIVATE, 6, 0) = 0xb7ece000
mprotect(0xb7fdc000, 24004, PROT_NONE)  = 0
mmap2(0xb7fdc000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 6, 0x10d) = 0xb7fdc000
mmap2(0xb7fe0000, 7620, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fe0000
close(6)                                = 0
munmap(0xb7fe2000, 48875)               = 0
getpid()                                = 2786
fstat64(1, {st_mode=S_IFREG|0644, st_size=1174, ...}) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fec000
rt_sigaction(SIGALRM, {0x80484e4, [ALRM], SA_RESTART|0x4000000}, NULL, 8) = 0
alarm(30)                               = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({60, 0}, 0xbffffb88)          = -1 ERRNO_516 (errno 516)
--- SIGALRM (Alarm clock) ---
write(1, "PID: 2786\nGot ALRM\n", 19PID: 2786
Got ALRM
)   = 19
munmap(0xb7fec000, 8192)                = 0
semget(IPC_PRIVATE, 8192, IPC_CREAT|IPC_EXCL|0xb7fde1e0|0640

Now 2.4:

# uname -a
Linux pegasus 2.4.27-rc3 #1 Tue Jul 27 13:54:25 EEST 2004 i686 unknown unknown GNU/Linux

# strace ./a.out
execve("./a.out", ["./a.out"], [/* 24 vars */]) = 0
uname({sys="Linux", node="pegasus", ...}) = 0
brk(0)                                  = 0x80497bc
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/var/app/glibc-2.3/etc/ld.so.cache", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=43176, ...}) = 0
old_mmap(NULL, 43176, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40013000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240Y\1"..., 1024) = 1024
fstat64(4, {st_mode=S_IFREG|0755, st_size=16153080, ...}) = 0
old_mmap(NULL, 1131908, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4001e000
mprotect(0x40129000, 38276, PROT_NONE)  = 0
old_mmap(0x40129000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x10a000) = 0x40129000
old_mmap(0x4012f000, 13700, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4012f000
close(4)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40133000
munmap(0x40013000, 43176)               = 0
getpid()                                = 22475
fstat64(1, {st_mode=S_IFREG|0644, st_size=1207, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
rt_sigaction(SIGALRM, {0x80484e4, [ALRM], SA_RESTART|0x4000000}, NULL, 8) = 0
alarm(30)                               = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({60, 0}, 0xbffff8c8)          = -1 EINTR (Interrupted system call)
--- SIGALRM (Alarm clock) ---
write(1, "PID: 22475\nGot ALRM\n", 20PID: 22475
Got ALRM
)  = 20
munmap(0x40013000, 4096)                = 0
_exit(0)                                = ?

# ./a.out &
[1] 22833
PID: 22833
# strace -p 22833
munmap(0x40013000, 4096)                = 0
_exit(0)                                = ?
[1]+  Done                    ./a.out

Well, SIGALRM and write() is not shown, which isn't ok, but at least
strace did not fall off and have shown munmap() and exit().
--
vda

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>

void handler(int sig)
{
        switch (sig) {
        case SIGALRM:
                printf("Got ALRM\n");
                exit(0);
                break;
        }
}

void setup_signals(__sighandler_t handler)
{
        struct sigaction sa;

        sigemptyset(&sa.sa_mask);
        sigaddset(&sa.sa_mask, SIGALRM);
        sa.sa_handler = handler;
        sa.sa_flags = SA_RESTART;
        sigaction(SIGALRM, &sa, NULL);
}

int main()
{
        printf("PID: %d\n",getpid());
        setup_signals(handler);
        alarm(30);
        sleep(60);
        return 0;
}

