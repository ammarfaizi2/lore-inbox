Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTKZRzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTKZRzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:55:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:22461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262827AbTKZRzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:55:47 -0500
Date: Wed, 26 Nov 2003 09:55:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bruce Perens <bruce@perens.com>, Ulrich Drepper <drepper@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal left blocked after signal handler.
In-Reply-To: <20031126173953.GA3534@perens.com>
Message-ID: <Pine.LNX.4.58.0311260945030.1524@home.osdl.org>
References: <20031126173953.GA3534@perens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Uli added to participants ]

On Wed, 26 Nov 2003, Bruce Perens wrote:
>
> A signal should be blocked while its signal handler is executing, and
> then unblocked when the handler returns - unless SA_NOMASK is set.
>
> -test9 and -test10 leave the signal _blocked_forever_.

>From what I can tell, this is a glibc bug. Do an "strace" on the program,
and see how "siglongjmp()" doesn't appear to do any system calls at all.

It's up to siglongjmp() to restore the signal mask that it saved on
sigsetjmp().

What library version are you using (but yes, I see the same thing with
"Fedora Core 1").

In fact, with strace I don't even see where the signal mask would be
_saved_ in sigsetjmp. So as far as I can tell, this just cannot work.

			Linus

--- rest of email saved for Uli ---
>
> This causes the build-time confidence test for Electric Fence to break,
> and no doubt lots of other code.
>
> If SA_NOMASK is set, the signal is not blocked.
>
> Test program attached below.
>
> 	Thanks
>
> 	Bruce
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <signal.h>
> #include <setjmp.h>
>
> static sigjmp_buf	sjbuf;
> static int		sig = SIGINT;
>
> static void
> handler(int i)
> {
> 	struct sigaction	act;
>
> 	memset((void *)&act, 0, sizeof(act));
> 	act.sa_handler = SIG_DFL;
>
> 	fprintf(stderr, "Signal handler hit!\n");
> 	fflush(stderr);
> 	sigaction(sig, &act, 0);
> 	siglongjmp(sjbuf, 1);
>
> }
>
> static void
> invoke_signal()
> {
> 	struct sigaction	act;
>
> 	memset((void *)&act, 0, sizeof(act));
> 	act.sa_handler = handler;
>
> 	/* act.sa_flags = SA_NOMASK; */
>
> 	if ( sigsetjmp(sjbuf, 0) == 0 ) {
> 		sigaction(sig, &act, 0);
> 		fprintf(stderr, "Sending signal... ");
> 		fflush(stderr);
> 		kill(getpid(), sig);
> 		fprintf(stderr, "Huh? Nothing happened. Signal was left blocked.\n");
> 	}
> }
>
> int
> main(int argc, char * * argv)
> {
> 	sigset_t	set;
>
> 	sigemptyset(&set);
> 	sigaddset(&set, sig);
>
> 	invoke_signal();
> 	invoke_signal();
> 	fprintf(stderr, "Unblocking signal... ");
> 	if ( sigsetjmp(sjbuf, 0) == 0 ) {
> 		sigprocmask(SIG_UNBLOCK,  &set, 0);
> 	}
>
> 	return 0;
> }
>
