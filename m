Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269973AbUJNF1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269973AbUJNF1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 01:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269976AbUJNF1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 01:27:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18120 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269973AbUJNF0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 01:26:51 -0400
Subject: unkillable process
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097731227.2666.11264.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Oct 2004 01:20:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's really bad when a task group leader exits.
The process becomes unkillable.

This is with the 2.6.8-rc1 kernel. I haven't seen
any mention of this getting fixed since then.
Here's the top of the /proc/*/status file:

Name:   a.out
State:  Z (zombie)
SleepAVG:       59%
Tgid:   9662
Pid:    9662
PPid:   1
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    1000    1000    1000    1000
FDSize: 0
Groups: 500 1000 
Threads:        9

Here's the code:

///////////////////////////////////////////////////////////////
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
/////////////////////////////////////////////////////////////////////


