Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVCNPbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVCNPbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVCNPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:31:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:28381 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261540AbVCNPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:30:23 -0500
Message-ID: <4235AE08.6080605@tobias-grundmann.de>
Date: Mon, 14 Mar 2005 16:30:16 +0100
From: Tobias Grundmann <lk@tobias-grundmann.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.6.11 Making it possible to ignore blocked signals
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:67246fc725eebc4314ed16889a45a476
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch fixes the IMHO incorrect behavior to silently ignore 
attempts to set SIG_IGN on blocked signals (i.e. while running in a 
signal handler). See below for further explanation.

Tobias

--- kernel/signal.c.orig        2005-03-06 18:12:26.000000000 +0100
+++ kernel/signal.c     2005-03-06 18:13:08.000000000 +0100
@@ -163,14 +163,6 @@
       if (t->ptrace & PT_PTRACED)
               return 0;

-       /*
-        * Blocked signals are never ignored, since the
-        * signal handler may change by the time it is
-        * unblocked.
-        */
-       if (sigismember(&t->blocked, sig))
-               return 0;
-
       /* Is it explicitly or implicitly ignored? */
       handler = t->sighand->action[sig-1].sa.sa_handler;
       return   handler == SIG_IGN ||


-------- Original Message --------
Subject: 	PROBLEM: Ignoring blocked signals in 2.6 / 2.4 not possible
Date: 	Sat, 26 Feb 2005 11:10:01 +0100
From: 	<lk@tobias-grundmann.de>
To: 	<linux-kernel@vger.kernel.org>
CC: 	<lk@tobias-grundmann.de>



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

Please be so kind to CC any answer to me directly since I'm
currently not subscribed to lkml.

Yours
Tobias Grundmann


