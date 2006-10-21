Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161487AbWJUQ0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161487AbWJUQ0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161486AbWJUQ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:26:20 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:52452 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1161005AbWJUQ0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:26:19 -0400
Date: Sun, 22 Oct 2006 01:28:39 +0900 (JST)
Message-Id: <20061022.012839.108306870.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: torvalds@osdl.org, rmk+lkml@arm.linux.org.uk, davem@davemloft.net,
       nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061020214122.GA29237@linux-mips.org>
References: <20061020205929.GE8894@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
	<20061020214122.GA29237@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 22:41:22 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > It's just that we weren't quite careful enough at that time (and even 
> > then, that would only matter for some really really unlikely and strange 
> > situations that only happen when you fork() from a _threaded_ environment, 
> > so it shouldn't be anything you'd notice under normal load).
> > 
> > I think.
> 
> The flush is there since a very long time.  I have it in my tree since
> ~ 2.1.36 and I get the feeling anybody every has been seriously revisited
> the issue since.

I think calling fork() (or system() or popen() or so) in threaded
program is neither very unlikely or strange.  But this breakage happens
very rarely indeed, especially non-preemptive kernel.

During debugging this issue, I had used this test program and slightly
modified kernel --- inserting yield() at middle of dup_mmap().

With the modified kernel on 32KB VIPT D$, running this test program
some times could reproduce the breakage ("BAD!" messages).  I heard
PARISC people had successed to reproduce it too.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

static void *thread_func(void *arg)
{
	unsigned char buf[2048], j;
	int i;
	for (j = 0; ; j++) {
		/* fill buf[] with j */
		memset(buf, j, sizeof(buf)/2);
		sched_yield();
		memset(buf + sizeof(buf)/2, j, sizeof(buf)/2);
		sched_yield();
		/* check buf[] contents */
		for (i = 0; i < sizeof(buf); i++) {
			if (buf[i] != j) {
				printf("BAD! %p (%d != %d)\n",
				       buf + i, buf[i], j);
				exit(1);
			}
		}
	}
}

int main(int argc, char *argv[])
{
	int i;
	pid_t pid;
	pthread_t tid;
	for (i = 0; i < 4; i++)
		pthread_create(&tid, NULL, thread_func, NULL);
	for (i = 0; i < 100; i++) {
		pid = fork();
		if (pid == -1) {
			perror("fork");
			exit(1);
		}
		if (pid)
			waitpid(pid, NULL, 0);
		else
			exit(0);
	}
	return 0;
}

---
Atsushi Nemoto
