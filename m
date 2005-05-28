Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVE1Bir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVE1Bir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVE1Bir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:38:47 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:36805 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261909AbVE1Bin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:38:43 -0400
Subject: Re: disowning a process
From: Steven Rostedt <rostedt@goodmis.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4297AE6F.9040707@davyandbeth.com>
References: <42975945.7040208@davyandbeth.com>
	 <1117217088.4957.24.camel@localhost.localdomain>
	 <42976D3A.5020200@davyandbeth.com>
	 <1117227438.5730.235.camel@localhost.localdomain>
	 <4297AE6F.9040707@davyandbeth.com>
Content-Type: multipart/mixed; boundary="=-IuJxs+ZEqXXzhYKk3G/p"
Organization: Kihon Technologies
Date: Fri, 27 May 2005 21:38:36 -0400
Message-Id: <1117244316.6477.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IuJxs+ZEqXXzhYKk3G/p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-27 at 18:34 -0500, Davy Durham wrote:
> Well, when I tried using it in a program with some sleeps to test.. I 
> noticed that the intermediate process that daemon creates is not cleaned 
> up with a wait() call (so I see a defunct process in the ps listing).

You didn't use it right. See below.

> 
> If I manually do the double fork() then I can call waitpid() myself for 
> the pid that I know it spawned.   But if I just call wait() after 
> calling daemon, then I don't know if I just cleaned up the pid it 
> spawned (do I?), or some other previously spawned one (for perhaps 
> totally different reasons)..

You still need to fork the first child, and the daemon does the second
fork and exits the parent, and does all the necessary things for the
system to make a proper daemon.

> 
> For my specifics it may not be a problem, but I guess I'm just whining 
> about the fact that daemon() doesn't clean it up itself (or can it?)

Attached is a simple C program that uses daemon the way you want to.

-- Steve

--=-IuJxs+ZEqXXzhYKk3G/p
Content-Disposition: attachment; filename=daemon.c
Content-Type: text/x-csrc; name=daemon.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>


int main (int argc, char **argv)
{
	pid_t pid;

	if ((pid = fork()) < 0) {
		perror("fork");
	} else if (!pid) {
		if (daemon(1,1) < 0) {
			perror("daemon");
			exit(-1);
		}
		printf("daemon is %d\n",getpid());
		sleep(100);
		exit(0);
	}

	printf("middle child is %d (and died)\n",pid);
	waitpid(pid,NULL,0);

	printf("parent is %d\n",getpid());

	sleep(100);
	return 0;
}

--=-IuJxs+ZEqXXzhYKk3G/p--

