Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269398AbUJGA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269398AbUJGA04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUJGA04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:26:56 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:60644 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269398AbUJGA0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:26:50 -0400
Subject: Re: Invisible threads in 2.6.9
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: patrics@interia.pl, nuno.silva@vgertech.com, xschmi00@stud.feec.vutbr.cz,
       cfriesen@nortelnetworks.com
Content-Type: text/plain
Organization: 
Message-Id: <1097108498.2674.254.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Oct 2004 20:21:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do indeed have a kernel problem. I re-did the
example code using the raw clone() system call,
to avoid any pthreads troubles. I took out the
busy loop; add it back in if you care to verify
that it would indeed chew up CPU time.

(I started the threads stopped, so they wouldn't
need to have distinct stacks.)

-------------------------- begin example ---------------------------
$ ./zombie-leader 
$ ps -mfL
UID       PID PPID  LWP  C NLWP STIME TTY          TIME CMD
albert   3224 3223    -  0    1 Sep29 pts/19   00:00:00 bash
albert      -    - 3224  0    1 Sep29 -        00:00:00 -
albert   7442    1    -  0    9 20:05 pts/19   00:00:00 [zombie-leader] <defunct>
albert   7457 3224    -  0    1 20:06 pts/19   00:00:00 xterm
albert      -    - 7457  0    1 20:06 -        00:00:00 -
albert   7475 3224    -  0    1 20:10 pts/19   00:00:00 ps -mfL
albert      -    - 7475  0    1 20:10 -        00:00:00 -
$ ls /proc/7442/task/
ls: /proc/7442/task/: No such file or directory
$ ls /proc/7442/     
ls: cannot read symbolic link /proc/7442/cwd: Permission denied
ls: cannot read symbolic link /proc/7442/root: Permission denied
ls: cannot read symbolic link /proc/7442/exe: Permission denied
auxv  cmdline  cwd  environ  exe  fd  maps  mem  mounts  root  stat  statm  status  task  wchan
$ ps -mo stat,ppid,pid,tid,nlwp,args
STAT PPID  PID  TID NLWP COMMAND
-    3223 3224    -    1 bash
Ss      -    - 3224    1 -
-       1 7442    -    9 [zombie-leader] <defunct>
-    3224 7457    -    1 xterm
S       -    - 7457    1 -
-    3224 7477    -    1 ps -mo stat,ppid,pid,tid,nlwp,args
R+      -    - 7477    1 -
---------------------------- end example -------------------------------

////////////////////// begin code ///////////////////////////
#include <sys/types.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <sched.h>

#ifndef CLONE_THREAD
#define CLONE_THREAD         0x00010000
#endif
#ifndef CLONE_DETACHED
#define CLONE_DETACHED       0x00400000
#endif
#ifndef CLONE_STOPPED
#define CLONE_STOPPED        0x02000000
#endif

// similar to NPTL pthreads, AFAIK
#define FLAGS (CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_VM|CLONE_THREAD|CLONE_DETACHED)

static pid_t one;

static void die(int signo){
  (void)signo;
  _exit(0);
}

static void hang(void){
  for(;;) pause();
}

static int clone_fn(void *vp){
  (void)vp;
  hang();
  return 0; // keep gcc happy
}

static long clone_stack_data[2048];
#ifdef __hppa__
static long *clone_stack = &clone_stack_data[0];
#else
static long *clone_stack = &clone_stack_data[2048];
#endif

int main(int argc, char *argv[]){
  pid_t minime;
  int i = 8;
  (void)argc;
  (void)argv;

  one = getpid();
  signal(SIGHUP,die);
  if(fork()) hang();    // parent later killed as readyness signal

  while(i--){
    // better be stopped... they share a stack
    minime = clone(clone_fn, clone_stack, FLAGS | CLONE_STOPPED, NULL);
    if(minime==-1){
      perror("no clone");
      kill(one,SIGKILL);
      _exit(8);
    }
  }

  kill(one,SIGHUP); // let the shell know we're ready

  _exit(0);  // make task group leader a zombie
  return 0;  // keep gcc happy
}

/////////////////////// end code /////////////////////////////


