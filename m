Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUFEPY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUFEPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUFEPY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 11:24:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59843 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261605AbUFEPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 11:24:49 -0400
Message-ID: <40C1E6A9.3010307@elegant-software.com>
Date: Sat, 05 Jun 2004 11:28:41 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: clone() <-> getpid() bug in 2.6?
Content-Type: multipart/mixed;
 boundary="------------000904070706000207050004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000904070706000207050004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I have a test program (see attached) that shows what looks like a bug in 
2.6.5-1.358 (FedoraCore2)...and breaks my program :(

In summary, I am doing:

 clone(run_thread, stack + sizeof(stack) -1,
            CLONE_FS|CLONE_FILES|CLONE_VM|SIGCHLD, NULL))

According to the man page the child process should have its own pid as 
returned by getpid()...much like fork().

In 2.6 the child receives the parent's pid from getpid(), while 2.4 
works as documented:

In 2.4 the test program does:
 parent pid: 26647
 clone returned pid: 26648
 thread reported pid: 26648

In 2.6 the test program does:
 parent pid: 16665
 thread reported pid: 16665
 clone returned pid: 16666

Is this fixed in later kernels?

Thx

Russ

--------------000904070706000207050004
Content-Type: text/plain;
 name="clone-pid-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clone-pid-test.c"


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sched.h>
#include <signal.h>
#include <sys/wait.h>

/* to compile:
  gcc -Wall clone-pid-test.c -o clone-pid-test
 */

static int run_thread(void *arg)
{
  printf("thread reported pid: %d\n", getpid()); 

  return 0;
}

static char stack[4096];

static int create_thread()
{
  int
    pid;

  /* create thread */
  if ( (pid = clone(run_thread, stack + sizeof(stack) -1,
		    CLONE_FS|CLONE_FILES|CLONE_VM|SIGCHLD, NULL)) == -1 ) {
    perror("clone:");
    exit(-1);
  }/* end if */

  return pid ;
}

int main(int argc, char *argv[])
{
  printf("parent pid: %d\n", getpid());
  printf("clone returned pid: %d\n",  create_thread());
  wait(NULL);
  return 0;
}

--------------000904070706000207050004--
