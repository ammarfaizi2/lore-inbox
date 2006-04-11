Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWDKIGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWDKIGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWDKIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:06:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:22224 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932346AbWDKIGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:06:19 -0400
Date: Tue, 11 Apr 2006 16:03:26 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
Message-ID: <20060411120326.GA84@oleg>
References: <20060410174346.GA100@oleg> <20060411072722.0953A1809BB@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411072722.0953A1809BB@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Roland McGrath wrote:
>
> > So, de_thread() sets SIGNAL_GROUP_EXEC and sends SIGKILL to other thereads.
> > 
> > Sub-thread receives the signal, and calls get_signal_to_deliver->do_group_exit.
> > do_group_exit() calls zap_other_threads(SIGNAL_GROUP_EXIT) because there is no
> > SIGNAL_GROUP_EXIT set. zap_other_threads() notices SIGNAL_GROUP_EXEC, wakes up
> > execer, and changes ->signal->flags to SIGNAL_GROUP_EXIT.
> > 
> > de_thread() re-locks sighand, sees !SIGNAL_GROUP_EXEC and goes to 'dying:'.
> 
> That is what I intend.  The exec'ing thread backs out and processes its SIGKILL.
> It sounds like you are calling this scenario a problem, but I don't know why.

Ok, here is the test:

#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <stdlib.h>

static void *tfunc(void *arg)
{
	pause();
	return NULL;
}

int main(int argc, const char *argv[])
{
	pthread_t thread;

	if (!argv[0]) {
		printf("--------- SUCCESS ----------\n");
		exit(0);
	}

	if (pthread_create(&thread, NULL, tfunc, NULL)) {
		perror ("pthread_create");
		exit (1);
	}

	execl("/proc/self/exe", NULL);

	return pause();
}


	$ ./test
	--------- SUCCESS ----------

With this patch applied I have:

	$ ./test
	Killed

Oleg.

