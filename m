Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTKZRj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTKZRj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:39:57 -0500
Received: from dsl-sj-66-219-74-27.broadviewnet.net ([66.219.74.27]:20097 "EHLO
	server.perens.com") by vger.kernel.org with ESMTP id S264239AbTKZRjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:39:54 -0500
Date: Wed, 26 Nov 2003 09:39:53 -0800
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Signal left blocked after signal handler.
Message-ID: <20031126173953.GA3534@perens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: bruce@perens.com (Bruce Perens)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A signal should be blocked while its signal handler is executing, and
then unblocked when the handler returns - unless SA_NOMASK is set.

-test9 and -test10 leave the signal _blocked_forever_.

This causes the build-time confidence test for Electric Fence to break,
and no doubt lots of other code.

If SA_NOMASK is set, the signal is not blocked.

Test program attached below.

	Thanks

	Bruce

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <setjmp.h>

static sigjmp_buf	sjbuf;
static int		sig = SIGINT;

static void
handler(int i)
{
	struct sigaction	act;

	memset((void *)&act, 0, sizeof(act));
	act.sa_handler = SIG_DFL;

	fprintf(stderr, "Signal handler hit!\n");
	fflush(stderr);
	sigaction(sig, &act, 0);
	siglongjmp(sjbuf, 1);

}

static void
invoke_signal()
{
	struct sigaction	act;

	memset((void *)&act, 0, sizeof(act));
	act.sa_handler = handler;

	/* act.sa_flags = SA_NOMASK; */

	if ( sigsetjmp(sjbuf, 0) == 0 ) {
		sigaction(sig, &act, 0);
		fprintf(stderr, "Sending signal... ");
		fflush(stderr);
		kill(getpid(), sig);
		fprintf(stderr, "Huh? Nothing happened. Signal was left blocked.\n");
	}
}

int
main(int argc, char * * argv)
{
	sigset_t	set;

	sigemptyset(&set);
	sigaddset(&set, sig);

	invoke_signal();
	invoke_signal();
	fprintf(stderr, "Unblocking signal... ");
	if ( sigsetjmp(sjbuf, 0) == 0 ) {
		sigprocmask(SIG_UNBLOCK,  &set, 0);
	}

	return 0;
}
