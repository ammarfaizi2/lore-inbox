Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUAaTT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 14:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUAaTT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 14:19:27 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:20878 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265083AbUAaTTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 14:19:24 -0500
Date: Sat, 31 Jan 2004 20:19:23 +0100
From: bert hubert <ahu@ds9a.nl>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, molnar@elte.hu, phil-list@redhat.com
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131191923.GA21333@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org, molnar@elte.hu, phil-list@redhat.com
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl> <20040131155155.GA1504@kiste> <20040131161805.GA15941@outpost.ds9a.nl> <20040131181518.GB1815@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131181518.GB1815@kiste>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Added Ingo & NPTL list]

[Matthias reports that threads forking multiple programs and running waitpid
 on them has problems] 

On Sat, Jan 31, 2004 at 07:15:19PM +0100, Matthias Urlichs wrote:

> > If they do not wait for a specific pid, the kernel is right. The kernel has
> > no way of knowing which process a specific waitpid is waiting for otherwise!
> > 
> Please check my original mail again. The thread _is_ waiting for a
> specific pid.

I can't reproduce this with 2.6.1, can you check if this works as intended
on your system? Should output:

Thread 0 Launched pid 10967
Thread 1 Launched pid 10971
Thread 1 waitpid for 10971 returned for 10971, status: 1
Thread 0 waitpid for 10967 returned for 10967, status: 3

This is with NPTL 0.60 (Debian Unstable).

./sleep program:

#!/bin/sh
sleep $1
exit $1

testcase.c:

#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <pthread.h>
#include <stdlib.h>

void unixDie(const char* what)
{
  perror(what);
  exit(1);
}
int s_counter;
void *func(void *p)
{
  pid_t pid;
  int status;
  int counter=s_counter++;

  pid=fork();
  if(pid<0)
    unixDie("doing fork");
  if(!pid) {
    char *arguments[]={"./sleep","",0};
    char str[10];
    sprintf(str,"%d",(int)p);
    arguments[1]=str;

    if(execve(arguments[0],arguments,0))
      unixDie("doing execve");
  }
  if(pid) {
    pid_t ret;
    printf("Thread %d Launched pid %d\n", counter, pid);
    ret=waitpid(pid, &status, 0);
    if(ret<0)
      unixDie("waitpid");

    printf("Thread %d waitpid for %d returned for %d, status: %d\n",counter, pid, ret, WEXITSTATUS(status));
  }

  return 0;
}


int main(int argc, char **argv)
{
  pthread_t t1, t2;
  pthread_create(&t1, 0, func,(void*)3);
  sleep(1);
  pthread_create(&t2, 0, func,(void*)1);

  pthread_join(t2,0);
  pthread_join(t1,0);
  return 0;
}


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
