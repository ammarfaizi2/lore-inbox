Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTEBQ7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEBQ7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:59:40 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:51353 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262931AbTEBQ7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:59:38 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 May 2003 10:12:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Ingo Molnar wrote:

>
> We are pleased to announce the first publically available source code
> release of a new kernel-based security feature called the "Exec Shield",
> for Linux/x86. The kernel patch (against 2.4.21-rc1, released under the
> GPL/OSL) can be downloaded from:
>
> 	http://redhat.com/~mingo/exec-shield/
>
> The exec-shield feature provides protection against stack, buffer or
> function pointer overflows, and against other types of exploits that rely
> on overwriting data structures and/or putting code into those structures.
> The patch also makes it harder to pass in and execute the so-called
> 'shell-code' of exploits. The patch works transparently, ie. no
> application recompilation is necessary.

[ very cool stuff ]

Ingo, do you want protection against shell code injection ? Have the
kernel to assign random stack addresses to processes and they won't be
able to guess the stack pointer to place the jump. I use a very simple
trick in my code :

#define MAX_STKSHIFT 1024

struct thrunner {
	int (*proc)(void *);
	void *data;
}

static int thread_runner(void *data) {
	struct thrunner *thr = data;

	alloca(myrand(MAX_STKSHIFT));
	return thr->proc(thr->data);
}

int my_thread_create(int (*proc)(void *), void *data) {
	struct thrunner *thr;
	...
	thr->proc = proc;
	thr->data = data;
	pthread_create(..., thread_runner, thr, ... );
	...
}

int main(int argc, char *argv[]) {

	mysrand();
	...
}

Same thing can be done for non threaded programs :

int main(int argc, char *argv[]) {

	mysrand();
	alloca(myrand(MAX_STKSHIFT));
	return real_main(argc, argv);
}


Yes, there's still the possibility that an attacker get lucky ( this get
lower increasing MAX_STKSHIFT ) and yes you waste some stack space. But,
oh well, it works w/out any kernel modification and it's portable on all
systems that have alloca().




- Davide

