Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262200AbSI1QvU>; Sat, 28 Sep 2002 12:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSI1QvU>; Sat, 28 Sep 2002 12:51:20 -0400
Received: from pop.gmx.net ([213.165.64.20]:39933 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262200AbSI1QvU>;
	Sat, 28 Sep 2002 12:51:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Axel <Axel.Zeuner@gmx.de>
Reply-To: Axel.Zeuner@gmx.de
To: linux-kernel@vger.kernel.org, phil-list@redhat.com
Subject: 2.5.39: Signal delivery to thread groups: Bug or feature
Date: Sat, 28 Sep 2002 19:14:26 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020928165120Z262200-8740+2744@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
I played a little bit with the new clone flags and wrote a small test 
program using two threads: The first (initial) thread blocks all signals. The 
second thread is created with all signals blocked and inherits the signal 
mask of the initial thread. It unblocks SIGINT and calls sys_rt_sigtimedwait 
with the remaining signal mask. Therefore it waits for all signals with 
exception of SIGINT. In the kernel this yields to an empty signal mask for 
this thread during the sigwait. No signal handler is installed by the 
process. Now an external SIGINT is delivered to the whole process: The 
signal delivery code decides to send this signal directly to the initial thread 
because no user handler is installed and the signal mask for this thread 
blocks the signal. The second thread never receives the SIGINT.

Reason:
The main signal dispatching function send_sig_info in kernel/signal.c 
requires at the moment an installed signal handler for delivery of signals 
to members of the thread group.

Therefore NPTL/NPT must install signal handlers for all signals 
during startup to allow signal delivery to other threads and must restore
these default handlers to SIG_DFL after first delivery and raise
the signal to create the correct exit code.
IMHO, the current signal system is not a clean solution (yet), but of course
much better than the ugly signal forwarding required by the thread group 
leader only working as signal thread in 2.4.X. 

Axel



