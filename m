Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVBYSkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVBYSkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVBYSkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:40:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:51696 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262776AbVBYSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:40:03 -0500
To: <linux-kernel@vger.kernel.org>
Subject: =?iso-8859-1?Q?PROBLEM:_Ignoring_blocked_signals_in_2=2E6_/_2=2E4?=
From: <lk@tobias-grundmann.de>
Message-Id: <6385649$1109356214421f6eb62c3755.62229880@config6.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 6385649
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Fri, 25 Feb 2005 19:38:01 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.133
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a question regarding blocked signals:

Is the current implementation to ignore attempts to set SIG_IGN on
blocked signals correct? 
The following code will go into an endless loop on kernels 2.6.10 and
2.4.25, which is IMHO not the behaviour one would expect. 

--------------------
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>

volatile int sig_received  = 0;

void sigio_handler_ex (int signum, siginfo_t * siginfo, void * ucontext)
{
        struct sigaction sigio_action;

        sig_received++;
        printf("handler %d\n",sig_received);

        sigio_action.sa_handler = SIG_IGN;
        sigio_action.sa_flags = 0;
        sigemptyset(&sigio_action.sa_mask);
        sigaction (SIGIO, &sigio_action, 0);

        kill(getpid(),SIGIO);

        sigio_action.sa_sigaction =  sigio_handler_ex;
        sigio_action.sa_flags = SA_SIGINFO;
        sigemptyset(&sigio_action.sa_mask);
        sigaction (SIGIO, &sigio_action, 0);
}

int main(int argc, char **argv) {
        struct sigaction sigio_action;
        sigio_action.sa_sigaction =  sigio_handler_ex;
        sigio_action.sa_flags = SA_SIGINFO;
        sigemptyset(&sigio_action.sa_mask);

        sigaction (SIGIO, &sigio_action, 0);

        kill(getpid(),SIGIO);

        while  (! sig_received) {
                printf("waiting for signal\n");
                sleep(1);
        }

        kill(getpid(),SIGIO);

        printf("%d signals handled\n",sig_received);
}

--------------------

In kernel 2.6.10/kernel/signal.c sig_ignored() I found this comment:
...
/*
 * Blocked signals are never ignored, since the
 * signal handler may change by the time it is
 * unblocked.
 */

if (sigismember(&t->blocked, sig))
		return 0;
...

so it seems this behaviour is intentional, but I don't understand
it. Why should it matter if a signal handler may change while blocked,
if it is ignored also, which is a user request?

The machine im writing this mail on runs with the above lines
commented out without any problems so far...

All this resulted from problems a customer had with implementing a
whole protocol-stack to a serially attached device in a
signal-handler. After the handler ran (with SIG_IGN) there was always
an extra SIGIO which triggered the handler again. Of course the real
fix was to move the protocol-stack out of the handler but still it
should have worked since it was a controlled environment (so there
wasn't even a race between entering the handler and setting
SIG_IGN). Oh and it worked for years under some realtime variant of
hp-unix.

Please be so kind and CC any answer to me directly since im
currently not subscribed to lkm.

Yours
Tobias Grundmann
